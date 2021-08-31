-- Poczty
insert all
    into poczty (kod_poczty,poczta) values ('01-100','Warszawa')
    into poczty (kod_poczty,poczta) values ('02-200','Grodzisk')
    into poczty (kod_poczty,poczta) values ('03-300','Gdynia')
    into poczty (kod_poczty,poczta) values ('04-400','Bytom')
SELECT *
    FROM dual;

-- Adresy
insert all
    into adresy (nr_poczty,miasto,ulica,numer_lokalu) values (1,'Warszawa','Lazurowa','11c')
    into adresy (nr_poczty,miasto,ulica,numer_lokalu) values (2,'Grodzisk','Palmowa','4a')
    into adresy (nr_poczty,miasto,ulica,numer_lokalu) values (3,'Gdynia','Krajowa','2a')
    into adresy (nr_poczty,miasto,ulica,numer_lokalu) values (4,'Bytom','Karpiowa','10d')
SELECT *
    FROM dual;
  
--Domy_maklerskie
insert all
    into domy_maklerskie (nr_adresu,nazwa,data_zalozenia,NIP,REGON,KRS) values (5,'Dom Maklerski 1',to_date('11/04/2000', 'DD/MM/YYYY'),'7740001454','610188201','0000126258')
SELECT *
    FROM dual;
    
--Stanowiska
insert all
    into stanowiska (nazwa_stanowiska, opis) values ('Programista', 'programuje')
    into stanowiska (nazwa_stanowiska, opis) values ('Sprzataczka', 'sprzata')
    into stanowiska (nazwa_stanowiska, opis) values ('Ksiegowa', 'zajmuje sie ksiegowoscia')
    into stanowiska (nazwa_stanowiska, opis) values ('Makler', 'odpowiada za analize techniczna i fundamentalna, przygotowuje raporty na temat trendow wystepujacyhc na rynkach')
    into stanowiska (nazwa_stanowiska, opis) values ('Pracownik POK', 'pracownik punktu obslugi klienta')
SELECT *
    FROM dual;
    
--Wlasciciele
insert all
    into wlasciciele (nr_domu_maklerskiego,nr_adresu,imie,nazwisko) values (2,6,'Kacper','Mazur')
    into wlasciciele (nr_domu_maklerskiego,nr_adresu,imie,nazwisko) values (2,7,'Damian','Tosinski')
SELECT * 
    FROM dual;
    
--Placowki
insert all
    into placowki (nr_domu_maklerskiego,nazwa_placowka,adres,status_placowki) values (2,'Placowka 1',5,'Otwarta')
    into placowki (nr_domu_maklerskiego,nazwa_placowka,adres,status_placowki) values (2,'Placowka 2',6,'Otwarta')
    into placowki (nr_domu_maklerskiego,nazwa_placowka,adres,status_placowki) values (2,'Placowka 3',7,'Otwarta')
    into placowki (nr_domu_maklerskiego,nazwa_placowka,adres,status_placowki) values (2,'Placowka 4',8,'Zamknieta')
SELECT *
    FROM dual;
    
--Pracownicy
insert all
    into pracownicy (nr_domu_maklerskiego,nr_placowki,nr_adresu,nr_stanowiska,imie,nazwisko,data_urodzenia,pesel,plec,data_zatrudnienia,data_zwolnienia) values (2,5,5,1,'Eliasz','Mincler',to_date('11/04/2001', 'DD/MM/YYYY'),'99999999999','M',to_date('11/04/2032', 'DD/MM/YYYY'),to_date('11/04/2033', 'DD/MM/YYYY'))
    into pracownicy (nr_domu_maklerskiego,nr_placowki,nr_adresu,nr_stanowiska,imie,nazwisko,data_urodzenia,pesel,plec,data_zatrudnienia,data_zwolnienia) values (2,6,6,2,'Antoni','Manowski',to_date('11/04/2001', 'DD/MM/YYYY'),'99999999992','M',to_date('11/04/2032', 'DD/MM/YYYY'),to_date('11/04/2033', 'DD/MM/YYYY'))
    into pracownicy (nr_domu_maklerskiego,nr_placowki,nr_adresu,nr_stanowiska,imie,nazwisko,data_urodzenia,pesel,plec,data_zatrudnienia,data_zwolnienia) values (2,7,7,4,'Daniel','Mazur',to_date('11/04/2001', 'DD/MM/YYYY'),'99999999993','M',to_date('11/04/2032', 'DD/MM/YYYY'),to_date('11/04/2033', 'DD/MM/YYYY'))
SELECT *
    FROM dual;
    
--Inwestorzy
insert all
    into inwestorzy (nr_placowki,nr_pracownika,nr_adresu,imie,nazwisko,e_mail,nr_telefonu,data_dolaczenia,pesel,plec) values (5,7,5,'Steve','Jobs','steevejobs@gmail.com',123456789,to_date('11/04/2000', 'DD/MM/YYYY'),91991919191,'M')
SELECT *
    FROM dual;
    
--Konta
insert all
    into konta (nr_domu_maklerskiego,nr_inwestora,rodzaj_konta,depozyt) values (2,1,'Akcje','100')
SELECT *
    FROM dual;
    
--Maklerzy
insert all
    into maklerzy (nr_pracownika,nr_licencji,data_uzyskania_licencji) values (9,312912,to_date('11/04/2020', 'DD/MM/YYYY'))
SELECT *
    FROM dual;
    
--Symbole
insert all
    into symbole (symbol,nazwa_symbolu) values ('GOOGL','Alphabet Inc (Google)')
SELECT *
    FROM dual;
    
--Wynagrodzenia
insert all
    into wynagrodzenia (nr_pracownika,data,kwota_pods,kwota_dod) values (9,to_date('11/04/2034', 'DD/MM/YYYY'),10000,2000)
SELECT *
    FROM dual;
    
--Wartosci
insert all
    into wartosci (nr_symbolu,nr_konta,ilosc,cena) values (1,1,32,388)
SELECT *
    FROM dual;

--Oferty
insert all
    into oferty (nr_domu_maklerskiego,nr_konta,nr_inwestora,nr_symbolu,ilosc,cena,data_wygasniecia,pozycja) values (2,1,1,1,322,32322332,to_date('11/04/2034', 'DD/MM/YYYY'),'Kupno')
SELECT *
    FROM dual;
    
--Transakcje
insert all
    into transakcje (nr_domu_maklerskiego,nr_inwestora,nr_konta,nr_symbolu,ilosc,cena,pozycja,data_przeprowadzenia) values (2,1,1,1,342,23223,'Kupno',to_date('11/04/2034', 'DD/MM/YYYY'))
SELECT *
    FROM dual;

--Oferta_Transakcja
insert all
    into oferta_transakcja (nr_oferty,nr_transakcji) values (2,1)
SELECT *
    FROM dual;

