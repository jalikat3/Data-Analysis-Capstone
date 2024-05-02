import pandas as pd
import mysql.connector

# read in CSV
df = pd.read_csv('output_cleansed_2.csv')
df = df.drop(columns=['Alleged Issues'])
df = df.drop(columns=['Legal Premise'])
df = df.drop(columns=['Legal Course of Action'])


# MySQL connection parameters
host = '127.0.0.1'
user = 'root'
password = 'redacted'
database = 'redacted'
table_name = 'website_lawsuits'

# Connect to MySQL
connection = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=database
)

# Create a MySQL cursor
cursor = connection.cursor()

# Create the MySQL table if it doesn't exist
create_table_query = """
CREATE TABLE IF NOT EXISTS {} (
    `ID` INT,
    `Plaintiff Name` VARCHAR(255),
    `Defendant Name` VARCHAR(255),
    `State of Filing` VARCHAR(255),
    `Date of Filing` TEXT,
    `Industry` VARCHAR(255),
    `Website` TEXT,
    `Website Purpose` TEXT,
    `Summary` TEXT
);
""".format(table_name)

cursor.execute(create_table_query)

# Insert DataFrame rows into the MySQL table
try:
    for index, row in df.iterrows():
        values = tuple(row)
        columns = ', '.join([f"`{col}`" for col in df.columns])
        placeholders = ', '.join(['%s'] * len(df.columns))

        insert_query = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
        cursor.execute(insert_query, values)

    connection.commit()
    print("Data inserted successfully.")
except Exception as e:
    print(f"Error: {e}")
    connection.rollback()
finally:
    # Close the connection
    connection.close()