CREATE TABLE Supplier (
                          SupplierID INT PRIMARY KEY IDENTITY(1,1),
                          SupplierName NVARCHAR(100) NOT NULL,
                          ContactNumber NVARCHAR(15) CHECK (LEN(ContactNumber) BETWEEN 7 AND 15),
                          Address NVARCHAR(255) NULL
);

CREATE TABLE Product (
                         ProductID INT PRIMARY KEY IDENTITY(1,1),
                         ProductName NVARCHAR(100) NOT NULL,
                         Category NVARCHAR(50) NOT NULL,
                         Price DECIMAL(12,2) CHECK (Price >= 0),
                         SupplierID INT NOT NULL,
                         FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE Customer (
                          CustomerID INT PRIMARY KEY IDENTITY(1,1),
                          CustomerName NVARCHAR(100) NOT NULL,
                          ContactNumber NVARCHAR(15) NULL,
                          Email NVARCHAR(100) UNIQUE NULL
);

CREATE TABLE [Order] (
                         OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE NOT NULL,
    OrderAmount DECIMAL(12,2) CHECK (OrderAmount > 0),
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    );

CREATE TABLE Employee (
                          EmployeeID INT PRIMARY KEY IDENTITY(1,1),
                          EmployeeName NVARCHAR(100) NOT NULL,
                          Position NVARCHAR(50) NOT NULL,
                          ContactNumber NVARCHAR(15) NULL
);