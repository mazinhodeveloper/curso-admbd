Aula 20 
Professor: Celso 
Data: 30/07/2025 


Tabelas Temporárias no MySQL: Uso, Vantagens e Boas Práticas 

CREATE TEMPORARY TABLE temp_clientes (
id INT,
nome VARCHAR(100)
); 
 
INSERT INTO temp_clientes VALUES (1, 'João'), (2, 'Maria'), (3, 'Joaquin'); 
 
SELECT * FROM temp_clientes; 

INSERT INTO temp_clientes VALUES (4, 'Mariana'); 

SELECT * FROM temp_clientes; 

DROP TEMPORARY TABLE IF EXISTS temp_clientes; 



Conceitos Essenciais e Dicas Para Otimizar Seu Uso 




MySQL Temporary Table 
https://chatgpt.com/c/688a4d35-2840-8009-99f9-357ae0a88e6c 




MySQL Workbench 
USER: root 
PASS: senac 
HOST: localhost:3307 


pgAdmin 4 
PASS: senac 


https://www.mysql.com 
https://www.w3schools.com 
https://www.w3schools.com/sql 
https://www.w3schools.com/mysql 














