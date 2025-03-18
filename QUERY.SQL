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