-- Defined function che restituisca il corso di laurea di un dato studente.
-- ???

-- SELECT cdl("IN0512345");

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

-- SHOW CREATE FUNCTION media_ponderata;
-- SELECT media_ponderata('IN0500273');

-- Defined function che restituisca il rank di uno studente nel suo corso di laurea
-- in base alla sua media ponderata.

-- ???

-- For test
-- SELECT rank_cdl('IN0500273');
