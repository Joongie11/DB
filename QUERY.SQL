-- 4 ЗАВДАННЯ --

-- Вибрати всі механічні клавіатури
SELECT * FROM Product
WHERE Category = 'Mechanical';

-- Отримати всі замовлення, сума яких перевищує 2000
SELECT * FROM Orders
WHERE OrderAmount > 2000;

-- Знайти всіх клієнтів, які мають конкретний email
SELECT * FROM Customer
WHERE Email = 'john.smith@example.com';

-- Вибрати всі товари від постачальника з ID = 5
SELECT * FROM Product
WHERE SupplierID = 5;

-- Отримати всіх співробітників, які мають позицію "Manager"
SELECT * FROM Employee
WHERE Position = 'Manager';

-- 5 ЗАВДАННЯ --

-- Вибрати всі клавіатури в діапазоні цін від 50 до 150 доларів
SELECT * FROM Product
WHERE Price BETWEEN 50 AND 150;

-- Вибірка всіх замовлень, де сума понад 2000 і дата після 1 січня 2025 року
SELECT * FROM Orders
WHERE OrderAmount > 2000 AND OrderDate > '2025-01-01';

-- Вибірка всіх товарів, які належать до категорії 'Mechanical' або 'Gaming'
SELECT * FROM Product
WHERE Category = 'Mechanical' OR Category = 'Gaming';

-- Вибірка товарів, ціна яких знаходиться в межах 100-300 і вони не належать до категорії 'Membrane'
SELECT * FROM Product
WHERE Price BETWEEN 100 AND 300 AND NOT Category = 'Membrane';

-- Вибірка замовлень, зроблених клієнтами з ID у діапазоні від 10 до 50, але виключаючи ID 25
SELECT * FROM Orders
WHERE CustomerID BETWEEN 10 AND 50 AND NOT CustomerID = 25;

-- 6 ЗАВДАННЯ --

-- Вибірка клієнтів, у яких ім'я починається на "A"
SELECT * FROM Customer
WHERE CustomerName LIKE 'A%';

-- Вибірка товарів, які містять слово "Gaming" у назві
SELECT * FROM Product
WHERE ProductName LIKE '%Gaming%';

-- Вибірка постачальників, у яких адреса містить слово "Street"
SELECT * FROM Supplier
WHERE Address LIKE '%Street%';

-- Вибірка клієнтів, чий email закінчується на "@example.com"
SELECT * FROM Customer
WHERE Email LIKE '%@example.com';

-- Вибірка замовлень, де дата замовлення містить "2025-01"
SELECT * FROM Orders
WHERE OrderDate LIKE '2025-01%';

-- 7 ЗАВДАННЯ --

-- Вибрати всі замовлення, включаючи ім'я клієнта, назву товару та ім'я постачальника
SELECT o.OrderID, o.OrderDate, c.CustomerName, p.ProductName, s.SupplierName, o.OrderAmount
FROM Orders o
         JOIN Customer c ON o.CustomerID = c.CustomerID
         JOIN Product p ON o.OrderID = p.ProductID
         JOIN Supplier s ON p.SupplierID = s.SupplierID;

-- Отримання інформації про замовлення разом із даними про клієнта
SELECT Orders.OrderID, Orders.OrderDate, Orders.OrderAmount,
       Customer.CustomerName, Customer.Email
FROM Orders
         JOIN Customer ON Orders.CustomerID = Customer.CustomerID;

-- Отримання списку замовлень із назвами товарів та їхніми постачальниками
SELECT Orders.OrderID, Orders.OrderDate, Product.ProductName,
       Supplier.SupplierName
FROM Orders
         JOIN Product ON Orders.OrderID = Product.ProductID
         JOIN Supplier ON Product.SupplierID = Supplier.SupplierID;

-- Отримання списку товарів із зазначенням їхніх постачальників
SELECT Product.ProductName, Product.Price, Supplier.SupplierName
FROM Product
         JOIN Supplier ON Product.SupplierID = Supplier.SupplierID;

-- Отримання списку працівників, які обробляли замовлення
SELECT Employee.EmployeeName, Orders.OrderID, Orders.OrderDate
FROM Employee
         JOIN Orders ON Employee.EmployeeID = Orders.CustomerID;






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

-- Поєднання WHERE та JOIN
SELECT
    o.OrderID,
    o.OrderDate,
    o.OrderAmount,
    c.CustomerName,
    c.Email,
    p.ProductName,
    s.SupplierName
FROM Orders o
         JOIN Customer c ON o.CustomerID = c.CustomerID
         JOIN Product p ON o.OrderID = p.ProductID
         JOIN Supplier s ON p.SupplierID = s.SupplierID
WHERE o.OrderDate > '2024-11-01'
ORDER BY o.OrderDate ASC;



