Aula 18 
Professor: Celso  
Data: 25/07/2025 


MySQL Workbench 
USER: root 
PASS: senac 
HOST: localhost:3307 


pgAdmin 4 
PASS: senac 




-- Table: clientes.clientes

-- DROP TABLE IF EXISTS clientes.clientes;

CREATE TABLE IF NOT EXISTS clientes.clientes
(
    id_cliente integer NOT NULL,
    nome_cliente character(70) COLLATE pg_catalog."default",
    cpf_cnpj character(20) COLLATE pg_catalog."default",
    celular character(20) COLLATE pg_catalog."default",
    email character(100) COLLATE pg_catalog."default",
    cep character(9) COLLATE pg_catalog."default",
    logradouro character(60) COLLATE pg_catalog."default",
    numero character(15) COLLATE pg_catalog."default",
    complemento character(15) COLLATE pg_catalog."default",
    bairro character(30) COLLATE pg_catalog."default",
    cidade character(40) COLLATE pg_catalog."default",
    estado character(2) COLLATE pg_catalog."default",
    CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS clientes.clientes
    OWNER to postgres;


-- SELECT 
SELECT * FROM clientes.clientes 
ORDER BY id_cliente ASC 






https://www.postgresql.org 
https://www.postgresql.org/docs 
https://www.w3schools.com/postgresql 

https://www.postman.com 

https://www.mysql.com 
https://www.w3schools.com 
https://www.w3schools.com/sql 
https://www.w3schools.com/mysql 














