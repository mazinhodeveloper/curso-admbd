Aula 30 
Professor: Celso 
Data: 22/08/2025 


# Diferenças: 
 - MySQL 
 - PostgreSQL 

# MySQL 
https://www.mysql.com 
https://dev.mysql.com/doc 
https://dev.mysql.com/doc/workbench/en/ 

# PostgreSQL 
https://www.postgresql.org 
https://www.postgresql.org/docs 
https://www.pgadmin.org 

-- SCHEMA: loja_schema

-- DROP SCHEMA IF EXISTS loja_schema ;

CREATE SCHEMA IF NOT EXISTS loja_schema
    AUTHORIZATION postgres;

-- Table: loja_schema.clientes

-- DROP TABLE IF EXISTS loja_schema.clientes;

CREATE TABLE IF NOT EXISTS loja_schema.clientes
(
    id_cliente integer NOT NULL,
    nome_cliente character(60) COLLATE pg_catalog."default",
    cnpj character(20) COLLATE pg_catalog."default",
    email character(50) COLLATE pg_catalog."default",
    celular character(20) COLLATE pg_catalog."default",
    CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS loja_schema.clientes
    OWNER to postgres;

INSERT INTO loja_schema.clientes(
	id_cliente, nome_cliente, cnpj, email, celular)
	VALUES (?, ?, ?, ?, ?);

INSERT INTO loja_schema.clientes(
	id_cliente, nome_cliente, cnpj, email, celular)
	VALUES (1, 'Kalunga', '11.111.111/0001-11', 'kalunga@kalunga.com.br', '11 9999-9999');

SELECT id_cliente, nome_cliente, cnpj, email, celular
	FROM loja_schema.clientes;

SELECT * FROM loja_schema.clientes; 

SELECT id_cliente, nome_cliente, cnpj, email, celular
	FROM loja_schema.clientes WHERE id_cliente=1;

-- SELECT * FROM loja_schema.clientes; 

-- SELECT id_cliente, nome_cliente, cnpj, email, celular
--	FROM loja_schema.clientes WHERE id_cliente=1;


-- UPDATE loja_schema.clientes SET celular='11 8888-8888' WHERE id_cliente=1;
UPDATE loja_schema.clientes SET celular='11 77777-8888' WHERE id_cliente=1;

SELECT * FROM loja_schema.clientes; 


# PostgreSQL / Update Table 
-- Table: loja_schema.clientes

-- DROP TABLE IF EXISTS loja_schema.clientes;

CREATE TABLE IF NOT EXISTS loja_schema.clientes
(
    id_cliente integer NOT NULL,
    nome_cliente character(60) COLLATE pg_catalog."default",
    cnpj character(20) COLLATE pg_catalog."default",
    email character(50) COLLATE pg_catalog."default",
    celular character(20) COLLATE pg_catalog."default",
    endereco character(80) COLLATE pg_catalog."default",
    CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS loja_schema.clientes
    OWNER to postgres; 

# DROP Table 
DROP TABLE IF EXISTS loja_schema.clientes;


# New / Clientes, Produtos, Pedidos, Itens_Pedidos 
-- Tabela de clientes
CREATE TABLE loja_schemas.clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    data_nascimento DATE
);
 
-- Tabela de produtos
CREATE TABLE loja_schemas.produtos (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco NUMERIC(10,2) NOT NULL CHECK (preco > 0),
    estoque INT DEFAULT 0 CHECK (estoque >= 0)
);
 
-- Tabela de pedidos
CREATE TABLE loja_schemas.pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES loja_schemas.clientes(id_cliente),
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
-- Tabela de itens do pedido
CREATE TABLE loja_schemas.itens_pedido (
    id_item SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES loja_schemas.pedidos(id_pedido),
    id_produto INT REFERENCES loja_schemas.produtos(id_produto),
    quantidade INT CHECK (quantidade > 0),
    preco_unitario NUMERIC(10,2)
);

# View / Com Erro 
CREATE VIEW loja_schemas.view_pedidos_totais AS
SELECT 
    p.id_pedido,
    c.nome AS cliente,
    p.data_pedido,
    SUM(i.quantidade * i.preco_unitario) AS total_pedido
FROM loja_schemas.pedidos p
JOIN loja_schemas.clientes c ON p.id_cliente = c.id_cliente
JOIN loja_schemas.itens_pedido i ON p.id_pedido = i.id_pedido
GROUP BY p.id_pedido, c.nome, p.data_pedido;


SELECT loja_schemas.view_pedidos_totais; 

# View2 / Com Erro 
CREATE VIEW loja_schemas.view_pedidos_totais AS
SELECT 
    p.id_pedido,
    c.nome AS cliente,
    p.data_pedido,
    SUM(i.quantidade * i.preco_unitario) AS total_pedido
FROM loja_schemas.pedidos p
JOIN loja_schemas.clientes c ON p.id_cliente = c.id_cliente
JOIN loja_schemas.itens_pedido i ON p.id_pedido = i.id_pedido
GROUP BY p.id_pedido, c.nome, p.data_pedido;


SELECT loja_schemas.view_pedidos_totais; 


# SQLServer 
https://www.microsoft.com/en-us/sql-server 
https://www.microsoft.com/en-us/sql-server/sql-server-downloads 

# New / Cria banco de dados 
CREATE DATABASE loja_virtual;

# New / Clientes, Produtos, Pedidos, Itens_Pedidos 
-- Tabela de clientes
CREATE TABLE clientes (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    data_nascimento DATE
);
 
-- Tabela de produtos
CREATE TABLE produtos (
    id_produto INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
    estoque INT DEFAULT 0 CHECK (estoque >= 0)
);
 
-- Tabela de pedidos
CREATE TABLE pedidos (
    id_pedido INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT,
    data_pedido DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
 
-- Tabela de itens do pedido
CREATE TABLE itens_pedido (
    id_item INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
); 

# Inserir dados na tabela clientes 
INSERT INTO clientes(nome, email, data_nascimento)
	VALUES ('Kalunga', 'kalunga@kalunga.com.br', '2000-09-11'); 
INSERT INTO clientes(nome, email, data_nascimento)
	VALUES ('Kabum', 'kabum@kabum.com.br', '2011-06-26'); 
INSERT INTO clientes(nome, email, data_nascimento)
	VALUES ('Submarino', 'contato@submarino.com.br', '1998-11-06'); 


# Seleciona 
SELECT * FROM clientes; 
SELECT * FROM clientes WHERE id_cliente=2;







https://mariadb.org 
https://mariadb.com/docs 
https://mariadb.org/documentation 

https://www.mysql.com 
https://dev.mysql.com/doc 
https://dev.mysql.com/doc/workbench/en/ 




