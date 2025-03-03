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
