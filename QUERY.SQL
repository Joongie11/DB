-- Вибрати всі механічні клавіатури
SELECT * FROM Product
WHERE Category = 'Mechanical';

-- Вибрати всі клавіатури в діапазоні цін від 50 до 150 доларів
SELECT * FROM Product
WHERE Price BETWEEN 50 AND 150;

-- Вибрати всі клавіатури, у яких у назві є слово "Gaming"
SELECT * FROM Product
WHERE ProductName LIKE '%Gaming%';
