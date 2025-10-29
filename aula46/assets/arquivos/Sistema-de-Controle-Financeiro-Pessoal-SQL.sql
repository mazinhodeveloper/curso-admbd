-- ================================
-- CONFIGURAÇÃO INICIAL
-- ================================
SET sql_mode = 'STRICT_ALL_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =======================================
-- BANCO DE DADOS: Sistema de Controle Financeiro Pessoal
-- =======================================

DROP DATABASE IF EXISTS financeiro;
CREATE DATABASE financeiro;
USE financeiro;

-- ================================
-- CRIAÇÃO DE TABELAS
-- ================================

-- Usuário
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    usuario_nome VARCHAR(120) NOT NULL,
    usuario_email VARCHAR(120) NOT NULL UNIQUE,
    usuario_senha VARCHAR(255) NOT NULL,
    usuario_data_cadastro DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Categoria
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    categoria_nome VARCHAR(120) NOT NULL,
    fk_id_categoria INT NULL,
    CONSTRAINT fk_categoria_pai FOREIGN KEY (fk_id_categoria) REFERENCES categoria(id_categoria)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Cartão
CREATE TABLE cartao (
    id_cartao INT AUTO_INCREMENT PRIMARY KEY,
    cartao_numero VARCHAR(50) NOT NULL,
    cartao_validade DATE NOT NULL,
    cartao_limite_credito DECIMAL(10,2) NOT NULL,
    fk_id_usuario INT NOT NULL,
    CONSTRAINT fk_cartao_usuario FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT chk_limite_credito_positivo CHECK (cartao_limite_credito >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Conta
CREATE TABLE conta (
    id_conta INT AUTO_INCREMENT PRIMARY KEY,
    conta_numero VARCHAR(50) NOT NULL,
    conta_tipo ENUM('corrente','poupanca','salario') NOT NULL,
    conta_saldo_atual DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    conta_banco VARCHAR(50) NOT NULL,
    fk_id_usuario INT NOT NULL,
    CONSTRAINT fk_conta_usuario FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Status de Fatura
CREATE TABLE status_fatura (
    id_status_fatura INT AUTO_INCREMENT PRIMARY KEY,
    status_fatura_nome ENUM('aberta','fechada','atrasada') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Fatura
CREATE TABLE fatura (
    id_fatura INT AUTO_INCREMENT PRIMARY KEY,
    fatura_data_inicio DATE NOT NULL,
    fatura_data_fim DATE NOT NULL,
    fatura_valor_total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    fk_id_cartao INT NOT NULL,
    fk_id_status INT NOT NULL,
    CONSTRAINT fk_fatura_cartao FOREIGN KEY (fk_id_cartao) REFERENCES cartao(id_cartao),
    CONSTRAINT fk_fatura_status FOREIGN KEY (fk_id_status) REFERENCES status_fatura(id_status_fatura),
    CONSTRAINT chk_fatura_period CHECK (fatura_data_fim >= fatura_data_inicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Orçamento
CREATE TABLE orcamento (
    id_orcamento INT AUTO_INCREMENT PRIMARY KEY,
    orcamento_descricao VARCHAR(120) NULL,
    orcamento_periodo_inicio DATE NOT NULL,
    orcamento_periodo_fim DATE NOT NULL,
    orcamento_valor_planejado DECIMAL(10,2) NOT NULL,
    orcamento_valor_usado DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    fk_id_usuario INT NOT NULL,
    fk_id_categoria INT NOT NULL,
    CONSTRAINT fk_orcamento_usuario FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_orcamento_categoria FOREIGN KEY (fk_id_categoria) REFERENCES categoria(id_categoria),
    CONSTRAINT chk_orcamento_period CHECK (orcamento_periodo_fim >= orcamento_periodo_inicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Pagamento de Fatura
CREATE TABLE pagamento_fatura (
    id_pagamento_fatura INT AUTO_INCREMENT PRIMARY KEY,
    pagamento_fatura_data DATE NOT NULL,
    fk_id_conta INT NOT NULL,
    fk_id_fatura INT NOT NULL,
    CONSTRAINT fk_pagamentofatura_conta FOREIGN KEY (fk_id_conta) REFERENCES conta(id_conta),
    CONSTRAINT fk_pagamentofatura_fatura FOREIGN KEY (fk_id_fatura) REFERENCES fatura(id_fatura)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Operação
CREATE TABLE operacao (
    id_operacao INT AUTO_INCREMENT PRIMARY KEY,
    operacao_nome ENUM('conta_saida','conta_entrada','fatura_saida') NOT NULL,
    fk_id_conta INT NULL,
    fk_id_fatura INT NULL,
    CONSTRAINT fk_operacao_conta FOREIGN KEY (fk_id_conta) REFERENCES conta(id_conta),
    CONSTRAINT fk_operacao_fatura FOREIGN KEY (fk_id_fatura) REFERENCES fatura(id_fatura),
    CONSTRAINT chk_operacao_target CHECK (
        (fk_id_conta IS NOT NULL AND fk_id_fatura IS NULL) OR
        (fk_id_conta IS NULL AND fk_id_fatura IS NOT NULL)
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Transação
CREATE TABLE transacao (
    id_transacao INT AUTO_INCREMENT PRIMARY KEY,
    transacao_valor DECIMAL(10,2) NOT NULL,
    transacao_data DATE NOT NULL,
    transacao_descricao VARCHAR(120) NULL,
    fk_id_categoria INT NOT NULL,
    fk_id_operacao INT NOT NULL,
    CONSTRAINT fk_transacao_categoria FOREIGN KEY (fk_id_categoria) REFERENCES categoria(id_categoria),
    CONSTRAINT fk_transacao_operacao FOREIGN KEY (fk_id_operacao) REFERENCES operacao(id_operacao),
    CONSTRAINT chk_transacao_valor_positivo CHECK (transacao_valor > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;


-- ====================
-- Criação de TRIGGERS
-- ====================
DELIMITER $$
-- -------------------------------------------------------
-- 1. BEFORE INSERT em pagamento_fatura
-- Bloqueia pagamento se fatura estiver fechada
CREATE TRIGGER trg_check_pagamento_fatura
BEFORE INSERT ON pagamento_fatura
FOR EACH ROW
BEGIN
    DECLARE v_status VARCHAR(20);

    SELECT s.status_fatura_nome
    INTO v_status
    FROM fatura f
    JOIN status_fatura s ON f.fk_id_status = s.id_status_fatura
    WHERE f.id_fatura = NEW.fk_id_fatura;

    IF v_status = 'fechada' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Pagamento não permitido: fatura já está fechada.';
    END IF;
END$$

-- -------------------------------------------------------
-- 2. Checa limite do cartão antes de efetuar transação
CREATE TRIGGER trg_check_limite_cartao
BEFORE INSERT ON transacao
FOR EACH ROW
BEGIN
    DECLARE v_tipo ENUM('conta_entrada','conta_saida','fatura_saida');
    DECLARE v_id_fatura INT;
    DECLARE v_id_cartao INT;
    DECLARE v_limite DECIMAL(12,2);
    DECLARE v_total DECIMAL(12,2);

    -- Descobre o tipo da operação e a fatura (se existir)
    SELECT operacao_nome, fk_id_fatura
    INTO v_tipo, v_id_fatura
    FROM operacao
    WHERE id_operacao = NEW.fk_id_operacao;

    -- Só valida se for fatura_saida
    IF v_tipo = 'fatura_saida' THEN
        -- Pega o cartão da fatura
        SELECT fk_id_cartao INTO v_id_cartao
        FROM fatura
        WHERE id_fatura = v_id_fatura;

        -- Busca limite do cartão
        SELECT cartao_limite_credito INTO v_limite
        FROM cartao
        WHERE id_cartao = v_id_cartao;

        -- Calcula valor total já lançado em faturas abertas desse cartão
        SELECT IFNULL(SUM(fatura_valor_total),0)
        INTO v_total
        FROM fatura f
        JOIN status_fatura s ON f.fk_id_status = s.id_status_fatura
        WHERE f.fk_id_cartao = v_id_cartao
          AND s.status_fatura_nome = 'aberta';

        -- Se exceder limite, cancela o insert
        IF (v_total + NEW.transacao_valor) > v_limite THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Transação negada: limite de crédito do cartão excedido.';
        END IF;
    END IF;
END$$

-- -------------------------------------------------------
-- 3. BEFORE INSERT em transacao - bloqueia fatura fechada/atrasada
CREATE TRIGGER trg_check_fatura_status
BEFORE INSERT ON transacao
FOR EACH ROW
BEGIN
    DECLARE v_tipo ENUM('conta_entrada','conta_saida','fatura_saida');
    DECLARE v_id_fatura INT;
    DECLARE v_status VARCHAR(20);

    SELECT operacao_nome, fk_id_fatura
    INTO v_tipo, v_id_fatura
    FROM operacao
    WHERE id_operacao = NEW.fk_id_operacao;

    IF v_tipo = 'fatura_saida' THEN
        SELECT s.status_fatura_nome
        INTO v_status
        FROM fatura f
        JOIN status_fatura s ON f.fk_id_status = s.id_status_fatura
        WHERE f.id_fatura = v_id_fatura;

        IF v_status IN ('fechada','atrasada') THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Não é permitido inserir transação em fatura fechada ou atrasada.';
        END IF;
    END IF;
END$$

-- -------------------------------------------------------
-- 4. AFTER INSERT em transacao - atualiza conta ou fatura
CREATE TRIGGER trg_transacao_update
AFTER INSERT ON transacao
FOR EACH ROW
BEGIN
    DECLARE v_tipo ENUM('conta_entrada','conta_saida','fatura_saida');
    DECLARE v_id_conta INT;
    DECLARE v_id_fatura INT;

    SELECT operacao_nome, fk_id_conta, fk_id_fatura
    INTO v_tipo, v_id_conta, v_id_fatura
    FROM operacao
    WHERE id_operacao = NEW.fk_id_operacao;

    IF v_tipo = 'conta_entrada' THEN
        UPDATE conta SET conta_saldo_atual = conta_saldo_atual + NEW.transacao_valor
        WHERE id_conta = v_id_conta;
    ELSEIF v_tipo = 'conta_saida' THEN
        UPDATE conta SET conta_saldo_atual = conta_saldo_atual - NEW.transacao_valor
        WHERE id_conta = v_id_conta;
    END IF;

    IF v_tipo = 'fatura_saida' THEN
        UPDATE fatura SET fatura_valor_total = fatura_valor_total + NEW.transacao_valor
        WHERE id_fatura = v_id_fatura;
    END IF;
END$$

-- -------------------------------------------------------
-- 5. AFTER INSERT em pagamento_fatura - debita conta e fecha fatura
CREATE TRIGGER trg_pagamento_fatura
AFTER INSERT ON pagamento_fatura
FOR EACH ROW
BEGIN
    DECLARE v_valor DECIMAL(12,2);

    SELECT fatura_valor_total
    INTO v_valor
    FROM fatura
    WHERE id_fatura = NEW.fk_id_fatura;

    UPDATE conta
    SET conta_saldo_atual = conta_saldo_atual - v_valor
    WHERE id_conta = NEW.fk_id_conta;

    UPDATE fatura
    SET fk_id_status = (SELECT id_status_fatura FROM status_fatura WHERE status_fatura_nome='fechada')
    WHERE id_fatura = NEW.fk_id_fatura;
END$$

-- -------------------------------------------------------
-- 6. Pagamento de Fatura, checando saldo conta (usando a FUNCTION fn_verifica_saldo_suficiente)
CREATE TRIGGER trg_valida_saldo_pagamento_fatura
BEFORE INSERT ON pagamento_fatura
FOR EACH ROW
BEGIN
    DECLARE v_valor_fatura DECIMAL(10,2);

    -- Pega o valor da fatura que está sendo paga
    SELECT fatura_valor_total INTO v_valor_fatura
    FROM fatura WHERE id_fatura = NEW.fk_id_fatura;

    -- CHAMA A FUNÇÃO CENTRAL: Se a função retornar FALSE (saldo insuficiente), bloqueia a operação
    IF NOT fn_verifica_saldo_suficiente(NEW.fk_id_conta, v_valor_fatura) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Saldo insuficiente para pagar o valor total da fatura.';
    END IF;
END$$

-- -------------------------------------------------------
-- 7. Débito em Conta, checando saldo conta (usando a FUNCTION fn_verifica_saldo_suficiente)
CREATE TRIGGER trg_valida_saldo_debito_conta
BEFORE INSERT ON transacao
FOR EACH ROW
BEGIN
    DECLARE v_operacao_nome VARCHAR(20);
    DECLARE v_id_conta INT;

    SELECT operacao_nome, fk_id_conta INTO v_operacao_nome, v_id_conta
    FROM operacao WHERE id_operacao = NEW.fk_id_operacao;

    -- Apenas continua se for uma saída de conta
    IF v_operacao_nome = 'conta_saida' THEN
        -- CHAMA A FUNÇÃO CENTRAL: Se a função retornar FALSE (saldo insuficiente), bloqueia a operação
        IF NOT fn_verifica_saldo_suficiente(v_id_conta, NEW.transacao_valor) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Saldo insuficiente para realizar a transação de débito.';
        END IF;
    END IF;
END$$


-- 8. Atualizar o Orçamento
-- A cada nova transação de despesa, encontra o orçamento correspondente do usuário para aquela categoria e período
CREATE TRIGGER trg_atualiza_orcamento_usado
AFTER INSERT ON transacao
FOR EACH ROW
BEGIN
    DECLARE v_id_usuario INT;
    DECLARE v_operacao_nome VARCHAR(20);

    -- Primeiro, identifica o tipo de operação
    SELECT operacao_nome INTO v_operacao_nome
    FROM operacao WHERE id_operacao = NEW.fk_id_operacao;

    -- IMPORTANTE! A trigger só deve rodar para despesas (saídas)
    IF v_operacao_nome = 'conta_saida' OR v_operacao_nome = 'fatura_saida' THEN

        -- Encontra o ID do usuário através da operação
        SELECT COALESCE(c.fk_id_usuario, ca.fk_id_usuario) INTO v_id_usuario
        FROM operacao AS op
        LEFT JOIN conta AS c ON op.fk_id_conta = c.id_conta
        LEFT JOIN fatura AS f ON op.fk_id_fatura = f.id_fatura
        LEFT JOIN cartao AS ca ON f.fk_id_cartao = ca.id_cartao
        WHERE op.id_operacao = NEW.fk_id_operacao;

        -- Se encontrou um usuário, atualiza o orçamento correspondente
        IF v_id_usuario IS NOT NULL THEN
            UPDATE orcamento
            SET orcamento_valor_usado = orcamento_valor_usado + NEW.transacao_valor
            WHERE 
                fk_id_usuario = v_id_usuario AND
                fk_id_categoria = NEW.fk_id_categoria AND
                NEW.transacao_data BETWEEN orcamento_periodo_inicio AND orcamento_periodo_fim;
        END IF;
    END IF;
END$$

DELIMITER ;


-- ================================
-- VIEWS
-- ================================
CREATE OR REPLACE VIEW vw_extrato_conta AS
SELECT c.id_conta, c.conta_numero, t.id_transacao, t.transacao_data,
       t.transacao_valor, t.transacao_descricao, o.operacao_nome,
       cat.categoria_nome,
       CASE WHEN o.operacao_nome='conta_saida' THEN -t.transacao_valor
            WHEN o.operacao_nome='conta_entrada' THEN t.transacao_valor
            ELSE 0 END AS impacto_saldo
FROM transacao t
JOIN operacao o ON t.fk_id_operacao = o.id_operacao
LEFT JOIN conta c ON o.fk_id_conta = c.id_conta
LEFT JOIN categoria cat ON t.fk_id_categoria = cat.id_categoria;

CREATE OR REPLACE VIEW vw_resumo_mensal_categoria AS
SELECT u.id_usuario, cat.id_categoria, cat.categoria_nome,
       YEAR(t.transacao_data) AS ano, MONTH(t.transacao_data) AS mes,
       SUM(t.transacao_valor) AS total_categoria
FROM transacao t
JOIN categoria cat ON t.fk_id_categoria = cat.id_categoria
JOIN operacao o ON t.fk_id_operacao = o.id_operacao
LEFT JOIN conta c ON o.fk_id_conta = c.id_conta
LEFT JOIN usuario u ON c.fk_id_usuario = u.id_usuario
GROUP BY u.id_usuario, cat.id_categoria, ano, mes;

CREATE OR REPLACE VIEW vw_orcamento_vs_realizado AS
SELECT o.id_orcamento, u.id_usuario, cat.categoria_nome,
       o.orcamento_periodo_inicio, o.orcamento_periodo_fim,
       o.orcamento_valor_planejado, o.orcamento_valor_usado,
       ROUND((o.orcamento_valor_usado / o.orcamento_valor_planejado) * 100, 2) AS percentual_utilizado
FROM orcamento o
JOIN usuario u ON o.fk_id_usuario = u.id_usuario
JOIN categoria cat ON o.fk_id_categoria = cat.id_categoria;

CREATE OR REPLACE VIEW vw_faturas_em_aberto AS
SELECT f.id_fatura, u.id_usuario, c.cartao_numero,
       f.fatura_data_inicio, f.fatura_data_fim,
       f.fatura_valor_total, s.status_fatura_nome
FROM fatura f
JOIN cartao c ON f.fk_id_cartao = c.id_cartao
JOIN usuario u ON c.fk_id_usuario = u.id_usuario
JOIN status_fatura s ON f.fk_id_status = s.id_status_fatura
WHERE s.status_fatura_nome IN ('aberta','atrasada');


-- ================================
-- FUNCTIONS
-- ================================
DELIMITER $$

CREATE FUNCTION fn_saldo_usuario(p_usuario INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE v_saldo DECIMAL(12,2);
    SELECT SUM(conta_saldo_atual) INTO v_saldo
    FROM conta WHERE fk_id_usuario = p_usuario;
    RETURN IFNULL(v_saldo,0.00);
END$$

CREATE FUNCTION fn_percentual_orcamento(p_id_orcamento INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE v_planejado DECIMAL(12,2);
    DECLARE v_usado DECIMAL(12,2);
    SELECT orcamento_valor_planejado, orcamento_valor_usado
    INTO v_planejado, v_usado FROM orcamento WHERE id_orcamento = p_id_orcamento;
    RETURN IFNULL((v_usado/v_planejado)*100,0);
END$$

DELIMITER ;

-- ================================
-- STORED PROCEDURES
-- ================================
DELIMITER $$

CREATE PROCEDURE sp_fechar_fatura(IN p_id_fatura INT)
BEGIN
    DECLARE v_status_aberta INT;
    DECLARE v_status_fechada INT;
    SELECT id_status_fatura INTO v_status_aberta FROM status_fatura WHERE status_fatura_nome='aberta';
    SELECT id_status_fatura INTO v_status_fechada FROM status_fatura WHERE status_fatura_nome='fechada';
    IF (SELECT fk_id_status FROM fatura WHERE id_fatura=p_id_fatura)=v_status_aberta THEN
        UPDATE fatura SET fk_id_status=v_status_fechada WHERE id_fatura=p_id_fatura;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Fatura não está aberta';
    END IF;
END$$

CREATE PROCEDURE sp_relatorio_usuario(IN p_id_usuario INT, IN p_data_inicio DATE, IN p_data_fim DATE)
BEGIN
    -- saldo total
    SELECT fn_saldo_usuario(p_id_usuario) AS saldo_total;

    -- resumo categorias
    SELECT cat.categoria_nome, SUM(t.transacao_valor) AS total_categoria
    FROM transacao t
    JOIN categoria cat ON t.fk_id_categoria=cat.id_categoria
    JOIN operacao o ON t.fk_id_operacao=o.id_operacao
    LEFT JOIN conta c ON o.fk_id_conta=c.id_conta
    WHERE c.fk_id_usuario=p_id_usuario AND t.transacao_data BETWEEN p_data_inicio AND p_data_fim
    GROUP BY cat.categoria_nome;

    -- faturas
    SELECT f.id_fatura, f.fatura_data_inicio, f.fatura_data_fim, f.fatura_valor_total, s.status_fatura_nome
    FROM fatura f
    JOIN cartao ca ON f.fk_id_cartao=ca.id_cartao
    JOIN status_fatura s ON f.fk_id_status=s.id_status_fatura
    WHERE ca.fk_id_usuario=p_id_usuario AND s.status_fatura_nome IN ('aberta','atrasada');
END$$

-- =======================================================================================================================
-- Essa function será usada dentro das triggers 'trg_valida_saldo_pagamento_fatura' e 'trg_valida_saldo_debito_conta'
-- Ela receberá o ID da conta e o valor do débito como parâmetros e retornará 1 se o saldo for suficiente senão 0.

-- DROP FUNCTION IF EXISTS fn_verifica_saldo_suficiente;
DELIMITER $$
CREATE FUNCTION fn_verifica_saldo_suficiente(p_id_conta INT, p_valor_debito DECIMAL(10,2))
RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE v_saldo_atual DECIMAL(10,2);

    -- Pega o saldo atual da conta informada
    SELECT conta_saldo_atual INTO v_saldo_atual 
    FROM conta WHERE id_conta = p_id_conta;

    -- Retorna TRUE (1) se o saldo for suficiente, FALSE (0) caso contrário
    IF v_saldo_atual >= p_valor_debito THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END$$

DELIMITER ;


-- =======================================================
-- SCRIPT DE INSERÇÃO DE DADOS BÁSICOS
-- =======================================================

-- Desativa a checagem de chaves estrangeiras para permitir a inserção em qualquer ordem, se necessário.
SET FOREIGN_KEY_CHECKS = 0;

-- Limpa as tabelas antes de inserir novos dados para evitar duplicatas ao re-executar o script.
TRUNCATE TABLE transacao;
TRUNCATE TABLE operacao;
TRUNCATE TABLE pagamento_fatura;
TRUNCATE TABLE fatura;
TRUNCATE TABLE orcamento;
TRUNCATE TABLE conta;
TRUNCATE TABLE cartao;
TRUNCATE TABLE categoria;
TRUNCATE TABLE status_fatura;
TRUNCATE TABLE usuario;

-- ================================
-- 1. DADOS BÁSICOS (TABELAS INDEPENDENTES)
-- ================================

-- Inserindo os 3 usuários
INSERT INTO usuario (id_usuario, usuario_nome, usuario_email, usuario_senha, usuario_data_cadastro) VALUES
(1, 'Beatriz Oliveira', 'beatriz@email.com', 'senha_hash_123', '2025-01-15'),
(2, 'Carlos Pereira', 'carlos@email.com', 'senha_hash_456', '2025-02-20'),
(3, 'Edemar Souza', 'edemar@email.com', 'senha_hash_789', '2025-03-10');

-- Inserindo os status de fatura (o ENUM garante a ordem)
INSERT INTO status_fatura (id_status_fatura, status_fatura_nome) VALUES
(1, 'aberta'),
(2, 'fechada'),
(3, 'atrasada');

-- Inserindo as categorias e subcategorias
INSERT INTO categoria (id_categoria, categoria_nome, fk_id_categoria) VALUES
(1, 'Alimentação', NULL),
(2, 'Restaurante', 1),
(3, 'Supermercado', 1),
(4, 'Moradia', NULL),
(5, 'Transporte', NULL),
(6, 'Lazer', NULL),
(7, 'Saúde', NULL),
(8, 'Salário', NULL); -- Categoria de receita

-- ================================
-- 2. DADOS DOS USUÁRIOS (CONTAS E CARTÕES)
-- ================================

-- Inserindo 2 contas para cada usuário
INSERT INTO conta (id_conta, fk_id_usuario, conta_banco, conta_numero, conta_tipo, conta_saldo_atual) VALUES
-- Contas de Beatriz
(1, 1, 'Nubank', '1111-1', 'corrente', 2500.00),
(2, 1, 'Itaú', '2222-2', 'poupanca', 15000.00),
-- Contas de Carlos
(3, 2, 'Nubank', '3333-3', 'corrente', 800.00),
(4, 2, 'Bradesco', '4444-4', 'salario', 1200.00),
-- Contas de Edemar
(5, 3, 'SICOOB', '5555-5', 'corrente', 4000.00),
(6, 3, 'Nubank', '6666-6', 'corrente', 350.00);

-- Inserindo 2 cartões para cada usuário
INSERT INTO cartao (id_cartao, fk_id_usuario, cartao_numero, cartao_validade, cartao_limite_credito) VALUES
-- Cartões de Beatriz
(1, 1, 'final 4010', '2028-12-31', 10000.00),
(2, 1, 'final 5020', '2027-10-31', 12000.00),
-- Cartões de Carlos
(3, 2, 'final 6030', '2029-01-31', 6000.00),
(4, 2, 'final 7040', '2026-08-31', 7500.00),
-- Cartões de Edemar
(5, 3, 'final 8050', '2028-05-31', 5500.00),
(6, 3, 'final 9060', '2029-04-30', 8000.00);

-- ================================
-- 3. PLANEJAMENTO (ORÇAMENTOS)
-- ================================
-- Orçamentos para Setembro/2025
INSERT INTO orcamento (fk_id_usuario, fk_id_categoria, orcamento_valor_planejado, orcamento_periodo_inicio, orcamento_periodo_fim) VALUES
-- Beatriz
(1, 1, 1500.00, '2025-09-01', '2025-09-30'), -- Alimentação
(1, 4, 2000.00, '2025-09-01', '2025-09-30'), -- Moradia
(1, 6, 800.00, '2025-09-01', '2025-09-30'),  -- Lazer
-- Carlos
(2, 1, 1200.00, '2025-09-01', '2025-09-30'), -- Alimentação
(2, 5, 300.00, '2025-09-01', '2025-09-30'),  -- Transporte
-- Edemar
(3, 1, 1300.00, '2025-09-01', '2025-09-30'), -- Alimentação
(3, 7, 400.00, '2025-09-01', '2025-09-30');   -- Saúde


-- =======================================
-- EVENTS
-- =======================================

SET GLOBAL event_scheduler = ON;

DELIMITER $$
-- Verificar status da fatura diariamente por data
CREATE EVENT evt_marcar_faturas_atrasadas
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '00:01:00') -- Roda todo dia, 1 minuto após a meia-noite
COMMENT 'Atualiza diariamente o status de faturas abertas e vencidas para "atrasada".'
DO
BEGIN
  UPDATE fatura
  SET fk_id_status = (
      SELECT id_status_fatura FROM status_fatura WHERE status_fatura_nome='atrasada'
  )
  WHERE fatura_data_fim < CURDATE()
    AND fk_id_status = (SELECT id_status_fatura FROM status_fatura WHERE status_fatura_nome='aberta');
END$$
DELIMITER ;
