
-- Tabelas

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente VARCHAR(100),
    cpf_cliente VARCHAR(14) UNIQUE,
    nascimento DATE
);

CREATE TABLE endereco_cliente (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    endereco VARCHAR(150),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE voo (
    id_voo INT PRIMARY KEY,
    codigo_voo VARCHAR(10),
    origem VARCHAR(50),
    destino VARCHAR(50),
    data_voo DATE,
    horario_voo TIME,
    valor_voo DECIMAL(10,2)
);

CREATE TABLE reserva (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_voo INT,
    id_cliente INT,
    FOREIGN KEY (id_voo) REFERENCES voo(id_voo),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Inserts

INSERT INTO cliente (id_cliente, nome_cliente, cpf_cliente, nascimento) VALUES
(1, 'Ana Silva', '123.456.789-00', '1990-01-01'),
(2, 'João Souza', '987.654.321-00', '1985-02-02'),
(3, 'Maria Oliveira', '456.789.123-00', '1992-03-03'),
(4, 'Carlos Pereira', '321.654.987-00', '1988-04-04');

INSERT INTO endereco_cliente (id_endereco, id_cliente, endereco) VALUES
(1, 1, 'Rua A, 123'),
(2, 2, 'Rua B, 456'),
(3, 3, 'Rua C, 789'),
(4, 4, 'Rua D, 101');

INSERT INTO voo (id_voo, codigo_voo, origem, destino, data_voo, horario_voo, valor_voo) VALUES
(1, 'VL123', 'São Paulo', 'Rio de Janeiro', '2025-04-01', '08:00:00', 300.00),
(2, 'VL124', 'Rio de Janeiro', 'São Paulo', '2025-04-05', '09:00:00', 350.00),
(3, 'VL125', 'Belo Horizonte', 'Brasília', '2025-04-05', '10:00:00', 400.00),
(4, 'VL126', 'Brasília', 'Curitiba', '2025-04-06', '11:00:00', 450.00),
(5, 'VL127', 'Curitiba', 'Belo Horizonte', '2025-04-07', '12:00:00', 500.00),
(6, 'VL128', 'São Paulo', 'Brasília', '2025-04-07', '13:00:00', 550.00),
(7, 'VL129', 'Rio de Janeiro', 'Curitiba', '2025-04-07', '14:00:00', 600.00),
(8, 'VL130', 'Belo Horizonte', 'São Paulo', '2025-04-08', '15:00:00', 650.00),
(9, 'VL131', 'Curitiba', 'Rio de Janeiro', '2025-04-09', '16:00:00', 700.00),
(10, 'VL132', 'Brasília', 'São Paulo', '2025-04-10', '17:00:00', 750.00),
(11, 'VL133', 'São Paulo', 'Curitiba', '2025-04-10', '18:00:00', 800.00),
(12, 'VL134', 'Rio de Janeiro', 'Brasília', '2025-04-12', '19:00:00', 850.00),
(13, 'VL135', 'Belo Horizonte', 'Rio de Janeiro', '2025-04-14', '20:00:00', 900.00),
(14, 'VL136', 'Curitiba', 'Brasília', '2025-04-15', '21:00:00', 950.00),
(15, 'VL137', 'Brasília', 'Belo Horizonte', '2025-04-15', '22:00:00', 1000.00),
(16, 'VL138', 'São Paulo', 'Curitiba', '2025-04-15', '23:00:00', 1050.00),
(17, 'VL139', 'Rio de Janeiro', 'Belo Horizonte', '2025-04-16', '00:00:00', 1100.00),
(18, 'VL140', 'Belo Horizonte', 'São Paulo', '2025-04-16', '01:00:00', 1150.00),
(19, 'VL141', 'Curitiba', 'Rio de Janeiro', '2025-04-18', '02:00:00', 1200.00),
(20, 'VL142', 'Brasília', 'São Paulo', '2025-04-23', '03:00:00', 1250.00);

INSERT INTO reserva (id_reserva, id_voo, id_cliente) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 1),
(6, 6, 2),
(7, 7, 3),
(8, 8, 4),
(9, 9, 1),
(10, 10, 2),
(11, 11, 3),
(12, 12, 4),
(13, 13, 1),
(14, 14, 2),
(15, 15, 3),
(16, 16, 4),
(17, 17, 1),
(18, 18, 2),
(19, 19, 3),
(20, 20, 4);
