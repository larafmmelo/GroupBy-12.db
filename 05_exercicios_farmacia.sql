-- EXERCICIOS 19 E 20: BANCO DE UMA FARMACIA
-- Compatível com SQLite / DB Browser for SQLite.

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Compra;
DROP TABLE IF EXISTS Medicamento;
DROP TABLE IF EXISTS Fornecedor;

CREATE TABLE Medicamento (
    id_medicamento INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    preco REAL NOT NULL
);

CREATE TABLE Fornecedor (
    id_fornecedor INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    cidade TEXT NOT NULL
);

CREATE TABLE Compra (
    id_compra INTEGER PRIMARY KEY AUTOINCREMENT,
    id_medicamento INTEGER NOT NULL,
    id_fornecedor INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    data_compra TEXT NOT NULL,
    FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

INSERT INTO Medicamento (nome, preco) VALUES
('Dipirona', 8.50),
('Paracetamol', 12.00),
('Vitamina C', 19.90),
('Soro fisiologico', 6.00),
('Curativo', 5.50);

INSERT INTO Fornecedor (nome, cidade) VALUES
('Distribuidora Alfa', 'Belo Horizonte'),
('Saude Mais', 'Sao Paulo'),
('Med Center', 'Curitiba');

-- 12 compras do fornecedor 1, 11 do fornecedor 2 e 5 do fornecedor 3.
WITH RECURSIVE numeros(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM numeros WHERE n < 28
)
INSERT INTO Compra (id_medicamento, id_fornecedor, quantidade, data_compra)
SELECT ((n - 1) % 5) + 1,
       CASE WHEN n <= 12 THEN 1
            WHEN n <= 23 THEN 2
            ELSE 3 END,
       CASE WHEN n % 2 = 0 THEN 15 ELSE 10 END,
       date('2026-10-01', '+' || n || ' day')
FROM numeros;

-- 19) Compras por fornecedor; somente mais de 10 compras.
SELECT f.nome AS fornecedor,
       COUNT(c.id_compra) AS quantidade_compras
FROM Fornecedor AS f
JOIN Compra AS c ON f.id_fornecedor = c.id_fornecedor
GROUP BY f.id_fornecedor, f.nome
HAVING COUNT(c.id_compra) > 10;

-- 20) Quantidade total comprada por medicamento; acima de 100 unidades.
SELECT m.nome AS medicamento,
       SUM(c.quantidade) AS quantidade_total
FROM Medicamento AS m
JOIN Compra AS c ON m.id_medicamento = c.id_medicamento
GROUP BY m.id_medicamento, m.nome
HAVING SUM(c.quantidade) > 100;
