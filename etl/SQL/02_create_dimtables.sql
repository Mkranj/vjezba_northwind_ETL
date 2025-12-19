-- Izrada tablice za mjesta dobavljanja, kupca

CREATE TABLE dMjesto (
    sifMjesto INT IDENTITY (1, 1) NOT NULL ,
    imeGrad VARCHAR(100) NOT NULL,
    imeDrzava VARCHAR(100) NOT NULL
);


CREATE TABLE dProizvod (
    sifProizvod INT IDENTITY (1, 1) NOT NULL ,
    imeProizvod VARCHAR(100) NOT NULL,
    sifKategorija INT NOT NULL,
    imeKategorija VARCHAR(100) NOT NULL,
);

