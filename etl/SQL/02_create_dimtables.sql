-- Izrada tablice za mjesta dobavljanja, kupca

CREATE TABLE dMjesto (
    sifMjesto INT IDENTITY (1, 1) NOT NULL ,
    imeGrad VARCHAR(100) NOT NULL,
    imeDrzava VARCHAR(100) NOT NULL
);


CREATE TABLE dProizvod (
    sifProizvod INT IDENTITY (1, 1) NOT NULL ,
    -- originalna šifra - za spajanje pri punjenju činjeničnih
    fProductID INT NOT NULL,
    imeProizvod VARCHAR(100) NOT NULL,
    sifKategorija INT NOT NULL,
    imeKategorija VARCHAR(100) NOT NULL
);

CREATE TABLE dZaposlenik (
    sifZaposlenik INT IDENTITY (1, 1) NOT NULL ,
    -- originalna šifra - za spajanje pri punjenju činjeničnih
    fEmployeeID INT NOT NULL,
    imeZaposlenik VARCHAR(100) NOT NULL,
    prezimeZaposlenik VARCHAR(100) NOT NULL,
    sifMjestoZaposlenik INT NOT NULL,
);

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
)
INSERT INTO dMjesto (imeGrad, imeDrzava)
SELECT City, Country
FROM mjesta;


WITH proizvodi AS (
    SELECT DISTINCT
        prod.ProductID AS fProductID,
        ProductName AS imeProizvod,
        prod.CategoryID AS sifKategorija,
        CategoryName AS imeKategorija 
    FROM northwind.dbo.Products AS prod
    JOIN  northwind.dbo.Categories AS kat
    ON prod.CategoryID = kat.CategoryID
)
INSERT INTO dProizvod (fProductID, imeProizvod, sifKategorija, imeKategorija)
SELECT fProductID, imeProizvod, sifKategorija, imeKategorija
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