Aula 25 
Professor: Lilian 
Data: 11/08/2025 


# Criar Banco Digital 

CREATE DATABASE banco_digital; 

USE banco_digital; 

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(150),
    email VARCHAR(150),
    telefone VARCHAR(12)
);

CREATE TABLE banco (
    id_banco INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150),
    codigo VARCHAR(5)
);

CREATE TABLE conta (
    id_conta INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('corrente', 'poupanca', 'salario'),
    saldo DECIMAL(10,2),
    id_cliente INT,
    id_banco INT,
    CONSTRAINT fk_conta_id_cliente_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_conta_id_banco_banco FOREIGN KEY (id_banco) REFERENCES banco(id_banco)
);

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2),
    status_pagamento BOOLEAN,
    data_pagamento DATETIME,
    id_cliente INT,
    id_conta INT,
    CONSTRAINT fk_pagamento_id_cliente_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_pagamento_id_conta_conta FOREIGN KEY (id_conta) REFERENCES conta(id_conta)
);




# INNER JOIN / SAME EXAMPLE 
USE banco_digital; 

SELECT c.id_conta, c.saldo, c.tipo, cl.nome nome, b.nome banco FROM conta c INNER JOIN cliente cl ON c.id_cliente = cl.id_cliente INNER JOIN banco b ON b.id_banco = c.id_banco;

SELECT c.*, b.nome banco, cl.nome nome FROM conta c, cliente cl, banco b WHERE c.id_cliente = cl.id_cliente AND c.id_banco = b.id_banco;








