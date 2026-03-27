-- Sarah Bjork YH24

-- Skapar databasen
CREATE DATABASE bokhandel;
-- Väljer databasen
USE bokhandel;
-- Skapar tabelen som representerear kunder i systemet
CREATE TABLE Kunder (
    KundID INT AUTO_INCREMENT PRIMARY KEY,
    Namn VARCHAR(100),
    Epost VARCHAR(100),
    Telefon VARCHAR(20),
    Adress VARCHAR(255)
);
-- Skapar tabelen som representerar böcker i systemet med info om boken och lager info
CREATE TABLE Bocker (
    ISBN VARCHAR(20) PRIMARY KEY,
    Titel VARCHAR(255),
    Forfattare VARCHAR(100),
    Pris DECIMAL(10,2),
    Lagerstatus INT
);
-- Skapar tabelen som innehåller info om beställningar som Kunder kan göra i systemet. Hämtar en foreign key från kunden som skapar den
CREATE TABLE Bestallningar (
    Ordernummer INT AUTO_INCREMENT PRIMARY KEY,
    Datum DATE,
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
-- test insert och select
INSERT INTO Kunder (Namn, Epost, Telefon, Adress)
	VALUES ('Tom', 'Tom@gmailcom', '07655503', 'Kalmargaten 1');

SELECT * FROM Kunder;
	