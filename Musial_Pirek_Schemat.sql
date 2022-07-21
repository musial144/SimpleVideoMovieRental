CREATE DATABASE Wypozyczalnia_Video
GO

CREATE TABLE Wypozyczalnia_Video.dbo.Klient(
id_klienta INT IDENTITY(1,1) CONSTRAINT Klient_PK PRIMARY KEY,
imie VARCHAR(20) NOT NULL,
nazwisko VARCHAR(20) NOT NULL,
telefon VARCHAR(9) NOT NULL,
miasto VARCHAR(30) NOT NULL,
ulica VARCHAR(30) NOT NULL,
nr_mieszkania INT NOT NULL,
CONSTRAINT check_telefon CHECK(
SUBSTRING(telefon,1,1) BETWEEN '0' AND '9' AND
SUBSTRING(telefon,2,1) BETWEEN '0' AND '9' AND
SUBSTRING(telefon,3,1) BETWEEN '0' AND '9' AND
SUBSTRING(telefon,4,1) BETWEEN '0' AND '9' AND
SUBSTRING(telefon,5,1) BETWEEN '0' AND '9' AND
SUBSTRING(telefon,6,1) BETWEEN '0' AND '9' AND
SUBSTRING(telefon,7,1) BETWEEN '0' AND '9' AND
SUBSTRING(telefon,8,1) BETWEEN '0' AND '9' AND
SUBSTRING(telefon,9,1) BETWEEN '0' AND '9')
)
GO

CREATE TABLE Wypozyczalnia_Video.dbo.Film(
id_filmu INT IDENTITY(1,1) CONSTRAINT Film_PK PRIMARY KEY,
tytul VARCHAR(30) NOT NULL,
nosnik VARCHAR(10) NOT NULL,
cena_wypozyczenia MONEY NOT NULL,
gatunek VARCHAR(15) NOT NULL,
rezyser VARCHAR(30) NOT NULL,
ocena DECIMAL(3,2) NOT NULL,
CONSTRAINT ocena_zakres CHECK(ocena > 1.00 AND ocena < 10.00)
)
GO

CREATE TABLE Wypozyczalnia_Video.dbo.Stanowisko(
id_stanowiska INT IDENTITY(1,1) CONSTRAINT Stanowisko_PK PRIMARY KEY,
nazwa_stanowiska VARCHAR(15) NOT NULL,
wynagrodzenie MONEY NOT NULL
)
GO

CREATE TABLE Wypozyczalnia_Video.dbo.Pracownik(
id_pracownika INT IDENTITY(1,1) CONSTRAINT Pracownik_PK PRIMARY KEY,
imie VARCHAR(20) NOT NULL,
naziwsko VARCHAR(20) NOT NULL,
data_zatrudnienia DATE NOT NULL,
id_stanowiska INT NOT NULL,
CONSTRAINT Stanowisko_FK FOREIGN KEY(id_stanowiska) REFERENCES Stanowisko(id_stanowiska)
)
GO

CREATE TABLE Wypozyczalnia_Video.dbo.Wypozyczenie(
id_wypozyczenia INT IDENTITY(1,1) CONSTRAINT Wypozyczenie_PK PRIMARY KEY,
data_wypozyczenia DATE NOT NULL,
data_oddania DATE,
termin_oddania DATE NOT NULL,
koszt_wypozyczenia MONEY NOT NULL,
wysokosc_kary MONEY NOT NULL,
id_klienta INT NOT NULL,
id_filmu INT NOT NULL,
id_pracownika INT NOT NULL,
CONSTRAINT Klient_FK FOREIGN KEY(id_klienta) REFERENCES Klient(id_klienta),
CONSTRAINT Film_FK FOREIGN KEY(id_filmu) REFERENCES Film(id_filmu),
CONSTRAINT Pracownik_FK FOREIGN KEY(id_pracownika) REFERENCES Pracownik(id_pracownika)
)
GO