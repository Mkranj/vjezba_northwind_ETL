SELECT 
        dproizvod.imeproizvod,
        SUM(prihod) AS prihodi
FROM fProdajaProizvod
JOIN dDatum
ON fprodajaproizvod.sifdatumprodaja = ddatum.sifdatum
JOIN dproizvod
ON fprodajaproizvod.sifproizvod = dproizvod.sifproizvod
WHERE dproizvod.imeKategorija = 'Dairy Products'
AND ddatum.dobagodine = 3 --zima
GROUP BY dproizvod.imeproizvod
ORDER BY SUM(prihod) DESC;