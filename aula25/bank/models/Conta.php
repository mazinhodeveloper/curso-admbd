<?php

require_once __DIR__ . '/../config/database.php';

class Conta
{
    private $pdo;

    public function __construct($pdo)
    {
        $this->pdo = $pdo;
    }

    // Cadastrar nova conta
    public function cadastrarConta($id_cliente, $id_banco, $tipo_conta, $saldo = 0)
    {
        try {
            $stmt = $this->pdo->prepare("INSERT INTO conta (id_cliente,id_banco,tipo,saldo) VALUES (?,?,?,?)");
            $stmt->execute([$id_cliente, $id_banco, $tipo_conta, $saldo]);
            if ($stmt->rowCount() === 0) {
                return false;
            }
            return true;
        } catch (PDOException $e) {
            echo "Erro ao cadastrar conta: " . $e->getMessage();
            return false;
        }
    }
    // Atualizar conta existente
    public function atualizarConta($id_conta, $id_cliente, $id_banco, $tipo_conta)
    {
        try {
            $stmt = $this->pdo->prepare("UPDATE conta SET tipo = ?, saldo = ? WHERE id_conta = ?");
            $stmt->execute([$id_cliente, $id_banco, $tipo_conta, $id_conta]);
            if ($stmt->rowCount() === 0) {
                return false;
            }
            return true;
        } catch (PDOException $e) {
            echo "Erro ao atualizar conta: " . $e->getMessage();
            return false;
        }
    }

    // Listar todas as contas
    public function listarContas()
    {
        try {
            $stmt = $this->pdo->query("SELECT c.*, b.nome banco, cl.nome nome FROM conta c, cliente cl, banco b WHERE c.id_cliente = cl.id_cliente AND c.id_banco = b.id_banco;");
            if ($stmt->rowCount() === 0) {
                return [];
            }
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao listar contas: " . $e->getMessage();
            return [];
        }
    }
    // Listar conta por ID
    public function listarId($id_conta)
    {
        try {
            $stmt = $this->pdo->prepare("SELECT * FROM conta WHERE id_conta = ?");
            $stmt->execute([$id_conta]);
            if ($stmt->rowCount() === 0) {
                return [];
            }
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao listar conta: " . $e->getMessage();
            return [];
        }
    }

    // Excluir conta
    public function excluirConta($id_conta)
    {
        try {
            $stmt = $this->pdo->prepare("DELETE FROM conta WHERE id_conta = ?");
            $stmt->execute([$id_conta]);
            if ($stmt->rowCount() === 0) {
                return false;
            }
            return true;
        } catch (PDOException $e) {
            echo "Erro ao excluir conta: " . $e->getMessage();
            return false;
        }
    }
}
