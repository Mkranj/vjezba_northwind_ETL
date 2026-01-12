-- Izrada tablica za info o proizvodima, zaposlenicima i kupcima

CREATE TABLE dProizvod (
    sifProizvod INT PRIMARY KEY IDENTITY (1, 1) NOT NULL ,
    -- originalna šifra - za spajanje pri punjenju činjeničnih
    fProductID INT NOT NULL,
    imeProizvod VARCHAR(100) NOT NULL,
    sifKategorija INT NOT NULL,
    imeKategorija VARCHAR(100) NOT NULL,
    gradDobavljen VARCHAR(100) NOT NULL,
    drzavaDobavljen VARCHAR(100) NOT NULL
);


CREATE INDEX dProizvod_gradDobavljen
ON dProizvod (gradDobavljen);
CREATE INDEX dProizvod_drzavaDobavljen
ON dProizvod (drzavaDobavljen);

CREATE TABLE dZaposlenik (
    sifZaposlenik INT PRIMARY KEY IDENTITY (1, 1) NOT NULL ,
    -- originalna šifra - za spajanje pri punjenju činjeničnih
    fEmployeeID INT NOT NULL,
    imeZaposlenik VARCHAR(100) NOT NULL,
    prezimeZaposlenik VARCHAR(100) NOT NULL,
    gradZaposlenik VARCHAR(100) NOT NULL,
    drzavaZaposlenik VARCHAR(100) NOT NULL
);

CREATE INDEX dZaposlenik_gradZaposlenik
ON dZaposlenik (gradZaposlenik);
CREATE INDEX dZaposlenik_drzavaZaposlenik
ON dZaposlenik (drzavaZaposlenik);


CREATE TABLE dKupac (
    sifKupac INT PRIMARY KEY IDENTITY (1, 1) NOT NULL ,
    -- originalna šifra - za spajanje pri punjenju činjeničnih
    fCustomerID VARCHAR(100) NOT NULL,
    imeKupca VARCHAR(100) NOT NULL,
    gradKupca VARCHAR(100) NOT NULL,
    drzavaKupca VARCHAR(100) NOT NULL
);

CREATE INDEX dKupac_gradKupca
ON dKupac (gradKupca);
CREATE INDEX dZaposlenik_drzavaKupca
ON dKupac (drzavaKupca);

--- Punjenje dimenzijskih tablica

WITH proizvodi AS (
    SELECT
        prod.ProductID AS fProductID,
        prod.ProductName AS imeProizvod,
        prod.CategoryID AS sifKategorija,
        CategoryName AS imeKategorija,
        supplier.City AS grad,
        supplier.Country AS drzava
    FROM northwind.dbo.Products AS prod
    JOIN  northwind.dbo.Categories AS kat
    ON prod.CategoryID = kat.CategoryID
    LEFT JOIN northwind.dbo.Suppliers AS supplier
    ON prod.SupplierID = supplier.SupplierID
)
INSERT INTO dProizvod (fProductID, imeProizvod, sifKategorija, imeKategorija, gradDobavljen, drzavaDobavljen)
SELECT fProductID, imeProizvod, sifKategorija, imeKategorija, grad, drzava
FROM proizvodi;

WITH zaposlenici AS (
    SELECT
        EmployeeID AS fEmployeeID,
        FirstName AS imeZaposlenik,
        LastName AS prezimeZaposlenik,
        emp.City AS grad,
        emp.Country AS drzava
    FROM northwind.dbo.Employees AS emp
)
INSERT INTO dZaposlenik (fEmployeeID, imeZaposlenik, prezimeZaposlenik, gradZaposlenik, drzavaZaposlenik)
SELECT fEmployeeID, imeZaposlenik, prezimeZaposlenik, grad, drzava
FROM zaposlenici;


WITH kupci AS (
    SELECT
        cust.CustomerID AS CustomerID,
        cust.ContactName AS ContactName,
        cust.City AS grad,
        cust.Country AS drzava
    FROM northwind.dbo.Customers AS cust
)
INSERT INTO dKupac (fCustomerID, imeKupca, gradKupca, drzavaKupca)
SELECT CustomerID, ContactName, grad, drzava
FROM kupci;