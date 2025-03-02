-- Вибірка всіх клієнтів
SELECT * FROM Customer;

-- Вибірка всіх продуктів разом із постачальниками
SELECT p.ProductID, p.ProductName, p.Category, p.Price, s.SupplierName
FROM Product p
         JOIN Supplier s ON p.SupplierID = s.SupplierID;

-- Вибірка замовлень із інформацією про клієнтів
SELECT o.OrderID, o.OrderDate, o.OrderAmount, c.CustomerName, c.Email
FROM [Order] o
         JOIN Customer c ON o.CustomerID = c.CustomerID;

-- Підрахунок кількості замовлень кожного клієнта
SELECT c.CustomerName, COUNT(o.OrderID) AS OrderCount
FROM Customer c
         LEFT JOIN [Order] o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

-- Сума всіх замовлень за кожного клієнта
SELECT c.CustomerName, SUM(o.OrderAmount) AS TotalSpent
FROM Customer c
         LEFT JOIN [Order] o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

-- Вибірка найдорожчого товару
SELECT TOP 1 * FROM Product ORDER BY Price DESC;

-- Вибірка середньої ціни товарів за категоріями
SELECT Category, AVG(Price) AS AvgPrice
FROM Product
GROUP BY Category;

-- Вибірка співробітників, які працюють на посаді "Manager"
SELECT * FROM Employee WHERE Position LIKE '%Manager%';


