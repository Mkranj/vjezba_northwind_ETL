SELECT 
       zaposlenikMjesto.imedrzava,
       SUM(prihod) AS prihodi
FROM fProdajaProizvod
JOIN dDatum
ON fprodajaproizvod.sifdatumprodaja = ddatum.sifdatum
JOIN dzaposlenik
ON fprodajaproizvod.sifzaposlenik = dzaposlenik.sifzaposlenik
JOIN dMjesto AS zaposlenikMjesto
ON dzaposlenik.sifmjestozaposlenik = zaposlenikMjesto.sifmjesto
WHERE dDatum.godina = 1997
GROUP BY zaposlenikMjesto.ImeDrzava;