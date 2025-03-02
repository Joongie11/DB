-- Оновлення ціни продукту
UPDATE Product
SET Price = 1400.00
WHERE ProductName = 'Laptop';

-- Оновлення контактної інформації клієнта
UPDATE Customer
SET ContactNumber = '5555555555'
WHERE CustomerName = 'Sofi Sha';

-- Видалення одного замовлення
DELETE FROM [Order]
WHERE OrderID = 2;

-- Оновлення посади співробітника
UPDATE Employee
SET Position = 'Senior Manager'
WHERE EmployeeID = 1;
