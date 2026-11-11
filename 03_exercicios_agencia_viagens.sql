-- EXERCICIOS 12 A 15: BANCO DE UMA AGENCIA DE VIAGENS
-- Compatível com SQLite / DB Browser for SQLite.

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Reserva;
DROP TABLE IF EXISTS Destino;
DROP TABLE IF EXISTS Cliente;

CREATE TABLE Cliente (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE Destino (
    id_destino INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_destino TEXT NOT NULL,
    pais TEXT NOT NULL
);

CREATE TABLE Reserva (
    id_reserva INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    id_destino INTEGER NOT NULL,
    data_viagem TEXT NOT NULL,
    valor REAL NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_destino) REFERENCES Destino(id_destino)
);

INSERT INTO Cliente (nome) VALUES
('Alice'), ('Bernardo'), ('Camila'), ('Daniel'), ('Elisa'), ('Felipe');

INSERT INTO Destino (nome_destino, pais) VALUES
('Lisboa', 'Portugal'),
('Paris', 'Franca'),
('Santiago', 'Chile'),
('Roma', 'Italia'),
('Buenos Aires', 'Argentina');

INSERT INTO Reserva (id_cliente, id_destino, data_viagem, valor) VALUES
(1, 1, '2026-12-10', 2500.00),
(2, 1, '2026-12-12', 2800.00),
(3, 1, '2027-01-05', 3100.00),
(4, 1, '2027-01-10', 2200.00),
(5, 1, '2027-02-01', 2600.00),
(6, 1, '2027-02-15', 2400.00),
(1, 2, '2027-03-01', 6200.00),
(2, 2, '2027-03-05', 5800.00),
(3, 3, '2027-04-10', 900.00),
(4, 4, '2027-05-12', 4200.00),
(5, 4, '2027-06-15', 4600.00),
(6, 5, '2027-07-20', 1800.00),
(1, 3, '2027-08-01', 1300.00);

-- 12) Destino com pelo menos cinco reservas.
SELECT d.nome_destino AS destino,
       COUNT(r.id_reserva) AS quantidade_reservas
FROM Destino AS d
JOIN Reserva AS r ON d.id_destino = r.id_destino
GROUP BY d.id_destino, d.nome_destino
HAVING COUNT(r.id_reserva) >= 5;

-- 13) Soma dos valores por destino; total superior a R$ 5.000,00.
SELECT d.nome_destino AS destino,
       SUM(r.valor) AS valor_total
FROM Destino AS d
JOIN Reserva AS r ON d.id_destino = r.id_destino
GROUP BY d.id_destino, d.nome_destino
HAVING SUM(r.valor) > 5000.00;

-- 14) Média dos valores das reservas por país; média acima de R$ 1.000,00.
SELECT d.pais,
       AVG(r.valor) AS valor_medio
FROM Destino AS d
JOIN Reserva AS r ON d.id_destino = r.id_destino
GROUP BY d.pais
HAVING AVG(r.valor) > 1000.00;

-- 15) Cliente e maior reserva; somente maior que R$ 2.000,00.
SELECT c.nome AS cliente,
       MAX(r.valor) AS reserva_mais_cara
FROM Cliente AS c
JOIN Reserva AS r ON c.id_cliente = r.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING MAX(r.valor) > 2000.00;
