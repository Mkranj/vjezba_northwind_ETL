SELECT 
        --dzaposlenik.sifzaposlenik,
        CONCAT(dzaposlenik.imezaposlenik, ' ', dzaposlenik.prezimezaposlenik) AS zaposlenik,
        AVG(popust) AS prosjecni_popust,
        MAX(popust) AS najveci_popust
FROM fProdajaProizvod
JOIN dDatum
ON fprodajaproizvod.sifdatumprodaja = ddatum.sifdatum
JOIN dzaposlenik
ON fprodajaproizvod.sifzaposlenik = dzaposlenik.sifzaposlenik
WHERE dDatum.danutjednu IN (4, 5) -- gledamo popuste četvrtkom i petkom
GROUP BY --dzaposlenik.sifzaposlenik,
        CONCAT(dzaposlenik.imezaposlenik, ' ', dzaposlenik.prezimezaposlenik)
ORDER BY AVG(popust) DESC;