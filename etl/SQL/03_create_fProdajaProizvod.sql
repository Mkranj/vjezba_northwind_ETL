-- Izrada glavne činjenične tablice

CREATE TABLE fProdajaProizvod (
    sifProdajaProizvod INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    sifProizvod INT NOT NULL, 
    sifDatumProdaja INT NOT NULL,
    sifMjestoProdano INT NOT NULL,
    sifZaposlenik INT NOT NULL,
    komad INT NOT NULL,
    cijena DECIMAL(20, 3) NOT NULL,
    popust DECIMAL(20, 3) NOT NULL,
    prihod DECIMAL(20, 3) NOT NULL,
    
    CONSTRAINT fk_sifProizvod FOREIGN KEY (sifProizvod) REFERENCES dProizvod (sifProizvod),
    CONSTRAINT fk_sifDatumProdaja FOREIGN KEY (sifDatumProdaja) REFERENCES dDatum (sifDatum),
    CONSTRAINT fk_sifMjestoProdano FOREIGN KEY (sifMjestoProdano) REFERENCES dMjesto (sifMjesto),
    CONSTRAINT fk_sifZaposlenik FOREIGN KEY (sifZaposlenik) REFERENCES dZaposlenik (sifZaposlenik)
);


CREATE INDEX fProdajaProizvod_proizvod
ON fProdajaProizvod (sifProizvod);
CREATE INDEX fProdajaProizvod_datumProdaja
ON fProdajaProizvod (sifDatumProdaja);
CREATE INDEX fProdajaProizvod_mjestoProdano
ON fProdajaProizvod (sifMjestoProdano);
CREATE INDEX fProdajaProizvod_zaposlenik
ON fProdajaProizvod (sifZaposlenik);

-- punjenje tablice

WITH prodani_proizvodi AS (
    SELECT 
        OD.ProductID,
        OD.UnitPrice,
        OD.Quantity,
        -- popust je postotak -> bolje nam je IZNOS popusta spremati, smislenija kao mjera. Pa postotak možemo po potrebi računati u upitima
        (OD.UnitPrice * OD.Discount) AS Discount,
        -- ukupni prihod - količina * snižena cijena
        (OD.Quantity * (OD.UnitPrice - (OD.UnitPrice * OD.Discount)) ) AS totalIncome,
        Ord.EmployeeID,
        CAST(Ord.OrderDate AS DATE) AS OrderDate,
        Ord.ShipCity AS ShipCity
    FROM [northwind].[dbo].[Order Details] AS OD
    LEFT JOIN northwind.dbo.Orders AS Ord
    ON OD.OrderID = Ord.OrderID
) 
INSERT INTO fProdajaProizvod 
    (sifProizvod, sifDatumProdaja,
    sifMjestoProdano, sifZaposlenik,
    komad, cijena, popust, prihod)
SELECT
    proizvod.sifProizvod,
    datProdaja.sifDatum AS sifDatumProdaja,
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
LEFT JOIN dMjesto AS mjestProdano
ON prodani_proizvodi.ShipCity = mjestProdano.imeGrad
LEFT JOIN dZaposlenik AS zaposlenik
ON prodani_proizvodi.EmployeeID = zaposlenik.fEmployeeID;

/*Zamjena NULL vrijednosti posebnim zapisima*/

UPDATE fProdajaProizvod
SET sifDatumProdaja = (SELECT sifdatum FROM dDatum WHERE datum = '0001-01-01')
WHERE sifDatumProdaja IS NULL;