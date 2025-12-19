import pyodbc
import os
from pathlib import Path

conn_master = pyodbc.connect(
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=sqlserver;"
    "DATABASE=master;"
    "UID=sa;"
    "PWD=" + os.environ.get("SA_PASSWORD") + ";"
    "Encrypt=yes;"
    "TrustServerCertificate=yes;",
    # without autocommit everything is immediately a transaction, which
    # prevents us from creating databases
    autocommit=True
)

def readSQLFile(filepath: Path) -> str:
    with open(filepath, "r") as file:
        content = file.readlines()

    content = "\n".join(content)
    return(content)

# kreiranje i korištenje baze trebalo bi uvijek biti zaseban execute statement

with conn_master.cursor() as cursor:
    cursor.execute("CREATE DATABASE nw_skladiste_staging;")

# Na kraju, ako sve prođe okej, kopirati staging u actual bazu.
# U pravom procesu ovo bi zamijenilo trenutno aktivnu.

conn_master.close()

# umjesto korištenja USE DB, bolje napraviti konekciju direktno na taj DB pa iz nje raditi kursore

conn_nws = pyodbc.connect(
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=sqlserver;"
    "DATABASE=nw_skladiste_staging;"
    "UID=sa;"
    "PWD=" + os.environ.get("SA_PASSWORD") + ";"
    "Encrypt=yes;"
    "TrustServerCertificate=yes;",
    # without autocommit everything is immediately a transaction, which
    # prevents us from creating databases
    autocommit=True
)

# Kreiranje dimenzijskih tablica ----

create_ddatum_sql = readSQLFile(Path("SQL/01_create_dDatum.sql"))

with conn_nws.cursor() as cursor:
    cursor.execute(create_ddatum_sql)
conn_nws.commit()


create_dim_sql = readSQLFile(Path("SQL/02_create_dimtables.sql"))

with conn_nws.cursor() as cursor:
    cursor.execute(create_dim_sql)
conn_nws.commit()

conn_nws.close()

print("ETL complete")