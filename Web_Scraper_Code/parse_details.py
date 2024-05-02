import csv
from bs4 import BeautifulSoup
import os

_my_dict = None;
_my_dict_2=None;

def extract_details(number, html_content):
    soup = BeautifulSoup(html_content, 'html.parser')
    plaintiff_details = {}
    defendant_details = {}
    case_summary = {}
    case_details = {}


    # Plaintiff details
    plaintiff_block = soup.find('div', class_='plaintiff_block')
    if plaintiff_block:
        name_element = plaintiff_block.find('span', class_='legal_label', string='Name:').find_next_sibling(text=True)
        filing_date_element = plaintiff_block.find('span', class_='legal_label', string='Filing date:').find_next_sibling(text=True)
        state_of_filing_element = plaintiff_block.find('span', class_='legal_label', string='State of filing:').find_next_sibling(text=True)

        plaintiff_details['Name'] = name_element
        plaintiff_details['Filing date'] = filing_date_element
        plaintiff_details['State of filing'] = state_of_filing_element

    # Defendant details
    defendant_block = soup.find('div', class_='defendant_block')
    if defendant_block:
        name_element = defendant_block.find('span', class_='legal_label', string='Name:').find_next_sibling(text=True).get_text(strip=True)
        website_element = defendant_block.find('span', class_='legal_label', string='Website:')
        website_li = website_element.find_next('a')
        website_text = website_li.get_text(strip=True)

        industry_element = website_element.find_next('li').get_text(strip=True)
        summary_element = defendant_block.find('span', class_='legal_label', string='Summary:').find_next_sibling(text=True).get_text(strip=True)

        defendant_details['Name'] = name_element
        defendant_details['Website'] = website_text
        defendant_details['Industry'] = industry_element
        defendant_details['Summary'] = summary_element

    # Case Information 
    case_summary_element = soup.find('div', class_='legal_summary')
    if case_summary_element:
        p_element = case_summary_element.find('p')
        if p_element:
            case_summary_text = p_element.get_text(strip=True)
            case_summary['Summary'] = case_summary_text
    case_details_element = soup.find('div', class_='legal_case_details')

    if case_details_element:
        alleged_issues = []
        legal_premise = []
        legal_course_of_action = []
        alleged_issues_element = case_details_element.find('h3', text='Plaintiff alleges issues in its Complaint including the following:')
        if alleged_issues_element:
            alleged_issues_list = alleged_issues_element.find_next('ul')
            alleged_issues = [li.text.strip() for li in alleged_issues_list.find_all('li')]
            for value in alleged_issues_list.find_all('li'):
                issue=value.text.strip()
                add_to_alleged_issues(number, issue)

        legal_premise_element = case_details_element.find('h3',
                                                          text='Plaintiff asserts the following cause(s) of action in its Complaint:')
        if legal_premise_element:
            legal_premise_list = legal_premise_element.find_next('ul')
            legal_premise = [li.text.strip() for li in legal_premise_list.find_all('li')]
        legal_course_of_action_element = case_details_element.find('h3',
                                                                   text='Plaintiff seeks the following relief by way of its Complaint:')
        if legal_course_of_action_element:
            legal_course_of_action_list = legal_course_of_action_element.find_next('ul')
            legal_course_of_action = [li.text.strip() for li in legal_course_of_action_list.find_all('li')]
            for value in legal_course_of_action_list.find_all('li'):
                result=value.text.strip()
                add_to_result(number, result)

        case_details = {
            'Alleged Issues': alleged_issues,
            'Legal Premise': legal_premise,
            'Legal Course of Action': legal_course_of_action
        }

    return number, plaintiff_details, defendant_details, case_summary, case_details

def save_to_csv(data, csv_filename):

        with open(csv_filename, 'a', newline='', encoding='utf-8') as csvfile:
            fieldnames = ['ID', 'Plaintiff Name', 'Defendant Name', 'State of Filing', 'Date of Filing', 'Industry',
                          'Website', 'Website Purpose', 'Summary', 'Alleged Issues', 'Legal Premise',
                          'Legal Course of Action']

            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

            # check if the header exists
            if csvfile.tell() == 0:
                writer.writeheader()

            # get array in case data
            alleged_issues = data[4].get('Alleged Issues', [])
            legal_premise = data[4].get('Legal Premise', [])
            legal_course_of_action = data[4].get('Legal Course of Action', [])

            # write the row
            writer.writerow({
                'ID': data[0],
                'Plaintiff Name': data[1].get('Name'),
                'Defendant Name': data[2].get('Name'),
                'State of Filing': data[1].get('State of filing'),
                'Date of Filing': data[1].get('Filing date'),
                'Industry': data[2].get('Industry'),
                'Website': data[2].get('Website'),
                'Website Purpose': data[2].get('Summary'),
                'Summary': data[3].get('Summary'),
                'Alleged Issues': alleged_issues,
                'Legal Premise': legal_premise,
                'Legal Course of Action': legal_course_of_action
            })


# function to add onto the alleged_issues column
def add_to_alleged_issues(ID, issue):
    global _my_dict
    if _my_dict is None:
        _my_dict={}
    if str(ID) in _my_dict:
        issue_num = len(_my_dict[str(ID)])+1
        issue_key = f"issue_{issue_num}"
        _my_dict[str(ID)][issue_key] = issue
    else:
        _my_dict[str(ID)]={"issue_1":issue}

# creating the list of alleged issues, based on the parsed HTML files
# creates a new CSV so that I can create a new table
def create_alleged_issues_list(data, csv_filename):
    with open(csv_filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['ID', 'Issue_Num', 'Issue'])
        for id, issues in data.items():
            for issue_num, issue in issues.items():
                writer.writerow([id, issue_num, issue])

def add_to_result(ID, result):
    global _my_dict_2
    if _my_dict_2 is None:
        _my_dict_2={}
    if str(ID) in _my_dict_2:
        result_num = len(_my_dict_2[str(ID)])+1
        issue_key = f"result_{result_num}"
        _my_dict_2[str(ID)][issue_key] = result
    else:
        _my_dict_2[str(ID)]={"result_1":result}


def create_result_list(data, csv_filename):
    with open(csv_filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['ID', 'Result_Num', 'Result'])
        for id, results in data.items():
            for result_num, result in results.items():
                writer.writerow([id, result_num, result])
    print("Results CSV created")

# Code to be ran to start the parsing/saving process
# folder path is the Cases folder on the root of the directory
folder_path = os.path.join(os.path.dirname(__file__), 'Cases')
with open('output_whole_dataset.csv', 'w', newline='', encoding='utf-8') as csvfile:
    fieldnames = ['ID','Plaintiff Name', 'Defendant Name', 'State of Filing', 'Date of Filing', 'Industry', 'Website',
                  'Website Purpose', 'Summary', 'Alleged Issues', 'Legal Premise', 'Legal Course of Action']

    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()

# Process each HTML file in the folder
# count is used for batch processing
count = 0
for filename in os.listdir(folder_path):
    # parse only .html files
    if filename.endswith('.html'):
        html_file_path = os.path.join(folder_path, filename)

        # read the data
        with open(html_file_path, 'r', encoding='utf-8') as file:
            html_content = file.read()

        # run extract_details to create the rows
        details_data = extract_details(count, html_content)

        # save to CSV
        save_to_csv(details_data, "output_whole_dataset_V3.csv")
        count += 1
        
# sample code to create the results/issues csv
#if _my_dict_2 is not None:
#   create_result_list(_my_dict_2, "Legal_Results_List.csv")
#else:
#   print("_my_dict_2 is empty. No data to create result list.")
#print("Saved content to output_whole_dataset.csv")


