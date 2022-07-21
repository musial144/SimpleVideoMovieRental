USE Wypozyczalnia_Video
GO

INSERT INTO Klient VALUES('Marek', 'Wac³awski', '999999999', '£ódŸ', 'Ba³uty', 55)
INSERT INTO Klient VALUES('Pawe³', 'Pawlak', '888888888', 'Wroc³aw', 'Lumumby', 42)
INSERT INTO Klient VALUES('Adrian', 'Markowicz', '777777777', 'Kraków', 'Limanka', 5)
INSERT INTO Klient VALUES('Andrzej', 'Prus', '666666666', 'Zakopanem', 'Widzew', 14)
INSERT INTO Klient VALUES('Marta', 'Mickiewicz', '555555555', 'Opole', 'Andrzejów', 10)
INSERT INTO Klient VALUES('W³odzimierz', 'Kacprowicz', '444444444', 'Gdañsk', 'Jana Paw³a', 18)
GO

INSERT INTO Film VALUES('Lœnienie', 'DVD', 13.55, 'horror', 'Patryk Vega', 6.21)
INSERT INTO Film VALUES('Lœnienie', 'DVD', 13.55, 'horror', 'Patryk Vega', 6.21)
INSERT INTO Film VALUES('Lœnienie', 'DVD', 13.55, 'horror', 'Patryk Vega', 6.21)

INSERT INTO Film VALUES('Stra¿nicy Galaktyki', 'CD', 10.99, 'komedia', 'Andrzej Wajda', 8.00)
INSERT INTO Film VALUES('Stra¿nicy Galaktyki', 'CD', 10.99, 'komedia', 'Andrzej Wajda', 8.00)
INSERT INTO Film VALUES('Stra¿nicy Galaktyki', 'CD', 10.99, 'komedia', 'Andrzej Wajda', 8.00)

INSERT INTO Film VALUES('Thor', 'Blue-Ray', 8.99, 'akcja', 'Cezary Pazura', 7.25)
INSERT INTO Film VALUES('Thor', 'Blue-Ray', 8.99, 'akcja', 'Cezary Pazura', 7.25)
INSERT INTO Film VALUES('Thor', 'Blue-Ray', 8.99, 'akcja', 'Cezary Pazura', 7.25)

INSERT INTO Film VALUES('Avengers', 'VHS', 9.95, 'komedia', 'Bartosz Walaszek', 7.43)
INSERT INTO Film VALUES('Avengers', 'VHS', 9.95, 'komedia', 'Bartosz Walaszek', 7.43)
INSERT INTO Film VALUES('Avengers', 'VHS', 9.95, 'komedia', 'Bartosz Walaszek', 7.43)

INSERT INTO Film VALUES('Forest Gump', 'CD', 11.50, 'dramat', 'Quentin Tarantino', 8.32)
INSERT INTO Film VALUES('Forest Gump', 'CD', 11.50, 'dramat', 'Quentin Tarantino', 8.32)
INSERT INTO Film VALUES('Forest Gump', 'CD', 11.50, 'dramat', 'Quentin Tarantino', 8.32)

INSERT INTO Film VALUES('Zielona Mila', 'DVD', 14.20, 'dramat', 'Andrzej Wajda', 8.51)
INSERT INTO Film VALUES('Zielona Mila', 'DVD', 14.20, 'dramat', 'Andrzej Wajda', 8.51)
INSERT INTO Film VALUES('Zielona Mila', 'DVD', 14.20, 'dramat', 'Andrzej Wajda', 8.51)
GO

INSERT INTO Stanowisko VALUES('Sprzedawca', 3000.00)
INSERT INTO Stanowisko VALUES('Sprz¹taczka', 2500.00)
GO

INSERT INTO Pracownik VALUES('Lukasz', 'Musial', '2005/12/15', 1)
INSERT INTO Pracownik VALUES('Wiktora', 'Trytytka', '2012/01/10', 1)
INSERT INTO Pracownik VALUES('Maria', 'Paczeœ', '2011/08/10', 2)
GO

INSERT INTO Wypozyczenie VALUES('2015/01/01', '2015/01/10', '2015/01/15', 13.55, 0.00, 1, 1, 1)
INSERT INTO Wypozyczenie VALUES('2018/12/02', '2018/12/20', '2018/12/16', 10.99, 10.00, 2, 5, 1)
INSERT INTO Wypozyczenie VALUES('2017/08/03', '2017/08/10', '2017/08/10', 6.29, 0.00, 3, 9, 2)
INSERT INTO Wypozyczenie VALUES('2016/07/04', '2016/07/07', '2016/07/11', 8.05, 0.00, 4, 15, 1)
INSERT INTO Wypozyczenie VALUES('2012/06/05', '2012/06/12', '2012/06/19', 11.50, 0.00, 5, 13, 2)
INSERT INTO Wypozyczenie VALUES('2015/05/06', '2015/05/14', '2015/05/13', 9.95, 5.00, 6, 10, 2)
GO

SELECT * FROM wypozyczenie
SELECT * FROM pracownik
SELECT * FROM stanowisko
SELECT * FROM film
SELECT * FROM klient
GO

