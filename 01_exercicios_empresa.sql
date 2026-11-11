-- EXERCICIOS 1 A 6: BANCO EMPRESA
-- Compatível com SQLite / DB Browser for SQLite.
-- Execute em um banco NOVO/separado para não conflitar com outras aulas.

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Estoque;
DROP TABLE IF EXISTS Filial;
DROP TABLE IF EXISTS Produto;

CREATE TABLE Produto (
    id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE Filial (
    id_filial INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE Estoque (
    id_filial INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    preco REAL NOT NULL,
    PRIMARY KEY (id_filial, id_produto),
    FOREIGN KEY (id_filial) REFERENCES Filial(id_filial),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

INSERT INTO Produto (nome) VALUES
('Notebook'), ('Mouse'), ('Teclado'), ('Monitor'), ('Impressora');

INSERT INTO Filial (nome) VALUES
('Matriz'), ('Filial Norte'), ('Filial Sul'), ('Filial Leste');

INSERT INTO Estoque (id_filial, id_produto, quantidade, preco) VALUES
(1, 1, 80, 2500.00),
(2, 1, 50, 2480.00),
(3, 1, 35, 2520.00),
(1, 2, 150, 55.00),
(2, 2, 100, 58.00),
(3, 2, 90, 52.00),
(4, 2, 80, 57.00),
(1, 3, 70, 120.00),
(2, 3, 55, 115.00),
(1, 4, 20, 900.00),
(3, 4, 25, 930.00),
(2, 5, 15, 450.00);

-- 1) Produto e quantidade de filiais em que está disponível.
SELECT p.nome AS produto,
       COUNT(DISTINCT e.id_filial) AS quantidade_de_filiais
FROM Produto AS p
JOIN Estoque AS e ON p.id_produto = e.id_produto
GROUP BY p.id_produto, p.nome;

-- 2) Quantidade total em estoque; somente acima de 100 unidades.
SELECT p.nome AS produto,
       SUM(e.quantidade) AS quantidade_total
FROM Produto AS p
JOIN Estoque AS e ON p.id_produto = e.id_produto
GROUP BY p.id_produto, p.nome
HAVING SUM(e.quantidade) > 100;

-- 3) Preço médio por produto, do maior para o menor.
SELECT p.nome AS produto,
       AVG(e.preco) AS preco_medio
FROM Produto AS p
JOIN Estoque AS e ON p.id_produto = e.id_produto
GROUP BY p.id_produto, p.nome
ORDER BY preco_medio DESC;

-- 4) Maior e menor preço; diferença acima de R$ 20,00.
SELECT p.nome AS produto,
       MAX(e.preco) AS maior_preco,
       MIN(e.preco) AS menor_preco,
       MAX(e.preco) - MIN(e.preco) AS diferenca
FROM Produto AS p
JOIN Estoque AS e ON p.id_produto = e.id_produto
GROUP BY p.id_produto, p.nome
HAVING MAX(e.preco) - MIN(e.preco) > 20.00;

-- 5) Total de unidades em cada filial; somente acima de 500.
SELECT f.nome AS filial,
       SUM(e.quantidade) AS total_unidades
FROM Filial AS f
JOIN Estoque AS e ON f.id_filial = e.id_filial
GROUP BY f.id_filial, f.nome
HAVING SUM(e.quantidade) > 500;

-- 6) Produtos disponíveis em pelo menos três filiais.
SELECT p.nome AS produto,
       COUNT(DISTINCT e.id_filial) AS quantidade_de_filiais
FROM Produto AS p
JOIN Estoque AS e ON p.id_produto = e.id_produto
GROUP BY p.id_produto, p.nome
HAVING COUNT(DISTINCT e.id_filial) >= 3;
