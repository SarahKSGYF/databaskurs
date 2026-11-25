-- Skapar databasen
CREATE DATABASE Commissions;
-- Väljer databasen
USE Commissions;

CREATE TABLE Costumer (
	CostumerID INT AUTO_INCREMENT PRIMARY KEY,
	Costumer_name VARCHAR(25) NOT NULL,
    EMail VARCHAR(20) NOT NULL UNIQUE,
    Tele VARCHAR(20),
    Orders INT NOT NULL DEFAULT 0
);

CREATE TABLE Model (
    ModelID INT AUTO_INCREMENT PRIMARY KEY,
    Model_name VARCHAR(25) NOT NULL UNIQUE,
    Size VARCHAR(20) NOT NULL,
    Material VARCHAR(8) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CHECK(Price>0)
);

CREATE TABLE Comm (
    CommID INT AUTO_INCREMENT PRIMARY KEY,
    Date_order TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Note VARCHAR(100),
	ModelID INT NOT NULL,
    FOREIGN KEY (ModelID) REFERENCES Model(ModelID),
    CostumerID INT NOT NULL,
    FOREIGN KEY (CostumerID) REFERENCES Costumer(CostumerID)
);

DELIMITER $$
CREATE TRIGGER Model_ordered AFTER INSERT ON Comm FOR EACH ROW 
BEGIN
	UPDATE Costumer SET Orders = Orders + 1
    WHERE CostumerID = NEW.CostumerID;
END $$

DELIMITER ;

INSERT INTO Model (Model_name, Size, Material, Price)
	VALUES ('Chaos Knight', 'Big vehacle', 'Plastic', 2000);
    
INSERT INTO Model (Model_name, Size, Material, Price)
	VALUES ('Spellweaver', 'Infantry', 'Metal', 300);

INSERT INTO Costumer (Costumer_name, Email)
	VALUES ('Max Galliger', 'paintfan@gmail.com');
    
INSERT INTO Costumer (Costumer_name, Email, Tele)
	VALUES ('Helen Rift', 'helen@gmail.com', '99999399');

INSERT INTO Costumer (Costumer_name, Email, Tele)
	VALUES ('Tove Fox', 'foxn@gmail.com', '99299999');
    
INSERT INTO Costumer (Costumer_name, Email, Tele)
	VALUES ('Gem Knight', 'oracle@gmail.com', '99999499');
    
INSERT INTO Costumer (Costumer_name, Email, Tele)
	VALUES ('Rolf First', 'last@gmail.com', '99998999');


INSERT INTO Comm (Note, ModelID, CostumerID)
	VALUES ('Blue, orange and green', 1, 2);

INSERT INTO Comm (Note, ModelID, CostumerID)
	VALUES ('Blue, orange and green', 1, 4);
INSERT INTO Comm (Note, ModelID, CostumerID)
	VALUES ('Blue, orange and green', 2, 2);

SELECT Comm.CommID, Costumer.CostumerID, Costumer.Costumer_Name, Model.ModelID, Model.Model_name
FROM Comm
INNER JOIN Costumer ON Comm.CostumerID = Costumer.CostumerID
INNER JOIN Model ON Comm.ModelID = Model.ModelID;

SELECT COUNT(CostumerID), CostumerID
FROM Comm
GROUP BY CostumerID
HAVING COUNT(CostumerID) >= 2;

SELECT * FROM Costumer;
SELECT * FROM Model;
SELECT * FROM Comm;