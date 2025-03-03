-- Вибрати всі механічні клавіатури
SELECT * FROM Product
WHERE Category = 'Mechanical';

-- Вибрати всі клавіатури типу "Gaming"
SELECT * FROM Product
WHERE ProductName LIKE '%Gaming%';

-- Вибрати клавіатури з RGB підсвіткою
SELECT * FROM Product
WHERE ProductName LIKE '%RGB%';

-- Вибрати всі клавіатури в діапазоні цін від 50 до 150 доларів
SELECT * FROM Product
WHERE Price BETWEEN 50 AND 150;

-- Вибрати gaming клавіатури, які мають RGB підсвітку та коштують більше 100 доларів
SELECT * FROM Product
WHERE Category = 'Gaming' AND ProductName LIKE '%RGB%' AND Price > 100;

-- Вибрати всі клавіатури, у яких у назві є слово "Gaming"
SELECT * FROM Product
WHERE ProductName LIKE '%Gaming%';

