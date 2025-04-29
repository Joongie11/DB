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

BEGIN TRAN;

-- Спроба оновити продукт, якого не існує
BEGIN TRAN;

UPDATE Product
SET Price = 999.99
WHERE ProductID = 9999;  -- неіснуючий ID

IF @@ERROR <> 0
    ROLLBACK;
ELSE
    COMMIT;

BEGIN TRAN;
BEGIN TRY
    -- Це викличе помилку, бо ціна не може бути від’ємною
    UPDATE Product
    SET Price = -500.00
    WHERE ProductID = 1;

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Виникла помилка:';
    PRINT ERROR_MESSAGE();
END CATCH;

BEGIN TRAN;

DECLARE @i INT = 1;

WHILE @i <= 100000
    BEGIN
        INSERT INTO TestData (ID, Name, Value)
        VALUES (@i, CONCAT('Name_', @i), RAND() * 1000);

        SET @i = @i + 1;
    END

COMMIT;

SELECT COUNT(*) AS TotalRows FROM TestData;

CREATE OR ALTER PROCEDURE UpdateProductPrice
    @ProductID INT,
    @NewPrice DECIMAL(12,2)
AS
BEGIN
    PRINT '--- Start: ' + CAST(GETDATE() AS NVARCHAR);

    UPDATE Product
    SET Price = @NewPrice
    WHERE ProductID = @ProductID;

    PRINT '--- End: ' + CAST(GETDATE() AS NVARCHAR);
END;


    EXEC UpdateProductPrice @ProductID = 1, @NewPrice = 999.99;
