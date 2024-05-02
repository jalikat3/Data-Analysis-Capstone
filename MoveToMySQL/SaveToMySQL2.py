import pandas as pd
import mysql.connector

# Read the CSV file into a DataFrame
df = pd.read_csv('Legal_Results_List.csv')

# MySQL connection parameters
host = '127.0.0.1'
user = 'root'
password = 'redacted'
database = 'redacted'
new_table_name = 'requested_result'

# Connect to MySQL
connection = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=database
)

# Create a MySQL cursor
cursor = connection.cursor()

# Create the new MySQL table if it doesn't exist
create_new_table_query = """
CREATE TABLE IF NOT EXISTS {} (
    `ID` INT,
    `Result_Num` VARCHAR(255),
    `Result` TEXT
);
""".format(new_table_name)

cursor.execute(create_new_table_query)

# Insert DataFrame rows into the new MySQL table
try:
    for index, row in df.iterrows():
        values = tuple(row)
        columns = ', '.join([f"`{col}`" for col in df.columns])
        placeholders = ', '.join(['%s'] * len(df.columns))

        insert_query = f"INSERT INTO {new_table_name} ({columns}) VALUES ({placeholders})"
        cursor.execute(insert_query, values)

    connection.commit()
    print("Data inserted successfully into the new table.")
except Exception as e:
    print(f"Error: {e}")
    connection.rollback()
finally:
    # Close the connection
    connection.close()
