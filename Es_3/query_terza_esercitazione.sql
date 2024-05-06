-- Qual è il corso scoperto
SELECT *
FROM corsi c
WHERE professore IS NULL;


-- Qual è il professore meno impegnato
SELECT matricola, SUM(cfu) AS cfu_tot
FROM professori p
INNER JOIN corsi c ON c.professore = p.matricola
GROUP BY professore
ORDER BY cfu_tot ASC
LIMIT 1;

-- Creazione della transizione
START TRANSACTION;

SELECT @prof := matricola, sum(cfu) as cfu_tot
FROM professori p
INNER JOIN corsi c ON c.professore = p.matricola
GROUP BY professore
ORDER BY cfu_tot ASC
LIMIT 1;

UPDATE corsi
SET professore = @prof
WHERE professore IS NULL;

COMMIT;

-- to check
-- select * from corsi where professore=41;

-- Stored procedure che scriva in una variabile passata il monte ore
-- di un dato docente. Lanciare un errore se il docente non esiste.
DELIMITER $$
CREATE PROCEDURE MonteOre(IN docente INT, OUT ore INT)
BEGIN
    SELECT SUM(cfu * 8)
    INTO ore
    FROM corsi c
    WHERE professore = docente;
    IF ore IS NULL THEN
        SIGNAL SQLSTATE "02000"
        SET MESSAGE_TEXT = "Docente not found !";
    END IF;
END $$
DELIMITER;

-- call MonteOre(41, @ore);
-- select @ore;
-- show create procedure MonteOre;

-- Defined function che restituisca il corso di laurea di un dato studente.
DELIMITER $$
CREATE FUNCTION cdl(matricola CHAR(9))
RETURNS CHAR(4) DETERMINISTIC
BEGIN
    RETURN SUBSTRING(matricola, 1, 4);
END $$
DELIMITER;

-- select cdl("IN0512345");

-- Defined function che restituisce la media ponderata di un dato studente
-- (Help function)
DELIMITER $$
CREATE FUNCTION media_ponderata(matricola CHAR(9))
RETURNS float DETERMINISTIC
BEGIN
    DECLARE mp float;
    SELECT SUM(c.cfu * e.voto) / SUM(c.cfu)
    INTO mp
    FROM esami e INNER JOIN corsi c ON e.corso = c.codice
    WHERE e.studente = matricola;
    RETURN(mp);
END $$
DELIMITER;

-- DROP FUNCTION IF EXISTS media_ponderata;
-- SHOW CREATE FUNCTION media_ponderata;
-- select media_ponderata('IN0500273');

-- Defined function che restituisca il rank di uno studente nel suo corso di laurea
-- in base alla sua media ponderata.
DELIMITER $$
CREATE FUNCTION rank_cdl(matricola CHAR(9))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE r INT ;
    SELECT COUNT(*)
    INTO r
    FROM studenti s
    WHERE cdl(s.matricola) = cdl(matricola) AND
    media_ponderata(s.matricola) >= media_ponderata(matricola);
    RETURN(r);
END $$
DELIMITER;

-- select rank_cdl('IN0500273');


-- Trigger 1
-- Creazione della tabella assunzioni
CREATE TABLE assunzioni (
matricola INT(4) PRIMARY KEY,
data_assunzione DATE
);

-- Trigger 1
DELIMITER $$
CREATE TRIGGER trg_data_assunzione
AFTER INSERT ON professori
FOR EACH ROW BEGIN
    INSERT INTO assunzioni VALUES (NEW.matricola, CURDATE());
END $$
DELIMITER;

-- select * from assunzioni;
-- INSERT INTO	professori (nome, cognome, cf, settore)
-- VALUES ("NNome", "CCognome", "CCGNNM24A41L424I", "ING-INF/00");
-- select * from assunzioni;

