--broj proizvoda koji su dobavljeni iz iste države u kojoj su i prodani u 2018. godini, prema državama


SELECT 
        proizvod.drzavaDobavljen,
        SUM(komad) AS broj_proizvoda
FROM fProdajaProizvod
JOIN dDatum
ON fprodajaproizvod.sifdatumprodaja = ddatum.sifdatum
JOIN dproizvod AS proizvod
ON fprodajaproizvod.sifproizvod = proizvod.sifproizvod
JOIN dkupac AS kupac
ON fprodajaproizvod.sifkupac = kupac.sifkupac
WHERE ddatum.godina = 1997
AND kupac.drzavaKupca = proizvod.drzavaDobavljen
GROUP BY proizvod.drzavaDobavljen;