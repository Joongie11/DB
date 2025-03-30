CREATE FUNCTION dbo.GetSupplierContact(@supplierId INT)
    RETURNS NVARCHAR(15)
AS
BEGIN
    DECLARE @phone NVARCHAR(15)

    SELECT @phone = ContactNumber
    FROM Supplier
    WHERE SupplierID = @supplierId

    RETURN ISNULL(@phone, 'Невідомо')
END

CREATE FUNCTION dbo.GetProductPriceWithVAT(@productId INT)
    RETURNS DECIMAL(12,2)
AS
BEGIN
    DECLARE @price DECIMAL(12,2)

    SELECT @price = Price * 1.20
    FROM Product
    WHERE ProductID = @productId

    RETURN ISNULL(@price, 0)
END

CREATE FUNCTION dbo.GetCustomerEmailDomain(@customerId INT)
    RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @domain NVARCHAR(100)
    DECLARE @email NVARCHAR(100)

    SELECT @email = Email
    FROM Customer
    WHERE CustomerID = @customerId

    SET @domain = RIGHT(@email, CHARINDEX('@', REVERSE(@email)) - 1)

    RETURN ISNULL(@domain, 'Невідомо')
END

SELECT dbo.GetSupplierContact(1) AS SupplierPhone;
SELECT dbo.GetProductPriceWithVAT(3) AS PriceWithVAT;
SELECT dbo.GetCustomerEmailDomain(2) AS EmailDomain;

CREATE FUNCTION dbo.OrdersByCustomer(@customerId INT)
    RETURNS TABLE
        AS
        RETURN (
        SELECT OrderID, OrderDate, OrderAmount
        FROM Orders
        WHERE CustomerID = @customerId
        );

CREATE FUNCTION dbo.ProductsCheaperThan(@maxPrice DECIMAL(10,2))
    RETURNS TABLE
        AS
        RETURN (
        SELECT ProductID, ProductName, Price
        FROM Product
        WHERE Price < @maxPrice
        );

CREATE FUNCTION dbo.CustomersWithOrdersAbove(@minAmount DECIMAL(10,2))
    RETURNS TABLE
        AS
        RETURN (
        SELECT DISTINCT
            c.CustomerID,
            c.CustomerName,
            o.OrderAmount
        FROM Customer c
                 JOIN Orders o ON c.CustomerID = o.CustomerID
        WHERE o.OrderAmount > @minAmount
        );


SELECT * FROM dbo.OrdersByCustomer(1);
SELECT * FROM dbo.ProductsCheaperThan(1000);
SELECT * FROM dbo.CustomersWithOrdersAbove(500);

