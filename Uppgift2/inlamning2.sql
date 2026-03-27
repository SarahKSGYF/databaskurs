-- Sarah Bjork YH24

-- Skapar databasen
CREATE DATABASE bokhandel;
-- Väljer databasen
USE bokhandel;
-- Skapar tabelen som representerear kunder i systemet
CREATE TABLE Kunder (
    KundID INT AUTO_INCREMENT PRIMARY KEY,
    Namn VARCHAR(100),
    Epost VARCHAR(100) UNIQUE,
    Telefon VARCHAR(20),
    Adress VARCHAR(255)
);
-- Skapar tabelen som representerar böcker i systemet med info om boken och lager info
CREATE TABLE Bocker (
    ISBN VARCHAR(13) PRIMARY KEY UNIQUE,
    Titel VARCHAR(255),
    Forfattare VARCHAR(100),
    Pris DECIMAL(10,2),
    Lagerstatus INT,
    CHECK(Pris>0)
);
-- Skapar tabelen som innehåller info om beställningar som Kunder kan göra i systemet. Hämtar en foreign key från kunden som skapar den
CREATE TABLE Bestallningar (
    Ordernummer INT AUTO_INCREMENT PRIMARY KEY,
    Datum TIMESTAMP,
    Totalbelopp DECIMAL(10,2),
    KundID INT,
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID)
);
-- Skapar tabelen för orderrad
CREATE TABLE Orderrader (
    Ordernummer INT,
    ISBN VARCHAR(20),
    Antal INT,
	RadID INT AUTO_INCREMENT PRIMARY KEY
);
-- Trigger för när Kunder skapas
CREATE TABLE Kund_log (
	KundID INT,
    Datum TIMESTAMP
    );

CREATE TRIGGER Kund_logga AFTER INSERT ON Kunder FOR EACH ROW INSERT INTO Kund_log VALUES(new.KundID, CURRENT_TIME());

-- Trigger för att minska lagerstatus när böcker beställs
DELIMITER $$
CREATE TRIGGER Bockerkopt AFTER INSERT ON Orderrader FOR EACH ROW 
BEGIN
	UPDATE Bocker SET Lagerstatus = Lagerstatus - NEW.Antal
    WHERE ISBN = NEW.ISBN;
END $$

DELIMITER ;

-- test insert och select
INSERT INTO Kunder (Namn, Epost, Telefon, Adress)
	VALUES ('Bengt', 'Bengt@gmailcom', '0734222203', 'Stockholmgatan 1');
    
INSERT INTO Kunder (Namn, Epost, Telefon, Adress)
	VALUES ('Tom', 'Tom@gmailcom', '07655503', 'Kalmargaten 1');
    
INSERT INTO Kunder (Namn, Epost, Telefon, Adress)
	VALUES ('Kaisa', 'Kaisa@gmailcom', '065442222', 'Ölandsvägen 1');
    
INSERT INTO Bocker 
VALUES ('4429959302', 'Bocken om ALLT', 'R. Tolk', 500.0, 10);

INSERT INTO Bocker 
VALUES ('9782345234', 'Bocken om inget', 'H. Bengt', 234.5, 30);

INSERT INTO Bocker 
VALUES ('97943299534', 'Bocken om något', 'E. Berg', 50.99, 5);

INSERT INTO Bestallningar (Datum, Totalbelopp, KundID)
VALUES (CURRENT_TIME(), 550.99, 2);

INSERT INTO Orderrader (Ordernummer, ISBN, Antal)
VALUES (1, '4429959302', 1), (1, '97943299534', 1);

INSERT INTO Bestallningar (Datum, Totalbelopp, KundID)
VALUES (CURRENT_TIME(), 550.99, 2);

INSERT INTO Orderrader (Ordernummer, ISBN, Antal)
VALUES (1, '4429959302', 1), (1, '97943299534', 1);

INSERT INTO Bestallningar (Datum, Totalbelopp, KundID)
VALUES (CURRENT_TIME(), 1234.5, 3);

INSERT INTO Orderrader (Ordernummer, ISBN, Antal)
VALUES (2, '4429959302', 2), (2, '9782345234', 1);

INSERT INTO Bestallningar (Datum, Totalbelopp, KundID)
VALUES (CURRENT_TIME(), 1234.5, 3);

INSERT INTO Orderrader (Ordernummer, ISBN, Antal)
VALUES (2, '4429959302', 2), (2, '9782345234', 1);


-- Skapar Index av Kunder Epost för snabbare sökande
CREATE INDEX idx_epost ON Kunder (Epost);

SELECT * FROM Bocker ORDER BY Pris;

-- Visar alla kunder med gmail adress som börjar med K is sitt namn
SELECT * FROM Kunder WHERE Epost LIKE '%gmail%' AND Namn LIKE 'K%';
-- Ändrar kundid 2's Epost
UPDATE Kunder SET Epost = 'Postnr2@amazon.com' WHERE KundID = 2;
-- Test av delete och rollback
START TRANSACTION;
DELETE FROM Kunder WHERE KundID = 1;
ROLLBACK;
-- Visar Ordrar och vilka kunder som skapat dem
SELECT Bestallningar.Ordernummer, Kunder.KundID, Kunder.Namn
FROM Bestallningar
INNER JOIN Kunder ON Bestallningar.KundID = Kunder.KundID;

SELECT Bestallningar.Ordernummer, Kunder.KundID, Kunder.Namn
FROM Kunder
LEFT JOIN Bestallningar ON Bestallningar.KundID = Kunder.KundID;
-- Visar Hur många ordar vissa kunder har gjort
SELECT COUNT(KundID), KundID
FROM Bestallningar
GROUP BY KundID;
-- Visar Hur många ordar vissa kunder har gjort med minst två som krav för att visas
SELECT COUNT(KundID), KundID
FROM Bestallningar
GROUP BY KundID
HAVING COUNT(KundID) >2;


SELECT * FROM Kund_log;

SELECT * FROM Bocker;
