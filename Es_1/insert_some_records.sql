-- Inserire degli studenti
INSERT INTO
    studenti
VALUES
    (
        "DR1400034",
        "Giovanni",
        "Pinna",
        "PNNGNN96L17123X"
    ),
    (
        "SM3211162",
        "Leonardo",
        "Bianchi",
        "BNCLRD99A12L424Y"
    );

-- Inserire dei professori
INSERT INTO
    professori (nome, cognome, cf, settore)
VALUES
    (
        "Andrea",
        "De Lorenzo",
        "DLRNDR84B11G642N",
        "ING-INF/05"
    ),
    (
        "Eric",
        "Medvet",
        "MDVRCE79C02L424U",
        "ING-INF/05"
    );

-- Inseriamo dei corsi
INSERT INTO
    corsi
VALUES
    ("079IN", "Basi di Dati", 9, 0001);

INSERT INTO
    corsi (codice, nome, cfu)
VALUES
    ("511SM", "Natural language processing", 6);

-- Inseriamo degli esami
INSERT INTO
    esami
VALUES
    ("079IN", "DR1400034", "2023-06-03", 30, TRUE);

INSERT INTO
    esami (corso, studente, data, voto)
VALUES
    ("079IN", "SM3211162", "2021-06-23", 28);
