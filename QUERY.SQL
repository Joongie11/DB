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

-- 1. Вибираємо всіх клієнтів, які вказали Email та мають номер телефону довший за 5 символів
SELECT *
FROM Customer
WHERE Email IS NOT NULL
  AND LEN(ContactNumber) > 5;

-- 2. Виводимо всі продукти, ціна яких більше або дорівнює 1000
-- або категорія продукту дорівнює 'Gaming'
SELECT *
FROM Product
WHERE Price >= 1000
   OR Category = 'Gaming';

-- 3. Виводимо всі замовлення, зроблені після 2024-01-01
-- та з сумою замовлення меншою за 5000
SELECT *
FROM Orders
WHERE OrderDate > '2024-01-01'
  AND OrderAmount < 5000;

-- 1. LEFT JOIN: Виводимо всі продукти разом з їхніми постачальниками
-- Показуємо навіть ті продукти, які не мають прив'язаного постачальника
SELECT
    Product.ProductID,
    Product.ProductName,
    Supplier.SupplierName
FROM Product
         LEFT JOIN Supplier
                   ON Product.SupplierID = Supplier.SupplierID;


-- 2. FULL JOIN: Виводимо всі дані про замовлення та клієнтів
-- Включаємо клієнтів, які ще не робили замовлень, та замовлення без вказаних клієнтів
SELECT
    Customer.CustomerName,
    Orders.OrderID,
    Orders.OrderDate,
    Orders.OrderAmount
FROM Customer
         FULL JOIN Orders
                   ON Customer.CustomerID = Orders.CustomerID;






