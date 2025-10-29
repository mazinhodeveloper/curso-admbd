-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 15/08/2025 às 21:06
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Usar o banco de dados `supermercado`
--
USE supermercado;

-- --------------------------------------------------------
--
-- Selecionar todos os dados da tabela `produtos`
--
SELECT * FROM produtos; 

-- --------------------------------------------------------




DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ensure_estoque_row` (`p_id_prod` INT)   BEGIN
  IF NOT EXISTS (SELECT 1 FROM estoque WHERE id_produto = p_id_prod) THEN
    INSERT INTO estoque (id_produto, saldo_atual) VALUES (p_id_prod, 0);
  END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `descricao` varchar(80) NOT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `categorias_fiscais`
--

CREATE TABLE `categorias_fiscais` (
  `id_categoria_fiscal` int(11) NOT NULL,
  `descricao` varchar(120) NOT NULL,
  `ncm` varchar(10) NOT NULL,
  `csosn` varchar(3) DEFAULT NULL,
  `cst_icms` varchar(3) DEFAULT NULL,
  `cst_pis` varchar(2) DEFAULT NULL,
  `cst_cofins` varchar(2) DEFAULT NULL,
  `aliquota_icms` decimal(5,2) DEFAULT NULL,
  `aliquota_pis` decimal(5,2) DEFAULT NULL,
  `aliquota_cofins` decimal(5,2) DEFAULT NULL,
  `icms_st` tinyint(1) NOT NULL DEFAULT 0,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nome` varchar(120) NOT NULL,
  `cpf_cnpj` varchar(25) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `contas_a_pagar`
--

CREATE TABLE `contas_a_pagar` (
  `id_titulo` int(11) NOT NULL,
  `id_nf_entrada` int(11) DEFAULT NULL,
  `id_fornecedor` int(11) NOT NULL,
  `parcela` int(11) NOT NULL DEFAULT 1,
  `descricao` varchar(120) NOT NULL,
  `data_emissao` date NOT NULL,
  `data_vencimento` date NOT NULL,
  `valor` decimal(16,2) NOT NULL,
  `pago` tinyint(1) NOT NULL DEFAULT 0,
  `data_pagto` date DEFAULT NULL,
  `valor_pago` decimal(16,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `contas_a_receber`
--

CREATE TABLE `contas_a_receber` (
  `id_titulo` int(11) NOT NULL,
  `id_cupom` int(11) DEFAULT NULL,
  `id_cliente` int(11) NOT NULL,
  `parcela` int(11) NOT NULL DEFAULT 1,
  `descricao` varchar(120) NOT NULL,
  `data_emissao` date NOT NULL,
  `data_vencimento` date NOT NULL,
  `valor` decimal(16,2) NOT NULL,
  `recebido` tinyint(1) NOT NULL DEFAULT 0,
  `data_receb` date DEFAULT NULL,
  `valor_recebido` decimal(16,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cupom_fiscal`
--

CREATE TABLE `cupom_fiscal` (
  `id_cupom` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `numero` varchar(20) NOT NULL,
  `data_emissao` datetime NOT NULL DEFAULT current_timestamp(),
  `valor_total` decimal(16,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cupom_fiscal_itens`
--

CREATE TABLE `cupom_fiscal_itens` (
  `id_item` int(11) NOT NULL,
  `id_cupom` int(11) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `qtde` decimal(14,3) NOT NULL,
  `valor_unit` decimal(16,6) NOT NULL,
  `valor_total` decimal(16,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Acionadores `cupom_fiscal_itens`
--
DELIMITER $$
CREATE TRIGGER `trg_cfi_ad` AFTER DELETE ON `cupom_fiscal_itens` FOR EACH ROW BEGIN
  UPDATE estoque
     SET saldo_atual = saldo_atual + OLD.qtde
   WHERE id_produto = OLD.id_produto;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_cfi_ai` AFTER INSERT ON `cupom_fiscal_itens` FOR EACH ROW BEGIN
  UPDATE estoque
     SET saldo_atual = saldo_atual - NEW.qtde
   WHERE id_produto = NEW.id_produto;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_cfi_au` AFTER UPDATE ON `cupom_fiscal_itens` FOR EACH ROW BEGIN
  UPDATE estoque
     SET saldo_atual = saldo_atual - (NEW.qtde - OLD.qtde)  -- se aumentou a qtde, baixa mais
   WHERE id_produto = NEW.id_produto;
  IF NEW.id_produto <> OLD.id_produto THEN
    CALL ensure_estoque_row(OLD.id_produto);
    UPDATE estoque SET saldo_atual = saldo_atual + OLD.qtde WHERE id_produto = OLD.id_produto;
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_cfi_bi` BEFORE INSERT ON `cupom_fiscal_itens` FOR EACH ROW BEGIN
  CALL ensure_estoque_row(NEW.id_produto);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `estoque`
--

CREATE TABLE `estoque` (
  `id_produto` int(11) NOT NULL,
  `saldo_atual` decimal(14,3) NOT NULL DEFAULT 0.000,
  `atualizado_em` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `fornecedores`
--

CREATE TABLE `fornecedores` (
  `id_fornecedor` int(11) NOT NULL,
  `nome_fornecedor` varchar(120) NOT NULL,
  `cpf_cnpj` varchar(25) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `logradouro` varchar(80) DEFAULT NULL,
  `numero` varchar(15) DEFAULT NULL,
  `complemento` varchar(30) DEFAULT NULL,
  `bairro` varchar(50) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `estado` char(2) DEFAULT NULL,
  `contato` varchar(60) DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `nf_entrada`
--

CREATE TABLE `nf_entrada` (
  `id_nf_entrada` int(11) NOT NULL,
  `id_fornecedor` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `numero` varchar(20) NOT NULL,
  `serie` varchar(5) DEFAULT NULL,
  `chave_acesso` varchar(44) DEFAULT NULL,
  `data_emissao` date NOT NULL,
  `data_lancamento` datetime NOT NULL DEFAULT current_timestamp(),
  `valor_total` decimal(16,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `nf_entrada_itens`
--

CREATE TABLE `nf_entrada_itens` (
  `id_item` int(11) NOT NULL,
  `id_nf_entrada` int(11) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `qtde` decimal(14,3) NOT NULL,
  `valor_unit` decimal(16,6) NOT NULL,
  `valor_total` decimal(16,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Acionadores `nf_entrada_itens`
--
DELIMITER $$
CREATE TRIGGER `trg_nfei_ad` AFTER DELETE ON `nf_entrada_itens` FOR EACH ROW BEGIN
  UPDATE estoque
     SET saldo_atual = saldo_atual - OLD.qtde
   WHERE id_produto = OLD.id_produto;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_nfei_ai` AFTER INSERT ON `nf_entrada_itens` FOR EACH ROW BEGIN
  UPDATE estoque
     SET saldo_atual = saldo_atual + NEW.qtde
   WHERE id_produto = NEW.id_produto;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_nfei_au` AFTER UPDATE ON `nf_entrada_itens` FOR EACH ROW BEGIN
  UPDATE estoque
     SET saldo_atual = saldo_atual + (NEW.qtde - OLD.qtde)
   WHERE id_produto = NEW.id_produto;
  -- Se trocou o produto, estorna do antigo e credita no novo
  IF NEW.id_produto <> OLD.id_produto THEN
    CALL ensure_estoque_row(OLD.id_produto);
    UPDATE estoque SET saldo_atual = saldo_atual - OLD.qtde WHERE id_produto = OLD.id_produto;
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_nfei_bi` BEFORE INSERT ON `nf_entrada_itens` FOR EACH ROW BEGIN
  CALL ensure_estoque_row(NEW.id_produto);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id_produto` int(11) NOT NULL,
  `descricao_produto` varchar(80) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_unidade` int(11) NOT NULL,
  `id_categoria_fiscal` int(11) DEFAULT NULL,
  `preco_compra` decimal(16,2) NOT NULL DEFAULT 0.00,
  `margem_lucro` decimal(6,3) NOT NULL DEFAULT 0.000,
  `preco_sugerido` decimal(16,2) NOT NULL DEFAULT 0.00,
  `preco_venda` decimal(16,2) NOT NULL DEFAULT 0.00,
  `estoque_minimo` decimal(12,3) NOT NULL DEFAULT 0.000,
  `estoque_maximo` decimal(12,3) NOT NULL DEFAULT 0.000,
  `codigo_barras` varchar(20) NOT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Acionadores `produtos`
--
DELIMITER $$
CREATE TRIGGER `trg_produtos_precos_bi` BEFORE INSERT ON `produtos` FOR EACH ROW BEGIN
  IF NEW.preco_sugerido = 0 THEN
    SET NEW.preco_sugerido = ROUND(NEW.preco_compra * (1 + (NEW.margem_lucro/100)), 2);
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_produtos_precos_bu` BEFORE UPDATE ON `produtos` FOR EACH ROW BEGIN
  IF NEW.preco_compra <> OLD.preco_compra OR NEW.margem_lucro <> OLD.margem_lucro THEN
    SET NEW.preco_sugerido = ROUND(NEW.preco_compra * (1 + (NEW.margem_lucro/100)), 2);
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `unidades`
--

CREATE TABLE `unidades` (
  `id_unidade` int(11) NOT NULL,
  `sigla` varchar(5) NOT NULL,
  `descricao` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(120) DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Índices de tabela `categorias_fiscais`
--
ALTER TABLE `categorias_fiscais`
  ADD PRIMARY KEY (`id_categoria_fiscal`);

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Índices de tabela `contas_a_pagar`
--
ALTER TABLE `contas_a_pagar`
  ADD PRIMARY KEY (`id_titulo`),
  ADD KEY `fk_cap_fornecedor` (`id_fornecedor`),
  ADD KEY `fk_cap_nfe` (`id_nf_entrada`);

--
-- Índices de tabela `contas_a_receber`
--
ALTER TABLE `contas_a_receber`
  ADD PRIMARY KEY (`id_titulo`),
  ADD KEY `fk_car_cliente` (`id_cliente`),
  ADD KEY `fk_car_cupom` (`id_cupom`);

--
-- Índices de tabela `cupom_fiscal`
--
ALTER TABLE `cupom_fiscal`
  ADD PRIMARY KEY (`id_cupom`),
  ADD KEY `fk_cupom_cliente` (`id_cliente`);

--
-- Índices de tabela `cupom_fiscal_itens`
--
ALTER TABLE `cupom_fiscal_itens`
  ADD PRIMARY KEY (`id_item`),
  ADD KEY `fk_cfi_cupom` (`id_cupom`),
  ADD KEY `fk_cfi_prod` (`id_produto`);

--
-- Índices de tabela `estoque`
--
ALTER TABLE `estoque`
  ADD PRIMARY KEY (`id_produto`);

--
-- Índices de tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  ADD PRIMARY KEY (`id_fornecedor`);

--
-- Índices de tabela `nf_entrada`
--
ALTER TABLE `nf_entrada`
  ADD PRIMARY KEY (`id_nf_entrada`),
  ADD UNIQUE KEY `uk_nfe_chave` (`chave_acesso`),
  ADD KEY `fk_nfe_fornecedor` (`id_fornecedor`),
  ADD KEY `fk_nfe_usuario` (`id_usuario`);

--
-- Índices de tabela `nf_entrada_itens`
--
ALTER TABLE `nf_entrada_itens`
  ADD PRIMARY KEY (`id_item`),
  ADD KEY `fk_nfei_nfe` (`id_nf_entrada`),
  ADD KEY `fk_nfei_prod` (`id_produto`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id_produto`),
  ADD UNIQUE KEY `uk_produtos_codigo_barras` (`codigo_barras`),
  ADD KEY `fk_prod_categoria` (`id_categoria`),
  ADD KEY `fk_prod_unidade` (`id_unidade`),
  ADD KEY `fk_prod_cat_fiscal` (`id_categoria_fiscal`);

--
-- Índices de tabela `unidades`
--
ALTER TABLE `unidades`
  ADD PRIMARY KEY (`id_unidade`),
  ADD UNIQUE KEY `uk_unidades_sigla` (`sigla`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `categorias_fiscais`
--
ALTER TABLE `categorias_fiscais`
  MODIFY `id_categoria_fiscal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `contas_a_pagar`
--
ALTER TABLE `contas_a_pagar`
  MODIFY `id_titulo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `contas_a_receber`
--
ALTER TABLE `contas_a_receber`
  MODIFY `id_titulo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `cupom_fiscal`
--
ALTER TABLE `cupom_fiscal`
  MODIFY `id_cupom` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `cupom_fiscal_itens`
--
ALTER TABLE `cupom_fiscal_itens`
  MODIFY `id_item` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  MODIFY `id_fornecedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `nf_entrada`
--
ALTER TABLE `nf_entrada`
  MODIFY `id_nf_entrada` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `nf_entrada_itens`
--
ALTER TABLE `nf_entrada_itens`
  MODIFY `id_item` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id_produto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `unidades`
--
ALTER TABLE `unidades`
  MODIFY `id_unidade` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `contas_a_pagar`
--
ALTER TABLE `contas_a_pagar`
  ADD CONSTRAINT `fk_cap_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id_fornecedor`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cap_nfe` FOREIGN KEY (`id_nf_entrada`) REFERENCES `nf_entrada` (`id_nf_entrada`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `contas_a_receber`
--
ALTER TABLE `contas_a_receber`
  ADD CONSTRAINT `fk_car_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_car_cupom` FOREIGN KEY (`id_cupom`) REFERENCES `cupom_fiscal` (`id_cupom`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `cupom_fiscal`
--
ALTER TABLE `cupom_fiscal`
  ADD CONSTRAINT `fk_cupom_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `cupom_fiscal_itens`
--
ALTER TABLE `cupom_fiscal_itens`
  ADD CONSTRAINT `fk_cfi_cupom` FOREIGN KEY (`id_cupom`) REFERENCES `cupom_fiscal` (`id_cupom`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cfi_prod` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id_produto`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `estoque`
--
ALTER TABLE `estoque`
  ADD CONSTRAINT `fk_est_prod` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id_produto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `nf_entrada`
--
ALTER TABLE `nf_entrada`
  ADD CONSTRAINT `fk_nfe_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id_fornecedor`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nfe_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `nf_entrada_itens`
--
ALTER TABLE `nf_entrada_itens`
  ADD CONSTRAINT `fk_nfei_nfe` FOREIGN KEY (`id_nf_entrada`) REFERENCES `nf_entrada` (`id_nf_entrada`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nfei_prod` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id_produto`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `produtos`
--
ALTER TABLE `produtos`
  ADD CONSTRAINT `fk_prod_cat_fiscal` FOREIGN KEY (`id_categoria_fiscal`) REFERENCES `categorias_fiscais` (`id_categoria_fiscal`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prod_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prod_unidade` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id_unidade`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
