--broj proizvoda koji su dobavljeni iz iste države u kojoj su i prodani u 2018. godini, prema državama

SELECT 
        dobava.Imedrzava,
        SUM(komad) AS broj_proizvoda
FROM fProdajaProizvod
JOIN dDatum
ON fprodajaproizvod.sifdatumprodaja = ddatum.sifdatum
JOIN dproizvod AS proizvod
ON fprodajaproizvod.sifproizvod = proizvod.sifproizvod
JOIN dmjesto AS dobava
ON proizvod.sifmjestodobavljen = dobava.sifmjesto
JOIN dmjesto AS prodano
ON fprodajaproizvod.sifmjestoprodano = dobava.sifmjesto
WHERE ddatum.godina = 1997
AND dobava.imedrzava = prodano.imedrzava
GROUP BY dobava.imedrzava;