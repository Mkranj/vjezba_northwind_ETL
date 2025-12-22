# Izrada skladišta podataka za Northwind bazu narudžbi  

U ovom se projektu na temelju northwind baze podataka gradi baza koja predstavlja skladište podataka za daljnje analize. 
Kao primjer potencijalnih analiza rješeno je i par zadataka SQL upitima na izrađeno skladište.

Baza je dostupna na portu 1433 uz pokretanje naredbe `docker compose up`. Korisnik je *SA*, lozinka *CHANGEpass1!* .  

## Proces izgradnje skladišta podataka  
U SQL Server containeru izrađuje se transakcija baza `northwind`.  
Pomoću Python skripte u `etl/etl.py` provodi se ETL proces kojim se radi nova baza, `nw_skladiste_staging`, 
i u njoj izrađuju i pune relevantne tablice za skladište, s pripadajućim primarnim i stranim ključevima. SQL kojim se organizira 
postupak numeriran je i nalazi se u folderu `etl/SQL/`.

## Rješenja zadataka  
Nakon što je baza napravljena i ETL dovršen, možemo se spojiti na server i bazu skladišta, *nw_skladiste_staging*.  
Tada se na njoj mogu vrtiti rješenja zadataka pomoću upita u folderu `etl/zadaci_SQL`.  

Razlike od originalnih zadatak:  
U korištenoj northwind bazi postoje podaci samo za narudžbe od 1996 do 1998, pa su rješenja prilagođena tim godinama umjesto npr. 2017.  
U ovoj NW bazi nema eksplicitnih podataka o kontinentima kojima države pripadaju, pa nisu uključeni u rješenja (zadatak 1).