-- Izrada glavne činjenične tablice

CREATE TABLE fProdajaProizvod (
    sifProdajaProizvod INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    fOrderID INT NOT NULL,
    sifProizvod INT NOT NULL, 
    sifDatumProdaja INT NOT NULL,
    sifMjestoDobavljen INT NOT NULL,
    sifMjestoProdano INT NOT NULL,
    sifZaposlenik INT NOT NULL,
    komad INT NOT NULL,
    cijena DECIMAL(20, 3) NOT NULL,
    popust DECIMAL(20, 3) NOT NULL,
    prihod DECIMAL(20, 3) NOT NULL
);



-- punjenje tablice

WITH prodani_proizvodi AS (
    SELECT 
        OD.ProductID,
        OD.OrderID,
        OD.UnitPrice,
        OD.Quantity,
        OD.Discount,
        -- ukupni prihod - količina * snižena cijena
        (OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS totalIncome,
        Ord.EmployeeID,
        CAST(Ord.OrderDate AS DATE) AS OrderDate,
        Ord.ShipCity AS ShipCity,
        Suppliers.City AS SupplierCity
    FROM [northwind].[dbo].[Order Details] AS OD
    LEFT JOIN northwind.dbo.Orders AS Ord
    ON OD.OrderID = Ord.OrderID
    LEFT JOIN northwind.dbo.Products
    ON OD.ProductID = Products.ProductID
    LEFT JOIN northwind.dbo.Suppliers
    ON Products.SupplierID = Suppliers.SupplierID
) 
INSERT INTO fProdajaProizvod 
    (fOrderID, sifProizvod, sifDatumProdaja, sifMjestoDobavljen,
    sifMjestoProdano, sifZaposlenik,
    komad, cijena, popust, prihod)
SELECT
    prodani_proizvodi.OrderID, 
    proizvod.sifProizvod,
    datProdaja.sifDatum AS sifDatumProdaja,
    mjestDobavljen.sifMjesto AS sifMjestoDobavljen,
    mjestProdano.sifMjesto AS sifMjestoProdano,
    zaposlenik.sifzaposlenik AS sifZaposlenik,
    Quantity AS komad,
    UnitPrice AS cijena,
    Discount AS popust,
    totalIncome AS prihod
FROM prodani_proizvodi
LEFT JOIN dProizvod AS proizvod
ON prodani_proizvodi.ProductID = proizvod.fProductID
LEFT JOIN dDatum AS datProdaja
ON prodani_proizvodi.OrderDate = datProdaja.datum
LEFT JOIN dMjesto AS mjestDobavljen 
ON prodani_proizvodi.SupplierCity = mjestDobavljen.imeGrad
LEFT JOIN dMjesto AS mjestProdano
ON prodani_proizvodi.ShipCity = mjestProdano.imeGrad
LEFT JOIN dZaposlenik AS zaposlenik
ON prodani_proizvodi.EmployeeID = zaposlenik.fEmployeeID;

/*Zamjena NULL vrijednosti posebnim zapisima*/

UPDATE fProdajaProizvod
SET sifDatumProdaja = (SELECT sifdatum FROM dDatum WHERE datum = '0001-01-01')
WHERE sifDatumProdaja IS NULL;