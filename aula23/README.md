Aula 23 
Professor: Celso 
Data: 06/08/2025 


MySQL Workbench 
USER: root 
PASS: senac 
HOST: localhost:3307 



USE financeiro; 

# CHECK 
CREATE TABLE empregados2 (
	id INT PRIMARY KEY,
	nome VARCHAR(100),
	salario DECIMAL(10,2) CHECK (salario > 1500)
); 

INSERT INTO empregados2 (id,nome,salario) VALUES (1,'João da Silva',2000); 

INSERT INTO empregados2 (id,nome,salario) VALUES (2,'Maria de Jesus',1200); 
# Mensagem do MySQL: Documentação 
#4025 - CONSTRAINT `empregados2.salario` failed for `financeiro`.`empregados2` 

INSERT INTO empregados2 (id,nome,salario) VALUES (2,'Maria de Jesus',1501);  

UPDATE empregados2 SET salario=800 WHERE id=2; 
# Mensagem do MySQL: Documentação 
#4025 - CONSTRAINT `empregados2.salario` failed for `financeiro`.`empregados2` 

UPDATE empregados2 SET salario=1510 WHERE id=2; 


# UNIQUE 
CREATE TABLE clientes (
	id INT,
	name VARCHAR(100),
	cpf VARCHAR(20) UNIQUE
); 

INSERT INTO clientes (id,nome,cpf) VALUES (1,'José Maria','11.111.111/0001-11'); 

INSERT INTO clientes (id,nome,cpf) VALUES (2,'José Maria','11.111.111/0001-11'); 
# Mensagem do MySQL: Documentação 
#1062 - Entrada '11.111.111/0001-11' duplicada para a chave 'cpf'





https://blog.devart.com 
https://blog.devart.com/mysql-data-types.html 
https://dev.mysql.com/doc/en/data-types.html 
https://dev.mysql.com/doc/refman/8.4/en/create-table.html 
https://www.prisma.io/dataguide/mysql/introduction-to-data-types 
https://dev.mysql.com/doc/refman/8.4/en/enum.html 
https://www.prisma.io/dataguide/mysql/introduction-to-data-types 
https://dev.to/harshm03/guide-to-mysql-constraints-4j5i 
https://hasura.io/learn/database/mysql/core-concepts/4-mysql-constraints 





https://mariadb.org 
https://www.mysql.com 
https://www.w3schools.com 
https://www.w3schools.com/sql 
https://www.w3schools.com/mysql 














