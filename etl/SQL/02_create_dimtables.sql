-- Izrada tablice za mjesta dobavljanja, kupca

CREATE TABLE dMjesto (
    sifMjesto INT PRIMARY KEY IDENTITY (1, 1) NOT NULL ,
    imeGrad VARCHAR(100) NOT NULL,
    imeDrzava VARCHAR(100) NOT NULL
);


CREATE TABLE dProizvod (
    sifProizvod INT PRIMARY KEY IDENTITY (1, 1) NOT NULL ,
    -- originalna šifra - za spajanje pri punjenju činjeničnih
    fProductID INT NOT NULL,
    imeProizvod VARCHAR(100) NOT NULL,
    sifKategorija INT NOT NULL,
    imeKategorija VARCHAR(100) NOT NULL,
    sifMjestoDobavljen INT NOT NULL,
    
    CONSTRAINT fk_sifMjestoDobavljen FOREIGN KEY (sifMjestoDobavljen) REFERENCES dMjesto (sifMjesto)
);


CREATE INDEX dProizvod_mjestoDobavljen
ON dProizvod (sifMjestoDobavljen);

-- RESEARCH: indeksi za ključeve iz originalne baze? Rekao bih ne jer to ubrzava samo ETL, ne i korištenje

CREATE TABLE dZaposlenik (
    sifZaposlenik INT PRIMARY KEY IDENTITY (1, 1) NOT NULL ,
    -- originalna šifra - za spajanje pri punjenju činjeničnih
    fEmployeeID INT NOT NULL,
    imeZaposlenik VARCHAR(100) NOT NULL,
    prezimeZaposlenik VARCHAR(100) NOT NULL,
    sifMjestoZaposlenik INT NOT NULL,

    CONSTRAINT fk_sifMjestoZaposlenik FOREIGN KEY (sifMjestoZaposlenik) REFERENCES dMjesto (sifMjesto)
);

CREATE INDEX dZaposlenik_mjestoZaposlenik
ON dZaposlenik (sifMjestoZaposlenik);

--- Punjenje dimenzijskih tablica

WITH mjesta AS (
    SELECT DISTINCT 
    ShipCity AS City, ShipCountry AS Country
    FROM northwind.dbo.Orders
    -- kod zaposlenika ima dodatnih gradova
    UNION
    SELECT DISTINCT
        City, Country
    FROM northwind.dbo.Employees
    UNION
    SELECT DISTINCT
        City, Country
    FROM northwind.dbo.Suppliers
)
INSERT INTO dMjesto (imeGrad, imeDrzava)
SELECT City, Country
FROM mjesta;

--


WITH proizvodi AS (
    SELECT
        prod.ProductID AS fProductID,
        prod.ProductName AS imeProizvod,
        prod.CategoryID AS sifKategorija,
        CategoryName AS imeKategorija,
        mjestDobavljen.sifMjesto AS sifMjestoDobavljen
    FROM northwind.dbo.Products AS prod
    JOIN  northwind.dbo.Categories AS kat
    ON prod.CategoryID = kat.CategoryID
    LEFT JOIN northwind.dbo.Suppliers AS supplier
    ON prod.SupplierID = supplier.SupplierID
    LEFT JOIN dMjesto AS mjestDobavljen 
    ON supplier.City = mjestDobavljen.imeGrad
)
INSERT INTO dProizvod (fProductID, imeProizvod, sifKategorija, imeKategorija, sifMjestoDobavljen)
SELECT fProductID, imeProizvod, sifKategorija, imeKategorija, sifMjestoDobavljen
FROM proizvodi;

WITH zaposlenici AS (
    SELECT
        EmployeeID AS fEmployeeID,
        FirstName AS imeZaposlenik,
        LastName AS prezimeZaposlenik,
        dmj.sifMjesto AS sifMjestoZaposlenik
    FROM northwind.dbo.Employees AS emp
    LEFT JOIN dMjesto AS dmj 
    ON emp.City = dmj.imeGrad
)
INSERT INTO dZaposlenik (fEmployeeID, imeZaposlenik, prezimeZaposlenik, sifMjestoZaposlenik)
SELECT fEmployeeID, imeZaposlenik, prezimeZaposlenik, sifMjestoZaposlenik
FROM zaposlenici;