-- Trigger 1
-- Creazione della tabella assunzioni
CREATE TABLE
    assunzioni (
        matricola INT (4) PRIMARY KEY,
        data_assunzione DATE
    );

-- Trigger 1: Scrivere un trigger per tenere traccia delle assunzioni. 
-- Supporre che l’inserimento di un docente nel DB coincida con la sua data di assunzione.
-- ???
-- SELECT * FROM assunzioni;
-- INSERT INTO	professori (nome, cognome, cf, settore) VALUES ("NNome", "CCognome", "CCGNNM24A41L424I", "ING-INF/00");
-- SELECT * FROM assunzioni;
