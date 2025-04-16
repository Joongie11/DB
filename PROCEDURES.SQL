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
            EXEC GetAllProducts;
            EXEC GetOrdersByCustomer @CustomerID = 1;
            EXEC GetProductStats;



