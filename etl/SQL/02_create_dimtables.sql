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
    imeKategorija VARCHAR(100) NOT NULL,
);

--- Punjenje dimenzijskih tablica

WITH mjesta AS (
    SELECT DISTINCT ShipCity, ShipCountry
    FROM northwind.dbo.Orders
)
INSERT INTO dMjesto (imeGrad, imeDrzava)
SELECT ShipCity, ShipCountry
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