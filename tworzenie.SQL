/*
Created: 26.11.2020
Modified: 28.11.2020
Project: Dom Maklerski
Model: Dom Maklerski
Company: Database Solutions
Author: Kacper Mazur, Damian Tosi?ski
Version: 2.0
Database: Oracle 19c
*/


-- Create sequences section -------------------------------------------------

CREATE SEQUENCE PlacowkiSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE AdresySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE KontaSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE InwestorzySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE TransakcjeSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE SymboleSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE OfertySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE WlascicieleSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE Domy_maklerskieSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE PracownicySeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE StanowiskaSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE WynagrodzeniaSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE PocztySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE MaklerzySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

-- Create tables section -------------------------------------------------

-- Table Domy_Maklerskie

CREATE TABLE Domy_Maklerskie(
  nr_domu_maklerskiego Integer NOT NULL,
  nr_adresu Integer NOT NULL,
  nazwa Varchar2(30 ) NOT NULL,
  data_zalozenia Date NOT NULL,
  NIP Char(10 ) NOT NULL,
  REGON Char(9 ) NOT NULL,
  KRS Varchar2(25 )
)
/

-- Create indexes for table Domy_Maklerskie

CREATE INDEX IX_Relationship1 ON Domy_Maklerskie (nr_adresu)
/

-- Add keys for table Domy_Maklerskie

ALTER TABLE Domy_Maklerskie ADD CONSTRAINT dom_maklerski_PK PRIMARY KEY (nr_domu_maklerskiego)
/

-- Table Pracownicy

CREATE TABLE Pracownicy(
  nr_pracownika Integer NOT NULL,
  nr_domu_maklerskiego Integer NOT NULL,
  nr_placowki Integer NOT NULL,
  nr_adresu Integer NOT NULL,
  nr_stanowiska Integer NOT NULL,
  imie Varchar2(20 ) NOT NULL,
  nazwisko Varchar2(30 ) NOT NULL,
  data_urodzenia Date NOT NULL,
  PESEL Char(11 ),
  plec Char(1 )
        CHECK (plec IN ('K','M')),
  data_zatrudnienia Date NOT NULL,
  data_zwolnienia Date
)
/

-- Create indexes for table Pracownicy

CREATE INDEX IX_zatrudnia ON Pracownicy (nr_domu_maklerskiego)
/

CREATE INDEX IX_zatrudnia_2 ON Pracownicy (nr_placowki)
/

CREATE INDEX IX_Relationship5 ON Pracownicy (nr_adresu)
/

CREATE INDEX IX_Relationship6 ON Pracownicy (nr_stanowiska)
/

-- Add keys for table Pracownicy

ALTER TABLE Pracownicy ADD CONSTRAINT pracownik_PK PRIMARY KEY (nr_pracownika)
/

-- Table Maklerzy

CREATE TABLE Maklerzy(
  nr_pracownika Integer NOT NULL,
  nr_licencji Integer NOT NULL,
  data_uzyskania_licencji Date NOT NULL
)
/

-- Add keys for table Maklerzy

ALTER TABLE Maklerzy ADD CONSTRAINT Unique_Identifier1 PRIMARY KEY (nr_pracownika)
/

-- Table Placowki

CREATE TABLE Placowki(
  nr_placowki Integer NOT NULL,
  nr_domu_maklerskiego Integer NOT NULL,
  nazwa_placowka Varchar2(30 ) NOT NULL,
  adres Varchar2(400 ) NOT NULL,
  status_placowki Varchar2(12 ) NOT NULL
        CHECK (status_placowki IN ('Otwarta','Zamknieta'))
)
/

-- Create indexes for table Placowki

CREATE INDEX IX_posiada_placowke ON Placowki (nr_domu_maklerskiego)
/

-- Add keys for table Placowki

ALTER TABLE Placowki ADD CONSTRAINT placowka_PK PRIMARY KEY (nr_placowki)
/

-- Table Inwestorzy

CREATE TABLE Inwestorzy(
  nr_inwestora Integer NOT NULL,
  nr_placowki Integer NOT NULL,
  nr_pracownika Integer NOT NULL,
  nr_adresu Integer NOT NULL,
  imie Varchar2(20 ) NOT NULL,
  nazwisko Varchar2(30 ) NOT NULL,
  e_mail Varchar2(30 ) NOT NULL,
  nr_telefonu Varchar2(15 ) NOT NULL,
  data_dolaczenia Date NOT NULL,
  PESEL Char(11 ) NOT NULL,
  plec Char(1 )
        CHECK (plec IN ('K','M'))
)
/

-- Create indexes for table Inwestorzy

CREATE INDEX IX_pracownik_opiekuje_sie ON Inwestorzy (nr_pracownika)
/

CREATE INDEX IX_obluguje ON Inwestorzy (nr_placowki)
/

CREATE INDEX IX_Relationship8 ON Inwestorzy (nr_adresu)
/

-- Add keys for table Inwestorzy

ALTER TABLE Inwestorzy ADD CONSTRAINT inwestor_PK PRIMARY KEY (nr_inwestora)
/

-- Table Konta

CREATE TABLE Konta(
  nr_konta Integer NOT NULL,
  nr_domu_maklerskiego Integer NOT NULL,
  nr_inwestora Integer NOT NULL,
  rodzaj_konta Varchar2(25 ) NOT NULL
        CHECK (rodzaj_konta IN ('Akcje','Obligacje','Instrumenty_pochodne')),
  depozyt Number(10,2) NOT NULL
)
/

-- Create indexes for table Konta

CREATE INDEX IX_ma ON Konta (nr_inwestora)
/

CREATE INDEX IX_obsluguje ON Konta (nr_domu_maklerskiego)
/

-- Add keys for table Konta

ALTER TABLE Konta ADD CONSTRAINT konto_PK PRIMARY KEY (nr_konta)
/

-- Table Oferty

CREATE TABLE Oferty(
  nr_oferty Integer NOT NULL,
  nr_domu_maklerskiego Integer NOT NULL,
  nr_konta Integer NOT NULL,
  nr_inwestora Integer NOT NULL,
  nr_symbolu Integer NOT NULL,
  ilosc Float(126) NOT NULL,
  cena Number(10,2) NOT NULL,
  pozycja Varchar2(15 ) NOT NULL
        CHECK (pozycja IN ('Kupno','Sprzedaz')),
  data_wygasniecia Date NOT NULL
)
/

-- Create indexes for table Oferty

CREATE INDEX IX_wystawia ON Oferty (nr_konta)
/

CREATE INDEX IX_wystawia_2 ON Oferty (nr_inwestora)
/

CREATE INDEX IX_posiada_2 ON Oferty (nr_domu_maklerskiego)
/

CREATE INDEX IX_Relationship17 ON Oferty (nr_symbolu)
/

-- Add keys for table Oferty

ALTER TABLE Oferty ADD CONSTRAINT oferta_PK PRIMARY KEY (nr_oferty)
/

-- Table Transakcje

CREATE TABLE Transakcje(
  nr_transakcji Integer NOT NULL,
  nr_domu_maklerskiego Integer NOT NULL,
  nr_inwestora Integer NOT NULL,
  nr_konta Integer NOT NULL,
  nr_symbolu Integer NOT NULL,
  ilosc Float(126) NOT NULL,
  cena Number(10,2) NOT NULL,
  pozycja Varchar2(15 ) NOT NULL
        CHECK (pozycja IN ('Kupno','Sprzedaz')),
  data_przeprowadzenia Date NOT NULL
)
/

-- Create indexes for table Transakcje

CREATE INDEX IX_posiada_3 ON Transakcje (nr_domu_maklerskiego)
/

CREATE INDEX IX_realizuje_4 ON Transakcje (nr_inwestora)
/

CREATE INDEX IX_Relationship16 ON Transakcje (nr_symbolu)
/

CREATE INDEX IX_Relationship30 ON Transakcje (nr_konta)
/

-- Add keys for table Transakcje

ALTER TABLE Transakcje ADD CONSTRAINT transkacja_PK PRIMARY KEY (nr_transakcji)
/

-- Table Oferta_Transakcja

CREATE TABLE Oferta_Transakcja(
  nr_oferty Integer NOT NULL,
  nr_transakcji Integer NOT NULL
)
/

-- Table Adresy

CREATE TABLE Adresy(
  nr_adresu Integer NOT NULL,
  nr_poczty Integer NOT NULL,
  miasto Varchar2(20 ) NOT NULL,
  ulica Varchar2(30 ) NOT NULL,
  numer_lokalu Varchar2(5 ) NOT NULL
)
/

-- Create indexes for table Adresy

CREATE INDEX IX_Relationship4 ON Adresy (nr_poczty)
/

-- Add keys for table Adresy

ALTER TABLE Adresy ADD CONSTRAINT PK_Adresy PRIMARY KEY (nr_adresu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Adresy.nr_adresu IS 'Unikatowy identyfikator adresu'
/
COMMENT ON COLUMN Adresy.miasto IS 'Miasto'
/
COMMENT ON COLUMN Adresy.ulica IS 'Ulica'
/
COMMENT ON COLUMN Adresy.numer_lokalu IS 'Numer lokalu'
/

-- Table Wlasciciele

CREATE TABLE Wlasciciele(
  nr_wlasciciela Integer NOT NULL,
  nr_domu_maklerskiego Integer NOT NULL,
  nr_adresu Integer NOT NULL,
  imie Varchar2(20 ) NOT NULL,
  nazwisko Varchar2(20 ) NOT NULL
)
/

-- Create indexes for table Wlasciciele

CREATE INDEX IX_Relationship2 ON Wlasciciele (nr_adresu)
/

CREATE INDEX IX_Relationship3 ON Wlasciciele (nr_domu_maklerskiego)
/

-- Add keys for table Wlasciciele

ALTER TABLE Wlasciciele ADD CONSTRAINT PK_Wlasciciele PRIMARY KEY (nr_wlasciciela)
/

-- Table and Columns comments section

COMMENT ON COLUMN Wlasciciele.nr_wlasciciela IS 'Unikatowy identyfikator w?a?ciciela'
/
COMMENT ON COLUMN Wlasciciele.imie IS 'Imi? w?a?ciciela'
/
COMMENT ON COLUMN Wlasciciele.nazwisko IS 'Nazwisko w?a?ciciela'
/

-- Table Poczty

CREATE TABLE Poczty(
  nr_poczty Integer NOT NULL,
  kod_poczty Char(6 ) NOT NULL,
  poczta Char(20 ) NOT NULL
)
/

-- Add keys for table Poczty

ALTER TABLE Poczty ADD CONSTRAINT PK_Poczty PRIMARY KEY (nr_poczty)
/

ALTER TABLE Poczty ADD CONSTRAINT kod_poczty UNIQUE (kod_poczty)
/

-- Table and Columns comments section

COMMENT ON COLUMN Poczty.nr_poczty IS 'Unikatowy identyfikator poczty'
/
COMMENT ON COLUMN Poczty.kod_poczty IS 'Kod pocztowy'
/
COMMENT ON COLUMN Poczty.poczta IS 'Lokalizacja poczty'
/

-- Table Stanowiska

CREATE TABLE Stanowiska(
  nr_stanowiska Integer NOT NULL,
  nazwa_stanowiska Varchar2(20 ) NOT NULL,
  opis Varchar2(400 ) NOT NULL
)
/

-- Add keys for table Stanowiska

ALTER TABLE Stanowiska ADD CONSTRAINT PK_Stanowiska PRIMARY KEY (nr_stanowiska)
/

ALTER TABLE Stanowiska ADD CONSTRAINT nazwa1 UNIQUE (nazwa_stanowiska)
/

-- Table and Columns comments section

COMMENT ON COLUMN Stanowiska.nr_stanowiska IS 'Unikatowy identyfikator stanowiska'
/
COMMENT ON COLUMN Stanowiska.nazwa_stanowiska IS 'Nazwa stanowiska'
/
COMMENT ON COLUMN Stanowiska.opis IS 'Opis'
/

-- Table Wynagrodzenia

CREATE TABLE Wynagrodzenia(
  nr_wynagordzenia Integer NOT NULL,
  nr_pracownika Integer NOT NULL,
  data Date NOT NULL,
  kwota_pods Number(10,2) NOT NULL,
  kwota_dod Number(10,2)
)
/

-- Create indexes for table Wynagrodzenia

CREATE INDEX IX_Relationship7 ON Wynagrodzenia (nr_pracownika)
/

-- Add keys for table Wynagrodzenia

ALTER TABLE Wynagrodzenia ADD CONSTRAINT PK_Wynagrodzenia PRIMARY KEY (nr_wynagordzenia)
/

-- Table and Columns comments section

COMMENT ON COLUMN Wynagrodzenia.nr_wynagordzenia IS 'Unikatowy indentyfikator wynagrodzenia'
/
COMMENT ON COLUMN Wynagrodzenia.data IS 'Data otrzymania wynagrodzenia'
/
COMMENT ON COLUMN Wynagrodzenia.kwota_pods IS 'Wynagrodzenie podstawowe'
/
COMMENT ON COLUMN Wynagrodzenia.kwota_dod IS 'Kwota dodatkowa'
/

-- Table Symbole

CREATE TABLE Symbole(
  nr_symbolu Integer NOT NULL,
  symbol Varchar2(10 ) NOT NULL,
  nazwa_symbolu Varchar2(30 ) NOT NULL
)
/

-- Add keys for table Symbole

ALTER TABLE Symbole ADD CONSTRAINT PK_Symbole PRIMARY KEY (nr_symbolu)
/

ALTER TABLE Symbole ADD CONSTRAINT symbol UNIQUE (symbol)
/

ALTER TABLE Symbole ADD CONSTRAINT nazwa UNIQUE (nazwa_symbolu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Symbole.nr_symbolu IS 'Unikatowy identyfikator symbolu'
/
COMMENT ON COLUMN Symbole.symbol IS 'Symbol'
/
COMMENT ON COLUMN Symbole.nazwa_symbolu IS 'Nazwa symbolu'
/

-- Table Wartosci

CREATE TABLE Wartosci(
  nr_symbolu Integer NOT NULL,
  nr_konta Integer NOT NULL,
  ilosc Number(10,2) NOT NULL,
  cena Number(10,2) NOT NULL,
  pozycja Varchar2(15 )
        CHECK (pozycja IN ('Kupno','Sprzedaz'))
)
/

-- Add keys for table Wartosci

ALTER TABLE Wartosci ADD CONSTRAINT PK_Wartosci PRIMARY KEY (nr_symbolu,nr_konta)
/

-- Table and Columns comments section

COMMENT ON COLUMN Wartosci.ilosc IS 'Ilosc '
/
COMMENT ON COLUMN Wartosci.cena IS 'Cena jednostki'
/
COMMENT ON COLUMN Wartosci.pozycja IS 'Pozycja'
/

-- Trigger for sequence Domy_maklerskieSeq1 for column nr_domu_maklerskiego in table Domy_Maklerskie ---------
CREATE OR REPLACE TRIGGER ts_Domy_Maklerskie_Domy_maklerskieSeq1 BEFORE INSERT
ON Domy_Maklerskie FOR EACH ROW
BEGIN
  :new.nr_domu_maklerskiego := Domy_maklerskieSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Domy_Maklerskie_Domy_maklerskieSeq1 AFTER UPDATE OF nr_domu_maklerskiego
ON Domy_Maklerskie FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_domu_maklerskiego in table Domy_Maklerskie as it uses sequence.');
END;
/

-- Trigger for sequence PracownicySeq for column nr_pracownika in table Pracownicy ---------
CREATE OR REPLACE TRIGGER ts_Pracownicy_PracownicySeq BEFORE INSERT
ON Pracownicy FOR EACH ROW
BEGIN
  :new.nr_pracownika := PracownicySeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Pracownicy_PracownicySeq AFTER UPDATE OF nr_pracownika
ON Pracownicy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_pracownika in table Pracownicy as it uses sequence.');
END;
/

-- Trigger for sequence PlacowkiSeq1 for column nr_placowki in table Placowki ---------
CREATE OR REPLACE TRIGGER ts_Placowki_PlacowkiSeq1 BEFORE INSERT
ON Placowki FOR EACH ROW
BEGIN
  :new.nr_placowki := PlacowkiSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Placowki_PlacowkiSeq1 AFTER UPDATE OF nr_placowki
ON Placowki FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_placowki in table Placowki as it uses sequence.');
END;
/

-- Trigger for sequence InwestorzySeq1 for column nr_inwestora in table Inwestorzy ---------
CREATE OR REPLACE TRIGGER ts_Inwestorzy_InwestorzySeq1 BEFORE INSERT
ON Inwestorzy FOR EACH ROW
BEGIN
  :new.nr_inwestora := InwestorzySeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Inwestorzy_InwestorzySeq1 AFTER UPDATE OF nr_inwestora
ON Inwestorzy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_inwestora in table Inwestorzy as it uses sequence.');
END;
/

-- Trigger for sequence KontaSeq1 for column nr_konta in table Konta ---------
CREATE OR REPLACE TRIGGER ts_Konta_KontaSeq1 BEFORE INSERT
ON Konta FOR EACH ROW
BEGIN
  :new.nr_konta := KontaSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Konta_KontaSeq1 AFTER UPDATE OF nr_konta
ON Konta FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_konta in table Konta as it uses sequence.');
END;
/

-- Trigger for sequence OfertySeq1 for column nr_oferty in table Oferty ---------
CREATE OR REPLACE TRIGGER ts_Oferty_OfertySeq1 BEFORE INSERT
ON Oferty FOR EACH ROW
BEGIN
  :new.nr_oferty := OfertySeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Oferty_OfertySeq1 AFTER UPDATE OF nr_oferty
ON Oferty FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_oferty in table Oferty as it uses sequence.');
END;
/

-- Trigger for sequence TransakcjeSeq1 for column nr_transakcji in table Transakcje ---------
CREATE OR REPLACE TRIGGER ts_Transakcje_TransakcjeSeq1 BEFORE INSERT
ON Transakcje FOR EACH ROW
BEGIN
  :new.nr_transakcji := TransakcjeSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Transakcje_TransakcjeSeq1 AFTER UPDATE OF nr_transakcji
ON Transakcje FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_transakcji in table Transakcje as it uses sequence.');
END;
/

-- Trigger for sequence AdresySeq1 for column nr_adresu in table Adresy ---------
CREATE OR REPLACE TRIGGER ts_Adresy_AdresySeq1 BEFORE INSERT
ON Adresy FOR EACH ROW
BEGIN
  :new.nr_adresu := AdresySeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Adresy_AdresySeq1 AFTER UPDATE OF nr_adresu
ON Adresy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_adresu in table Adresy as it uses sequence.');
END;
/

-- Trigger for sequence WlascicieleSeq1 for column nr_wlasciciela in table Wlasciciele ---------
CREATE OR REPLACE TRIGGER ts_Wlasciciele_WlascicieleSeq1 BEFORE INSERT
ON Wlasciciele FOR EACH ROW
BEGIN
  :new.nr_wlasciciela := WlascicieleSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Wlasciciele_WlascicieleSeq1 AFTER UPDATE OF nr_wlasciciela
ON Wlasciciele FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_wlasciciela in table Wlasciciele as it uses sequence.');
END;
/

-- Trigger for sequence PocztySeq1 for column nr_poczty in table Poczty ---------
CREATE OR REPLACE TRIGGER ts_Poczty_PocztySeq1 BEFORE INSERT
ON Poczty FOR EACH ROW
BEGIN
  :new.nr_poczty := PocztySeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Poczty_PocztySeq1 AFTER UPDATE OF nr_poczty
ON Poczty FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_poczty in table Poczty as it uses sequence.');
END;
/

-- Trigger for sequence StanowiskaSeq1 for column nr_stanowiska in table Stanowiska ---------
CREATE OR REPLACE TRIGGER ts_Stanowiska_StanowiskaSeq1 BEFORE INSERT
ON Stanowiska FOR EACH ROW
BEGIN
  :new.nr_stanowiska := StanowiskaSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Stanowiska_StanowiskaSeq1 AFTER UPDATE OF nr_stanowiska
ON Stanowiska FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_stanowiska in table Stanowiska as it uses sequence.');
END;
/

-- Trigger for sequence WynagrodzeniaSeq1 for column nr_wynagordzenia in table Wynagrodzenia ---------
CREATE OR REPLACE TRIGGER ts_Wynagrodzenia_WynagrodzeniaSeq1 BEFORE INSERT
ON Wynagrodzenia FOR EACH ROW
BEGIN
  :new.nr_wynagordzenia := WynagrodzeniaSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Wynagrodzenia_WynagrodzeniaSeq1 AFTER UPDATE OF nr_wynagordzenia
ON Wynagrodzenia FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_wynagordzenia in table Wynagrodzenia as it uses sequence.');
END;
/

-- Trigger for sequence SymboleSeq1 for column nr_symbolu in table Symbole ---------
CREATE OR REPLACE TRIGGER ts_Symbole_SymboleSeq1 BEFORE INSERT
ON Symbole FOR EACH ROW
BEGIN
  :new.nr_symbolu := SymboleSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Symbole_SymboleSeq1 AFTER UPDATE OF nr_symbolu
ON Symbole FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column nr_symbolu in table Symbole as it uses sequence.');
END;
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE Pracownicy ADD CONSTRAINT zatrudnia FOREIGN KEY (nr_domu_maklerskiego) REFERENCES Domy_Maklerskie (nr_domu_maklerskiego)
/



ALTER TABLE Placowki ADD CONSTRAINT posiada_placowke FOREIGN KEY (nr_domu_maklerskiego) REFERENCES Domy_Maklerskie (nr_domu_maklerskiego)
/



ALTER TABLE Inwestorzy ADD CONSTRAINT pracownik_opiekuje_sie FOREIGN KEY (nr_pracownika) REFERENCES Pracownicy (nr_pracownika)
/



ALTER TABLE Inwestorzy ADD CONSTRAINT obsluguje_1 FOREIGN KEY (nr_placowki) REFERENCES Placowki (nr_placowki)
/



ALTER TABLE Konta ADD CONSTRAINT inwestor_ma_konta FOREIGN KEY (nr_inwestora) REFERENCES Inwestorzy (nr_inwestora)
/



ALTER TABLE Konta ADD CONSTRAINT obsluguje FOREIGN KEY (nr_domu_maklerskiego) REFERENCES Domy_Maklerskie (nr_domu_maklerskiego)
/



ALTER TABLE Oferty ADD CONSTRAINT wystawia FOREIGN KEY (nr_konta) REFERENCES Konta (nr_konta)
/



ALTER TABLE Oferty ADD CONSTRAINT wystawia_2 FOREIGN KEY (nr_inwestora) REFERENCES Inwestorzy (nr_inwestora)
/



ALTER TABLE Oferty ADD CONSTRAINT posiada_2 FOREIGN KEY (nr_domu_maklerskiego) REFERENCES Domy_Maklerskie (nr_domu_maklerskiego)
/



ALTER TABLE Transakcje ADD CONSTRAINT posiada_3 FOREIGN KEY (nr_domu_maklerskiego) REFERENCES Domy_Maklerskie (nr_domu_maklerskiego)
/



ALTER TABLE Transakcje ADD CONSTRAINT realizuje_4 FOREIGN KEY (nr_inwestora) REFERENCES Inwestorzy (nr_inwestora)
/



ALTER TABLE Pracownicy ADD CONSTRAINT zatrudnia_2 FOREIGN KEY (nr_placowki) REFERENCES Placowki (nr_placowki)
/



ALTER TABLE Domy_Maklerskie ADD CONSTRAINT dom_maklerski_ma_adres FOREIGN KEY (nr_adresu) REFERENCES Adresy (nr_adresu)
/



ALTER TABLE Wlasciciele ADD CONSTRAINT Wlasciciel_ma_adres FOREIGN KEY (nr_adresu) REFERENCES Adresy (nr_adresu)
/



ALTER TABLE Wlasciciele ADD CONSTRAINT dom_maklerski_ma_wlasciciela FOREIGN KEY (nr_domu_maklerskiego) REFERENCES Domy_Maklerskie (nr_domu_maklerskiego)
/



ALTER TABLE Pracownicy ADD CONSTRAINT pracownik_ma_adres FOREIGN KEY (nr_adresu) REFERENCES Adresy (nr_adresu)
/



ALTER TABLE Pracownicy ADD CONSTRAINT pracownik_ma_stanowisko FOREIGN KEY (nr_stanowiska) REFERENCES Stanowiska (nr_stanowiska)
/



ALTER TABLE Wynagrodzenia ADD CONSTRAINT pracownik_otrzymuje_wynagrodzenie FOREIGN KEY (nr_pracownika) REFERENCES Pracownicy (nr_pracownika)
/



ALTER TABLE Transakcje ADD CONSTRAINT transakcja_ma_symbol FOREIGN KEY (nr_symbolu) REFERENCES Symbole (nr_symbolu)
/



ALTER TABLE Oferty ADD CONSTRAINT oferta_ma_symbol FOREIGN KEY (nr_symbolu) REFERENCES Symbole (nr_symbolu)
/



ALTER TABLE Wartosci ADD CONSTRAINT wartosci_maja_symbole FOREIGN KEY (nr_symbolu) REFERENCES Symbole (nr_symbolu)
/



ALTER TABLE Wartosci ADD CONSTRAINT wartosci_maja_konta FOREIGN KEY (nr_konta) REFERENCES Konta (nr_konta)
/



ALTER TABLE Transakcje ADD CONSTRAINT konto_realizuje_transakcje FOREIGN KEY (nr_konta) REFERENCES Konta (nr_konta)
/



ALTER TABLE Adresy ADD CONSTRAINT adres_posiada_poczte FOREIGN KEY (nr_poczty) REFERENCES Poczty (nr_poczty)
/



ALTER TABLE Inwestorzy ADD CONSTRAINT inwestor_posiada_adres FOREIGN KEY (nr_adresu) REFERENCES Adresy (nr_adresu)
/

CREATE INDEX "pracownik_posiada_stanowisko" ON "PRACOWNICY" ("NR_STANOWISKA");

CREATE INDEX "inwestorzy_w_placowce" ON "INWESTORZY" ("NR_PLACOWKI");

CREATE INDEX "inwestor_ma_konta" ON "KONTA" ("NR_INWESTORA");




