-- Banco de dados: `financeiro2`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ContaFuncionarios` (OUT `quantidade` INT)   SELECT COUNT(*) INTO quantidade FROM funcionarios$$

--
-- Funções
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_desconto` (`valor` DECIMAL(10,2), `percentual` INT) RETURNS DECIMAL(10,2)  RETURN valor - (valor * percentual / 100)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_verSalario` (`a` SMALLINT) RETURNS VARCHAR(60) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  RETURN
(SELECT CONCAT('O salario de ', nome, ' é ', salario)
FROM funcionarios
WHERE id_funcionario  = a)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `imc` (`peso` DECIMAL(10,2), `altura` DECIMAL(10,2)) RETURNS DECIMAL(10,2)  RETURN peso / (altura*altura)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `centro_custos`
--

CREATE TABLE `centro_custos` (
  `id_centro_custos` int(11) NOT NULL,
  `descricao_centro_custos` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `centro_custos`
--

INSERT INTO `centro_custos` (`id_centro_custos`, `descricao_centro_custos`) VALUES
(1, 'Lapa Tito'),
(2, 'Pompeia'),
(3, 'Sipião');

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `contato`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `contato` (
`nome_fornecedor` varchar(80)
,`celular` varchar(15)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `contatof`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `contatof` (
`nome_fornecedor` varchar(80)
,`celular` varchar(15)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Estrutura para tabela `fornecedores`
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

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
  `id_funcionario` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `salario` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `funcionarios`
--

INSERT INTO `funcionarios` (`id_funcionario`, `nome`, `salario`) VALUES
(1, 'José Ferreira da SIlva', 3500),
(2, 'João Saldanha', 5000),
(3, 'Maria da SIlva', 3500);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagamentos`
--

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

--
-- Despejando dados para a tabela `pagamentos`
--

INSERT INTO `pagamentos` (`id_pagamento`, `id_fornecedor`, `data_vcto`, `valor`, `data_pagto`, `valor_pago`, `descricao`, `id_tipo_pagto`, `id_forma_pagto`, `oculto`, `id_usuario`, `data_exclusao`, `id_centro_custos`) VALUES
(102, 15, '2025-05-25', 383.79, '2025-05-25', 383.79, '', 17, 5, 0, 0, '0000-00-00', 2),
(103, 16, '2025-05-26', 242.5, '2025-05-26', 242.5, '', 17, 5, 0, 0, '0000-00-00', 2),
(104, 15, '2025-05-25', 361.75, '2025-05-25', 361.75, '', 17, 5, 0, 0, '0000-00-00', 2),
(105, 17, '2025-05-26', 436, '2025-05-27', 457, '', 17, 5, 0, 0, '0000-00-00', 2),
(106, 18, '2025-05-26', 2999.61, '2025-05-26', 2999.61, '', 17, 5, 0, 0, '0000-00-00', 2),
(107, 19, '2025-05-26', 546.11, '2025-05-27', 557, '', 17, 5, 0, 0, '0000-00-00', 2),
(108, 20, '2025-05-25', 1145.4, '2025-05-25', 1145.4, '', 17, 5, 0, 0, '0000-00-00', 2),
(109, 21, '2025-05-26', 1353.73, '2025-05-26', 1353.73, '', 17, 5, 0, 0, '0000-00-00', 2),
(110, 12, '2025-05-26', 1032, '2025-05-26', 1032, '', 17, 5, 0, 0, '0000-00-00', 2),
(111, 22, '2025-05-26', 933.6, '2025-05-26', 933.6, '', 17, 5, 0, 0, '0000-00-00', 2),
(112, 26, '2025-05-25', 2193.92, '2025-05-25', 2193.92, '', 17, 5, 0, 0, '0000-00-00', 2),
(113, 23, '2025-05-24', 2548.17, '2025-05-24', 2548.17, '', 17, 5, 0, 0, '0000-00-00', 2),
(115, 24, '2025-05-26', 293.68, '2025-05-26', 293.68, '', 17, 5, 0, 0, '0000-00-00', 2),
(116, 25, '2025-05-26', 332.3, '2025-05-26', 332.3, '', 17, 5, 0, 0, '0000-00-00', 2),
(117, 27, '2025-05-26', 1412.44, '2025-05-26', 1412.44, '', 17, 5, 0, 0, '0000-00-00', 2),
(118, 28, '2025-05-24', 1380, '2025-05-24', 1380, '', 17, 5, 0, 0, '0000-00-00', 2),
(119, 29, '2025-05-24', 511.04, '2025-05-24', 511.04, '', 17, 5, 0, 0, '0000-00-00', 2),
(120, 29, '2025-05-24', 203.39, '2025-05-24', 203.39, '', 17, 5, 0, 0, '0000-00-00', 2),
(121, 30, '2025-05-26', 1077.59, '2025-05-26', 1077.59, 'Manutenção - balcão açougue', 17, 5, 0, 0, '0000-00-00', 2),
(122, 31, '2025-05-26', 1132.49, '2025-05-26', 1132.49, '', 17, 5, 0, 0, '0000-00-00', 2),
(124, 14, '2025-05-26', 5822.99, '2025-05-26', 5822.99, '', 5, 8, 0, 0, '0000-00-00', 2),
(126, 41, '2025-05-26', 486.96, '2025-05-26', 486.96, 'EXTRA - ZAINE', 6, 1, 0, 0, '0000-00-00', 2),
(127, 41, '2025-06-02', 486.96, '2025-06-02', 486.96, 'EXTRA - ZAINE', 6, 1, 0, 0, '0000-00-00', 2),
(128, 41, '2025-06-09', 486.96, '2025-06-09', 486.96, 'EXTRA - ZAINE', 6, 1, 0, 0, '0000-00-00', 2),
(129, 42, '2025-05-26', 2035, '2025-05-26', 2035, 'PAGAMENTO SEMANAL', 6, 1, 0, 0, '0000-00-00', 2),
(130, 43, '2025-05-26', 700, '2025-05-26', 700, 'PAGAMENTO SEMANAL', 6, 2, 0, 0, '0000-00-00', 2),
(131, 45, '2025-05-26', 630, '2025-05-26', 630, 'PAGAMENTO SEMANAL', 6, 1, 0, 0, '0000-00-00', 2),
(132, 44, '2025-05-26', 875, '2025-05-26', 875, 'PAGAMENTO SEMANAL', 6, 1, 0, 0, '0000-00-00', 2),
(133, 47, '2025-05-25', 492, '2025-05-25', 492, 'CARTÃO DE CRÉDITO - 25', 18, 8, 0, 0, '0000-00-00', 2),
(134, 16, '2025-05-26', 413, '2025-05-26', 413, '', 18, 5, 0, 0, '0000-00-00', 3),
(135, 48, '2025-05-26', 391.6, '2025-05-26', 391.6, '', 18, 5, 0, 0, '0000-00-00', 3),
(136, 38, '2025-05-26', 972.59, '2025-05-26', 972.59, '', 18, 5, 0, 0, '0000-00-00', 3),
(137, 36, '2025-05-26', 868.06, '2025-05-26', 868.06, '', 18, 5, 0, 0, '0000-00-00', 3),
(138, 20, '2025-05-26', 317.18, '2025-05-26', 317.18, '', 18, 5, 0, 0, '0000-00-00', 3),
(140, 37, '2025-05-26', 3458, '2025-05-26', 3458, '', 18, 5, 0, 0, '0000-00-00', 3),
(142, 51, '2025-05-26', 1750, '2025-05-26', 1750, 'PAGAMENTO SEMANAL', 19, 1, 0, 0, '0000-00-00', 3),
(143, 51, '2025-05-26', 400, '2025-05-26', 400, 'FERIADO - 01/05', 19, 1, 0, 0, '0000-00-00', 3),
(144, 47, '2025-05-25', 492, '2025-05-25', 492, 'CARTÃO DE CRÉDITO - 25', 18, 1, 0, 0, '0000-00-00', 3),
(158, 50, '2025-05-24', 4457.53, '2025-05-24', 4457.53, '', 18, 5, 0, 0, '0000-00-00', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `plano_contas`
--

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
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id_produto` int(11) NOT NULL,
  `descricao_produto` varchar(60) NOT NULL,
  `imagem1` varchar(256) NOT NULL,
  `imagem2` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id_produto`, `descricao_produto`, `imagem1`, `imagem2`) VALUES
(1, 'Computador', 'https://img.freepik.com/vetores-gratis/desenhos-animados-de-laptop_78370-508.jpg', 0x0000001c667479706176696600000000617669666d6966316d696166000000ea6d657461000000000000002168646c72000000000000000070696374000000000000000000000000000000000e7069746d00000000000100000022696c6f630000000044400001000100000000010e00010000000000000e960000002369696e6600000000000100000015696e6665020000000001000061763031000000006a697072700000004b6970636f00000013636f6c726e636c780001000d0006800000000c6176314381040c000000001469737065000000000000027200000272000000107069786900000000030808080000001769706d6100000000000000010001040182030400000e9e6d64617412000a0a19266719c782021a0d0832851d11400104104140f4bacdcb2f4897a2cc596702a06ededdf47e362e12f8a9921e05a86d603c45fcad90a0732c5afed01e447c327e069d117789e818787cf18260f508ecc021e3cae9184dc48d0600e1bb126749de4618a996271bde58bcc6c11d7637a1480ec4808af2490bd679fe486557b43f0aed94f07ce06c3838d53b5e602043cc8ed124a2b63bed855129e43c0b0c979d19a5dfbf3543545e82eae91093a5f10cc3a79d18fa16ce2983d04fe5ee66c6ee94d201658e232155757bd2f0832b220cafccbc5775adb4224875f22193689695aee7b0d18e1b108a797f909dc25fef92d8e979eed06558d4ffa2f80cc408d59e5365a7fc38c1be57a9bc0a95442bcccd654e2a7d11f5c8e1a314e2ca86389de082e39b917eb8c937e7eff534f56d2fcd7a09a0b62b8e5cb4378465f71d2101822c8dfcacb64a11575a9ed90c0ee6c50f1c2c0885b4077d9eb07bfc7cd7ecda6e55d2c45c1a94d9835d0891c64e8967bce6a077d4c46abdabdcbb4aab575af0ee00533ee59a0e37fa44a8a13c4496a5da8fae22b1990f06ec508e62dab264e7503be7e723977c74c718eff1099b7b008246582900b25ccc471d171f97ead07fdbc82bd75aebf407930157ca8b06d2b37be766bdeab2aabed35b79cd291fa0c1a2a8020d0fece79091fc865acdf9183a0ac6cc35f879fe0a2a1a0f554530117b847de2b4c48b8083f60458dc7d3dfa9186d04fc9534909ef688a837f7b993d36860c57b791d290d3758b080f7377f65498e8d19859be07b2ffbe402220dbf5a1af339354635ac094b63f011b05b3e7fd8f6e44a331b418a9c94dd44b5d35e92c4de82f3c9a879852b3bfd9493e3021453599cd248fd9f91c0ca93c8ae79f01850296abeb014ff4f18c8d52ccd2f11c1c16ca9d6e89c19c867a42a42a58ccbbc170b5ce765342c6096ad4e67f4ba99be32880c31cf64877c3e35dc702e78913ed84d5d70d25f18991377749240665f827881e16319b16ad1b8e9bbd5c9f74a80c89b97c014e2f01fb79575dab5ae0143321ddf001c9e4c7c9a5ac204bd3a4b1cba6ec90062cc97675e9c0598d9b898346856e2824a865e6b97578f441b3d97a89061bdfc7b1765b73896e053847bd245ea0c2aef0efc5729ac9ee7955d1ec837ffbff3eabfcf2f3e5d70caf1fdd65ebc9cb4c7e06cfc828d9def7c28279bf1f314d52b08abd533a0c0900e863ebe863905260c0659a3664479b4dc2c62ba2cce5e4ba890ae30976789a44c061ecb5c9880869c6722326553d69578ac546f597f7cc6d4c1305d7d972b6fcc0a1cd13f9fb596da5d0d51405ec56cbcb02c929cbcfb344fcbe37e0973d66470b3b0cf1c7a1866e4497d86db2b35967b7eee32b6bda39bb082559d32c326163a6e849501479df99817c742e8b374582aa65a2d780303aee15378e87d71164df318d1b69c90835d36b8648035426479d956fdfce38539e36db83f99666b8a8d479a32c9a4e0c865133a617ef9a7679c654b60177f2cae9b194e928195fc741a8671b66bfefb872d515e8a0b70b317b6fd88b4cb08f16f8d0c24b3be92a9524c4db4b3979dbe6864b89a3ad547b242ac4f9d7804fda45769386845df4dd95a8e0fa102f3952623619a7668b3486d4618dbb85386b93593437a1503bf55cd2861482d897dc38f732a9e4393ae89da76bb680486d148cac117e9dbde0aae88e9981800a3f4d2d6e0ff1c09a40bcdaa3c6f419e1094b04f13f61453629bea72a0d3ade40952461e75f162c25e2c1c26d08235c50b0ae78f1a31648cc4e346310b4f8858a479177248c48b4043745dc63ea3f786fc32db4e83270b96b34c7eb2f4075f85c904e84f85d23ab7cc159422625a900a0d168c1b39d2176d0f792f8be07b9b4c3986dd354480843c8517b5326a1215d2376c8c39d3253cebd0faa40d1275036fdad594e9a0a996cefc444e4d83d28fa5848caeb9127f5fe207d1bc8a248f000b4045d35be23423b644f266477e69eadbc65a745b98a5f5df032cbe78d7145eb84e3150fb04b77062f5eb21eb72dc75cb00a9bebb2c5363c3f456909aca1d01cc59ee915312393aad9589cd9b3939c3554f197862e7a64fdd857ce2a6119e15711e3d69135a62de7d006364b7dfe345b2fe8af1c75616054a541be84fa41ae7a52c423839ac8610846bda2f02beb0c3297a4d84a1d78fb155cdccec9e0d9d912b64ca23e1023baa1364d4d991f37cd45f332674b54ff60856835358a9f5066f44eedf6436bd7f09fbe1abb5787231a71bcceac39f266851c29d8ab1de673a46158786ee6a5c371e7e7e971f9307ae8af35cea40a203269db626ad0f345307188ef433c3bfccf37da1f1143c3942206c4dd651c8ea9d087556a34b47f805007fa450044ea873c69fd46b0059b9e415737027a02abe005d291f7ebdc3f20ce9fab26d8e0242bcbda045ddabd5f662688f2578cdcb6436dfc7ce1fb1af40d2cc32ea636cd8f17b71922849070f2610839c6a4d7434b0e4e9cafb8aa0c2a14d0589c7d7bc2aa9606c5eb3e407fdf63c964aea62eab76c93e2d5a1e9f842d14e0417a1790bcf84072259658cd186c725e8890f702748b47dc68ab77074b1bf05a141a2104f8976e871cc49106b1fc91d79b29e3bd6fdd757dbfd85a81ede053e9eea8ea97ed411146933427ad86d39b6cc3e81a0d2fff04e06b7ea1650b4ad7227a599ad8c69142e4ec64241b0d6d056729214d6738f5a5cf3f23d661bb9dae23254d96ea49a56dd982fa2511674031033726fbade04eec2915a307475f0a62a02fef1b64035012e291033bfc283585b1139114fe2939ac594b4935021671a0d62b44ae0b6f38f72b3cdf46722349089ab7fb36dc9f31607134d68a5a638f10d5794fe2fabaab4b198a80eee862836d3e7e377df6f7c05220bfda4289a0999550ba4eedd58a427bdd268773d3617bd0d6fd47ee134b93820487d69b1c1ad419f3447bf9f5554d41c1f79af2ee0b871d2b92b17181eb3b750cb6fcc6a38573b85f83df4186ed04878b989f0c03ac4bfdc00e6a1dbc150d7b38e05994216f14141002cc349b5b55c2e837d27c5a5462991464f7f9b3f0328efba0f5ba7818779e3150311dbd37dbf04aabf4ffc8db72cffc6de8f9e71bec17c7367f20ef23c6a69e2d9412614ebd2b5d4cb6f23ae1867023f845add1606aade79a43648b51a2e309297e508b49235ac104d8a0238936f0049cd1c736a5792cbd0a1f9d72f709156451690f4277041fb7c34024befa414640e2002ac5a10e7d8216ed0ac633c419100b7bee96f22c0dab87df4bc652e8366073e559d7e27d3f64b4dc046aaf61b49373cf58e29de762338807e751e8e5a7e517805f64d3acc060e0a7855168b2ac800ad025fb347c3072d8c29cb517f570a3a025757cb627aae1c90f570b7b06a55f2b9536c69e4c6b825145b51bf07970dfe78e26ae0b4bc277160005e15a1bdea418d3b873a0794986cde99af817b4b9f6f0759494cc86dc628346c12cd272b400fffc4e9930ff874091c8719ff88e2790b1668e7d56bed36ac303061688119ffa525656d1bbbdd281ed9a051e2a386488043fc12171bd3e5987dcc103bf4bd75f599a029454f22c3f8d676d8347be01f1f4b6cd39cc33b7d00ed7388ae4d4fbfa7e8e7a122a1ba33f01c6ea416c7af3fe8fa824c156da6a42f4f669bb6b02975756f84fbadc891561fdfbe139e9e7f5db672f8cdfe93969b8d673750a6d0ddac772e2fb08be85463f16cf829f0fd403e771ac62d77d6266da5158170e42b68d29f79d4bab82d858fb91f20b9dd4eede4f2d3516d7ee6c6cc419ba0289adff3878d81998ef11f26eea97c1bb7184400fa1d8461b8719e3f503006b5a155b7849f0692e827ca9706a9b54fa5d1284db8466c7e80bcc55dd15e15d9fab208b69c664b3267a5005b1c3a0d7ecb65c6f784323869a57c46f1d670ebda9b9e63f8a5345d152f42367e251518e286852547f49b3235060e4f8030fdd71241b18de198c9729f5a83b065a1e52a0d7b7cc4173ef27053905f933e7d7d3d6bed952354a4cfca7a0dc42129cd7e7d21449d22c8d3d918d353e84ec9a903b7081a53f038d76d6f8e6e84b96a7d2e2d308d81363f8d23b0201e05517a2a26c6a4aad73336231ee56c1eb8d19ba588baf007a88e681c2c010eb3bb18acae230d2df1f0a10d140cbd5420a613a2c4cedf7f29db24b32f50ac37e053240dc6d455357083adeeb2f494141afd143b1ba1978fd626b477c7d151b40cda403796d8fb7667fb64c8a053e4a8c3270cd2e2cf824c253b51c6bd743025b86d407bf498424a87dd6e22fe0f4e7b249b7108725bea14b8d51346b16f3bf7fdd704269c81fcd372be09f48eba24b0d66533c6bf87ce7bf2a7a51f12839b8e588b18fab102d1ae605eef641b17cda8fa99effdce139049596c3d06a6f9f914f7838a3f7e43ebbc1899dd9b6ccbad4e856d8e6734e554e6cdd8e8a67ffe4d98de8ce0806919df0574f77572702f4459975dcf7a83c062cbab8dcd6044f3675a338ad780b705925402bee454f1fd2b71ab6bf4d61e646098f02596dc8a571affe50c8510cb32864aa5436e07780a55377860272a8c4597bf2cc6e7c67a2faa424e3beb856825d4776bbad9ad8aa2ee7f8d05eafcb35fe50777753a805f3cede62c83aee7e88b350a535045a2adfdaa375e40a9c206672b3371e59c4c4be112b843540ad4fa1f5ac4f3c5d694681ad805bb86aa681f496511094d648977c044486f72bf83bcd680beebeb5e4518be07e056eeb79417eb2a72b7bbfb3e72ec60889639c36f2cd32e62e1fbe95b2a40fea12c447478683f08d56d07aec9954de3f332654f3fda5549657dc300be171684aa3f43da11bcd2d1365991f81fc6da2f2aae7c702a1aeb37f97aa040b96cd08ec0137fa02b131ba825c52bc65d26039910627ac26db744a4b4c14971c83982319992c653ec34e76dc2a0ea019a9b0fe6f440addefcbd2fcc22f6e75cc379f5c2df94f859e5e73be73c44c733119b887466cf4c5f9d9fdd9d26e307579d3bd58e751dc371c7bcade3db8d52254c8a3b5e449a438abc6b60bf06afffb7458edb5d4bdd3fa40fff6a5b1a3e89eb470a3cd8a3590dd5dd835bd4bb4566fc1ca14591e3cb057102093b200d37033b3302daf441b3a946bb9eabc2814fbd83a593693099d1e55220b174060a51bc69cb8b4939ca049ae8cb2d8ecdc041c329f0eeac6b7251c502ec644170dc8);

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

-- --------------------------------------------------------

--
-- Estrutura para view `contato`
--
DROP TABLE IF EXISTS `contato`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `contato`  AS SELECT `fornecedores`.`nome_fornecedor` AS `nome_fornecedor`, `fornecedores`.`celular` AS `celular`, `fornecedores`.`email` AS `email` FROM `fornecedores` ;

-- --------------------------------------------------------

--
-- Estrutura para view `contatof`
--
DROP TABLE IF EXISTS `contatof`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `contatof`  AS SELECT `fornecedores`.`nome_fornecedor` AS `nome_fornecedor`, `fornecedores`.`celular` AS `celular`, `fornecedores`.`email` AS `email` FROM `fornecedores` ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `centro_custos`
--
ALTER TABLE `centro_custos`
  ADD PRIMARY KEY (`id_centro_custos`);

--
-- Índices de tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  ADD PRIMARY KEY (`id_fornecedor`);

--
-- Índices de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`id_funcionario`);

--
-- Índices de tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD PRIMARY KEY (`id_pagamento`);

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
-- AUTO_INCREMENT de tabela `centro_custos`
--
ALTER TABLE `centro_custos`
  MODIFY `id_centro_custos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  MODIFY `id_fornecedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  MODIFY `id_funcionario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  MODIFY `id_pagamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1376;

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
