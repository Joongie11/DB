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

-- 8 ЗАВДАННЯ --

-- Оператор LEFT JOIN для відображення всіх замовлень та відповідних клієнтів
SELECT Orders.OrderID, Orders.OrderDate, Orders.OrderAmount,
       Customer.CustomerName, Customer.Email
FROM Orders
         LEFT JOIN Customer ON Orders.CustomerID = Customer.CustomerID;

-- Виведення всіх клієнтів і їхніх замовлень, включаючи клієнтів без замовлень
SELECT Customer.CustomerID, Customer.CustomerName, Customer.Email, Orders.OrderID, Orders.OrderDate, Orders.OrderAmount
FROM Orders
         RIGHT JOIN Customer ON Orders.CustomerID = Customer.CustomerID;

-- Виведення всіх постачальників і відповідних продуктів, включаючи постачальників, у яких немає продуктів
SELECT Supplier.SupplierName, Product.ProductName, Product.Price
FROM Supplier
         LEFT JOIN Product ON Supplier.SupplierID = Product.SupplierID;

-- Виведення всіх клієнтів і їхніх замовлень, включаючи клієнтів, які не зробили жодного замовлення
SELECT Customer.CustomerName, Customer.Email, Orders.OrderID, Orders.OrderAmount
FROM Customer
         RIGHT JOIN Orders ON Customer.CustomerID = Orders.CustomerID;

-- Виведення всіх замовлень разом із продуктами, навіть якщо в замовленні не зазначено конкретний товар
SELECT Orders.OrderID, Orders.OrderDate, Orders.OrderAmount, Product.ProductName
FROM Orders
         FULL JOIN Product ON Orders.OrderID = Product.ProductID;

-- 9 ЗАВДАННЯ --

-- SUBQUERY для вибору замовлень із сумою вище середнього
SELECT OrderID, OrderDate, OrderAmount, CustomerID
FROM Orders
WHERE OrderAmount > (SELECT AVG(OrderAmount) FROM Orders);

-- Виведення клієнтів, які зробили замовлення на суму більше середнього значення всіх замовлень
SELECT CustomerID, CustomerName, Email
FROM Customer
WHERE CustomerID IN (
    SELECT CustomerID FROM Orders
    WHERE OrderAmount > (SELECT AVG(OrderAmount) FROM Orders)
);

-- Виведення продуктів, які мають ціну вище середньої ціни всіх товарів
SELECT ProductID, ProductName, Category, Price
FROM Product
WHERE Price > (SELECT AVG(Price) FROM Product);

-- Виведення постачальників, які надають хоча б один товар із категорії "Mechanical"
SELECT SupplierID, SupplierName, ContactNumber, Address
FROM Supplier
WHERE SupplierID IN (
    SELECT SupplierID FROM Product
    WHERE Category = 'Mechanical'
);

-- Виведення замовлень, що містять товари дорожчі за найдешевший товар у категорії "Gaming"
SELECT OrderID, OrderDate, OrderAmount
FROM Orders
WHERE OrderID IN (
    SELECT DISTINCT OrderID FROM Product
    WHERE Price > (SELECT MIN(Price) FROM Product WHERE Category = 'Gaming')
);

-- 10 ЗАВДАННЯ --

-- GROUP BY, HAVING та JOIN для підрахунку продажів постачальників
SELECT s.SupplierName, SUM(o.OrderAmount) AS TotalSales
FROM Orders o
         JOIN Product p ON o.OrderID = p.ProductID
         JOIN Supplier s ON p.SupplierID = s.SupplierID
GROUP BY s.SupplierName
HAVING SUM(o.OrderAmount) > 2000;

-- Підрахунок загальної суми замовлень для кожного клієнта, відображення тільки тих, у кого загальна сума перевищує 2000
SELECT c.CustomerID, c.CustomerName, SUM(o.OrderAmount) AS TotalSpent
FROM Orders o
         JOIN Customer c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING SUM(o.OrderAmount) > 2000;

-- Підрахунок кількості замовлень для кожного місяця та вибір місяців із більше ніж 10 замовленнями
SELECT YEAR(o.OrderDate) AS OrderYear, MONTH(o.OrderDate) AS OrderMonth, COUNT(o.OrderID) AS OrderCount
FROM Orders o
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
HAVING COUNT(o.OrderID) > 10;

-- Вибір категорій товарів, загальний продаж яких перевищує 3000
SELECT p.Category, SUM(o.OrderAmount) AS TotalSales
FROM Orders o
         JOIN Product p ON o.OrderID = p.ProductID
GROUP BY p.Category
HAVING SUM(o.OrderAmount) > 3000;

-- Визначення клієнтів, які зробили понад 5 замовлень
SELECT c.CustomerID, c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Orders o
         JOIN Customer c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) > 5;

-- 11 ЗАВДАННЯ --

-- Визначення загальної суми замовлень кожного клієнта, які перевищують середнє значення
SELECT c.CustomerName, SUM(o.OrderAmount) AS TotalSpent
FROM Orders o
         JOIN Customer c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerName
HAVING SUM(o.OrderAmount) > (SELECT AVG(OrderAmount) FROM Orders);

-- Виведення замовлень з інформацією про постачальників, де сума замовлення понад 1500
SELECT o.OrderID, o.OrderDate, o.OrderAmount, c.CustomerName, s.SupplierName
FROM Orders o
         JOIN Customer c ON o.CustomerID = c.CustomerID
         JOIN Product p ON o.OrderID = p.ProductID
         JOIN Supplier s ON p.SupplierID = s.SupplierID
WHERE o.OrderAmount > 1500;

-- Отримання списку клієнтів, які здійснили замовлення в січні 2025 року
SELECT DISTINCT c.CustomerID, c.CustomerName, c.Email
FROM Customer c
         JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate BETWEEN '2025-01-01' AND '2025-01-31';

-- Визначення клієнтів, які зробили понад 3 замовлень
SELECT c.CustomerID, c.CustomerName, COUNT(o.OrderID) AS OrderCount
FROM Customer c
         JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) > 3;

-- Виведення замовлень із даними клієнтів, де замовлення більше середнього значення для відповідного місяця
SELECT o.OrderID, o.OrderDate, o.OrderAmount, c.CustomerName
FROM Orders o
         JOIN Customer c ON o.CustomerID = c.CustomerID
WHERE o.OrderAmount > (
    SELECT AVG(OrderAmount)
    FROM Orders
    WHERE MONTH(OrderDate) = MONTH(o.OrderDate)
);





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



