-- EXERCICIOS 7 A 11: BANCO DE UMA PADARIA
-- Compatível com SQLite / DB Browser for SQLite.

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ItemPedido;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS Cliente;

CREATE TABLE Cliente (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE Produto (
    id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    preco REAL NOT NULL
);

CREATE TABLE Pedido (
    id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    data_pedido TEXT NOT NULL,
    total REAL NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE ItemPedido (
    id_pedido INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

INSERT INTO Cliente (nome) VALUES
('Ana Souza'), ('Bruno Lima'), ('Carla Mendes'), ('Diego Alves'), ('Eva Rocha');

INSERT INTO Produto (nome, preco) VALUES
('Pao de queijo', 4.00), ('Bolo de cenoura', 35.00),
('Cafe', 6.00), ('Sanduiche', 18.00), ('Torta', 50.00);

INSERT INTO Pedido (id_cliente, data_pedido, total) VALUES
(1, '2026-10-01', 120.00),
(1, '2026-10-02', 220.00),
(1, '2026-10-03', 190.00),
(2, '2026-10-01', 75.00),
(2, '2026-10-02', 95.00),
(3, '2026-10-03', 600.00),
(3, '2026-10-03', 150.00),
(4, '2026-10-04', 85.00),
(5, '2026-10-04', 45.00),
(1, '2026-10-04', 90.00),
(2, '2026-10-04', 110.00);

INSERT INTO ItemPedido (id_pedido, id_produto, quantidade) VALUES
(1, 1, 10), (1, 3, 5),
(2, 2, 2), (2, 3, 10),
(3, 4, 5), (3, 1, 8),
(4, 1, 6), (4, 3, 3),
(5, 2, 1), (5, 4, 2),
(6, 5, 4), (6, 2, 2),
(7, 1, 12), (7, 3, 6),
(8, 4, 3), (8, 1, 5),
(9, 3, 4), (9, 1, 3),
(10, 2, 2), (10, 4, 2),
(11, 1, 15), (11, 3, 8);

-- 7) Cliente e quantidade de pedidos (somente quem fez pedido).
SELECT c.nome AS cliente,
       COUNT(p.id_pedido) AS quantidade_pedidos
FROM Cliente AS c
JOIN Pedido AS p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome;

-- 8) Soma do valor dos pedidos por cliente; total acima de R$ 500,00.
SELECT c.nome AS cliente,
       SUM(p.total) AS total_pedidos
FROM Cliente AS c
JOIN Pedido AS p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING SUM(p.total) > 500.00;

-- 9) Unidades vendidas por produto; mais de 30 unidades.
SELECT pr.nome AS produto,
       SUM(ip.quantidade) AS unidades_vendidas
FROM Produto AS pr
JOIN ItemPedido AS ip ON pr.id_produto = ip.id_produto
GROUP BY pr.id_produto, pr.nome
HAVING SUM(ip.quantidade) > 30;

-- 10) Média do valor dos pedidos por cliente; média acima de R$ 80,00.
SELECT c.nome AS cliente,
       AVG(p.total) AS media_pedidos
FROM Cliente AS c
JOIN Pedido AS p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING AVG(p.total) > 80.00;

-- 11) Quantidade de pedidos por data; somente datas com mais de 10.
SELECT data_pedido,
       COUNT(*) AS quantidade_pedidos
FROM Pedido
GROUP BY data_pedido
HAVING COUNT(*) > 10;
