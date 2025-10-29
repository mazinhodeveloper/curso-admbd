<?php

require_once __DIR__ . '/../config/database.php';

class Banco
{
    private $pdo;
    private $id_banco;
    private $nome_banco;
    private $codigo_banco;

    public function __construct($pdo)
    {
        $this->pdo = $pdo;
    }

    // Método para cadastrar um novo banco
    public function cadastrarBanco($nome_banco, $codigo_banco)
    {
        try {
            $stmt = $this->pdo->prepare("INSERT INTO banco (nome,codigo) VALUES (?,?)");
            $stmt->execute([$nome_banco, $codigo_banco]);
            if ($stmt->rowCount() === 0) {
                echo "Erro ao cadastrar banco.";
                return false;
            }
            return true;
        } catch (PDOException $e) {
            echo "Erro ao cadastrar banco: " . $e->getMessage();
            return false;
        }
    }

    // Método para buscar todos os bancos
    public function listarBancos()
    {
        try {
            $stmt = $this->pdo->query("SELECT * FROM banco");
            if ($stmt->rowCount() === 0) {
                echo "Nenhum banco encontrado.";
                return [];
            }
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao listar bancos: " . $e->getMessage();
            return [];
        }
    }

    // Método para buscar um banco específico por ID
    public function buscarBancoPorId($id_banco)
    {
        try {
            $stmt = $this->pdo->prepare("SELECT * FROM banco WHERE id_banco = ?");
            $stmt->execute([$id_banco]);
            if ($stmt->rowCount() === 0) {
                echo "Nenhum banco encontrado com o ID: $id_banco";
                return null;
            }
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao buscar banco: " . $e->getMessage();
            return null;
        }
    }

    // Método para atualizar um banco existente
    public function atualizarBanco($id_banco, $nome_banco, $codigo_banco)
    {
        try {
            $stmt = $this->pdo->prepare("UPDATE banco SET nome = ?, codigo = ? WHERE id_banco = ?");
            $stmt->execute([$nome_banco, $codigo_banco, $id_banco]);
            if ($stmt->rowCount() === 0) {
                echo "Nenhum banco encontrado com o ID: $id_banco";
                return false;
            }
            return true;
        } catch (PDOException $e) {
            echo "Erro ao atualizar banco: " . $e->getMessage();
            return false;
        }
    }

    // Método para excluir um banco
    public function excluirBanco($id_banco)
    {
        try {
            $stmt = $this->pdo->prepare("DELETE FROM banco WHERE id_banco = ?");
            $stmt->execute([$id_banco]);
            if ($stmt->rowCount() === 0) {
                echo "Nenhum banco encontrado com o ID: $id_banco";
                return false;
            }
            return true;
        } catch (PDOException $e) {
            echo "Erro ao excluir banco: " . $e->getMessage();
            return false;
        }
    }
}
