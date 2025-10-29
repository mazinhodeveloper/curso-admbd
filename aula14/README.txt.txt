Aula 14 
Professor: Celso  
Data: 16/07/2025 


MySQL Workbench 
USER: root 
PASS: senac 
HOST: localhost:3307 

 
--
-- CREATE FUNCTION calcular_desconto AND imc 
--
USE financeiro; 
CREATE FUNCTION calcular_desconto(valor DECIMAL(10,2), percentual INT) RETURNS DECIMAL(10,2) RETURN valor - (valor * percentual / 100); 
SELECT calcular_desconto(100, 10); -- Resultado: 90.00


CREATE FUNCTION imc(peso DECIMAL(10,2), altura DECIMAL(10,2)) RETURNS DECIMAL(10,2) RETURN peso / (altura*altura); 
SELECT imc(95,1.75); 
SELECT imc(60,1.74); 



--
-- CREATE TABLE funcionários 
--
USE financeiro; 
CREATE TABLE `funcionarios` (
  `id_funcionario` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `salario` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
INSERT INTO `funcionarios` (`id_funcionario`, `nome`, `salario`) VALUES
(1, 'José Ferreira da SIlva', 3500),
(2, 'João Saldanha', 5000),
(3, 'Maria da SIlva', 3500);
 
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`id_funcionario`);
ALTER TABLE `funcionarios`
  MODIFY `id_funcionario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;



--
-- CREATE FUNCTION  
--
USE financeiro; 
CREATE FUNCTION fn_verSalario (a SMALLINT)
RETURNS VARCHAR(60)
RETURN
(SELECT CONCAT('O salario de ', nome, ' é ', salario)
FROM funcionarios
WHERE id_funcionario  = a);
 
SELECT fn_verSalario (2) AS Resultado;
SELECT fn_verSalario(3) AS Resultado;
 
--
-- CREATE PROCEDURE  
--
CREATE PROCEDURE ContaFuncionarios(OUT quantidade INT)
SELECT COUNT(*) INTO quantidade FROM funcionarios;
 
-- Para executar:
CALL ContaFuncionarios(@total);
SELECT @total;


--
-- SELECT / FORMAT   
--
USE financeiro; 
SELECT nome,FORMAT(salario,2,'de_DE') as remuneracao FROM funcionarios; 



-- 
-- VIEWS 
-- 
USE financeiro; 
CREATE VIEW contato AS 
SELECT nome_fornecedor,celular,email FROM fornecedores; 

SELECT * FROM contato;


-- 
-- TRIGGERS 
-- 



--
-- Banco de dados: `bancsenac`
--
CREATE DATABASE bancsenac; 

-- --------------------------------------------------------
USE bancsenac; 

--
-- Estrutura para tabela `clientes`
--
CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nome_cliente` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `celular` varchar(20) NOT NULL,
  `agencia` varchar(8) NOT NULL,
  `conta` varchar(6) NOT NULL,
  `digito` varchar(1) NOT NULL,
  `saldo_atual` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
 
INSERT INTO `clientes` (`id_cliente`, `nome_cliente`, `email`, `celular`, `agencia`, `conta`, `digito`, `saldo_atual`) VALUES
(1, 'Bill Gates', 'bill@microsoft.com', '(11) 99999-9999', '98765', '123456', '7', 0);



--
-- Estrutura para tabela `movimentacao`
--

CREATE TABLE `movimentacao` (
  `id_movimento` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `data` date NOT NULL,
  `descricao` varchar(40) NOT NULL,
  `valor` float NOT NULL,
  `D_C` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);
 
ALTER TABLE `movimentacao`
  ADD PRIMARY KEY (`id_movimento`);
 
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
 
ALTER TABLE `movimentacao`
  MODIFY `id_movimento` int(11) NOT NULL AUTO_INCREMENT;


--
-- CREATE TRIGGER 
--
DELIMITER $$

CREATE TRIGGER atualiza_saldo_cliente
AFTER INSERT ON movimentacao
FOR EACH ROW
BEGIN
  IF NEW.d_c = 'C' THEN
    UPDATE clientes
    SET saldo_atual = saldo_atual + NEW.valor
    WHERE id_cliente = NEW.id_cliente;
  ELSEIF NEW.d_c = 'D' THEN
    UPDATE clientes
    SET saldo_atual = saldo_atual - NEW.valor
    WHERE id_cliente = NEW.id_cliente;
  END IF;

END$$
 
/* 
Tradução:
Cria Gatilho atualiza_saldo_cliente
Após o INSERT da tabela movimentacao
FOR EACH ROW // Aqui inicia o processo
BEGIN
  IF NEW.d_c = 'C' THEN // if, significa "SE"
    UPDATE clientes
    SET saldo_atual = saldo_atual + NEW.valor
    WHERE id_cliente = NEW.id_cliente;
  ELSEIF NEW.d_c = 'D' THEN // ELSEIF nesse caso significa, caso contrário
    UPDATE clientes
    SET saldo_atual = saldo_atual - NEW.valor
    WHERE id_cliente = NEW.id_cliente;
  END IF;
*/ 

--
-- INSERT INTO movimentacao  
--
USE bancsenac; 

INSERT INTO movimentacao (id_cliente, data, descricao, valor, D_C) VALUES
(1, '2025-07-10', 'Depósito Inicial', 10000.00, 'C'),
(1, '2025-07-11', 'Pagamento Conta Luz', 250.75, 'D'),
(1, '2025-07-12', 'Recebimento Freelance', 1500.00, 'C'),
(1, '2025-07-13', 'Compra Online', 300.99, 'D'),
(1, '2025-07-14', 'Transferência Recebida', 500.00, 'C'); 




--
-- CHATGPT 
--
https://chatgpt.com 
Criar uma interface HTML com ajuda do chatgpt. Coloque esse prompt:
Observe o script a seguir: quero que baseado nele, crie um formulário html com bootstrap para inclusão do fornecedor e quero que quando digitar o cep, atualize o logradouro, bairro, cidade e estado através da API do viacep: CREATE TABLE `fornecedores` ( 
  `nome_fornecedor` varchar(80) NOT NULL, 
  `cpf_cnpj` varchar(25) NOT NULL, 
  `celular` varchar(15) NOT NULL, 
  `email` varchar(100) NOT NULL, 
  `cep` varchar(10) NOT NULL, 
  `logradouro` varchar(60) NOT NULL, 
  `numero` varchar(15) NOT NULL, 
  `complemento` varchar(15) NOT NULL, 
  `bairro` varchar(50) NOT NULL, 
  `cidade` varchar(50) NOT NULL, 
  `estado` varchar(2) NOT NULL, 
  `contato` varchar(50) NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; 



 

--
-- ATIVIDADE 
--
Atividades:
Sabendo criar um banco de dados e tabelas, fazer relacionamentos, o CRUD, funções, procedures, trigges e views,
Vamos implementar uma loja virtual, abastecendo estoque e deduzindo na venda? Trabalho em grupo.
 



















































-----------------------------  OLD CLASS ----------   


EXEMPLOS: 
SELECT * FROM tipos_pagamento t INNER JOIN plano_contas p ON t.id_contas=p.id_contas; 
SELECT * FROM tipos_pagamento t LEFT JOIN plano_contas p ON t.id_contas=p.id_contas; 



AULA: 
CREATE DATABASE teste_join; 

USE teste_join; 

CREATE TABLE `dependentes` (
  `id_dependente` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `id_titular` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
--
-- Despejando dados para a tabela `dependentes`
--
 
INSERT INTO `dependentes` (`id_dependente`, `nome`, `id_titular`) VALUES
(10, 'Julia Clara', 1),
(11, 'Lucas Silva', 2),
(12, 'Sofia Mendes', 3),
(13, 'Pedro Torres', 4),
(14, 'João Souza', 999),
(15, 'Lara Lima', NULL);
 
-- --------------------------------------------------------
--
-- Estrutura para tabela `parentesco`
--
 
CREATE TABLE `parentesco` (
  `id_dependente` int(11) NOT NULL,
  `grau` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
--
-- Despejando dados para a tabela `parentesco`
--
INSERT INTO `parentesco` (`id_dependente`, `grau`) VALUES
(10, 'Filha'),
(11, 'Filho'),
(12, 'Filha'),
(15, 'Enteada'),
(16, 'Sobrinha');
 
-- --------------------------------------------------------
--
-- Estrutura para tabela `titulares`
--
 
CREATE TABLE `titulares` (
  `id_titular` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
--
-- Despejando dados para a tabela `titulares`
--
 
INSERT INTO `titulares` (`id_titular`, `nome`) VALUES
(1, 'Ana Clara'),
(2, 'Bruno Silva'),
(3, 'Carlos Mendes'),
(4, 'Daniela Torres'),
(5, 'Eduardo Lima');
 
--
-- Índices para tabelas despejadas
--
 
--
-- Índices de tabela `dependentes`
--
ALTER TABLE `dependentes`
  ADD PRIMARY KEY (`id_dependente`);
 
--
-- Índices de tabela `parentesco`
--
ALTER TABLE `parentesco`
  ADD PRIMARY KEY (`id_dependente`);
 
--
-- Índices de tabela `titulares`
--
ALTER TABLE `titulares`
  ADD PRIMARY KEY (`id_titular`);


SHOW DATABASES; 


EXEMPLOS DA AULA: 

SELECT d.nome AS dependentes, t.nome AS titular FROM dependentes d INNER JOIN titulares t ON d.id_titular = t.id_titular; 

SELECT d.nome AS dependentes, t.nome AS titular FROM dependentes d LEFT JOIN titulares t ON d.id_titular = t.id_titular; 

SELECT d.nome AS dependentes, t.nome AS titular FROM dependentes d RIGHT JOIN titulares t ON d.id_titular = t.id_titular; 

SELECT d.nome AS dependentes, t.nome AS titular FROM dependentes d LEFT JOIN titulares t ON d.id_titular = t.id_titular 
UNION 
SELECT d.nome AS dependentes, t.nome AS titular FROM dependentes d RIGHT JOIN titulares t ON d.id_titular = t.id_titular; 


SELECT * FROM dependentes; 
SELECT * FROM parentesco; 
SELECT * FROM titulares; 



-- 
-- ------------------------------------------------------------
--

AULA: 
CREATE DATABASE financeiro; 

USE financeiro; 

CREATE TABLE `plano_contas` (
  `id_conta` int(11) NOT NULL,
  `codigo_conta` varchar(20) NOT NULL,
  `descricao_conta` varchar(100) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `grupo` varchar(50) DEFAULT NULL,
  `ordem` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
 
--
-- Despejando dados para a tabela `plano_contas`
--
 
INSERT INTO `plano_contas` (`id_conta`, `codigo_conta`, `descricao_conta`, `tipo`, `grupo`, `ordem`) VALUES
(1, '1.01', 'Receita de Vendas', 'Receita', 'VENDAS', 1),
(2, '2.01', 'Custo das Mercadorias Vendidas (CMV)', 'Despesa', 'CMV', 2),
(3, '3.00', 'Margem Bruta', 'Resultado', 'MARGEM BRUTA', 3),
(4, '4.01', 'Despesas Administrativas', 'Despesa', 'DESPESAS OPERACIONAIS', 4),
(5, '4.02', 'Despesas Comerciais', 'Despesa', 'DESPESAS OPERACIONAIS', 4),
(6, '5.01', 'Juros sobre Empréstimos', 'Despesa', 'DESPESAS FINANCEIRAS', 5),
(7, '6.01', 'Rendimentos Aplicações', 'Receita', 'RECEITAS FINANCEIRAS', 6),
(8, '7.01', 'Impostos Federais', 'Despesa', 'IMPOSTOS', 7),
(9, '7.02', 'Impostos Estaduais', 'Despesa', 'IMPOSTOS', 7),
(10, '8.00', 'Lucro ou Prejuízo do Exercício', 'Resultado', 'LUCRO/PREJUÍZO', 8);
 
-- --------------------------------------------------------
 
--
-- Estrutura para tabela `tipo_pagamentos`
--
 
CREATE TABLE `tipo_pagamentos` (
  `id_tipo_pagto` int(11) NOT NULL,
  `descricao_tipo` varchar(40) NOT NULL,
  `id_conta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
--
-- Despejando dados para a tabela `tipo_pagamentos`
--
 
INSERT INTO `tipo_pagamentos` (`id_tipo_pagto`, `descricao_tipo`, `id_conta`) VALUES
(1, 'MERCADORIA - PRODUÇÃO', 2),
(2, 'MANUTENÇÃO ', NULL),
(4, 'MATERIAL DE ESCRITÓRIO', NULL),
(5, 'ENERGIA ELÉTRICA - 1', NULL),
(6, 'SALÁRIOS - ALVORADA 1', NULL),
(7, 'SIMPLES NACIONAL - 1 & PRODUÇÃO', NULL),
(8, 'FGTS - 1', NULL),
(9, 'INSS - 1', NULL),
(11, 'CONTABILIDADE - 1', NULL),
(12, 'MATERIAL DE LIMPEZA - 1', NULL),
(13, 'EMBALAGEM - PRODUÇÃO', NULL),
(14, 'SABESP - 1', NULL),
(15, 'TELEFONE/INTERNET', NULL),
(16, 'COMBUSTÍVEL CRECHE', NULL),
(17, 'MERCADORIA - ALVORADA 1', 2),
(18, 'MERCADORIA - ALVORADA 2', 2),
(19, 'SALÁRIOS - ALVORADA 2', NULL),
(20, 'SALÁRIOS - PRODUÇÃO', NULL),
(21, 'ADIANTAMENTO - 1', NULL),
(22, 'ADIANTAMENTO - 2', NULL),
(23, 'ADIANTAMENTO - PRODUÇÃO', NULL),
(24, 'ENERGIA ELÉTRICA - 2', NULL),
(25, 'ENERGIA ELÉTRICA - PRODUÇÃO', NULL),
(26, 'SABESP - 2', NULL),
(27, 'SABESP - PRODUÇÃO ', NULL),
(28, 'SIMPLES NACIONAL - 2', NULL),
(29, 'FGTS - 2', NULL),
(30, 'FGTS - PRODUÇÃO', NULL),
(31, 'INSS - 2', NULL),
(32, 'INSS - PRODUÇÃO ', NULL),
(33, 'CONTABILIDADE - 2', NULL),
(34, 'MATERIAL DE LIMPEZA - 2', NULL),
(35, 'EMPRÉSTIMO - 1', NULL),
(36, 'EMPRÉSTIMO - 2', NULL),
(37, 'EMPRÉSTIMO - PRODUÇÃO', NULL),
(38, 'EMBALAGEM - 1', NULL),
(39, 'EMBALAGEM - 2', NULL),
(40, 'ALUGUEL - ALVORADA 2', NULL),
(43, 'SEGURO CARRO', NULL),
(44, 'CAFÉ DA MANHÃ', NULL),
(45, 'VALE TRANSPORTE', NULL),
(46, 'TARIFA DE OPERAÇÃO DE CARTÃO', NULL);
 
--
-- Índices para tabelas despejadas
--
 
--
-- Índices de tabela `plano_contas`
--
ALTER TABLE `plano_contas`
  ADD PRIMARY KEY (`id_conta`);
 
--
-- Índices de tabela `tipo_pagamentos`
--
ALTER TABLE `tipo_pagamentos`
  ADD PRIMARY KEY (`id_tipo_pagto`),
  ADD KEY `id_conta` (`id_conta`);
 
--
-- AUTO_INCREMENT para tabelas despejadas
--
 
--
-- AUTO_INCREMENT de tabela `plano_contas`
--
ALTER TABLE `plano_contas`
  MODIFY `id_conta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
 
--
-- AUTO_INCREMENT de tabela `tipo_pagamentos`
--
ALTER TABLE `tipo_pagamentos`
  MODIFY `id_tipo_pagto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
 
--
-- Restrições para tabelas despejadas
--
 
--
-- Restrições para tabelas `tipo_pagamentos`
--
ALTER TABLE `tipo_pagamentos`
  ADD CONSTRAINT `tipo_pagamentos_ibfk_1` FOREIGN KEY (`id_conta`) REFERENCES `plano_contas` (`id_conta`);





USE financeiro; 

SELECT * FROM plano_contas; 

SELECT * FROM tipo_pagamentos; 




USE financeiro; 

SELECT t.descricao_conta AS conta, p.descricao_tipo AS tipo FROM tipo_pagamentos p INNER JOIN plano_contas t ON p.id_conta = t.id_conta; 
SELECT t.descricao_conta AS conta, p.descricao_tipo AS tipo FROM tipo_pagamentos p LEFT JOIN plano_contas t ON p.id_conta = t.id_conta; 
SELECT t.descricao_conta AS conta, p.descricao_tipo AS tipo FROM tipo_pagamentos p RIGHT JOIN plano_contas t ON p.id_conta = t.id_conta; 

SELECT t.descricao_conta AS conta, p.descricao_tipo AS tipo FROM tipo_pagamentos p LEFT JOIN plano_contas t ON p.id_conta = t.id_conta 
UNION 
SELECT t.descricao_conta AS conta, p.descricao_tipo AS tipo FROM tipo_pagamentos p RIGHT JOIN plano_contas t ON p.id_conta = t.id_conta; 






--
-- CREATE TABLE `fornecedores`
--


CREATE TABLE `fornecedores` (
  `id_fornecedor` int(11) NOT NULL,
  `nome_fornecedor` varchar(80) NOT NULL,
  `cpf_cnpj` varchar(25) NOT NULL,
  `celular` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `cep` varchar(10) NOT NULL,
  `logradouro` varchar(60) NOT NULL,
  `numero` varchar(15) NOT NULL,
  `complemento` varchar(15) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `contato` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
--
-- Despejando dados para a tabela `fornecedores`
--
 
INSERT INTO `fornecedores` (`id_fornecedor`, `nome_fornecedor`, `cpf_cnpj`, `celular`, `email`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `contato`) VALUES
(1, 'da Costa', '80.759.264/0001-62', '+55 84 2375-945', '', '46610935', 'Feira das Neves', '76', '', 'Andiroba', 'Peixoto do Norte', 'CE', 'Ana Lívia - +55 (084) 4278 7890'),
(2, 'Sales Ltda.', '47.063.182/0001-03', '+55 81 0665 030', 'erickda-paz@freitas.com', '76104714', 'Via Silveira', '31', '', 'Itatiaia', 'Barbosa', 'AL', 'Juan - +55 71 8559-0977'),
(3, 'Moura', '823.749.065-74', '+55 81 5551-590', '', '22945-682', 'Condomínio Bárbara Duarte', '5', '', 'Conjunto São Francisco De Assis', 'Jesus', 'MG', 'Rafael - (031) 6118 7755'),
(4, 'Rocha S/A', '76.028.145/0001-62', '0300 611 1330', 'castroyuri@bol.com.br', '77936-153', 'Trecho Sophie da Cunha', '63', '', 'Canaa', 'Araújo', 'PE', 'Ana Sophia - +55 (081) 1764-3039'),
(5, 'Cavalcanti da Paz - ME', '65.204.317/0001-95', '71 6875 7738', '', '05550824', 'Distrito de Nascimento', '247', '', 'Virgínia', 'Silveira', 'AL', 'Cauê - +55 21 2040-7522'),
(6, 'Moura', '860.479.521-94', '+55 (084) 4896-', 'almeidaolivia@jesus.org', '17446-660', 'Via Costela', '64', '', 'Barão Homem De Melo 3ª Seção', 'Rocha', 'PA', 'Gustavo Henrique - (084) 9125-6097'),
(7, 'Ramos', '01.768.942/0001-87', '0900-251-8536', '', '10979-519', 'Conjunto Yago Gonçalves', '9', '', 'Belvedere', 'Azevedo', 'SE', 'Yuri - (031) 5375-1007'),
(8, 'Araújo', '83.905.472/0001-10', '(041) 1269 6116', 'peixotosophie@araujo.br', '75415115', 'Alameda de Monteiro', '12', '', 'Palmeiras', 'Moreira', 'AP', 'Juliana - +55 (011) 3031-0450'),
(9, 'da Conceição da Mata - ME', '175.829.034-04', '(071) 7448 5291', '', '89426223', 'Rodovia Luigi Duarte', '64', '', 'Nova Gameleira', 'Costela', 'RN', 'Augusto - 61 1126 4862'),
(10, 'Jesus', '51.379.208/0001-02', '81 0657 3547', 'yasmincavalcanti@correia.com', '62662-375', 'Distrito de Moraes', '81', '', 'Vila Rica', 'Gonçalves', 'AC', 'Maria - (041) 9703-4148'),
(11, 'Pereira Ribeiro S/A', '73.625.041/0001-47', '+55 (061) 0468 ', '', '54391-014', 'Setor Rodrigo Costa', '232', '', 'Nova Esperança', 'Gomes do Galho', 'BA', 'Isabella - 41 3816-8644'),
(12, 'Moura', '928.056.317-30', '+55 84 8457 637', 'ccaldeira@yahoo.com.br', '70930576', 'Rua Campos', '7', '', 'Ademar Maldonado', 'Barbosa do Campo', 'RN', 'Alexandre - +55 81 4329-4316'),
(13, 'Melo', '62.537.914/0001-43', '+55 (011) 8523-', '', '76337-390', 'Área Lucas Gabriel Cardoso', '15', '', 'Vila Piratininga', 'Dias', 'RN', 'Noah - 0800-184-5670'),
(14, 'Ramos', '74.912.503/0001-70', '+55 (071) 2504 ', 'ddas-neves@mendes.com', '58754-080', 'Núcleo Cardoso', '68', '', 'Corumbiara', 'Fernandes', 'RO', 'Natália - (031) 4864 7530'),
(15, 'Vieira', '107.356.892-02', '(051) 7111-3126', '', '79168602', 'Residencial das Neves', '64', '', 'Lagoinha Leblon', 'Cavalcanti da Prata', 'MA', 'Larissa - 71 3478-9784'),
(16, 'Dias', '01.875.369/0001-00', '(011) 0886 0164', 'lorenzo84@duarte.org', '35749-220', 'Rodovia de Martins', '19', '', 'Xodo-Marize', 'Novaes', 'BA', 'João Gabriel - 31 1237-9332'),
(17, 'Nogueira Moraes - EI', '92.704.681/0001-97', '(051) 4038-2778', '', '14296-354', 'Avenida Kaique Azevedo', '63', '', 'Santa Efigênia', 'das Neves de Ferreira', 'MS', 'Maria Clara - +55 (031) 4059-8025'),
(18, 'Rodrigues e Filhos', '093.861.257-30', '(084) 6237 6254', 'natalia66@oliveira.br', '91662082', 'Viaduto de Silva', '61', '', 'Floramar', 'Farias', 'AC', 'Joaquim - 84 2169-1972'),
(19, 'Fernandes Ltda.', '60.837.249/0001-88', '+55 (021) 7385-', '', '60484-870', 'Travessa de Vieira', '80', '', 'Morro Dos Macacos', 'Nunes', 'MS', 'Catarina - +55 (071) 0404 9438'),
(20, 'Nogueira', '43.192.750/0001-15', '+55 (021) 5090-', 'pedro76@bol.com.br', '20290-725', 'Recanto Fernandes', '931', '', 'Nova Granada', 'Freitas da Serra', 'PE', 'Joaquim - +55 (084) 2918 8966'),
(21, 'Lima', '406.752.931-70', '(081) 3620 8296', '', '70869-305', 'Esplanada de da Mota', '17', '', 'Vila Ouro Minas', 'Duarte', 'GO', 'João Lucas - 84 1973 7813'),
(22, 'Pires Campos - ME', '64.832.750/0001-02', '(041) 0704 3666', 'rezendethales@bol.com.br', '94506782', 'Chácara Monteiro', '20', '', 'Custodinha', 'Viana', 'PR', 'Bryan - (051) 0562 4629'),
(23, 'Nunes Lima - EI', '02.813.947/0001-47', '51 2591 1824', '', '45448727', 'Distrito de Azevedo', '128', '', 'Luxemburgo', 'Cardoso do Oeste', 'RS', 'Vitória - (051) 9378-2527'),
(24, 'Viana S/A', '850.679.321-12', '0300 756 8512', 'da-matanicole@hotmail.com', '59306046', 'Trevo da Cunha', '71', '', 'Barão Homem De Melo 2ª Seção', 'Moraes de Fernandes', 'RO', 'Pedro Henrique - 0300 762 0743'),
(25, 'Campos', '51.802.673/0001-04', '0800-057-8771', '', '86408115', 'Colônia Brenda Azevedo', '58', '', 'Aparecida 7ª Seção', 'Nascimento', 'MT', 'Ian - 81 2222-3950'),
(26, 'Novaes', '03.852.619/0001-12', '11 3267 5926', 'isisalmeida@da.com', '05800019', 'Distrito de da Costa', '70', '', 'Olhos Dágua', 'Farias Grande', 'MS', 'Daniela - +55 11 8612-6951'),
(27, 'Pinto', '376.198.540-10', '+55 61 4858-099', '', '40956180', 'Passarela Araújo', '76', '', 'Nova Vista', 'Ramos', 'RN', 'Beatriz - +55 (031) 2576-2948'),
(28, 'Moura Ltda.', '25.784.013/0001-20', '+55 (051) 9546-', 'yfogaca@monteiro.com', '20696-711', 'Setor Mirella Vieira', '32', '', 'Dona Clara', 'Dias', 'AC', 'Emanuella - +55 84 7594 5164'),
(29, 'Mendes Santos Ltda.', '82.657.490/0001-68', '41 5678 4661', '', '20998139', 'Trevo de Silva', '5', '', 'Vila Madre Gertrudes 1ª Seção', 'Nascimento', 'AP', 'Yasmin - +55 (051) 0157 5175'),
(30, 'Rodrigues', '321.647.089-03', '41 6937-6409', 'cda-cunha@nascimento.br', '38707-914', 'Residencial de Vieira', '57', '', 'Conjunto Serra Verde', 'Viana', 'MS', 'Ian - (031) 9271 1769');
 
 
-- ALTER TABLE `fornecedores` MODIFY `id_fornecedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

-- 
--- SELECTS 
--

USE financeiro; 

SELECT nome_fornecedor,celular,email FROM `fornecedores` WHERE celular LIKE '%11%'; 

SELECT * FROM fornecedores; 



SELECT nome_fornecedor,celular,email FROM `fornecedores` WHERE celular LIKE '%11%'; 

SELECT nome_fornecedor,celular,email,cep,estado FROM `fornecedores` where estado='BA' or estado='CE' or estado='PA'; 
 
SELECT nome_fornecedor,celular,email,cep,estado FROM `fornecedores` where estado in('BA','CE','PA'); 

SELECT * FROM fornecedores WHERE bairro='andiroba'; 




USE financeiro ;

-- 
-- tabela centro de custos 
-- 
CREATE TABLE `centro_custos` ( 
  `id_centro_custos` int(11) NOT NULL AUTO_INCREMENT, 
  `descricao_centro_custos` varchar(50) DEFAULT NULL, 
  PRIMARY KEY (`id_centro_custos`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 

-- SELECT * FROM centro_custos; 
TRUNCATE centro_custos; 
INSERT INTO `centro_custos` VALUES (1,'Produção'),(2,'Alvorada 1'),(3,'Alvorada 2'); 

SELECT * FROM centro_custos; 



-- 
-- Tabela pagamentos 
-- 
CREATE TABLE `pagamentos` (
  `id_pagamento` int(11) NOT NULL AUTO_INCREMENT, 
  `id_fornecedor` int(11) NOT NULL DEFAULT '0', 
  `data_vcto` date NOT NULL, 
  `valor` float NOT NULL DEFAULT '0', 
  `data_pagto` date NOT NULL, 
  `valor_pago` float NOT NULL DEFAULT '0', 
  `descricao` varchar(80) NOT NULL, 
  `id_tipo_pagto` int(11) NOT NULL DEFAULT '0', 
  `id_forma_pagto` int(11) NOT NULL DEFAULT '0', 
  `oculto` int(11) NOT NULL DEFAULT '0', 
  `id_usuario` int(11) NOT NULL DEFAULT '0', 
  `data_exclusao` date NOT NULL, 
  `id_centro_custos` int(11) NOT NULL DEFAULT '0', 
  PRIMARY KEY (`id_pagamento`) 
) ENGINE=InnoDB CHARSET=utf8mb4; 


INSERT INTO `pagamentos` VALUES (102,15,'2025-05-25',383.79,'2025-05-25',383.79,'',17,5,0,0,'0000-00-00',2),(103,16,'2025-05-26',242.5,'2025-05-26',242.5,'',17,5,0,0,'0000-00-00',2),(104,15,'2025-05-25',361.75,'2025-05-25',361.75,'',17,5,0,0,'0000-00-00',2),(105,17,'2025-05-26',436,'2025-05-27',457,'',17,5,0,0,'0000-00-00',2),(106,18,'2025-05-26',2999.61,'2025-05-26',2999.61,'',17,5,0,0,'0000-00-00',2),(107,19,'2025-05-26',546.11,'2025-05-27',557,'',17,5,0,0,'0000-00-00',2),(108,20,'2025-05-25',1145.4,'2025-05-25',1145.4,'',17,5,0,0,'0000-00-00',2),(109,21,'2025-05-26',1353.73,'2025-05-26',1353.73,'',17,5,0,0,'0000-00-00',2),(110,12,'2025-05-26',1032,'2025-05-26',1032,'',17,5,0,0,'0000-00-00',2),(111,22,'2025-05-26',933.6,'2025-05-26',933.6,'',17,5,0,0,'0000-00-00',2),(112,26,'2025-05-25',2193.92,'2025-05-25',2193.92,'',17,5,0,0,'0000-00-00',2),(113,23,'2025-05-24',2548.17,'2025-05-24',2548.17,'',17,5,0,0,'0000-00-00',2),(115,24,'2025-05-26',293.68,'2025-05-26',293.68,'',17,5,0,0,'0000-00-00',2),(116,25,'2025-05-26',332.3,'2025-05-26',332.3,'',17,5,0,0,'0000-00-00',2),(117,27,'2025-05-26',1412.44,'2025-05-26',1412.44,'',17,5,0,0,'0000-00-00',2),(118,28,'2025-05-24',1380,'2025-05-24',1380,'',17,5,0,0,'0000-00-00',2),(119,29,'2025-05-24',511.04,'2025-05-24',511.04,'',17,5,0,0,'0000-00-00',2),(120,29,'2025-05-24',203.39,'2025-05-24',203.39,'',17,5,0,0,'0000-00-00',2),(121,30,'2025-05-26',1077.59,'2025-05-26',1077.59,'Manutenção - balcão açougue',17,5,0,0,'0000-00-00',2),(122,31,'2025-05-26',1132.49,'2025-05-26',1132.49,'',17,5,0,0,'0000-00-00',2),(124,14,'2025-05-26',5822.99,'2025-05-26',5822.99,'',5,8,0,0,'0000-00-00',2),(126,41,'2025-05-26',486.96,'2025-05-26',486.96,'EXTRA - ZAINE',6,1,0,0,'0000-00-00',2),(127,41,'2025-06-02',486.96,'2025-06-02',486.96,'EXTRA - ZAINE',6,1,0,0,'0000-00-00',2),(128,41,'2025-06-09',486.96,'2025-06-09',486.96,'EXTRA - ZAINE',6,1,0,0,'0000-00-00',2),(129,42,'2025-05-26',2035,'2025-05-26',2035,'PAGAMENTO SEMANAL',6,1,0,0,'0000-00-00',2),(130,43,'2025-05-26',700,'2025-05-26',700,'PAGAMENTO SEMANAL',6,2,0,0,'0000-00-00',2),(131,45,'2025-05-26',630,'2025-05-26',630,'PAGAMENTO SEMANAL',6,1,0,0,'0000-00-00',2),(132,44,'2025-05-26',875,'2025-05-26',875,'PAGAMENTO SEMANAL',6,1,0,0,'0000-00-00',2),(133,47,'2025-05-25',492,'2025-05-25',492,'CARTÃO DE CRÉDITO - 25',18,8,0,0,'0000-00-00',2),(134,16,'2025-05-26',413,'2025-05-26',413,'',18,5,0,0,'0000-00-00',3),(135,48,'2025-05-26',391.6,'2025-05-26',391.6,'',18,5,0,0,'0000-00-00',3),(136,38,'2025-05-26',972.59,'2025-05-26',972.59,'',18,5,0,0,'0000-00-00',3),(137,36,'2025-05-26',868.06,'2025-05-26',868.06,'',18,5,0,0,'0000-00-00',3),(138,20,'2025-05-26',317.18,'2025-05-26',317.18,'',18,5,0,0,'0000-00-00',3),(140,37,'2025-05-26',3458,'2025-05-26',3458,'',18,5,0,0,'0000-00-00',3),(142,51,'2025-05-26',1750,'2025-05-26',1750,'PAGAMENTO SEMANAL',19,1,0,0,'0000-00-00',3),(143,51,'2025-05-26',400,'2025-05-26',400,'FERIADO - 01/05',19,1,0,0,'0000-00-00',3),(144,47,'2025-05-25',492,'2025-05-25',492,'CARTÃO DE CRÉDITO - 25',18,1,0,0,'0000-00-00',3),(158,50,'2025-05-24',4457.53,'2025-05-24',4457.53,'',18,5,0,0,'0000-00-00',3)



-- 
-- REEDITED 
-- 

USE financeiro ;

-- SELECT * FROM centro_custos; 
-- SELECT * FROM pagamentos; 
-- TRUNCATE centro_custos; 
-- INSERT INTO `centro_custos` VALUES (1,'Produção'),(2,'Alvorada 1'),(3,'Alvorada 2'); 

-- SELECT * FROM centro_custos; 
/*
CREATE TABLE `pagamentos` (
  `id_pagamento` int(11) NOT NULL,
  `id_fornecedor` int(11) NOT NULL DEFAULT 0,
  `data_vcto` date NOT NULL,
  `valor` float NOT NULL DEFAULT 0,
  `data_pagto` date NOT NULL,
  `valor_pago` float NOT NULL DEFAULT 0,
  `descricao` varchar(80) NOT NULL,
  `id_tipo_pagto` int(11) NOT NULL DEFAULT 0,
  `id_forma_pagto` int(11) NOT NULL DEFAULT 0,
  `oculto` int(11) NOT NULL DEFAULT 0,
  `id_usuario` int(11) NOT NULL DEFAULT 0,
  `data_exclusao` date NOT NULL,
  `id_centro_custos` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
*/ 
--
-- Despejando dados para a tabela `pagamentos`
--
 


-- TRUNCATE pagamentos; 
-- SELECT * FROM pagamentos; 

/*
INSERT INTO `pagamentos` (`id_pagamento`, `id_fornecedor`, `data_vcto`, `valor`, `data_pagto`, `valor_pago`, `descricao`, `id_tipo_pagto`, `id_forma_pagto`, `oculto`, `id_usuario`, `data_exclusao`, `id_centro_custos`) VALUES
(102, 15, '2025-05-25', 383.79, '2025-05-25', 383.79, '', 17, 5, 0, 0, '2025-06-25', 2),
(103, 16, '2025-05-26', 242.5, '2025-05-26', 242.5, '', 17, 5, 0, 0, '2025-06-25', 2),
(104, 15, '2025-05-25', 361.75, '2025-05-25', 361.75, '', 17, 5, 0, 0, '2025-06-25', 2),
(105, 17, '2025-05-26', 436, '2025-05-27', 457, '', 17, 5, 0, 0, '2025-06-25', 2); 
*/ 

/* 
INSERT INTO `pagamentos` (`id_pagamento`, `id_fornecedor`, `data_vcto`, `valor`, `data_pagto`, `valor_pago`, `descricao`, `id_tipo_pagto`, `id_forma_pagto`, `oculto`, `id_usuario`, `data_exclusao`, `id_centro_custos`) VALUES
(106, 18, '2025-05-26', 2999.61, '2025-05-26', 2999.61, '', 17, 5, 0, 0, '2025-06-25', 2),
(107, 19, '2025-05-26', 546.11, '2025-05-27', 557, '', 17, 5, 0, 0, '2025-06-25', 2),
(108, 20, '2025-05-25', 1145.4, '2025-05-25', 1145.4, '', 17, 5, 0, 0, '2025-06-25', 2),
(109, 21, '2025-05-26', 1353.73, '2025-05-26', 1353.73, '', 17, 5, 0, 0, '2025-06-25', 2),
(110, 12, '2025-05-26', 1032, '2025-05-26', 1032, '', 17, 5, 0, 0, '2025-06-25', 2),
(111, 22, '2025-05-26', 933.6, '2025-05-26', 933.6, '', 17, 5, 0, 0, '2025-06-25', 2),
(112, 26, '2025-05-25', 2193.92, '2025-05-25', 2193.92, '', 17, 5, 0, 0, '2025-06-25', 2),
(113, 23, '2025-05-24', 2548.17, '2025-05-24', 2548.17, '', 17, 5, 0, 0, '2025-06-25', 2),
(115, 24, '2025-05-26', 293.68, '2025-05-26', 293.68, '', 17, 5, 0, 0, '2025-06-25', 2),
(116, 25, '2025-05-26', 332.3, '2025-05-26', 332.3, '', 17, 5, 0, 0, '2025-06-25', 2),
(117, 27, '2025-05-26', 1412.44, '2025-05-26', 1412.44, '', 17, 5, 0, 0, '2025-06-25', 2),
(118, 28, '2025-05-24', 1380, '2025-05-24', 1380, '', 17, 5, 0, 0, '2025-06-25', 2),
(119, 29, '2025-05-24', 511.04, '2025-05-24', 511.04, '', 17, 5, 0, 0, '2025-06-25', 2); 
*/ 

/* 
INSERT INTO `pagamentos` (`id_pagamento`, `id_fornecedor`, `data_vcto`, `valor`, `data_pagto`, `valor_pago`, `descricao`, `id_tipo_pagto`, `id_forma_pagto`, `oculto`, `id_usuario`, `data_exclusao`, `id_centro_custos`) VALUES
(120, 29, '2025-05-24', 203.39, '2025-05-24', 203.39, '', 17, 5, 0, 0, '2025-06-25', 2),
(121, 30, '2025-05-26', 1077.59, '2025-05-26', 1077.59, 'Manutenção - balcão açougue', 17, 5, 0, 0, '2025-06-25', 2),
(122, 31, '2025-05-26', 1132.49, '2025-05-26', 1132.49, '', 17, 5, 0, 0, '2025-06-25', 2),
(124, 14, '2025-05-26', 5822.99, '2025-05-26', 5822.99, '', 5, 8, 0, 0, '2025-06-25', 2),
(126, 41, '2025-05-26', 486.96, '2025-05-26', 486.96, 'EXTRA - ZAINE', 6, 1, 0, 0, '2025-06-25', 2),
(127, 41, '2025-06-02', 486.96, '2025-06-02', 486.96, 'EXTRA - ZAINE', 6, 1, 0, 0, '2025-06-25', 2),
(128, 41, '2025-06-09', 486.96, '2025-06-09', 486.96, 'EXTRA - ZAINE', 6, 1, 0, 0, '2025-06-25', 2),
(129, 42, '2025-05-26', 2035, '2025-05-26', 2035, 'PAGAMENTO SEMANAL', 6, 1, 0, 0, '2025-06-25', 2),
(130, 43, '2025-05-26', 700, '2025-05-26', 700, 'PAGAMENTO SEMANAL', 6, 2, 0, 0, '2025-06-25', 2),
(131, 45, '2025-05-26', 630, '2025-05-26', 630, 'PAGAMENTO SEMANAL', 6, 1, 0, 0, '2025-06-25', 2),
(132, 44, '2025-05-26', 875, '2025-05-26', 875, 'PAGAMENTO SEMANAL', 6, 1, 0, 0, '2025-06-25', 2),
(133, 47, '2025-05-25', 492, '2025-05-25', 492, 'CARTÃO DE CRÉDITO - 25', 18, 8, 0, 0, '2025-06-25', 2),
(134, 16, '2025-05-26', 413, '2025-05-26', 413, '', 18, 5, 0, 0, '2025-06-25', 3),
(135, 48, '2025-05-26', 391.6, '2025-05-26', 391.6, '', 18, 5, 0, 0, '2025-06-25', 3),
(136, 38, '2025-05-26', 972.59, '2025-05-26', 972.59, '', 18, 5, 0, 0, '2025-06-25', 3),
(137, 36, '2025-05-26', 868.06, '2025-05-26', 868.06, '', 18, 5, 0, 0, '2025-06-25', 3),
(138, 20, '2025-05-26', 317.18, '2025-05-26', 317.18, '', 18, 5, 0, 0, '2025-06-25', 3),
(140, 37, '2025-05-26', 3458, '2025-05-26', 3458, '', 18, 5, 0, 0, '2025-06-25', 3),
(142, 51, '2025-05-26', 1750, '2025-05-26', 1750, 'PAGAMENTO SEMANAL', 19, 1, 0, 0, '2025-06-25', 3),
(143, 51, '2025-05-26', 400, '2025-05-26', 400, 'FERIADO - 01/05', 19, 1, 0, 0, '2025-06-25', 3),
(144, 47, '2025-05-25', 492, '2025-05-25', 492, 'CARTÃO DE CRÉDITO - 25', 18, 1, 0, 0, '2025-06-25', 3),
(158, 50, '2025-05-24', 4457.53, '2025-05-24', 4457.53, '', 18, 5, 0, 0, '2025-06-25', 3);
*/ 

SELECT * FROM pagamentos;


-- 
-- TESTING 
-- 
SELECT descricao_centro_custos, ROUND(SUM(valor),2) AS total FROM pagamentos p INNER JOIN centro_custos c on c.id_centro_custos=p.id_centro_custos GROUP BY descricao_centro_custos;

ROUND (função de arredondamento)
SUM (função de soma)
 
Relacionamos as tabelas pagamentos com centro de custos
e somamos os valores agrupados pelo centro de custos.


-- 
-- Criando uma view 
-- 

USE financeiro; 
-- 
-- VIEW 
-- 
/*
CREATE VIEW custos AS SELECT descricao_centro_custos, 
ROUND(SUM(valor), 2) AS total 
FROM pagamentos p 
INNER JOIN 
centro_custos c 
ON c.id_centro_custos = p.id_centro_custos 
GROUP BY descricao_centro_custos; 

SELECT * FROM custos; 
*/ 


CREATE VIEW conta AS SELECT descricao_centro_custos, 
ROUND(COUNT(valor), 2) AS total 
FROM pagamentos p 
INNER JOIN 
centro_custos c 
ON c.id_centro_custos = p.id_centro_custos 
GROUP BY descricao_centro_custos; 

SELECT * FROM conta; 



-- 
-- BETWEEN 
-- 
SELECT * FROM pagamentos WHERE valor BETWEEN 1000 AND 3000; 

SELECT * FROM `pagamentos` WHERE data_vcto BETWEEN '2025-06-01' AND '2025-06-30'; 



-- 
-- LIMIT 
-- 
SELECT * FROM `pagamentos` LIMIT 5; 

SELECT * FROM `pagamentos` LIMIT 10; 



-- 
-- FUNCTION NOW() 
-- 
SELECT NOW() data_atual; 



-- 
-- FUNCTION CURRENT_DATE();  
-- 
SELECT CURRENT_DATE(); 


-- 
-- FUNCTION CURRENT_TIME();  
-- 
SELECT CURRENT_TIME();


-- 
-- FUNCTION CURRENT_TIMESTAMP();   
-- 
SELECT CURRENT_TIMESTAMP(); 


-- 
-- FUNCTION CURRENT_USER();  
-- 
SELECT CURRENT_USER(); 





















