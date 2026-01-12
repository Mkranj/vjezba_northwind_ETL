--usporedba ukupnih prihoda u 2017 godini u odnosu na državu u kojoj je zaposlenik

SELECT 
       dzaposlenik.drzavaZaposlenik,
       SUM(prihod) AS prihodi
FROM fProdajaProizvod
JOIN dDatum
ON fprodajaproizvod.sifdatumprodaja = ddatum.sifdatum
JOIN dzaposlenik
ON fprodajaproizvod.sifzaposlenik = dzaposlenik.sifzaposlenik
WHERE dDatum.godina = 1997
GROUP BY dzaposlenik.drzavaZaposlenik;