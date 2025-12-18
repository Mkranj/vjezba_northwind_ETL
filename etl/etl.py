import pyodbc
import os

conn = pyodbc.connect(
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=sqlserver;"
    "DATABASE=master;"
    "UID=sa;"
    "PWD=" + os.environ.get("SA_PASSWORD") + ";"
    "Encrypt=yes;"
    "TrustServerCertificate=yes;"
)

cursor = conn.cursor()
# We are not guaranteed to run ETL AFTER the db is created.
# So we connect to master db first,
# and then wait for Northwind
cursor.execute("USE Northwind")

# Example ETL: add a row
cursor.execute("""
INSERT INTO Customers (CustomerID, CompanyName)
VALUES ('ZZZZZ', 'ETL Insert Test')
""")

conn.commit()
conn.close()

print("ETL complete")