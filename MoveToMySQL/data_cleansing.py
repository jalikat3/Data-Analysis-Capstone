import csv
from datetime import datetime
import pandas as pd

def cleanse_data(input_file, output_file):
    with open(input_file, 'r', newline='', encoding='utf-8') as csv_input:
        reader = csv.DictReader(csv_input)
        fieldnames = reader.fieldnames

        def cleanse_row(row):
            row['Plaintiff Name'] = row['Plaintiff Name'].strip().lower().title()

            row['Defendant Name'] = row['Defendant Name'].strip().lower().title()

            row['State of Filing'] = row['State of Filing'].strip().lower().title()

            row['Industry'] = row['Industry'].strip().lower().title()

            row['Date of Filing'] = row['Date of Filing'].strip()
            row['Date of Filing'] = pd.to_datetime(row['Date of Filing'], format='%B %d, %Y', errors='coerce')

            return row

        with open(output_file, 'w', newline='', encoding='utf-8') as csv_output:
            writer = csv.DictWriter(csv_output, fieldnames=fieldnames)
            writer.writeheader()

            for row in reader:
                cleansed_row = cleanse_row(row)
                writer.writerow(cleansed_row)

if __name__ == "__main__":
    input_file = 'output_whole_dataset.csv'
    output_file = 'output_cleansed_dataset.csv'
    cleanse_data(input_file, output_file)
