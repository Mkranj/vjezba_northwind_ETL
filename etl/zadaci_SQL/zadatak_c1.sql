--usporedba ukupnih prihoda po kategorijama proizvoda prodanih u 2017. godini, po kontinentima

SELECT 
        imeKategorija,
        SUM(prihod) AS prihodi
FROM fProdajaProizvod
JOIN dDatum
ON fprodajaproizvod.sifdatumprodaja = ddatum.sifdatum
JOIN dproizvod
ON fprodajaproizvod.sifproizvod = dproizvod.sifproizvod
WHERE ddatum.godina = 1997
GROUP BY imeKategorija;

-- NEMAMO info o kontinentima, pa su izostavljeni!