-- Query 1: elencare tutti gli studenti iscritti ad ingegneria
SELECT
    *
FROM
    studenti
WHERE
    matricola LIKE "IN%";

-- Query 2: elencare tutte le ragazze iscritte a ingegneria.
SELECT
    *
FROM
    studenti
WHERE
    matricola LIKE "IN%"
    AND (
        cf LIKE "_________4%"
        OR cf LIKE "_________5%"
        OR cf LIKE "_________6%"
        OR cf LIKE "_________7%"
    );

-- Query 2 alternativa 1
SELECT
    *
FROM
    studenti
WHERE
    matricola LIKE "IN%"
    AND SUBSTRING(cf, 10, 1) IN ("4", "5", "6", "7");

-- Query 2 alternativa 2
SELECT
    *
FROM
    studenti
WHERE
    matricola LIKE "IN%"
    AND SUBSTRING(cf, 10, 1) BETWEEN "4" AND "7";

-- Query 2: modifica al DB
ALTER TABLE studenti
ADD COLUMN genere CHAR(1) NOT NULL;

SET
    SQL_SAFE_UPDATES = 0;

UPDATE studenti
SET
    genere = "M";

UPDATE studenti
SET
    genere = "F"
WHERE
    SUBSTRING(cf, 10, 1) BETWEEN "4" AND "7";

SET
    SQL_SAFE_UPDATES = 1;

ALTER TABLE studenti ADD CHECK (genere IN ("M", "F"));

-- Query 2: dopo la modifica del DB
SELECT
    *
FROM
    studenti
WHERE
    matricola LIKE "IN%"
    AND genere = "F";

-- Query 3: quanti studenti hanno preso una lode negli esami del prof. De Lorenzo?
SELECT
    COUNT(DISTINCT e.studente) as n_lodati
FROM
    esami e
    INNER JOIN corsi c ON e.corso = c.codice
    INNER JOIN professori p ON c.professore = p.matricola
WHERE
    e.lode = TRUE
    AND p.cognome = "De Lorenzo";

-- Query 4: quali studenti hanno preso più di una lode con il prof. De Lorenzo?
SELECT
    e.studente,
    COUNT(e.lode) as n_lodi
FROM
    esami e
    INNER JOIN corsi c ON e.corso = c.codice
    INNER JOIN professori p ON c.professore = p.matricola
WHERE
    e.lode = TRUE
    AND p.cognome = "De Lorenzo"
GROUP BY
    e.studente
HAVING
    n_lodi >= 2;

-- Query 5: media ponderata per uno specifico studente (in questo caso per la matricola "IN0500273")
SELECT
    e.studente,
    SUM(e.voto * c.cfu) / SUM(c.cfu) AS media_ponderata
FROM
    esami e
    INNER JOIN corsi c ON e.corso = c.codice
WHERE
    e.studente = 'IN0500273'
GROUP BY
    e.studente;

-- Query 6: trovare lo studente più performante in ogni corso
-- Query 7: calcolare la media dei voti per ogni corso
-- Query 8: calcolare il totale di cfu ottenuti da ogni studente
-- Query 9: lista degli studenti che hanno fatto un esame in ogni settore