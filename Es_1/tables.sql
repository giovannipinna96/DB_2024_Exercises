--Creare la tabella studente
CREATE TABLE
    studenti (
        matricola CHAR(9) PRIMARY KEY,
        nome VARCHAR(45) NOT NULL,
        cognome VARCHAR(45) NOT NULL,
        cf CHAR(16) NOT NULL UNIQUE
    );

--Creare la tabella professore
CREATE TABLE
    professori (
        matricola INT (4) PRIMARY KEY AUTO_INCREMENT,
        nome VARCHAR(45) NOT NULL,
        cognome VARCHAR(45) NOT NULL,
        cf CHAR(16) NOT NULL UNIQUE,
        settore VARCHAR(12) NOT NULL
    );

--Creare la tabella corso
CREATE TABLE
    corsi (
        codice CHAR(5) PRIMARY KEY,
        nome VARCHAR(45) NOT NULL,
        cfu TINYINT NOT NULL,
        professore INT (4),
        FOREIGN KEY (professore) REFERENCES professori (matricola) ON DELETE SET NULL
    );

--Creare la tabella esame
CREATE TABLE
    esami (
        corso CHAR(5),
        studente CHAR(9),
        data DATE,
        voto TINYINT NOT NULL,
        lode BOOL DEFAULT FALSE,
        FOREIGN KEY (corso) REFERENCES corsi (codice),
        FOREIGN KEY (studente) REFERENCES studenti (matricola) ON DELETE CASCADE,
        CHECK (voto BETWEEN 18 AND 30),
        CHECK (
            (
                voto <= 30
                AND lode = FALSE
            )
            OR (
                voto = 30
                AND lode = TRUE
            )
        )
    );