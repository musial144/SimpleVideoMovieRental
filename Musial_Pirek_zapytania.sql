USE Wypozyczalnia_Video

--1--
-- Œrednia ocena dla poszczególnych gatunków filmowych  
SELECT gatunek, CAST(AVG(ocena) AS NUMERIC(3,2)) AS srednia_ocena FROM film GROUP BY gatunek ORDER BY srednia_ocena DESC

--2--
-- Ile razy by³y wypo¿yczane poszczególne tytu³y
SELECT tytul, COUNT(wypozyczenie.id_filmu) FROM film JOIN wypozyczenie ON film.id_filmu = wypozyczenie.id_filmu GROUP BY tytul

--3--
-- Ile filmów by³o zwrócone z opóŸnieniem
SELECT COUNT(id_wypozyczenia) FROM wypozyczenie WHERE wysokosc_kary > 0

--4--
-- Dochód uzyskany od klienta, malej¹co
SELECT klient.id_klienta, nazwisko, SUM(koszt_wypozyczenia) + SUM(wysokosc_kary) AS dochod FROM wypozyczenie 
JOIN klient ON klient.id_klienta = wypozyczenie.id_klienta GROUP BY klient.id_klienta, nazwisko
ORDER BY dochod DESC

--5--
-- Liczba wypo¿yczeñ filmów dla poszczególnych re¿yserów
SELECT rezyser, COUNT(wypozyczenie.id_filmu) AS ilosc_wypozyczen FROM film 
JOIN wypozyczenie ON film.id_filmu = wypozyczenie.id_filmu GROUP BY rezyser ORDER BY rezyser DESC

--6--
-- Przychód z danego filmu, z sortowaniem po ocenie
SELECT tytul, ocena, SUM(koszt_wypozyczenia) + SUM(wysokosc_kary) FROM wypozyczenie 
JOIN film ON film.id_filmu = wypozyczenie.id_filmu GROUP BY tytul, ocena ORDER BY ocena DESC

--7--
-- Najchêtniej wybierany noœnik
SELECT nosnik, COUNT(wypozyczenie.id_filmu) AS ilosc_wypozyczen FROM film 
JOIN wypozyczenie ON film.id_filmu = wypozyczenie.id_filmu 
GROUP BY nosnik
HAVING count(wypozyczenie.id_filmu) = (SELECT TOP 1 COUNT(wypozyczenie.id_filmu) FROM wypozyczenie
									   JOIN film ON film.id_filmu = wypozyczenie.id_filmu
									   GROUP BY nosnik ORDER BY count(wypozyczenie.id_filmu) DESC)

--8--
-- Iloœc klientów z danego miasta
SELECT miasto, COUNT(id_klienta) AS ilosc_klientow FROM Klient GROUP BY miasto

--9--
-- Najchêtniej wybierane gatunki przez kobiety
SELECT COUNT(id_wypozyczenia), gatunek FROM wypozyczenie 
JOIN klient ON klient.id_klienta = wypozyczenie.id_klienta
JOIN film ON wypozyczenie.id_filmu = film.id_filmu
WHERE imie LIKE '%a' GROUP BY gatunek

--10--
-- Iloœæ wypo¿yczonych filmów przez danych pracowników
SELECT pracownik.id_pracownika, COUNT(id_wypozyczenia) FROM Pracownik 
JOIN Wypozyczenie ON Wypozyczenie.id_pracownika = Pracownik.id_pracownika GROUP BY Pracownik.id_pracownika

--11--
-- W których latach by³ najmniejszy ruch? posortuj malej¹co
SELECT YEAR(data_wypozyczenia) AS rok, COUNT(id_wypozyczenia) AS ilosc_wypozyczen 
FROM Wypozyczenie 
GROUP BY YEAR(data_wypozyczenia)
HAVING COUNT(id_wypozyczenia) = (SELECT top 1 COUNT(id_wypozyczenia)
								 FROM Wypozyczenie
								 GROUP BY YEAR(data_wypozyczenia)
								 ORDER BY COUNT(id_wypozyczenia) ASC)
ORDER BY rok DESC

--12--
-- Jaki procent zarobków stanowi¹ kary za przetrzymanie?
SELECT SUM(wysokosc_kary)/(SUM(koszt_wypozyczenia) + SUM(wysokosc_kary))*100 AS procent_z_kar FROM Wypozyczenie 

--13--
-- W których miesi¹cach jest najwiêcej wypo¿yczeñ?
SELECT MONTH(data_wypozyczenia) AS miesiac, COUNT(id_wypozyczenia) AS ilosc_wypozyczen FROM Wypozyczenie GROUP BY MONTH(data_wypozyczenia) ORDER BY miesiac DESC

--14--
-- Ilu jest pracowników na danym stanowisku?
SELECT nazwa_stanowiska, COUNT(id_pracownika) FROM Stanowisko JOIN Pracownik ON Stanowisko.id_stanowiska = Pracownik.id_stanowiska GROUP BY nazwa_stanowiska

--15--
-- Jak du¿o ksi¹¿ek aktualnie posiada ka¿dy z klientów uwzglêdniaj¹c tylko tych, którzy maj¹ aktualnie wypo¿yczon¹ 
-- przynajmniej jedn¹ ksi¹¿kê
SELECT klient.id_klienta, COUNT(Wypozyczenie.id_wypozyczenia) 
FROM Klient 
JOIN Wypozyczenie ON Klient.id_klienta = Wypozyczenie.id_klienta
WHERE Wypozyczenie.data_oddania IS NULL
GROUP BY klient.id_klienta


