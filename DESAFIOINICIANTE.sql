use AdventureWorks2019

-- 1) Adicione um novo produto � tabela "Production.Product". Suponha que o novo produto tenha o nome 'Smartphone', um custo padr�o de $200 e um pre�o de lista de $400.

INSERT INTO Production.Product (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate)
VALUES ('Smartphone', 'SMT-001', 1, 1, 'Black', 100, 50, 200.00, 400.00, 0, GETDATE());


INSERT INTO Production.ProductListPriceHistory (ProductID, StartDate, EndDate, ListPrice)
VALUES ((SELECT ProductID FROM Production.Product WHERE Name = 'Smartphone'), GETDATE(), NULL, 400.00);

-- Verifica as inser��es

SELECT ProductID, Name, ProductNumber, ListPrice, SellStartDate
FROM Production.Product
WHERE Name = 'Smartphone';


-- 2) Atualize o pre�o de lista (ListPrice) do produto com o nome 'Mountain Bike Socks'para $15 na tabela "Production.Product".

UPDATE Production.Product
SET ListPrice = 15.00
WHERE Name = 'Mountain Bike Socks';

-- 3) Recupere os nomes e pre�os de lista dos cinco produtos mais caros da tabela "Production.Product". Ordene os resultados em ordem decrescente de pre�o de lista

SELECT TOP 5 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

	

