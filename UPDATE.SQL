-- Оновлення ціни продукту
UPDATE Product
SET Price = 1400.00
WHERE ProductName = 'Laptop';

-- Оновлення контактної інформації клієнта
UPDATE Customer
SET ContactNumber = '5555555555'
WHERE CustomerName = 'John Smith';

-- Видалення одного замовлення
DELETE FROM Orders
WHERE OrderID = 2;

-- Оновлення посади співробітника
UPDATE Employee
SET Position = 'Senior Manager'
WHERE EmployeeID = 1;

UPDATE Product
SET Price = 550.00
WHERE ProductName = N'Logitech K120';