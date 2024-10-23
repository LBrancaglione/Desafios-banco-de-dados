USE AdventureWorks2019

-- Desafios Intermedi�rio 

/* 1) Escreva uma consulta SQL para recuperar informa��es sobre produtos e suas categorias. 
Inclua o nome do produto, a categoria e a quantidade em estoque.
Utilize as tabelas "Production.Product", "Production.ProductCategory" 
e "Production.ProductInventory" */

SELECT 
    p.Name AS product_name, 
    pc.Name AS category_name, 
    pi.Quantity AS quantity_in_stock
FROM 
    Production.Product p
JOIN 
    Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN 
    Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN 
    Production.ProductInventory pi ON p.ProductID = pi.ProductID;

/* 2) Escreva uma instru��o SQL para excluir todos os produtos da categoria 'Clothing' da tabela "Production.Product". 
Utilize a tabela "Production.ProductCategory" para identificar os produtos dessa categoria. */



-- Excluir os itens do carrinho de compras relacionados aos produtos da categoria 'Clothing'
DELETE FROM Sales.ShoppingCartItem
WHERE ProductID IN (
    SELECT p.ProductID 
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Clothing'
);

-- Excluir os detalhes dos pedidos de venda relacionados aos produtos da categoria 'Clothing'
DELETE FROM Sales.SalesOrderDetail
WHERE SpecialOfferID IN (
    SELECT sop.SpecialOfferID 
    FROM Sales.SpecialOfferProduct sop
    JOIN Production.Product p ON sop.ProductID = p.ProductID
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Clothing'
);

-- Excluir os produtos especiais relacionados aos produtos da categoria 'Clothing'
DELETE FROM Sales.SpecialOfferProduct
WHERE ProductID IN (
    SELECT p.ProductID 
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Clothing'
);

-- Excluir os detalhes de pedidos de compra relacionados aos produtos da categoria 'Clothing'
DELETE FROM Purchasing.PurchaseOrderDetail
WHERE ProductID IN (
    SELECT p.ProductID 
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Clothing'
);

-- Excluir os fornecedores dos produtos relacionados � categoria 'Clothing'
DELETE FROM Purchasing.ProductVendor
WHERE ProductID IN (
    SELECT p.ProductID 
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Clothing'
);

-- Excluir as avalia��es dos produtos relacionados � categoria 'Clothing'
DELETE FROM Production.ProductReview
WHERE ProductID IN (
    SELECT p.ProductID 
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Clothing'
);

-- Excluir as fotos dos produtos relacionados � categoria 'Clothing'
DELETE FROM Production.ProductProductPhoto
WHERE ProductID IN (
    SELECT p.ProductID 
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Clothing'
);

-- Excluir o hist�rico de pre�os dos produtos relacionados � categoria 'Clothing'
DELETE FROM Production.ProductListPriceHistory
WHERE ProductID IN (
    SELECT p.ProductID 
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Clothing'
);

-- Excluir o invent�rio dos produtos relacionados � categoria 'Clothing'
DELETE FROM Production.ProductInventory
WHERE ProductID IN (
    SELECT p.ProductID 
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Clothing'
);

-- Excluir o hist�rico de transa��es dos produtos relacionados � categoria 'Clothing'
DELETE FROM Production.TransactionHistory
WHERE ProductID IN (
    SELECT p.ProductID 
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Clothing'
);

-- Finalmente, excluir os produtos da tabela Product
DELETE FROM Production.Product
WHERE ProductID IN (
    SELECT p.ProductID 
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Clothing'
);

-- Verifica se tem algum produto com categoria clothing

SELECT p.ProductID
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Clothing';

/*3) Escreva uma consulta SQL para recuperar uma lista �nica de nomes completos de clientes, 
onde o nome � concatenado com base no t�tulo, primeiro nome, meio inicial e �ltimo nome. 
Adicione uma coluna adicional chamada 'NomeCompleto' e utilize a fun��o CASE para lidar com valores nulos.*/

SELECT DISTINCT 
    CustomerID, -- ou outro identificador exclusivo do cliente
    CASE
        WHEN Title IS NOT NULL THEN Title + ' '
        ELSE ''
    END +
    FirstName + ' ' +
    CASE
        WHEN MiddleName IS NOT NULL THEN MiddleName + '. '
        ELSE ''
    END +
    LastName AS NomeCompleto
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
ORDER BY NomeCompleto;