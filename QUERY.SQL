-- Вибрати всі механічні клавіатури
SELECT * FROM Product
WHERE Category = 'Mechanical';

-- Вибрати всі клавіатури в діапазоні цін від 50 до 150 доларів
SELECT * FROM Product
WHERE Price BETWEEN 50 AND 150;

-- Вибрати всі клавіатури, у яких у назві є слово "Gaming"
SELECT * FROM Product
WHERE ProductName LIKE '%Gaming%';

-- Вибрати всі замовлення, включаючи ім'я клієнта, назву товару та ім'я постачальника
SELECT o.OrderID, o.OrderDate, c.CustomerName, p.ProductName, s.SupplierName, o.OrderAmount
FROM Orders o
         JOIN Customer c ON o.CustomerID = c.CustomerID
         JOIN Product p ON o.OrderID = p.ProductID
         JOIN Supplier s ON p.SupplierID = s.SupplierID;

-- Оператор LEFT JOIN для відображення всіх замовлень та відповідних клієнтів
SELECT Orders.OrderID, Orders.OrderDate, Orders.OrderAmount,
       Customer.CustomerName, Customer.Email
FROM Orders
         LEFT JOIN Customer ON Orders.CustomerID = Customer.CustomerID;

-- SUBQUERY для вибору замовлень із сумою вище середнього
SELECT OrderID, OrderDate, OrderAmount, CustomerID
FROM Orders
WHERE OrderAmount > (SELECT AVG(OrderAmount) FROM Orders);

-- GROUP BY, HAVING та JOIN для підрахунку продажів постачальників
SELECT s.SupplierName, SUM(o.OrderAmount) AS TotalSales
FROM Orders o
         JOIN Product p ON o.OrderID = p.ProductID
         JOIN Supplier s ON p.SupplierID = s.SupplierID
GROUP BY s.SupplierName
HAVING SUM(o.OrderAmount) > 2000;

-- Складний багатотабличний запит для аналізу великих замовлень
SELECT
    c.CustomerName,
    c.Email,
    o.OrderDate,
    o.OrderAmount,
    p.ProductName,
    s.SupplierName
FROM Orders o
         JOIN Customer c ON o.CustomerID = c.CustomerID
         JOIN Product p ON o.OrderID = p.ProductID
         JOIN Supplier s ON p.SupplierID = s.SupplierID
WHERE o.OrderAmount > 1000
ORDER BY o.OrderAmount DESC;



