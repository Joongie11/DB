-- 1. Клієнти, які зробили хоча б одне замовлення
SELECT CustomerName
FROM Customer
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
);


-- 2. Список постачальників та клієнтів в одному стовпчику
SELECT SupplierName AS Name
FROM Supplier
UNION
SELECT CustomerName AS Name
FROM Customer;


-- 3. Всі замовлення з інформацією про клієнтів
SELECT
    Orders.OrderID,
    Customer.CustomerName,
    Orders.OrderDate
FROM Orders
         JOIN Customer ON Orders.CustomerID = Customer.CustomerID;

-- 1. Перевірка каскадного видалення
-- Видаляємо постачальника з SupplierID = 1
DELETE FROM Supplier
WHERE SupplierID = 1;

-- Перевірка: чи існують продукти, які були пов'язані з SupplierID = 1
SELECT * FROM Product WHERE SupplierID = 1;


-- 2. Перевірка каскадного видалення
DELETE FROM Customer
WHERE CustomerID = 2;

-- Перевірка: чи існують замовлення цього клієнта
SELECT * FROM Orders WHERE CustomerID = 2;


-- 3. Перевірка каскадного оновлення
-- Оновлюємо назву постачальника (SupplierName), з 'Supplier 2' на 'Updated Supplier'
UPDATE Supplier
SET SupplierName = 'Updated Supplier'
WHERE SupplierID = 2;

-- Перевірка: виводимо постачальника, щоб переконатися, що назва оновлена
SELECT * FROM Supplier WHERE SupplierID = 2;


-- 4. Перевірка каскадного оновлення (CustomerName)
-- Змінюємо ім’я клієнта
UPDATE Customer
SET CustomerName = 'Updated Customer'
WHERE CustomerID = 3;

-- Перевірка: виводимо клієнта, щоб переконатися, що ім’я оновлене
SELECT * FROM Customer WHERE CustomerID = 3;


-- 5. Перевірка поточного стану таблиць після всіх операцій
SELECT * FROM Supplier;
SELECT * FROM Product;

SELECT * FROM Customer;
SELECT * FROM Orders;

-- 1. -- Постачальники, впорядковані за алфавітом
SELECT *
FROM Supplier
ORDER BY SupplierName ASC;

-- 2. Замовлення за сумою, від найбільшої до найменшої
SELECT *
FROM Orders
ORDER BY OrderAmount DESC;




