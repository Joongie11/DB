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






