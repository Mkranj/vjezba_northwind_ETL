# Pokretanje SQL-ova s rješenjima zadataka

# Za provjeru ispravnosti napravljene baze podataka

# Pokrenuti iz root foldera sa
#`SA_PASSWORD='<password>' python etl/zadaci_SQL/pokreni_rjesenja.py`

import pyodbc
import os
from pathlib import Path


print("Konekcija na skladište")

conn_skladiste = pyodbc.connect(
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=127.0.0.1;"
    "PORT=1433;"
    "DATABASE=nw_skladiste_staging;"
    "UID=sa;"
    "PWD=" + os.environ.get("SA_PASSWORD") + ";"
    "Encrypt=yes;"
    "TrustServerCertificate=yes;"
)

def readSQLFile(filepath: Path) -> str:
    with open(filepath, "r") as file:
        content = file.readlines()

    content = "\n".join(content)
    return(content)


print("Zadatak 1")

zad_1 = readSQLFile(Path("etl/zadaci_sql/zadatak_c1.sql"))

with conn_skladiste.cursor() as cursor:
    cursor.execute(zad_1)
    results = cursor.fetchall()

    for row in results:
        print(row)

print("\nZadatak 2")

zad_2 = readSQLFile(Path("etl/zadaci_sql/zadatak_c2.sql"))

with conn_skladiste.cursor() as cursor:
    cursor.execute(zad_2)
    results = cursor.fetchall()

    for row in results:
        print(row)

        
print("\nZadatak 3")

zad_3 = readSQLFile(Path("etl/zadaci_sql/zadatak_c3.sql"))

with conn_skladiste.cursor() as cursor:
    cursor.execute(zad_3)
    results = cursor.fetchall()

    for row in results:
        print(row)

print("\nZadatak 4")

zad_4 = readSQLFile(Path("etl/zadaci_sql/zadatak_c4.sql"))

with conn_skladiste.cursor() as cursor:
    cursor.execute(zad_4)
    results = cursor.fetchall()

    for row in results:
        print(row)

print("\nZadatak 5")

zad_5 = readSQLFile(Path("etl/zadaci_sql/zadatak_c5.sql"))

with conn_skladiste.cursor() as cursor:
    cursor.execute(zad_5)
    results = cursor.fetchall()

    for row in results:
        print(row)