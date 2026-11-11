-- EXEMPLOS: ORDER BY, FUNCOES AGREGADAS, GROUP BY E HAVING
-- Compatível com SQLite / DB Browser for SQLite.
-- Abra um banco NOVO no DB Browser para este arquivo.
-- Execute o script inteiro em Execute SQL e clique em Write Changes.

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Estoque;
DROP TABLE IF EXISTS Produto;

CREATE TABLE Produto (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE Estoque (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_produto INTEGER NOT NULL,
    filial TEXT NOT NULL,
    quantidade INTEGER NOT NULL,
    preco REAL NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

INSERT INTO Produto (nome) VALUES
('Notebook'),
('Mouse'),
('Teclado'),
('Monitor'),
('Headset');

INSERT INTO Estoque (id_produto, filial, quantidade, preco) VALUES
(1, 'Centro', 40, 2500.00),
(1, 'Norte', 25, 2450.00),
(2, 'Centro', 120, 55.00),
(2, 'Sul', 90, 59.90),
(2, 'Norte', 70, 52.00),
(3, 'Centro', 60, 120.00),
(3, 'Sul', 45, 115.00),
(4, 'Norte', 18, 890.00),
(4, 'Sul', 22, 920.00),
(5, 'Centro', 35, 180.00);

-- ORDER BY: ordem crescente
SELECT nome
FROM Produto
ORDER BY nome ASC;

-- ORDER BY: ordem decrescente
SELECT nome
FROM Produto
ORDER BY nome DESC;

-- GROUP BY: agrupar pelo nome
SELECT p.nome
FROM Produto AS p
GROUP BY p.nome;

-- GROUP BY: agrupar pela chave e pelo nome
SELECT p.id, p.nome
FROM Produto AS p
GROUP BY p.id, p.nome;

-- COUNT: quantidade de filiais em que cada produto aparece
SELECT p.nome AS produto,
       COUNT(*) AS quantidade_de_filiais
FROM Produto AS p
JOIN Estoque AS e ON p.id = e.id_produto
GROUP BY p.id, p.nome;

-- SUM: quantidade total em estoque por produto
SELECT p.nome AS produto,
       SUM(e.quantidade) AS quantidade_total
FROM Produto AS p
JOIN Estoque AS e ON p.id = e.id_produto
GROUP BY p.id, p.nome;

-- MAX e MIN: maior e menor preço por produto
SELECT p.nome AS produto,
       MAX(e.preco) AS maior_preco,
       MIN(e.preco) AS menor_preco
FROM Produto AS p
JOIN Estoque AS e ON p.id = e.id_produto
GROUP BY p.id, p.nome;

-- AVG: preço médio por produto
SELECT p.nome AS produto,
       AVG(e.preco) AS preco_medio
FROM Produto AS p
JOIN Estoque AS e ON p.id = e.id_produto
GROUP BY p.id, p.nome;

-- GROUP BY com ORDER BY: maior média primeiro
SELECT p.nome AS produto,
       AVG(e.preco) AS preco_medio
FROM Produto AS p
JOIN Estoque AS e ON p.id = e.id_produto
GROUP BY p.id, p.nome
ORDER BY preco_medio DESC;

-- HAVING: produtos presentes em mais de uma filial
SELECT p.nome AS produto,
       COUNT(*) AS quantidade_de_filiais
FROM Produto AS p
JOIN Estoque AS e ON p.id = e.id_produto
GROUP BY p.id, p.nome
HAVING COUNT(*) > 1;

-- HAVING com AVG: média acima de R$ 20,00
SELECT p.nome AS produto,
       AVG(e.preco) AS preco_medio
FROM Produto AS p
JOIN Estoque AS e ON p.id = e.id_produto
GROUP BY p.id, p.nome
HAVING AVG(e.preco) > 20.00
ORDER BY preco_medio DESC;
