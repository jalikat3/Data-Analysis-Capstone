import pandas as pd
import mysql.connector

df = pd.read_csv('your-csv.csv')

host = '127.0.0.1'
user = 'your-user'
password = 'redacted-password'
database = 'redacted-db-name'
new_table_name = 'alleged_issues'

connection = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=database
)

cursor = connection.cursor()

create_new_table_query = """
CREATE TABLE IF NOT EXISTS {} (
    `ID` INT,
    `Issue_Num` VARCHAR(255),
    `Issue` TEXT
);
""".format(new_table_name)

cursor.execute(create_new_table_query)

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
    connection.close()
