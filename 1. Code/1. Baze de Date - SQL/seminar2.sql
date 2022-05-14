REM   Script: BD - Seminar 2 - Comenzi LDD
REM   Baze de Date - Seminar 2 - Comenzi LDD

-- CREATE TABLE
-- Exemplul 1. Sa se creeze tabela agenti paza si tabela firme in care sa fie precizate restrictiile de integritate.
-- 1. CREARE TABELA AGENTI PAZA
CREATE TABLE agenti_paza 
( 
    id_agent        NUMBER(3)       PRIMARY KEY, 
    nume            VARCHAR2(20)    NOT NULL, 
    prenume         VARCHAR2(20)    NOT NULL, 
    data_nastere    DATE, 
    cnp             CHAR(13)        UNIQUE NOT NULL 
);

-- 2. CREARE TABELA FIRME
CREATE TABLE firme  
(  
    cod_firma           NUMBER(2)       CONSTRAINT pk_firme_codFirma PRIMARY KEY,  
    denumire_firma      VARCHAR2(20)    NOT NULL,  
    localitate          VARCHAR2(20),  
    zona_geografica     VARCHAR2(15)    CONSTRAINT ck_firme_zonaGeografica CHECK  
                                        (zona_geografica IN ('Muntenia','Moldova','Transilvania','Dobrogea','Banat','Bucovina')),  
    cui                 CHAR(8)         UNIQUE NOT NULL  
);

-- 3. CREARE TABELA CONTRACT
CREATE TABLE contract  
(  
    agentiPaza_id_agent     NUMBER(3)               CONSTRAINT fk_contract_idAgent REFERENCES agenti_paza(id_agent), -- nu se specifica FOREIGN KEY 
    firme_cod_firma         NUMBER(2),  
    salariu                 NUMBER(4),  
    data_angajare           DATE,  
      
    -- Definirea restrictiilor  
    CONSTRAINT fk_contract_codFirma FOREIGN KEY(firme_cod_firma) REFERENCES firme(cod_firma),  
    CONSTRAINT ck_contract_salariul CHECK (salariu BETWEEN 2000 AND 5000)  
);;

-- CREATE TABLE AS 
-- Exemplul 3. Sa se creeze tabela fosti_agenti pe baza tabelei agenti si care va contine toate coloanele tabelei initiale.
-- CREARE TABELA FOSTI AGENTI CU TOATE COLOANELE TABELEI AGENTI PAZA
CREATE TABLE fosti_agenti
AS
SELECT * FROM agenti_paza;

--sau 
-- CREARE TABELA FOSTI AGENTI CU O PARTE DIN COLOANELE TABELEI AGENTI PAZA
CREATE TABLE fostii_agenti
AS
SELECT id_agent, nume, prenume FROM agenti_paza


-- ALTER TABLE - COLUMNS - ADD
-- Exemplul 4.2. Sa se adauge coloanele telefon, email si sex in tabela agenti paza.
ALTER TABLE agenti_paza
ADD (
    telefon CHAR(10),
    email VARCHAR2(20), 
    sex VARCHAR2(15)        CONSTRAINT ck_agenti_sex CHECK 
                            (sex IN('Femeiesc','Barbatesc'))
);


-- ALTER TABLE - COLUMNS - MODIFY
-- Exemplul 4.3. Sa se modifice tipul de date al coloanei email, marindu-se numarul de caractere permise la 50.
ALTER TABLE agenti_paza
MODIFY (
    email VARCHAR2(50)
);


-- ALTER TABLE - COLUMN - RENAME
ALTER TABLE agenti
    RENAME COLUMN email TO gmail;


-- ALTER TABLE - COLUMNS - SET UNUSED
-- Exemplul 4.5. Sa se inactiveze coloanele nume si prenume.
ALTER TABLE agenti_paza
SET UNUSED (nume, prenume);


-- ALTER TABLE - COLUMNS - DROP
-- Exemplul 4.4. Sa se stearga coloana telefon.
ALTER TABLE agenti_paza
DROP COLUMN telefon;


-- ALTER TABLE - COLUMNS - DROP UNUSED
-- Exemplul 4.6. Sa se stearga coloanele inactive.
ALTER TABLE agenti_paza
DROP UNUSED COLUMNS;


-- Vizualizare structura tabela
DESCRIBE agenti_paza;


-- ALTER TABLE - CONSTRAINT - ADD
-- Exemplul 4.7. Sa se adauge o restrictie pe coloana email.
ALTER TABLE agenti_paza
ADD CONSTRAINT
     uq_email UNIQUE (email);


-- ALTER TABLE - CONSTRAINT - MODIFY
-- Exemplul 4.8. Sa se dezactiveze rectrictia anterioara.
ALTER TABLE agenti_paza
    MODIFY CONSTRAINT UQ_EMAIL
    DISABLE;  --ENABLE


-- ALTER TABLE - CONSTRAINT - DROP
-- Exemplul 4.9. Sa se stearga restrictia acterioara.
ALTER TABLE firme
	DROP CONSTRAINT ck_firme_zonaGeografica;


-- DROP TABLE - CASCADE CONSTRAINTS
-- Exemplul 5.1. Sa se steaga tabela fosti agenti.
DROP TABLE fosti_agenti;

/* Se mai poate folosi cu optiunea CASCADE CONSTRAINTS pentru a sterge toate legaturile acelei tabele 
cu alte tabele, cu posibilitatea recuperarii lor.*/

DROP TABLE fosti_agenti CASCADE CONSTRAINTS;


-- FLASHBACK TABLE
-- Exemplul 5.2. Sa se recupereze tabela fosti agenti
FLASHBACK TABLE fosti_agenti TO BEFORE DROP;


-- TRUNCATE TABLE
-- Exemplul 6.1. Sa se stearga inregistrarile tabelei fosti agenti.
TRUNCATE TABLE fosti_agenti;


-- DROP TABLE - PURGE
-- Exemplul 6.2. Sa se stearga definitiv tabela fosti_agenti.
DROP TABLE fosti_agenti PURGE;


-- RENAME TABLE
-- Exemplul 4.1. Sa se redenumeasca table agenti paza in agenti.
RENAME agenti_paza TO agenti;


-- SELECT - USER TABLES
-- Exemplul 7. Sa se vizualizeze toate tabelele utilizatorului curent.
SELECT * FROM user_tables;


-- SELECT - USER CONSTRAINTS
-- Interogarea dictionarului bazei de date pentru aflarea numelui restrictiei.
SELECT *
  FROM user_constraints
  WHERE table_name = 'AGENTI_PAZA'
  AND constraint_name = 'UQ_EMAIL';


-- SELECT - USER CONSTRAINTS
-- Exemplul 8. Sa se vizualizeze denumirea tabelelor, restrictiile si tipul acestora pentru
utilizatorul curent

SELECT table_name, constraint_type, constraint_name
FROM user_contraints;


