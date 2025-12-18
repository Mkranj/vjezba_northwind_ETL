/*
Osnovna dimenzijska tablica su datumi, napraviti tablicu od najranijeg do najkasnijeg datuma
*/

CREATE TABLE dDatum (
    sifDatum INT IDENTITY (1, 1) NOT NULL ,
    datum DATE,
    dan SMALLINT,
    mjesec SMALLINT,
    godina SMALLINT,
    danUTjednu SMALLINT,
    vikend SMALLINT,
    -- 0 proljeće, 3 zima
    dobaGodine SMALLINT
);