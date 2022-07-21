USE Wypozyczalnia_Video
GO
--DROP PROCEDURE Dodaj_Wypozyczenie

CREATE PROCEDURE Dodaj_Wypozyczenie
(@data_wypozyczenia DATE, @liczba_dni INT, @id_klienta INT, @id_filmu INT, @id_pracownika INT)
AS
BEGIN
	IF (@liczba_dni <> 3 AND @liczba_dni <> 7 AND @liczba_dni <> 14)
		BEGIN
			PRINT('podano nieprawid³ow¹ liczbê dni wypo¿yczenia, wypo¿yczenie filmu ' + CAST(@id_filmu AS VARCHAR)
			+ ' przez klienta ' + CAST(@id_klienta AS VARCHAR)+ ' nie powiod³o siê')
			RETURN -1
		END
	DECLARE @termin_oddania DATE, @koszt_wypozyczenia MONEY
	SET @termin_oddania = DATEADD(day, @liczba_dni, @data_wypozyczenia)
	SET @koszt_wypozyczenia = (SELECT cena_wypozyczenia
							   FROM Wypozyczalnia_Video.dbo.Film
							   WHERE id_filmu = @id_filmu)

	IF @liczba_dni = 3
		BEGIN
			SET @koszt_wypozyczenia = ROUND(@koszt_wypozyczenia * 0.5, 2)
		END
	ELSE IF @liczba_dni = 7
		BEGIN
			SET @koszt_wypozyczenia = ROUND(@koszt_wypozyczenia * 0.7, 2)
		END

	INSERT INTO Wypozyczalnia_Video.dbo.Wypozyczenie VALUES(@data_wypozyczenia, NULL, @termin_oddania, @koszt_wypozyczenia,
	0.00, @id_klienta, @id_filmu, @id_pracownika)
END
GO

SELECT * FROM Wypozyczenie
EXECUTE Dodaj_Wypozyczenie '2017/06/17', 3, 4, 2, 2
SELECT * FROM Wypozyczenie
EXECUTE Dodaj_Wypozyczenie '2017/06/06', 14, 1, 5, 1
SELECT * FROM Wypozyczenie
EXECUTE Dodaj_Wypozyczenie '2019/07/07', 7, 2, 7, 2
SELECT * FROM Wypozyczenie
EXECUTE Dodaj_Wypozyczenie '2015/01/01', 3, 1, 1, 2
GO



----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
USE Wypozyczalnia_Video
GO

--DROP PROCEDURE Czy_wypozyczone

CREATE PROCEDURE Czy_Wypozyczone(@id_filmu INT, @czy_wypozyczone VARCHAR(3) OUTPUT)
AS
BEGIN

	DECLARE @czy_na_polce INT
	SET @czy_na_polce = (SELECT count(*)
						 FROM Wypozyczenie
						 JOIN Film ON Wypozyczenie.id_filmu = Film.id_filmu
						 WHERE Film.id_filmu = @id_filmu AND Wypozyczenie.data_oddania IS NULL)
	IF(@czy_na_polce = 0)
		BEGIN
			SET @czy_wypozyczone = 'NIE'
		END
	ELSE
		BEGIN
			SET @czy_wypozyczone = 'TAK'
		END
END
GO


DECLARE @film INT, @dostepnosc VARCHAR(3)
SET @film = 10
EXECUTE Czy_Wypozyczone @film, @dostepnosc OUTPUT
PRINT @dostepnosc
GO

DECLARE @film INT, @dostepnosc VARCHAR(3)
SET @film = 5
EXECUTE Czy_Wypozyczone @film, @dostepnosc OUTPUT
PRINT @dostepnosc
GO


----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
USE Wypozyczalnia_Video
GO
-- DROP FUNCTION Ile_Nieoddanych

CREATE FUNCTION Ile_Nieoddanych(@id_klienta INT)
RETURNS INT
AS
BEGIN
	DECLARE @ile INT
	SET @ile = (SELECT count(*)
				FROM Wypozyczenie
				WHERE id_klienta = @id_klienta AND data_oddania IS NULL)
	RETURN @ile
END
GO

SELECT DISTINCT id_klienta, dbo.Ile_Nieoddanych(id_klienta) AS wypozyczone_ksiazki
FROM Wypozyczenie
WHERE id_klienta = 1
GO

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

USE Wypozyczalnia_Video
GO
-- DROP PROCEDURE Oddaj_Ksiazke 

CREATE PROCEDURE Oddaj_Film (@id_klienta INT, @id_video INT, @data_oddania DATE)
AS
BEGIN
	DECLARE @czy_oddane INT
	SET @czy_oddane = (SELECT count(*)
					   FROM Wypozyczenie 
					   WHERE id_klienta = @id_klienta AND id_filmu = @id_video AND data_oddania IS NULL)
	
	IF(@czy_oddane = 0)
		BEGIN
			PRINT('Ju¿ oddano')
			RETURN -1
		END

	DECLARE @opóŸnienie INT
	SET @opóŸnienie = (SELECT DATEDIFF(day, Wypozyczenie.termin_oddania, @data_oddania) 
					   FROM Wypozyczenie 
					   WHERE id_klienta = @id_klienta AND id_filmu = @id_video AND data_oddania IS NULL)

	UPDATE Wypozyczenie
	SET data_oddania = @data_oddania
	WHERE id_klienta = @id_klienta AND id_filmu = @id_video AND data_oddania IS NULL

	

	IF (@opóŸnienie > 0 AND @opóŸnienie < 4)
		BEGIN
			UPDATE Wypozyczenie
			SET wysokosc_kary = 5.00
			WHERE id_klienta = @id_klienta AND id_filmu = @id_video AND data_oddania = @data_oddania
		END
	IF (@opóŸnienie > 3)
		BEGIN
			UPDATE Wypozyczenie
			SET wysokosc_kary = 10.00
			WHERE id_klienta = @id_klienta AND id_filmu = @id_video AND data_oddania = @data_oddania
		END
END
GO

SELECT * FROM Wypozyczenie
EXEC Oddaj_Film 4,2,'2017/06/19'
SELECT * FROM Wypozyczenie
EXEC Oddaj_Film 1,5,'2017/06/21'
SELECT * FROM Wypozyczenie
EXEC Oddaj_Film 2,7,'2019/07/15'
SELECT * FROM Wypozyczenie
EXEC Oddaj_Film 1, 1,'2015/01/15'
SELECT * FROM Wypozyczenie
GO

EXEC Oddaj_Film 1, 1,'2015/01/15'
GO

SELECT * FROM Wypozyczenie
GO

