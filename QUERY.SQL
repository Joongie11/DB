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

-- 1. Підрахунок кількості замовлень кожного клієнта
SELECT
    Customer.CustomerName,
    COUNT(Orders.OrderID) AS TotalOrders
FROM Customer
         LEFT JOIN Orders ON Customer.CustomerID = Orders.CustomerID
GROUP BY Customer.CustomerName
HAVING COUNT(Orders.OrderID) > 0; -- тільки ті, хто зробив хоча б одне замовлення


-- 2. Загальна сума замовлень по кожному клієнту
SELECT
    Customer.CustomerName,
    SUM(Orders.OrderAmount) AS TotalSpent
FROM Customer
         JOIN Orders ON Customer.CustomerID = Orders.CustomerID
GROUP BY Customer.CustomerName
HAVING SUM(Orders.OrderAmount) > 1000; -- фільтр клієнтів з витратами більше 1000


-- 3. Кількість продуктів у кожній категорії
SELECT
    Category,
    COUNT(ProductID) AS ProductCount
FROM Product
GROUP BY Category
HAVING COUNT(ProductID) >= 1; -- тільки категорії з товарами


-- 4. Середня сума замовлень по датах замовлення
SELECT
    OrderDate,
    AVG(OrderAmount) AS AverageOrderAmount
FROM Orders
GROUP BY OrderDate
HAVING AVG(OrderAmount) > 500; -- показати тільки дати з середнім замовленням більше 500


-- 5. Підрахунок кількості клієнтів, які зробили замовлення на кожну дату
SELECT
    Orders.OrderDate,
    COUNT(DISTINCT Orders.CustomerID) AS CustomerCount
FROM Orders
GROUP BY Orders.OrderDate
HAVING COUNT(DISTINCT Orders.CustomerID) > 0; -- дати, де були клієнти з замовленнями

SELECT COUNT(*) AS total_suppliers FROM Supplier;
SELECT COUNT(*) AS total_products FROM Product;
SELECT COUNT(*) AS total_customers FROM Customer;
SELECT COUNT(*) AS total_orders FROM Orders;
SELECT COUNT(*) AS total_employees FROM Employee;

-- 1. Середня ціна товару
SELECT AVG(Price) AS AverageProductPrice FROM Product;

-- 2. Максимальна сума замовлення
SELECT MAX(OrderAmount) AS MaxOrderValue FROM Orders;

-- 3. Кількість різних посад серед працівників
SELECT COUNT(DISTINCT Position) AS UniquePositions FROM Employee;

-- 1. Нумерація працівників за іменем
SELECT
    EmployeeID,
    EmployeeName,
    ROW_NUMBER() OVER (ORDER BY EmployeeName) AS RowNum
FROM Employee;

-- 2. Рейтинг працівників за посадою
SELECT
    EmployeeID,
    EmployeeName,
    Position,
    RANK() OVER (ORDER BY Position) AS PositionRank
FROM Employee;

-- 3. Середня сума замовлення по кожному клієнту
SELECT
    CustomerID,
    OrderID,
    OrderAmount,
    AVG(OrderAmount) OVER (PARTITION BY CustomerID) AS AvgOrderPerCustomer
FROM Orders;

-- 1. Підрахунок довжини імені працівника
SELECT
    EmployeeID,
    EmployeeName,
    LEN(EmployeeName) AS NameLength
FROM Employee;

-- 2. Отримати перші 3 символи назви постачальника
SELECT
    SupplierID,
    SupplierName,
    LEFT(SupplierName, 3) AS ShortName
FROM Supplier;

-- 3. Пошук позиції символа “@” у полі Email
SELECT
    CustomerID,
    Email,
    CHARINDEX('@', Email) AS AtPosition
FROM Customer;

-- 1. Отримати рік кожного замовлення
SELECT
    OrderID,
    OrderDate,
    YEAR(OrderDate) AS OrderYear
FROM Orders;

-- 2. Отримати місяць замовлення
SELECT
    OrderID,
    OrderDate,
    MONTH(OrderDate) AS OrderMonth
FROM Orders;

-- 3. Кількість днів від дати замовлення до сьогоднішньої дати
SELECT
    OrderID,
    OrderDate,
    DATEDIFF(DAY, OrderDate, GETDATE()) AS DaysSinceOrder
FROM Orders;

CREATE CLUSTERED INDEX IX_TestData_Value
    ON TestData(Value);

CREATE NONCLUSTERED INDEX IX_TestData_Name
    ON TestData(Name);

CREATE UNIQUE INDEX IX_TestData_ID
    ON TestData(ID);

CREATE NONCLUSTERED INDEX IX_TestData_ID_Include
    ON TestData(ID)
    INCLUDE (Name, Value);

SELECT Name, Value FROM TestData WHERE ID = 50;

CREATE NONCLUSTERED INDEX IX_Filtered_Value
    ON TestData(Value)
    WHERE Value > 900;

SELECT
    dbschemas.name AS SchemaName,
    dbtables.name AS TableName,
    dbindexes.name AS IndexName,
    indexstats.index_type_desc AS IndexType,
    indexstats.avg_fragmentation_in_percent AS FragmentationPercent,
    indexstats.page_count AS PageCount
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'LIMITED') AS indexstats
         INNER JOIN sys.tables dbtables ON indexstats.object_id = dbtables.object_id
         INNER JOIN sys.schemas dbschemas ON dbtables.schema_id = dbschemas.schema_id
         INNER JOIN sys.indexes dbindexes ON indexstats.object_id = dbindexes.object_id
    AND indexstats.index_id = dbindexes.index_id
WHERE dbindexes.name IS NOT NULL
ORDER BY indexstats.avg_fragmentation_in_percent DESC;

ALTER INDEX IX_TestData_Value ON TestData REORGANIZE;

SELECT
    OBJECT_NAME(ips.[object_id]) AS TableName,
    i.name AS IndexName,
    ips.index_type_desc AS IndexType,
    ips.avg_fragmentation_in_percent AS FragmentationPercent
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
         JOIN sys.indexes i ON ips.[object_id] = i.[object_id] AND ips.index_id = i.index_id
WHERE OBJECT_NAME(ips.[object_id]) = 'TestData';

ALTER INDEX IX_TestData_Value ON TestData REBUILD;

DROP INDEX IX_TestData_ID_Include ON TestData;

CREATE NONCLUSTERED INDEX IX_TestData_ID_Include
    ON TestData(ID)
    INCLUDE (Name, Value);

SELECT
    DB_NAME() AS [База_даних],
    OBJECT_NAME(i.[object_id]) AS [Таблиця],
    i.name AS [Індекс],
    i.type_desc AS [Тип_індексу],
    i.is_unique AS [Унікальний],
    ps.avg_fragmentation_in_percent AS [Фрагментація_у_%],
    ps.page_count AS [Кількість_сторінок]
FROM
    sys.indexes AS i
        INNER JOIN
    sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') AS ps
    ON i.[object_id] = ps.[object_id] AND i.index_id = ps.index_id
WHERE
    i.type > 0 AND i.is_hypothetical = 0
ORDER BY
    ps.avg_fragmentation_in_percent DESC;



























