-- Додавання постачальників
INSERT INTO Supplier (SupplierName, ContactNumber) VALUES
                                                       ('Supplier A', '1234567890'),
                                                       ('Supplier B', '9876543210');

-- Додавання продуктів
INSERT INTO Product (ProductName, Category, Price, SupplierID) VALUES
                                                                   ('Laptop', 'Electronics', 1500.00, 1),
                                                                   ('Phone', 'Electronics', 800.00, 2);

-- Додавання клієнтів
INSERT INTO Customer (CustomerName, ContactNumber, Email) VALUES
                                                              ('Sofi Sha', '1234567890', 'sofi.sha@example.com'),
                                                              ('Sarah Black', '9876543210', 'sarah.black@example.com');

-- Додавання замовлень
INSERT INTO [Order] (OrderDate, OrderAmount, CustomerID) VALUES
                                                             ('2024-11-01', 2300.00, 1),
                                                             ('2024-11-05', 800.00, 2);

-- Додавання співробітників
INSERT INTO Employee (EmployeeName, Position, ContactNumber) VALUES
                                                                 ('Alice Brown', 'Manager', '1231231234'),
                                                                 ('Greg Green', 'Sales', '9879879876');
