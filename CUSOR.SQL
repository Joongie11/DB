BEGIN TRAN;

-- Операція 1: оновлюємо ціну продукту
UPDATE Product
SET Price = 1200.00
WHERE ProductID = 1;

-- Операція 2: оновлюємо ім’я постачальника, який пов’язаний з цим продуктом
UPDATE Supplier
SET SupplierName = 'TechNova Ltd.'
WHERE SupplierID = (
    SELECT SupplierID FROM Product WHERE ProductID = 1
);

-- Умова для ROLLBACK: якщо більше немає товарів дешевших за 1000
IF (SELECT COUNT(*) FROM Product WHERE Price < 1000) = 0
    ROLLBACK;
ELSE
    COMMIT;

