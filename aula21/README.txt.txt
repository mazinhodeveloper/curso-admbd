Aula 21 
Professor: Celso 
Data: 01/08/2025 


MySQL Workbench 
USER: root 
PASS: senac 
HOST: localhost:3307 



CREATE DATABASE financeiro2; 

USE financeiro2; 
 
Importar documento: teste.sql 



USE financeiro2; 

SELECT * FROM fornecedores; 
SELECT * FROM pagamentos; 


SELECT * FROM pagamentos AS p 
INNER JOIN centro_custos AS c 
ON p.id_centro_custos=c.id_centro_custos 
INNER JOIN fornecedores AS f 
ON p.id_fornecedor=f.id_fornecedor 
INNER JOIN tipo_pagamentos AS t 
ON p.id_tipo_pagto=t.id_tipo_pagto; 


SELECT descricao_centro_custos, SUM(valor) AS total FROM pagamentos AS p 
INNER JOIN centro_custos AS c 
ON p.id_centro_custos=c.id_centro_custos 
INNER JOIN fornecedores AS f 
ON p.id_fornecedor=f.id_fornecedor 
INNER JOIN tipo_pagamentos AS t 
ON p.id_tipo_pagto=t.id_tipo_pagto 
GROUP BY descricao_centro_custos; 

SELECT descricao_centro_custos, ROUND(SUM(valor),2) AS total FROM pagamentos AS p 
INNER JOIN centro_custos AS c 
ON p.id_centro_custos=c.id_centro_custos 
INNER JOIN fornecedores AS f 
ON p.id_fornecedor=f.id_fornecedor 
INNER JOIN tipo_pagamentos AS t 
ON p.id_tipo_pagto=t.id_tipo_pagto 
GROUP BY descricao_centro_custos; 


CREATE VIEW custos AS SELECT
    descricao_centro_custos,
    ROUND(SUM(valor),
    2) AS total
FROM
    pagamentos AS p
INNER JOIN centro_custos AS c
ON
    p.id_centro_custos = c.id_centro_custos
INNER JOIN fornecedores AS f
ON
    p.id_fornecedor = f.id_fornecedor
INNER JOIN tipo_pagamentos AS t
ON
    p.id_tipo_pagto = t.id_tipo_pagto
GROUP BY
    descricao_centro_custos; 


SELECT * FROM custos; 
SELECT * FROM custos HAVING total > 1000; 

    
SELECT
    DISTINCT(descricao_centro_custos) 
FROM
    pagamentos AS p
INNER JOIN centro_custos AS c
ON
    p.id_centro_custos = c.id_centro_custos
INNER JOIN fornecedores AS f
ON
    p.id_fornecedor = f.id_fornecedor
INNER JOIN tipo_pagamentos AS t
ON
    p.id_tipo_pagto = t.id_tipo_pagto;


SELECT
    *
FROM
    pagamentos AS p
INNER JOIN centro_custos AS c
ON
    p.id_centro_custos = c.id_centro_custos
INNER JOIN fornecedores AS f
ON
    p.id_fornecedor = f.id_fornecedor
INNER JOIN tipo_pagamentos AS t
ON
    p.id_tipo_pagto = t.id_tipo_pagto
WHERE
    data_vcto BETWEEN '2025-05-01' AND '2025-05-30';




select * from pagamentos as p inner join centro_custos as c on p.id_centro_custos=c.id_centro_custos inner join fornecedores as f on p.id_fornecedor=f.id_fornecedor inner join tipo_pagamentos as t on p.id_tipo_pagto=t.id_tipo_pagto where id_pagamento in(102,103,104,105);



















https://www.mysql.com 
https://www.w3schools.com 
https://www.w3schools.com/sql 
https://www.w3schools.com/mysql 














