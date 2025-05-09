
-- 1. Обмеження домена: категорія клавіатур
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50) CHECK (Category IN ('механічні', 'мембранні', 'ігрові', 'офісні')),
    Price DECIMAL(10,2) CHECK (Price >= 0)
);

-- 2. Обмеження атрибута: унікальна пошта та обов’язкове ім’я клієнта
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Email NVARCHAR(100) UNIQUE,
    CustomerName NVARCHAR(100) NOT NULL
);

-- 3. Обмеження кортежу: якщо ціна > 0, то має бути наявність
CREATE TABLE ProductStock (
    ProductID INT PRIMARY KEY,
    Price DECIMAL(10,2),
    Stock INT,
    CHECK (Price = 0 OR Stock > 0)
);

-- 4. Обмеження відношення: замовлення має посилатися на клієнта
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    OrderAmount DECIMAL(10,2) CHECK (OrderAmount > 0),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 5. Обмеження NOT NULL та DEFAULT
ALTER TABLE Product ADD Stock INT DEFAULT 100 NOT NULL CHECK (Stock >= 0);

-- 6. FOREIGN KEY для Product - Supplier
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName NVARCHAR(100),
    ContactNumber NVARCHAR(15),
    Address NVARCHAR(255)
);

ALTER TABLE Product
ADD SupplierID INT,
FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID);

-- 7. CHECK: обмеження віку клієнта
ALTER TABLE Customer ADD Age INT CHECK (Age >= 18);

-- 8. Кортежне обмеження: одночасна перевірка двох значень
ALTER TABLE ProductStock
ADD CHECK (NOT (Price > 10000 AND Stock = 0));
