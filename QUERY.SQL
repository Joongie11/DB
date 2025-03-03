-- Вибрати всі механічні клавіатури, які коштують більше 100 доларів
SELECT * FROM Product
WHERE Category = 'Mechanical' AND Price > 100;

-- Вибрати всі клавіатури типу "Gaming"
SELECT * FROM Product
WHERE ProductName LIKE '%Gaming%';

-- Вибрати клавіатури з RGB підсвіткою
SELECT * FROM Product
WHERE ProductName LIKE '%RGB%';

-- Вибрати всі клавіатури в діапазоні цін від 50 до 150 доларів
SELECT * FROM Product
WHERE Price BETWEEN 50 AND 150;
