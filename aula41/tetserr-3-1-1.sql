-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 27/11/2024 às 17:33
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
-- Banco de dados: `tetserr`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `inserir_cliente` (IN `nome` VARCHAR(40))   BEGIN
    DECLARE idCliente INT;
    DECLARE novoIdCliUso VARCHAR(20);
    DECLARE idCliExistente INT;

    -- Pegar o maior idCliente da tabela e incrementar em 1
    SELECT IFNULL(MAX(idCliente), 0) + 1 INTO idCliente FROM cliente;

    -- Gerar o idCliUso baseado no idCliente (adicionando '-cli' ao final)
    SET novoIdCliUso = CONCAT(idCliente, '-cli');

    -- Verificar se o idCliUso já existe para evitar duplicidade
    SELECT COUNT(*) INTO idCliExistente FROM cliente WHERE idCliUso = novoIdCliUso;

    -- Verificar se idCliUso já existe, se existir, gerar um novo
    WHILE idCliExistente > 0 DO
        SET idCliente = idCliente + 1;  -- Incrementa o idCliente
        SET novoIdCliUso = CONCAT(idCliente, '-cli');  -- Atualiza o idCliUso
        SELECT COUNT(*) INTO idCliExistente FROM cliente WHERE idCliUso = novoIdCliUso;  -- Verifica novamente
    END WHILE;

    -- Inserir o novo cliente
    INSERT INTO cliente (idCliUso, nome)
    VALUES (novoIdCliUso, nome);

    -- Mostrar uma mensagem de sucesso após a inserção
    SELECT 'Cliente inserido com sucesso!', novoIdCliUso AS idCliUso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inserir_documento` (IN `tipo` VARCHAR(20), IN `nDoc` VARCHAR(20), IN `idFK_fun_for_cli` VARCHAR(20), IN `tipo_relacionamento` ENUM('funcionario','fornecedor','cliente'))   BEGIN
    DECLARE v_existente INT;

    -- Desabilitar temporariamente a verificação de chaves estrangeiras
    SET foreign_key_checks = 0;

    -- Verifica se a chave estrangeira é válida conforme o tipo_relacionamento
    IF tipo_relacionamento = 'funcionario' THEN
        -- Verifica se o idFK_fun_for_cli existe na tabela funcionario
        SELECT COUNT(*) INTO v_existente FROM funcionario WHERE idFunUso = idFK_fun_for_cli;
    ELSEIF tipo_relacionamento = 'fornecedor' THEN
        -- Verifica se o idFK_fun_for_cli existe na tabela fornecedor
        SELECT COUNT(*) INTO v_existente FROM fornecedor WHERE idForUso = idFK_fun_for_cli;
    ELSEIF tipo_relacionamento = 'cliente' THEN
        -- Verifica se o idFK_fun_for_cli existe na tabela cliente
        SELECT COUNT(*) INTO v_existente FROM cliente WHERE idCliUso = idFK_fun_for_cli;
    END IF;

    -- Se a chave estrangeira for válida, insere o documento
    IF v_existente > 0 THEN
        INSERT INTO documento (tipo, nDoc, idFK_fun_for_cli, tipo_relacionamento)
        VALUES (tipo, nDoc, idFK_fun_for_cli, tipo_relacionamento);
    ELSE
        -- Caso a chave estrangeira não seja válida, retorna um erro
        SELECT CONCAT('Erro: A chave estrangeira "', idFK_fun_for_cli, '" não existe na tabela correspondente.');
    END IF;

    -- Reabilitar a verificação de chaves estrangeiras
    SET foreign_key_checks = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inserir_fornecedor` (IN `nome` VARCHAR(40))   BEGIN
    DECLARE idFornecedor INT;
    DECLARE novoIdForUso VARCHAR(20);
    DECLARE idForExistente INT;

    -- Pegar o maior idFornecedor da tabela e incrementar em 1
    SELECT IFNULL(MAX(idFornecedor), 0) + 1 INTO idFornecedor FROM fornecedor;

    -- Gerar o idForUso baseado no idFornecedor (adicionando '-for' ao final)
    SET novoIdForUso = CONCAT(idFornecedor, '-for');

    -- Verificar se o idForUso já existe para evitar duplicidade
    SELECT COUNT(*) INTO idForExistente FROM fornecedor WHERE idForUso = novoIdForUso;

    -- Verificar se idForUso já existe, se existir, gerar um novo
    WHILE idForExistente > 0 DO
        SET idFornecedor = idFornecedor + 1;  -- Incrementa o idFornecedor
        SET novoIdForUso = CONCAT(idFornecedor, '-for');  -- Atualiza o idForUso
        SELECT COUNT(*) INTO idForExistente FROM fornecedor WHERE idForUso = novoIdForUso;  -- Verifica novamente
    END WHILE;

    -- Inserir o novo fornecedor
    INSERT INTO fornecedor (idForUso, nome)
    VALUES (novoIdForUso, nome);

    -- Mostrar uma mensagem de sucesso após a inserção
    SELECT 'Fornecedor inserido com sucesso!', novoIdForUso AS idForUso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inserir_funcionario` (IN `nome` VARCHAR(40))   BEGIN
    DECLARE idFuncionario INT;
    DECLARE novoIdFunUso VARCHAR(20);
    DECLARE idFunExistente INT;

    -- Pegar o maior idFuncionario da tabela e incrementar em 1
    SELECT IFNULL(MAX(idFuncionario), 0) + 1 INTO idFuncionario FROM funcionario;

    -- Gerar o idFunUso baseado no idFuncionario (adicionando '-fun' ao final)
    SET novoIdFunUso = CONCAT(idFuncionario, '-fun');

    -- Verificar se o idFunUso já existe para evitar duplicidade
    SELECT COUNT(*) INTO idFunExistente FROM funcionario WHERE idFunUso = novoIdFunUso;

    -- Verificar se idFunUso já existe, se existir, gerar um novo
    WHILE idFunExistente > 0 DO
        SET idFuncionario = idFuncionario + 1;  -- Incrementa o idFuncionario
        SET novoIdFunUso = CONCAT(idFuncionario, '-fun');  -- Atualiza o idFunUso
        SELECT COUNT(*) INTO idFunExistente FROM funcionario WHERE idFunUso = novoIdFunUso;  -- Verifica novamente
    END WHILE;

    -- Inserir o novo funcionário
    INSERT INTO funcionario (idFunUso, nome)
    VALUES (novoIdFunUso, nome);

    -- Mostrar uma mensagem de sucesso após a inserção
    SELECT 'Funcionario inserido com sucesso!', novoIdFunUso AS idFunUso;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL,
  `idCliUso` varchar(20) NOT NULL,
  `nome` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `documento`
--

CREATE TABLE `documento` (
  `idDoc` int(11) NOT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `nDoc` varchar(20) DEFAULT NULL,
  `idFK_fun_for_cli` varchar(20) DEFAULT NULL,
  `tipo_relacionamento` enum('funcionario','fornecedor','cliente') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `fornecedor`
--

CREATE TABLE `fornecedor` (
  `idFornecedor` int(11) NOT NULL,
  `idForUso` varchar(20) NOT NULL,
  `nome` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcionario`
--

CREATE TABLE `funcionario` (
  `idFuncionario` int(11) NOT NULL,
  `idFunUso` varchar(20) NOT NULL,
  `nome` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idCliente`),
  ADD UNIQUE KEY `idCliUso` (`idCliUso`);

--
-- Índices de tabela `documento`
--
ALTER TABLE `documento`
  ADD PRIMARY KEY (`idDoc`),
  ADD KEY `idFK_fun_for_cli` (`idFK_fun_for_cli`) USING BTREE;

--
-- Índices de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`idFornecedor`),
  ADD UNIQUE KEY `idForUso` (`idForUso`);

--
-- Índices de tabela `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`idFuncionario`),
  ADD UNIQUE KEY `idFunUso` (`idFunUso`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `documento`
--
ALTER TABLE `documento`
  MODIFY `idDoc` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  MODIFY `idFornecedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `funcionario`
--
ALTER TABLE `funcionario`
  MODIFY `idFuncionario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `documento`
--
ALTER TABLE `documento`
  ADD CONSTRAINT `fk_cliente` FOREIGN KEY (`idFK_fun_for_cli`) REFERENCES `cliente` (`idCliUso`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_fornecedor` FOREIGN KEY (`idFK_fun_for_cli`) REFERENCES `fornecedor` (`idForUso`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_funcionario` FOREIGN KEY (`idFK_fun_for_cli`) REFERENCES `funcionario` (`idFunUso`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
