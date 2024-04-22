-- Query 5.1: mostrare la media ponderata di ogni studente
SELECT s.matricola, s.nome, s.cognome,
    SUM(e.voto * c.cfu)/SUM(c.cfu) as media
FROM studenti s
INNER JOIN esami e
ON s.matricola = e.studente
INNER JOIN corsi c
ON e.corso = c.codice
GROUP BY e.studente;

-- Query 6: quanti studenti non hanno mai preso una lode?
SELECT *
FROM studenti s
WHERE
    NOT EXISTS (
        SELECT *
        FROM esami e
        WHERE e.lode = TRUE AND e.studente = s.matricola
    );

-- Query 6 alternativa
SELECT *
FROM studenti s
WHERE s.matricola NOT IN(
    SELECT DISTINCT studente
    FROM esami e
    WHERE e.lode = TRUE
);

-- Query 7: Quali docenti svolgono un monte ore minore di 120 ore?
SELECT p.nome, p.cognome, SUM(8 * c.cfu ) as monte_ore
FROM professori p
INNER JOIN corsi c ON p.matricola = c.professore
GROUP BY c.professore
HAVING monte_ore < 120;

-- Query 8: Verificare casi di omonimia tra studenti e/o professori
SELECT nome, cognome, COUNT(*) AS c
FROM (
    SELECT nome, cognome
    FROM studenti
    UNION ALL
    SELECT nome, cognome
    FROM professori) AS t
GROUP BY nome, cognome
ORDER BY c DESC;

-- Prepared statement 1: 
-- Creare un prepared statement che mostri tutti gli studenti appartenenti ad un corso di laurea passato come parametro
PREPARE studenti_cdl FROM
    "SELECT *
    FROM studenti
    WHERE matricola LIKE CONCAT(?, '%')";

-- usiamo lo statement per mostrare gli ingegneri informatici della triennale
SET @cdl = "IN05";
EXECUTE studenti_cdl USING @cdl;


-- PREPARED statement 2
-- Creare un prepared statement che mostri tutti gli studenti che hanno superato l'esame di un dato corso, il cui codice è passato come parametro
PREPARE studenti_superato_corso FROM
    "SELECT s.nome, s.cognome, s.matricola
    FROM studenti s
    INNER JOIN esami e
    ON s.matricola = e.studente
    WHERE e.corso = ?";

-- usiamo lo statement per mostrare gli studenti 
-- che hanno passato il corso di basi di dati (079IN)
SET @codice_corso = "079IN";
EXECUTE studenti_superato_corso USING @codice_corso;


-- Vista 1: Quali sono i voti preferti di ogni professore?
CREATE VIEW dist_voti AS
SELECT p.matricola, p.nome, p.cognome, e.voto, COUNT(e.voto) as n_voti
FROM professori p
INNER JOIN corsi c ON p.matricola = c.professore
    INNER JOIN esami e ON c.codice = e.corso
    GROUP BY p.matricola, e.voto;

-- ora scgliamo il voto più frequente per ogni docente
SELECT DISTINCT matricola, nome, cognome, voto
FROM dist_voti d1
WHERE n_voti = (
    SELECT MAX(n_voti)
    FROM dist_voti d2
    WHERE d1.matricola = d2.matricola
);

-- Vista 2: quali sono gli studenti più "bravi" di ogni corso di laurea?
CREATE VIEW bravura_per_cdl AS
SELECT s.matricola, s.nome, s.cognome, SUBSTRING(s.matricola, 1, 4) as cdl,
    SUM(e.voto * c.cfu) as bravura
FROM studenti s
INNER JOIN esami e ON s.matricola = e.studente
    INNER JOIN corsi c ON e.corso = c.codice
GROUP BY s.matricola;

-- scgliamo il più bravo di ciascun corso
SELECT DISTINCT matricola, nome, cognome, cdl
FROM bravura_per_cdl b1
WHERE bravura = (
    SELECT MAX(bravura)
    FROM bravura_per_cdl b2
    WHERE b1.cdl = b2.cdl
);

