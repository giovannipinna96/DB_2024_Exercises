--Creare il DB
CREATE DATABASE uni_db;

--Controllare di averlo creato
SHOW DATABASES;

--Selezionare il database
USE uni_db;

--Mostrare le tabelle create
SHOW TABLES;

--disattivare un vincolo
SET nomeVincolovoto = 0

--riattivare un vincolo
SET nomeVincolo = 1

--per un vincolo check
CONTRAINT nomeVincolo CHECK ...

--Disattivare i vincoli di integrità referenziale
SET
    foreign_key_checks = 0;

--Attivare i vincoli di integrità referenziale
SET
    foreign_key_checks = 1;

--Testiamo i vincoli
--Codice fiscale già esistente
INSERT INTO
    studenti
VALUES
    ("IN0500308", "Mario", "Rossi", "PNNGNN96L17123X");

--Testiamo i vincoli
--Un esame di un corso che non esiste 
INSERT INTO
    esami
VALUES
    ("111AA", "IN0500308", "2019-06-03", 25, NULL);

--Testiamo i vincoli
--Un 18 e lode 
INSERT INTO
    esami
VALUES
    ("511SM", "IN0500308", "2019-06-03", 18, TRUE);

--Update della tabella
ALTER TABLE studenti
ADD COLUMN genere CHAR(1) NOT NULL;

--Update
SET SQL_SAFE_UPDATES = 0;
UPDATE studenti SET genere = "M";
UPDATE studenti SET genere = "F"
WHERE SUBSTRING(cf, 10, 1) BETWEEN "4" AND "7";
SET SQL_SAFE_UPDATES = 1;

--Update tabella aggiunta vincolo
ALTER TABLE studenti ADD CHECK (genere IN ("M", "F"));

--delete DB
DROP DATABASE uni_db;
