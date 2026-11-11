# SQL — GROUP BY e HAVING | DB Browser for SQLite

Este pacote contém seis scripts SQL independentes, adaptados para **SQLite** e prontos para abrir no **DB Browser for SQLite**.

## Arquivos

| Arquivo | Conteúdo |
|---|---|
| `00_exemplos_order_group_having.sql` | Exemplos do material: ORDER BY, COUNT, SUM, MAX, MIN, AVG, GROUP BY e HAVING |
| `01_exercicios_empresa.sql` | Exercícios 1 a 6 — empresa |
| `02_exercicios_padaria.sql` | Exercícios 7 a 11 — padaria |
| `03_exercicios_agencia_viagens.sql` | Exercícios 12 a 15 — agência de viagens |
| `04_exercicios_clinica.sql` | Exercícios 16 a 18 — clínica médica |
| `05_exercicios_farmacia.sql` | Exercícios 19 e 20 — farmácia |

Cada arquivo cria suas próprias tabelas e insere dados de teste. Os arquivos são separados para evitar conflito entre bancos e tabelas.

## Como executar no DB Browser for SQLite

Faça este procedimento **para cada arquivo**:

1. Abra o DB Browser for SQLite.
2. Clique em **New Database**.
3. Salve um banco com um nome correspondente, por exemplo `exemplos.db` ou `empresa.db`.
4. Abra a aba **Execute SQL**.
5. Abra o arquivo `.sql` correspondente (ícone de pasta) ou cole o conteúdo no editor.
6. Clique em **Execute all** (ícone de execução).
7. Confira os resultados na área de resultados.
8. Clique em **Write Changes** para salvar as alterações no arquivo `.db`.

Repita criando um banco separado para cada script. Não execute todos os arquivos no mesmo banco.

## Observações importantes sobre SQLite

- SQLite não usa `CREATE DATABASE` nem `USE`. O próprio arquivo `.db` representa o banco.
- `INTEGER PRIMARY KEY AUTOINCREMENT` é a forma usada aqui para gerar IDs automaticamente.
- `TEXT` substitui `VARCHAR` nos exemplos deste pacote.
- `REAL` é usado para valores com casas decimais, como preços.
- `PRAGMA foreign_keys = ON` ativa a validação das chaves estrangeiras durante a conexão.
- Os comandos `DROP TABLE IF EXISTS` reiniciam as tabelas do script. Por isso, execute cada arquivo em um banco novo/separado para não apagar tabelas de outros trabalhos.

## Como enviar ao GitHub

1. Crie ou abra o repositório da atividade.
2. Clique em **Add file** → **Upload files**.
3. Envie os seis arquivos `.sql` e este `README.md` (ou envie a pasta descompactada).
4. Clique em **Commit changes**.

## Nota sobre os dados

Os INSERTs são dados fictícios de teste, criados para que as consultas retornem resultados e seja possível conferir COUNT, SUM, AVG, MAX, MIN e HAVING.
