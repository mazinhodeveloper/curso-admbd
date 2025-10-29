<?php

require_once __DIR__ . '/../config/database.php';

class Pagamento
{
    private $pdo;

    public function __construct($pdo)
    {
        $this->pdo = $pdo;
    }

    // Realizar pagamento
    public function realizarPagamento($id_conta, $valor)
    {
        try {
            // Iniciar transação
            $this->pdo->beginTransaction();
            // Verificar saldo disponível na conta
            $stmt = $this->pdo->prepare("SELECT * FROM conta WHERE id = ?");
            $stmt->execute([$id_conta]);
            $conta = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$conta || $conta['saldo'] < $valor) {
                // Rollback em caso de saldo insuficiente
                $this->pdo->rollBack();
                return false; // Saldo insuficiente
            }

            // Atualizar saldo da conta
            $novoSaldo = $conta['saldo'] - $valor;
            $stmt = $this->pdo->prepare("UPDATE conta SET saldo = ? WHERE id = ?");
            $stmt->execute([$novoSaldo, $id_conta]);

            // Registrar o pagamento
            $stmt = $this->pdo->prepare("INSERT INTO pagamento (id_conta, valor, status) VALUES (?, ?, ?)");
            $stmt->execute([$id_conta, $valor, 'Concluído']);

            // Commit da transação
            $this->pdo->commit();
            return true;
        } catch (PDOException $e) {
            // Rollback em caso de erro
            $this->pdo->rollBack();
            echo "Erro ao realizar pagamento: " . $e->getMessage();
            return false;
        }
    }

    // Listar todos os pagamentos
    public function listarPagamentos()
    {
        try {
            $stmt = $this->pdo->query("SELECT * FROM pagamento");
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao listar pagamentos: " . $e->getMessage();
            return [];
        }
    }
    // Listar pagamento por ID
    public function listarId($id)
    {
        try {
            $stmt = $this->pdo->prepare("SELECT * FROM pagamento WHERE id_pagamento = ?");
            $stmt->execute([$id]);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao listar pagamento por ID: " . $e->getMessage();
            return null;
        }
    }

    // Atualizar pagamento (placeholder, implementar conforme necessário)
    public function atualizarPagamento($id, $dados)
    {
        try {
            $stmt = $this->pdo->prepare("UPDATE pagamento SET id_conta = ?, valor = ?, status = ? WHERE id_pagamento = ?");
            return true;
        } catch (PDOException $e) {
            echo "Erro ao atualizar pagamento: " . $e->getMessage();
            return false;
        }
    }
}
