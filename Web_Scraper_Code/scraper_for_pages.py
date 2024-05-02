import requests
from bs4 import BeautifulSoup
import time
import os
def scrape_linked_page(link_url):
    # Send a GET request to the linked page
    response = requests.get(link_url)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Parse the HTML content using BeautifulSoup
        soup = BeautifulSoup(response.text, 'html.parser')
        return str(soup)
    else:
        print(f"Failed to fetch HTML from the linked page. Status code: {response.status_code}")
        return None


# parsed html in batches from
# Accessibility.com website
# set default to 50
def save_html_to_file(url, filename, max_pages=50):
    page_number = 0
    folder_name = 'Cases'
    while page_number <= max_pages:
        page_url = f"{url}/page/{page_number}"

        response = requests.get(page_url)

        if response.status_code == 200:
            soup = BeautifulSoup(response.text, 'html.parser')

            link_elements = soup.find_all('div', class_='postItemInner')

            for index, link_element in enumerate(link_elements, start=1):
                link_url = link_element.find('h3').find('a')['href']

                linked_page_html = scrape_linked_page(link_url)

                if linked_page_html:

                    file_path = os.path.join(folder_name, f"{filename}_page{page_number}_{index}.html")

                    with open(file_path, 'w', encoding='utf-8') as file:
                        file.write(linked_page_html)

                    print(f"HTML content from page {page_number}, box {index} saved to {filename}_page{page_number}_{index}.html")

                    # Pause for 5 seconds before scraping the next page
                    # To avoid "attacking" the website
                    time.sleep(2)
                else:
                    print(f"Could not find the link within the specified div on page {page_number}, box {index}.")

            page_number += 1
        else:
            print(f"Failed to fetch HTML from page {page_number}. Status code: {response.status_code}")
            break


website_url = 'https://www.accessibility.com/digital-lawsuits'
output_filename = 'output'

save_html_to_file(website_url, output_filename, max_pages=760)
