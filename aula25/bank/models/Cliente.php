<?php

require_once __DIR__ . '/../config/database.php';

class Cliente
{
    private $pdo;

    public function __construct($pdo)
    {
        $this->pdo = $pdo;
    }

    // Cadastro de cliente
    public function cadastrarCliente($nome, $email, $cpf, $telefone)
    {
        try {
            $stmt = $this->pdo->prepare("INSERT INTO cliente (nome,email,cpf,telefone) VALUES (?,?,?,?)");
            $stmt->execute([$nome, $email, $cpf, $telefone]);
            return true;
        } catch (PDOException $e) {
            echo "Erro ao cadastrar cliente: " . $e->getMessage();
            return false;
        }
    }
    // Atualiza de cliente
    public function atualizarCliente($nome, $email, $cpf, $telefone, $id_cliente)
    {
        try {
            $stmt = $this->pdo->prepare("UPDATE cliente SET nome = ?,email = ?,cpf = ?,telefone = ? WHERE id_cliente = ?");
            $stmt->execute([$nome, $email, $cpf, $telefone, $id_cliente]);
            if ($stmt->rowCount() === 0) {
                return false;
            }
            return true;
        } catch (PDOException $e) {
            echo "Erro ao cadastrar cliente: " . $e->getMessage();
            return false;
        }
    }

    public function listarClienteId($id)
    {
        try {
            $stmt = $this->pdo->prepare("SELECT * FROM cliente WHERE id_cliente = ?");
            $stmt->bindParam(1, $id, PDO::PARAM_INT);
            $stmt->execute([$id]);
            if ($stmt->rowCount() === 0) {
                return [];
            }
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao listar cliente por ID: " . $e->getMessage();
            return [];
        }
    }
    // Listar todos os clientes
    public function listarClientes()
    {
        try {
            $stmt = $this->pdo->query("SELECT * FROM cliente");
            if ($stmt->rowCount() === 0) {
                return [];
            }
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao listar clientes: " . $e->getMessage();
            return [];
        }
    }

    // Excluir cliente
    public function excluirCliente($id_cliente)
    {
        try {
            $stmt = $this->pdo->prepare("DELETE FROM cliente WHERE id_cliente = ?");
            $stmt->execute([$id_cliente]);
            if ($stmt->rowCount() === 0) {
                return false;
            }
            return true;
        } catch (PDOException $e) {
            echo "Erro ao excluir cliente: " . $e->getMessage();
            return false;
        }
    }
}
