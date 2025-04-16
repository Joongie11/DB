-- Інформація про таблицю Products
EXEC sp_help 'Product';

-- Оцінка використаного простору таблицею Orders
EXEC sp_spaceused 'Orders';

-- Перелік індексів для таблиці TestData
EXEC sp_helpindex 'TestData';

-- Показати всі продукти з таблиці Product
CREATE PROCEDURE GetAllProducts
AS
BEGIN
    SELECT * FROM Product;
END;


-- Повернути всі замовлення конкретного покупця за його CustomerID
    CREATE PROCEDURE GetOrdersByCustomer
    @CustomerID INT
    AS
    BEGIN
        SELECT * FROM Orders WHERE CustomerID = @CustomerID;
    END;


-- Показати статистику — кількість товарів і середню ціну
    CREATE PROCEDURE GetProductStats
    AS
    BEGIN
         SELECT
             COUNT(*) AS TotalProducts,
             AVG(Price) AS AvgPrice
         FROM Product;
    END;

-- Виконання процедур
    EXEC ##GetAllProducts;
    EXEC ##GetOrdersByCustomer @CustomerID = 1;
    EXEC ##GetProductStats;

-- 1. Тимчасова процедура: Отримати список всіх товарів
        CREATE PROCEDURE #GetAllProducts
        AS
        BEGIN
            SELECT * FROM Product;
        END;

        EXEC #GetAllProducts;

-- 2. Тимчасова процедура: Отримати замовлення конкретного покупця
            CREATE PROCEDURE #GetOrdersByCustomer
            @CustomerID INT
            AS
            BEGIN
                SELECT * FROM Orders WHERE CustomerID = @CustomerID;
            END;

            EXEC #GetOrdersByCustomer @CustomerID = 1;

-- 3. Тимчасова процедура: Порахувати середню ціну та кількість товарів
                CREATE PROCEDURE #GetProductStats
                AS
                BEGIN
                    SELECT COUNT(*) AS TotalProducts, AVG(Price) AS AvgPrice
                    FROM Product;
                END;

                EXEC #GetProductStats;

-- 1. Додати нове замовлення (із транзакцією)
    CREATE PROCEDURE AddOrder
        @CustomerID INT,
        @OrderAmount DECIMAL(12,2),
        @ProductID INT,
        @Quantity INT
    AS
    BEGIN
        BEGIN TRANSACTION;

        BEGIN TRY
            -- Додаємо замовлення
            INSERT INTO Orders (OrderDate, OrderAmount, CustomerID)
            VALUES (GETDATE(), @OrderAmount, @CustomerID);

            -- Оновлюємо залишок товару
            UPDATE Product
            SET Stock = Stock - @Quantity
            WHERE ProductID = @ProductID;

            COMMIT;
        END TRY
        BEGIN CATCH
            ROLLBACK;
            THROW;
        END CATCH;
    END;

        EXEC AddOrder
             @CustomerID = 5,
             @OrderAmount = 1099.99,
             @ProductID = 3,
             @Quantity = 1;

-- 2. Повернення замовлення
        CREATE PROCEDURE CancelOrder
            @OrderID INT,
            @ProductID INT,
            @Quantity INT
        AS
        BEGIN
            BEGIN TRANSACTION;

            BEGIN TRY
                DELETE FROM Orders
                WHERE OrderID = @OrderID;

                UPDATE Product
                SET Stock = Stock + @Quantity
                WHERE ProductID = @ProductID;

                COMMIT;
            END TRY
            BEGIN CATCH
                ROLLBACK;
                THROW;
            END CATCH;
        END;

            EXEC CancelOrder
                 @OrderID = 10,
                 @ProductID = 3,
                 @Quantity = 1;

-- 3. Перевірка наявності товару перед оформленням
            CREATE PROCEDURE CheckStock
            @ProductID INT
            AS
            BEGIN
                SELECT ProductName, Stock
                FROM Product
                WHERE ProductID = @ProductID;
            END;

                EXEC CheckStock
                     @ProductID = 3;


                CREATE PROCEDURE AddTestDataRows
                @RowCount INT
                AS
                BEGIN
                    DECLARE @i INT = 1;

                    WHILE @i <= @RowCount
                        BEGIN
                            INSERT INTO TestData (ID, Name, Value)
                            VALUES (
                                       (SELECT ISNULL(MAX(ID), 0) + 1 FROM TestData),
                                       CONCAT('Auto_Item_', @i),
                                       ROUND(RAND() * 1000, 2)
                                   );

                            SET @i = @i + 1;
                        END
                END;

                    EXEC AddTestDataRows @RowCount = 10;



                    CREATE PROCEDURE AddProductWithSequence
                        @ProductName NVARCHAR(100),
                        @Category NVARCHAR(50),
                        @Price DECIMAL(12,2),
                        @SupplierID INT,
                        @NewID INT OUTPUT
                    AS
                    BEGIN
                        SET NOCOUNT ON;

                        BEGIN TRY
                            INSERT INTO Product (ProductName, Category, Price, SupplierID)
                            VALUES (@ProductName, @Category, @Price, @SupplierID);

                            -- Отримуємо ID останнього вставленого запису
                            SET @NewID = SCOPE_IDENTITY();
                        END TRY
                        BEGIN CATCH
                            SET @NewID = NULL;
                        END CATCH
                    END;

-- Виклик

DECLARE @NewProductID INT;

EXEC AddProductWithSequence
     @ProductName = 'Test Keyboard',
     @Category = 'Test',
     @Price = 199.99,
     @SupplierID = 3,
     @NewID = @NewProductID OUTPUT;

SELECT @NewProductID AS InsertedID;







