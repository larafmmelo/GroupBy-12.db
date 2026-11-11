-- EXERCICIOS 16 A 18: BANCO DE UMA CLINICA MEDICA
-- Compatível com SQLite / DB Browser for SQLite.

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Consulta;
DROP TABLE IF EXISTS Medico;
DROP TABLE IF EXISTS Paciente;

CREATE TABLE Paciente (
    id_paciente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE Medico (
    id_medico INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    especialidade TEXT NOT NULL
);

CREATE TABLE Consulta (
    id_consulta INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente INTEGER NOT NULL,
    id_medico INTEGER NOT NULL,
    data_consulta TEXT NOT NULL,
    valor REAL NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico)
);

INSERT INTO Paciente (nome) VALUES
('Marina'), ('Joao'), ('Beatriz'), ('Rafael'), ('Sofia'), ('Lucas');

INSERT INTO Medico (nome, especialidade) VALUES
('Dra. Paula', 'Cardiologia'),
('Dr. Marcos', 'Dermatologia'),
('Dra. Renata', 'Pediatria'),
('Dr. Felipe', 'Cardiologia');

-- Dados de consulta suficientes para testar as contagens e agregações.
WITH RECURSIVE numeros(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM numeros WHERE n < 25
)
INSERT INTO Consulta (id_paciente, id_medico, data_consulta, valor)
SELECT ((n - 1) % 6) + 1,
       CASE WHEN n <= 22 THEN 1
            WHEN n <= 25 THEN 2
            ELSE 3 END,
       date('2026-10-01', '+' || n || ' day'),
       CASE WHEN n % 3 = 0 THEN 180.00 ELSE 160.00 END
FROM numeros;

-- Consultas adicionais para os demais médicos e especialidades.
INSERT INTO Consulta (id_paciente, id_medico, data_consulta, valor) VALUES
(1, 2, '2026-11-01', 120.00),
(2, 2, '2026-11-02', 140.00),
(3, 3, '2026-11-03', 200.00),
(4, 3, '2026-11-04', 190.00),
(5, 4, '2026-11-05', 250.00),
(6, 4, '2026-11-06', 230.00);

-- 16) Consultas por médico; somente mais de 20.
SELECT m.nome AS medico,
       COUNT(c.id_consulta) AS quantidade_consultas
FROM Medico AS m
JOIN Consulta AS c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nome
HAVING COUNT(c.id_consulta) > 20;

-- 17) Média do valor das consultas por médico; acima de R$ 150,00.
SELECT m.nome AS medico,
       AVG(c.valor) AS valor_medio
FROM Medico AS m
JOIN Consulta AS c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nome
HAVING AVG(c.valor) > 150.00;

-- 18) Arrecadação por especialidade; acima de R$ 10.000,00.
SELECT m.especialidade,
       SUM(c.valor) AS arrecadacao_total
FROM Medico AS m
JOIN Consulta AS c ON m.id_medico = c.id_medico
GROUP BY m.especialidade
HAVING SUM(c.valor) > 10000.00;
