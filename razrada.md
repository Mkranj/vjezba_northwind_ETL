# NorthWind skladište podataka  

## Ključne činjenice  
- prodaja jednog proizvoda u sklopu narudžbe (količina može biti 1+), s info o proizvodu, prodavaču, primijenjenom popustu, ukupnom prihodu, zaposleniku, državi dobavljeno, državi prodano. Cijena u trenutku?


## Dimenzijske tablice

dDatum -> datum prodaje
dProizvod - sifProizvod, imeProizvod, sifKatProizvod, imeKatProizvod
dMjesto - sifMjesto, imeMjesto, sifDrzava, imeDrzava -> dobavljač, kupac, zaposlenik
dZaposlenik - sifZaposlenik, imeZaposlenik, prezimeZaposlenik, sifMjestoZaposlenik?


## Činjenična tablica
fProdajaProizvod 
    - sifProdajaProizvod,
-- info iz transakcijske, kojoj narudžbi pripada?
    - tSifNarudzba
-- strani ključevi
    - sifProizvod, sifDatumProdaja, sifMjestoDobavljen, sifMjestoProdano, sifZaposlenik,
-- mjere
    - komad, cijena, popust, prihod