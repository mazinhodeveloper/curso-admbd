-- ========================================
-- Usuários (5 Inserções)
-- ========================================
INSERT INTO usuario (usuario_nome, usuario_email, usuario_senha, usuario_data_cadastro) VALUES
('Alice Silva', 'alice@email.com', '123', '2025-01-05'), -- ID 1
('Bruno Costa', 'bruno@email.com', '321', '2025-01-10'), -- ID 2 
('Carla Souza', 'carla@email.com', '124', '2025-01-12'), -- ID 3
('Diego Martins', 'diego@email.com', '223', '2025-01-15'), -- ID 4
('Eduarda Lima', 'eduarda@email.com', '143', '2025-01-20'); -- ID 5

-- ========================================
-- Categorias (10 Inserções)
-- ========================================
INSERT INTO categoria (categoria_nome,fk_id_categoria) VALUES
('Salário',NULL), -- ID 1
('Alimentação',NULL), -- ID 2
('Transporte',NULL), -- ID 3
('Lazer',NULL), -- ID 4
('Restaurante',2), -- ID 5
('IFood',2), -- ID 6
('Mercado',2), -- ID 7
('Uber',3), -- ID 8
('Cinema',4), -- ID 9
('Shopping',4); -- ID 10


-- ========================================
-- Contas (5 Inserções - 1 para cada usuário)
-- ========================================
INSERT INTO conta (conta_numero, conta_tipo, conta_saldo_atual, conta_banco, fk_id_usuario) VALUES
('1111-1', 'corrente', 5000.00, 'Banco A', 1), -- Alice
('2222-2', 'corrente', 3000.00, 'Banco B', 2), -- Bruno
('3333-3', 'poupanca', 8000.00, 'Banco C', 3), -- Carla
('4444-4', 'corrente', 4500.00, 'Banco D', 4), -- Diego
('5555-5', 'corrente', 2500.00, 'Banco E', 5); -- Eduarda

-- ========================================
-- Cartões (5 Inserções - 1 para cada usuário)
-- ========================================
INSERT INTO cartao (cartao_numero, cartao_validade, cartao_limite_credito, fk_id_usuario) VALUES
('1111 2222 3333 4444', '2028-12-01', 8000.00, 1),  -- Alice
('5555 6666 7777 8888', '2027-11-01', 6000.00, 2),  -- Bruno
('9999 0000 1111 2222', '2026-10-01', 7000.00, 3),  -- Carla
('3333 4444 5555 6666', '2029-09-01', 6500.00, 4),  -- Diego
('7777 8888 9999 0000', '2028-08-01', 7500.00, 5);  -- Eduarda

-- ========================================
-- Status de Fatura
-- ========================================
INSERT INTO status_fatura (status_fatura_nome) VALUES
('aberta'),
('fechada'),
('atrasada');

-- ========================================
-- Faturas (15 inserções. 3 faturas (1 aberta, 1 fechada, 1 atrasada) por usuario)
-- ========================================
INSERT INTO fatura (fatura_data_inicio, fatura_data_fim, fatura_valor_total, fk_id_cartao, fk_id_status) VALUES

('2025-07-01', '2025-07-31', 2000, 1, 2), -- fatura paga Alice
('2025-08-01', '2025-08-31', 1000, 1, 3), -- fatura atrasada Alice
('2025-09-01', '2025-09-30', 500, 1, 1), -- fatura aberta Alice

('2025-07-01', '2025-07-31', 1500, 2, 2), -- fatura paga Bruno
('2025-08-01', '2025-08-31', 800, 2, 3),  -- fatura atrasada Bruno
('2025-09-01', '2025-09-30', 600, 2, 1),  -- fatura aberta Bruno

('2025-07-01', '2025-07-31', 1800, 3, 2), -- fatura paga Carla
('2025-08-01', '2025-08-31', 1200, 3, 3), -- fatura atrasada Carla
('2025-09-01', '2025-09-30', 700, 3, 1),  -- fatura aberta Carla

('2025-07-01', '2025-07-31', 1600, 4, 2), -- fatura paga Diego
('2025-08-01', '2025-08-31', 900, 4, 3),  -- fatura atrasada Diego
('2025-09-01', '2025-09-30', 400, 4, 1),  -- fatura aberta Diego

('2025-07-01', '2025-07-31', 1400, 5, 2), -- fatura paga Eduarda
('2025-08-01', '2025-08-31', 1000, 5, 3), -- fatura atrasada Eduarda
('2025-09-01', '2025-09-30', 550, 5, 1);  -- fatura aberta Eduarda
-- Ajuste inicial nas faturas inseridas anteriormente para garantir consistência com os triggers.
-- Definimos todas como abertas (status 1) e valor_total 0, pois os valores serão populados pelas transações.
-- Após as transações, processamos pagamentos para as de julho (fechando-as) e atualizamos as de agosto para atrasadas.
UPDATE fatura SET fatura_valor_total = 0, fk_id_status = 1 WHERE id_fatura > 0;

-- ========================================
-- Orçamentos (30 Inserções - 6 por usuário, um para cada subcategoria principal, período de setembro)
-- ========================================
-- Orçamentos para Alice (ID 1) - Focados em subcategorias para demonstrar atualização via trigger em transações de setembro
INSERT INTO orcamento (orcamento_descricao, orcamento_periodo_inicio, orcamento_periodo_fim, orcamento_valor_planejado, orcamento_valor_usado, fk_id_usuario, fk_id_categoria) VALUES
('Orçamento Restaurante Setembro', '2025-09-01', '2025-09-30', 300.00, 0.00, 1, 5),
('Orçamento IFood Setembro', '2025-09-01', '2025-09-30', 200.00, 0.00, 1, 6),
('Orçamento Mercado Setembro', '2025-09-01', '2025-09-30', 500.00, 0.00, 1, 7),
('Orçamento Uber Setembro', '2025-09-01', '2025-09-30', 400.00, 0.00, 1, 8),
('Orçamento Cinema Setembro', '2025-09-01', '2025-09-30', 300.00, 0.00, 1, 9),
('Orçamento Shopping Setembro', '2025-09-01', '2025-09-30', 400.00, 0.00, 1, 10);

-- Orçamentos para Bruno (ID 2) - Valores ligeiramente variados para diversidade
INSERT INTO orcamento (orcamento_descricao, orcamento_periodo_inicio, orcamento_periodo_fim, orcamento_valor_planejado, orcamento_valor_usado, fk_id_usuario, fk_id_categoria) VALUES
('Orçamento Restaurante Setembro', '2025-09-01', '2025-09-30', 250.00, 0.00, 2, 5),
('Orçamento IFood Setembro', '2025-09-01', '2025-09-30', 150.00, 0.00, 2, 6),
('Orçamento Mercado Setembro', '2025-09-01', '2025-09-30', 400.00, 0.00, 2, 7),
('Orçamento Uber Setembro', '2025-09-01', '2025-09-30', 300.00, 0.00, 2, 8),
('Orçamento Cinema Setembro', '2025-09-01', '2025-09-30', 250.00, 0.00, 2, 9),
('Orçamento Shopping Setembro', '2025-09-01', '2025-09-30', 300.00, 0.00, 2, 10);

-- Orçamentos para Carla (ID 3) - Valores mais altos para demonstrar variação
INSERT INTO orcamento (orcamento_descricao, orcamento_periodo_inicio, orcamento_periodo_fim, orcamento_valor_planejado, orcamento_valor_usado, fk_id_usuario, fk_id_categoria) VALUES
('Orçamento Restaurante Setembro', '2025-09-01', '2025-09-30', 350.00, 0.00, 3, 5),
('Orçamento IFood Setembro', '2025-09-01', '2025-09-30', 250.00, 0.00, 3, 6),
('Orçamento Mercado Setembro', '2025-09-01', '2025-09-30', 600.00, 0.00, 3, 7),
('Orçamento Uber Setembro', '2025-09-01', '2025-09-30', 500.00, 0.00, 3, 8),
('Orçamento Cinema Setembro', '2025-09-01', '2025-09-30', 400.00, 0.00, 3, 9),
('Orçamento Shopping Setembro', '2025-09-01', '2025-09-30', 500.00, 0.00, 3, 10);

-- Orçamentos para Diego (ID 4)
INSERT INTO orcamento (orcamento_descricao, orcamento_periodo_inicio, orcamento_periodo_fim, orcamento_valor_planejado, orcamento_valor_usado, fk_id_usuario, fk_id_categoria) VALUES
('Orçamento Restaurante Setembro', '2025-09-01', '2025-09-30', 280.00, 0.00, 4, 5),
('Orçamento IFood Setembro', '2025-09-01', '2025-09-30', 180.00, 0.00, 4, 6),
('Orçamento Mercado Setembro', '2025-09-01', '2025-09-30', 450.00, 0.00, 4, 7),
('Orçamento Uber Setembro', '2025-09-01', '2025-09-30', 350.00, 0.00, 4, 8),
('Orçamento Cinema Setembro', '2025-09-01', '2025-09-30', 280.00, 0.00, 4, 9),
('Orçamento Shopping Setembro', '2025-09-01', '2025-09-30', 350.00, 0.00, 4, 10);

-- Orçamentos para Eduarda (ID 5)
INSERT INTO orcamento (orcamento_descricao, orcamento_periodo_inicio, orcamento_periodo_fim, orcamento_valor_planejado, orcamento_valor_usado, fk_id_usuario, fk_id_categoria) VALUES
('Orçamento Restaurante Setembro', '2025-09-01', '2025-09-30', 320.00, 0.00, 5, 5),
('Orçamento IFood Setembro', '2025-09-01', '2025-09-30', 220.00, 0.00, 5, 6),
('Orçamento Mercado Setembro', '2025-09-01', '2025-09-30', 550.00, 0.00, 5, 7),
('Orçamento Uber Setembro', '2025-09-01', '2025-09-30', 450.00, 0.00, 5, 8),
('Orçamento Cinema Setembro', '2025-09-01', '2025-09-30', 350.00, 0.00, 5, 9),
('Orçamento Shopping Setembro', '2025-09-01', '2025-09-30', 450.00, 0.00, 5, 10);

-- ========================================
-- Operações (25 Inserções: 2 por conta (entrada/saída) + 1 por fatura (saída))
-- ========================================
-- Operações de entrada em conta (1 por usuário)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('conta_entrada', 1, NULL); -- ID esperado: 1 (Alice)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('conta_entrada', 2, NULL); -- ID 2 (Bruno)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('conta_entrada', 3, NULL); -- ID 3 (Carla)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('conta_entrada', 4, NULL); -- ID 4 (Diego)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('conta_entrada', 5, NULL); -- ID 5 (Eduarda)

-- Operações de saída em conta (1 por usuário)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('conta_saida', 1, NULL); -- ID 6 (Alice)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('conta_saida', 2, NULL); -- ID 7 (Bruno)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('conta_saida', 3, NULL); -- ID 8 (Carla)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('conta_saida', 4, NULL); -- ID 9 (Diego)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('conta_saida', 5, NULL); -- ID 10 (Eduarda)

-- Operações de saída em fatura (1 por fatura)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 1); -- ID 11 (Alice Julho)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 2); -- ID 12 (Alice Agosto)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 3); -- ID 13 (Alice Setembro)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 4); -- ID 14 (Bruno Julho)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 5); -- ID 15 (Bruno Agosto)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 6); -- ID 16 (Bruno Setembro)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 7); -- ID 17 (Carla Julho)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 8); -- ID 18 (Carla Agosto)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 9); -- ID 19 (Carla Setembro)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 10); -- ID 20 (Diego Julho)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 11); -- ID 21 (Diego Agosto)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 12); -- ID 22 (Diego Setembro)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 13); -- ID 23 (Eduarda Julho)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 14); -- ID 24 (Eduarda Agosto)
INSERT INTO operacao (operacao_nome, fk_id_conta, fk_id_fatura) VALUES ('fatura_saida', NULL, 15); -- ID 25 (Eduarda Setembro)

-- ========================================
-- Transações (Múltiplas por operação - Total: ~100 inserções)
-- Somatórios respeitam os valores originais das faturas e limites dos cartões.
-- Distribuição em subcategorias para atualizar orçamentos de setembro via trigger.
-- Datas dentro dos períodos das faturas/contas. Despesas em setembro atualizam views de orçamento/resumo.
-- ========================================
-- Transações de entrada em conta (1 por usuário, salário em setembro - Atualiza saldo via trigger)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(3000.00, '2025-09-01', 'Salário Setembro', 1, 1), -- Alice (entrada, oper 1)
(2500.00, '2025-09-01', 'Salário Setembro', 1, 2), -- Bruno
(4000.00, '2025-09-01', 'Salário Setembro', 1, 3), -- Carla
(2800.00, '2025-09-01', 'Salário Setembro', 1, 4), -- Diego
(3200.00, '2025-09-01', 'Salário Setembro', 1, 5); -- Eduarda

-- Transações de saída em conta (3-4 por usuário, em setembro - Atualiza saldo/orçamento via triggers)
-- Alice (saídas, oper 6)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(200.00, '2025-09-05', 'Compra Mercado', 7, 6),
(100.00, '2025-09-10', 'Corrida Uber', 8, 6),
(150.00, '2025-09-15', 'Ingresso Cinema', 9, 6),
(120.00, '2025-09-20', 'Pedido IFood', 6, 6);

-- Bruno (saídas, oper 7)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(150.00, '2025-09-05', 'Compra Mercado', 7, 7),
(80.00, '2025-09-10', 'Corrida Uber', 8, 7),
(120.00, '2025-09-15', 'Ingresso Cinema', 9, 7),
(100.00, '2025-09-20', 'Almoço Restaurante', 5, 7);

-- Carla (saídas, oper 8)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(250.00, '2025-09-05', 'Compra Mercado', 7, 8),
(150.00, '2025-09-10', 'Corrida Uber', 8, 8),
(200.00, '2025-09-15', 'Ingresso Cinema', 9, 8),
(180.00, '2025-09-20', 'Compra Shopping', 10, 8);

-- Diego (saídas, oper 9)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(180.00, '2025-09-05', 'Compra Mercado', 7, 9),
(100.00, '2025-09-10', 'Corrida Uber', 8, 9),
(140.00, '2025-09-15', 'Ingresso Cinema', 9, 9),
(130.00, '2025-09-20', 'Pedido IFood', 6, 9);

-- Eduarda (saídas, oper 10)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(220.00, '2025-09-05', 'Compra Mercado', 7, 10),
(120.00, '2025-09-10', 'Corrida Uber', 8, 10),
(160.00, '2025-09-15', 'Ingresso Cinema', 9, 10),
(140.00, '2025-09-20', 'Almoço Restaurante', 5, 10);

-- Transações de saída em fatura (4-5 por fatura, somando aos valores originais - Atualiza fatura_valor_total/orçamento via triggers)
-- Alice Julho (fatura 1, oper 11, soma 2000 - Dentro do limite 8000)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(400.00, '2025-07-05', 'Almoço Restaurante', 5, 11),
(300.00, '2025-07-10', 'Pedido IFood', 6, 11),
(500.00, '2025-07-15', 'Compra Mercado', 7, 11),
(400.00, '2025-07-20', 'Corrida Uber', 8, 11),
(400.00, '2025-07-25', 'Compra Shopping', 10, 11);

-- Alice Agosto (fatura 2, oper 12, soma 1000)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(200.00, '2025-08-05', 'Almoço Restaurante', 5, 12),
(200.00, '2025-08-10', 'Pedido IFood', 6, 12),
(300.00, '2025-08-15', 'Compra Mercado', 7, 12),
(150.00, '2025-08-20', 'Corrida Uber', 8, 12),
(150.00, '2025-08-25', 'Ingresso Cinema', 9, 12);

-- Alice Setembro (fatura 3, oper 13, soma 500 - Atualiza orçamentos)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(100.00, '2025-09-05', 'Almoço Restaurante', 5, 13),
(100.00, '2025-09-10', 'Pedido IFood', 6, 13),
(150.00, '2025-09-15', 'Compra Mercado', 7, 13),
(100.00, '2025-09-20', 'Corrida Uber', 8, 13),
(50.00, '2025-09-25', 'Ingresso Cinema', 9, 13);

-- Bruno Julho (fatura 4, oper 14, soma 1500 - Dentro do limite 6000)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(300.00, '2025-07-05', 'Almoço Restaurante', 5, 14),
(250.00, '2025-07-10', 'Pedido IFood', 6, 14),
(400.00, '2025-07-15', 'Compra Mercado', 7, 14),
(300.00, '2025-07-20', 'Corrida Uber', 8, 14),
(250.00, '2025-07-25', 'Compra Shopping', 10, 14);

-- Bruno Agosto (fatura 5, oper 15, soma 800)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(150.00, '2025-08-05', 'Almoço Restaurante', 5, 15),
(150.00, '2025-08-10', 'Pedido IFood', 6, 15),
(200.00, '2025-08-15', 'Compra Mercado', 7, 15),
(150.00, '2025-08-20', 'Corrida Uber', 8, 15),
(150.00, '2025-08-25', 'Ingresso Cinema', 9, 15);

-- Bruno Setembro (fatura 6, oper 16, soma 600)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(120.00, '2025-09-05', 'Almoço Restaurante', 5, 16),
(100.00, '2025-09-10', 'Pedido IFood', 6, 16),
(150.00, '2025-09-15', 'Compra Mercado', 7, 16),
(120.00, '2025-09-20', 'Corrida Uber', 8, 16),
(110.00, '2025-09-25', 'Ingresso Cinema', 9, 16);

-- Carla Julho (fatura 7, oper 17, soma 1800 - Dentro do limite 7000)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(350.00, '2025-07-05', 'Almoço Restaurante', 5, 17),
(300.00, '2025-07-10', 'Pedido IFood', 6, 17),
(500.00, '2025-07-15', 'Compra Mercado', 7, 17),
(350.00, '2025-07-20', 'Corrida Uber', 8, 17),
(300.00, '2025-07-25', 'Compra Shopping', 10, 17);

-- Carla Agosto (fatura 8, oper 18, soma 1200)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(250.00, '2025-08-05', 'Almoço Restaurante', 5, 18),
(200.00, '2025-08-10', 'Pedido IFood', 6, 18),
(300.00, '2025-08-15', 'Compra Mercado', 7, 18),
(250.00, '2025-08-20', 'Corrida Uber', 8, 18),
(200.00, '2025-08-25', 'Ingresso Cinema', 9, 18);

-- Carla Setembro (fatura 9, oper 19, soma 700)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(150.00, '2025-09-05', 'Almoço Restaurante', 5, 19),
(120.00, '2025-09-10', 'Pedido IFood', 6, 19),
(200.00, '2025-09-15', 'Compra Mercado', 7, 19),
(130.00, '2025-09-20', 'Corrida Uber', 8, 19),
(100.00, '2025-09-25', 'Compra Shopping', 10, 19);

-- Diego Julho (fatura 10, oper 20, soma 1600 - Dentro do limite 6500)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(300.00, '2025-07-05', 'Almoço Restaurante', 5, 20),
(250.00, '2025-07-10', 'Pedido IFood', 6, 20),
(450.00, '2025-07-15', 'Compra Mercado', 7, 20),
(300.00, '2025-07-20', 'Corrida Uber', 8, 20),
(300.00, '2025-07-25', 'Ingresso Cinema', 9, 20);

-- Diego Agosto (fatura 11, oper 21, soma 900)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(200.00, '2025-08-05', 'Almoço Restaurante', 5, 21),
(150.00, '2025-08-10', 'Pedido IFood', 6, 21),
(250.00, '2025-08-15', 'Compra Mercado', 7, 21),
(150.00, '2025-08-20', 'Corrida Uber', 8, 21),
(150.00, '2025-08-25', 'Compra Shopping', 10, 21);

-- Diego Setembro (fatura 12, oper 22, soma 400)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(80.00, '2025-09-05', 'Almoço Restaurante', 5, 22),
(70.00, '2025-09-10', 'Pedido IFood', 6, 22),
(100.00, '2025-09-15', 'Compra Mercado', 7, 22),
(80.00, '2025-09-20', 'Corrida Uber', 8, 22),
(70.00, '2025-09-25', 'Ingresso Cinema', 9, 22);

-- Eduarda Julho (fatura 13, oper 23, soma 1400 - Dentro do limite 7500)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(250.00, '2025-07-05', 'Almoço Restaurante', 5, 23),
(200.00, '2025-07-10', 'Pedido IFood', 6, 23),
(400.00, '2025-07-15', 'Compra Mercado', 7, 23),
(300.00, '2025-07-20', 'Corrida Uber', 8, 23),
(250.00, '2025-07-25', 'Compra Shopping', 10, 23);

-- Eduarda Agosto (fatura 14, oper 24, soma 1000)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(200.00, '2025-08-05', 'Almoço Restaurante', 5, 24),
(150.00, '2025-08-10', 'Pedido IFood', 6, 24),
(300.00, '2025-08-15', 'Compra Mercado', 7, 24),
(200.00, '2025-08-20', 'Corrida Uber', 8, 24),
(150.00, '2025-08-25', 'Ingresso Cinema', 9, 24);

-- Eduarda Setembro (fatura 15, oper 25, soma 550)
INSERT INTO transacao (transacao_valor, transacao_data, transacao_descricao, fk_id_categoria, fk_id_operacao) VALUES
(110.00, '2025-09-05', 'Almoço Restaurante', 5, 25),
(100.00, '2025-09-10', 'Pedido IFood', 6, 25),
(150.00, '2025-09-15', 'Compra Mercado', 7, 25),
(110.00, '2025-09-20', 'Corrida Uber', 8, 25),
(80.00, '2025-09-25', 'Compra Shopping', 10, 25);

-- ========================================
-- Pagamentos de Fatura (5 Inserções - Um para cada fatura de julho, fechando-as via trigger)
-- ========================================
INSERT INTO pagamento_fatura (pagamento_fatura_data, fk_id_conta, fk_id_fatura) VALUES
('2025-08-05', 1, 1), -- Alice paga julho (debita 2000 do saldo, fecha fatura)
('2025-08-05', 2, 4), -- Bruno paga julho (debita 1500)
('2025-08-05', 3, 7), -- Carla paga julho (debita 1800)
('2025-08-05', 4, 10), -- Diego paga julho (debita 1600)
('2025-08-05', 5, 13); -- Eduarda paga julho (debita 1400)

-- ========================================
-- Atualização final de status para faturas de agosto (simulando o EVENT de atraso)
-- ========================================
UPDATE fatura SET fk_id_status = 3 WHERE id_fatura IN (2, 5, 8, 11, 14); -- Marca como atrasadas (agosto)
