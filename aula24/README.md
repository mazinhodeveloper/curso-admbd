Aula 24 
Professor: Celso 
Data: 08/08/2025 


MySQL Workbench 
USER: root 
PASS: senac 
HOST: localhost:3307 



USE financeiro; 


# LIKE 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%mata%'; 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE 'mata%'; 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%mata'; 

SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%almeida%'; 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE 'almeida%'; 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%almeida'; 

SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%pires%'; 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE 'pires%'; 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%pires'; 

# Final 'ME' 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%ME'; 

SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%Conceição%'; 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%conceição%'; 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%CONCEIÇÃO%'; 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%conceicao%'; 
SELECT id_fornecedor,nome_fornecedor FROM fornecedores WHERE nome_fornecedor LIKE '%conceiCao%'; 


# UNION 
SELECT nome_fornecedor AS nome FROM fornecedores; 

# INTERSECT 
CREATE TABLE t1 (
id INT PRIMARY KEY
);

CREATE TABLE t2 LIKE t1;

INSERT INTO t1(id) VALUES (1), (2), (3);
INSERT INTO t2(id) VALUES (2), (3), (4);

SELECT id FROM t1
INTERSECT
SELECT id FROM t2;


https://dev.mysql.com/doc/refman/8.4/en/intersect.html
https://dev.mysql.com/doc/refman/9.4/en/intersect.html 
https://mariadb.com/docs/server/reference/sql-statements/data-manipulation/selecting-data/joins-subqueries/intersect


# HAVING 
https://mariadb.com/docs/
https://mariadb.com/docs/columnstore/reference/data-manipulation-statements/columnstore-select 








https://learnsql.com 














https://mariadb.org 
https://www.mysql.com 
https://www.w3schools.com 
https://www.w3schools.com/sql 
https://www.w3schools.com/mysql 














