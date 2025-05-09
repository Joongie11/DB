CREATE TABLE Supplier (
                          SupplierID INT PRIMARY KEY IDENTITY(1,1),
                          SupplierName NVARCHAR(100) NOT NULL,
                          ContactNumber NVARCHAR(15) CHECK (LEN(ContactNumber) BETWEEN 7 AND 15),
                          Address NVARCHAR(255)
);

CREATE TABLE Product (
                         ProductID INT PRIMARY KEY IDENTITY(1,1),
                         ProductName NVARCHAR(100) NOT NULL,
                         Category NVARCHAR(50) NOT NULL,
                         Price DECIMAL(12,2) CHECK (Price >= 0),
                         SupplierID INT NOT NULL,
                         FOREIGN KEY (SupplierID)
                             REFERENCES Supplier(SupplierID)
                             ON DELETE CASCADE
                             ON UPDATE CASCADE
);

CREATE TABLE Customer (
                          CustomerID INT PRIMARY KEY IDENTITY(1,1),
                          CustomerName NVARCHAR(100) NOT NULL,
                          ContactNumber NVARCHAR(15),
                          Email NVARCHAR(100) UNIQUE
);

CREATE TABLE Orders (
                        OrderID INT PRIMARY KEY IDENTITY(1,1),
                        OrderDate DATE NOT NULL,
                        OrderAmount DECIMAL(12,2) CHECK (OrderAmount > 0),
                        CustomerID INT NOT NULL,
                        FOREIGN KEY (CustomerID)
                            REFERENCES Customer(CustomerID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE
);

ALTER TABLE Product
    ADD Stock INT DEFAULT 100 CHECK (Stock >= 0);

CREATE TABLE Employee (
                          EmployeeID INT PRIMARY KEY IDENTITY(1,1),
                          EmployeeName NVARCHAR(100) NOT NULL,
                          Position NVARCHAR(50) NOT NULL,
                          ContactNumber NVARCHAR(15) NULL
);

CREATE TABLE TestData (
                          ID INT NOT NULL,
                          Name NVARCHAR(100),
                          Value DECIMAL(10,2)
);

CREATE TABLE ProductAudit (
                              AuditID INT PRIMARY KEY IDENTITY(1,1),
                              ProductID INT,
                              ActionType NVARCHAR(10),
                              ActionDate DATETIME DEFAULT GETDATE()
);
