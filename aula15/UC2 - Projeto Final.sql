-- Estrutura de tabelas
--
-- Produto (id_produto PK, nome, descricao, preco, quantidade_estoque)
-- Cliente (id_cliente PK, nome, email, telefone, endereco)
-- Venda (id_venda PK, id_cliente FK, data_venda, valor_total)
-- ItemVenda (id_item_venda PK, id_venda FK, id_produto FK, quantidade, preco_unitario, subtotal)
-- MovimentacaoEstoque (id_movimentacao PK, id_produto FK, tipo, quantidade, data_movimentacao, origem, observacao)


CREATE DATABASE Loja
USE Loja

-- 1. Criação de tabelas
-- Tabela de Produtos
CREATE TABLE Produto (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT DEFAULT 0
);

-- Tabela de Clientes
CREATE TABLE Cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    endereco TEXT
);

-- Tabela de Vendas
CREATE TABLE Venda (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES Cliente(id_cliente),
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10, 2)
);

-- Itens da Venda
CREATE TABLE ItemVenda (
    id_item_venda SERIAL PRIMARY KEY,
    id_venda INT REFERENCES Venda(id_venda),
    id_produto INT REFERENCES Produto(id_produto),
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL
);

-- Movimentações de Estoque
CREATE TABLE MovimentacaoEstoque (
    id_movimentacao SERIAL PRIMARY KEY,
    id_produto INT REFERENCES Produto(id_produto),
    tipo VARCHAR(10) CHECK (tipo IN ('ENTRADA', 'SAIDA')),
    quantidade INT NOT NULL,
    data_movimentacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    origem VARCHAR(20), -- Ex: 'VENDA', 'REPOSICAO', 'AJUSTE'
    observacao TEXT
);

-- 2. Inserindo dados nas tabelas
-- Tabela Clientes
INSERT INTO Cliente (nome, email, telefone, endereco) VALUES
('Ana Paula Souza', 'ana.souza@email.com', '(11) 98888-1111', 'Rua das Flores, 123, SP'),
('Carlos Eduardo Lima', 'carlos.lima@email.com', '(21) 97777-2222', 'Av. Central, 456, RJ'),
('Mariana Silva Costa', 'mariana.silva@email.com', '(31) 96666-3333', 'Rua Azul, 789, BH'),
('João Pedro Martins', 'joao.martins@email.com', '(41) 95555-4444', 'Av. das Palmeiras, 321, PR'),
('Fernanda Ribeiro', 'fernanda.ribeiro@email.com', '(51) 94444-5555', 'Rua Verde, 654, RS'),
('Lucas Almeida', 'lucas.almeida@email.com', '(61) 93333-6666', 'SHN Quadra 3, Brasília, DF');

-- Tabela Produto
INSERT INTO Produto (nome, descricao, preco, quantidade_estoque) VALUES
('Notebook Dell Inspiron', 'Notebook 15.6", Intel i5, 8GB RAM, SSD 256GB', 3500.00, 0),
('Mouse Logitech M170', 'Mouse sem fio com conexão USB', 80.00, 0),
('Teclado Mecânico Redragon', 'Teclado com iluminação RGB', 250.00, 0),
('Monitor LG 24"', 'Monitor LED Full HD', 950.00, 0),
('HD Externo Seagate 1TB', 'Disco rígido portátil USB 3.0', 320.00, 0),
('Smartphone Samsung A34', 'Android, 128GB, Tela AMOLED', 1850.00, 0),
('Cadeira Gamer ThunderX3', 'Cadeira ergonômica com apoio lombar', 1200.00, 0),
('Webcam Logitech C920', 'Webcam Full HD com microfone', 480.00, 0),
('Fone Bluetooth JBL Tune', 'Fone sem fio com som JBL Pure Bass', 300.00, 0),
('Carregador Turbo Motorola', 'Carregador rápido USB-C 30W', 120.00, 0);

-- Reposição de estoque (entrada)
INSERT INTO MovimentacaoEstoque (id_produto, tipo, quantidade, origem, observacao) VALUES
(1, 'ENTRADA', 15, 'REPOSICAO', 'Compra fornecedor Dell'),
(2, 'ENTRADA', 50, 'REPOSICAO', 'Compra fornecedor Logitech'),
(3, 'ENTRADA', 30, 'REPOSICAO', 'Compra fornecedor Redragon'),
(4, 'ENTRADA', 20, 'REPOSICAO', 'Compra fornecedor LG'),
(5, 'ENTRADA', 25, 'REPOSICAO', 'Compra fornecedor Seagate'),
(6, 'ENTRADA', 18, 'REPOSICAO', 'Compra fornecedor Samsung'),
(7, 'ENTRADA', 10, 'REPOSICAO', 'Compra fornecedor ThunderX3'),
(8, 'ENTRADA', 22, 'REPOSICAO', 'Compra fornecedor Logitech'),
(9, 'ENTRADA', 35, 'REPOSICAO', 'Compra fornecedor JBL'),
(10, 'ENTRADA', 40, 'REPOSICAO', 'Compra fornecedor Motorola');

-- Atualiza os estoques de Produto conforme entrada. Atualização feita de forma manual
UPDATE Produto SET quantidade_estoque = 15 WHERE id_produto = 1;
UPDATE Produto SET quantidade_estoque = 50 WHERE id_produto = 2;
UPDATE Produto SET quantidade_estoque = 30 WHERE id_produto = 3;
UPDATE Produto SET quantidade_estoque = 20 WHERE id_produto = 4;
UPDATE Produto SET quantidade_estoque = 25 WHERE id_produto = 5;
UPDATE Produto SET quantidade_estoque = 18 WHERE id_produto = 6;
UPDATE Produto SET quantidade_estoque = 10 WHERE id_produto = 7;
UPDATE Produto SET quantidade_estoque = 22 WHERE id_produto = 8;
UPDATE Produto SET quantidade_estoque = 35 WHERE id_produto = 9;
UPDATE Produto SET quantidade_estoque = 40 WHERE id_produto = 10;

-- Vamos agora criar um gatilho para atualizar tabela produtos automaticamente após uma reposição de estoque (entrada)

-- 3. Trigger: registrar ENTRADA de estoque
-- Função para atualizar o estoque na entrada

-- O DELIMITER é usado para alterar o delimitador padrão (;) para que o MySQL
-- não interprete o ponto e vírgula dentro do corpo do trigger como o fim da instrução.
DELIMITER $$

CREATE TRIGGER trg_registrar_entrada_estoque
-- O trigger será acionado DEPOIS de uma INSERÇÃO na tabela MovimentacaoEstoque
AFTER INSERT ON MovimentacaoEstoque
-- A lógica será executada PARA CADA LINHA inserida
FOR EACH ROW
BEGIN
    -- Verifica se o tipo da movimentação inserida é 'ENTRADA'.
    -- 'NEW' é uma palavra-chave que se refere à linha que acabou de ser inserida.
    IF NEW.tipo = 'ENTRADA' THEN
        -- Se for uma entrada, atualiza a quantidade na tabela de produtos.
        UPDATE Produto
        SET quantidade_estoque = quantidade_estoque + NEW.quantidade
        WHERE id_produto = NEW.id_produto;
    END IF;
-- O END marca o fim do corpo do trigger.
END$$

-- Retorna o delimitador ao seu valor padrão.
DELIMITER ;


-- Teste com o item 10 (Carregador Turbo Motorola)
INSERT INTO MovimentacaoEstoque (id_produto, tipo, quantidade, origem, observacao)
VALUES (10, 'ENTRADA', 5, 'REPOSICAO', 'Nova reposição do carregador Motorola');




-- 4. Trigger: registrar SAÍDA em vendas
-- Função para registrar movimentações de saída ao inserir item de venda

DELIMITER $$

-- TRIGGER 1: CALCULAR O SUBTOTAL ANTES DE INSERIR O ITEM
-- Este trigger é do tipo BEFORE INSERT, ele roda antes do dado ser salvo.
-- Sua única função é calcular e preencher o campo 'subtotal'.
CREATE TRIGGER trg_calcula_subtotal_item
BEFORE INSERT ON ItemVenda
FOR EACH ROW
BEGIN
    SET NEW.subtotal = NEW.quantidade * NEW.preco_unitario;
END$$


-- TRIGGER 2: ATUALIZAR ESTOQUE E TOTAIS APÓS INSERIR O ITEM
-- Este trigger é do tipo AFTER INSERT, ele roda logo após o dado ser salvo.
CREATE TRIGGER trg_saida_venda_completa
AFTER INSERT ON ItemVenda
FOR EACH ROW
BEGIN
    -- Ação 1: Atualiza o valor total na tabela principal de Venda, somando todos os subtotais da tabela ItemVenda.
    UPDATE Venda
    SET valor_total = (SELECT SUM(iv.subtotal) FROM ItemVenda iv WHERE iv.id_venda = NEW.id_venda)
    WHERE id_venda = NEW.id_venda;

    -- Ação 2: Deduz a quantidade do estoque do produto
    UPDATE Produto
    SET quantidade_estoque = quantidade_estoque - NEW.quantidade
    WHERE id_produto = NEW.id_produto;

    -- Ação 3: Registra a movimentação de saída no histórico
    INSERT INTO MovimentacaoEstoque (id_produto, tipo, quantidade, origem, observacao)
    VALUES (
        NEW.id_produto,
        'SAIDA',
        NEW.quantidade,
        'VENDA',
        CONCAT('Venda ID: ', NEW.id_venda, ', Item ID: ', NEW.id_item_venda)
    );
END$$

DELIMITER ;



-- 4. Realizando vendas
--   4.1. Registra uma nova venda para a cliente Ana Paula (ID 1)
INSERT INTO Venda (id_cliente) VALUES (1);
SET @id_ultima_venda = LAST_INSERT_ID();

--   4.2. Insere os itens na venda. CADA INSERT ABAIXO VAI ACIONAR AMBOS OS TRIGGERS com a variável @id_ultima_venda.

-- Venda de 2 Cadeiras Gamer (ID 7) a R$ 1200.00 cada
-- O trigger 'trg_calcula_subtotal_item' vai calcular o subtotal (2 * 1200 = 2400)
-- O trigger 'trg_saida_venda_completa' vai:
--   - Somar 2400 ao valor_total da Venda 1
--   - Subtrair 2 do estoque de Cadeira Gamer
--   - Registrar a saída de 2 cadeiras na MovimentacaoEstoque
INSERT INTO ItemVenda (id_venda, id_produto, quantidade, preco_unitario)
VALUES (@id_ultima_venda, 7, 2, 1200.00);

-- Venda de 1 Notebook Dell (ID 1) a R$ 3500.00
-- O trigger 'trg_calcula_subtotal_item' vai calcular o subtotal (1 * 3500 = 3500)
-- O trigger 'trg_saida_venda_completa' vai:
--   - Somar 3500 ao valor_total da Venda 1
--   - Subtrair 1 do estoque de Notebook Dell
--   - Registrar a saída de 1 Notebook Dell na MovimentacaoEstoque
INSERT INTO ItemVenda (id_venda, id_produto, quantidade, preco_unitario)
VALUES (@id_ultima_venda, 1, 1, 3500.00);


-- =====================================================================
-- VERIFICANDO OS RESULTADOS
-- =====================================================================

-- Verificando a tabela Venda (o valor_total deve ser 2400 + 3500 = 5900)
SELECT * FROM Venda;

-- Verificando a tabela ItemVenda (os subtotais devem estar preenchidos)
SELECT * FROM ItemVenda;

-- Verificando o estoque dos produtos (as quantidades devem ter sido deduzidas dos ID 1 e ID 7)
SELECT * FROM Produto;

-- Verificando o histórico de movimentações (deve haver duas novas saídas)
SELECT id_produto, tipo, quantidade, origem, observacao FROM MovimentacaoEstoque;