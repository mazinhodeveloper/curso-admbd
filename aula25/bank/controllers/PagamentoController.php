<?php

require_once '../config/database.php';
require_once '../models/Pagamento.php';

class PagamentoController
{
    private $pagamento;

    public function __construct($pdo)
    {
        $this->pagamento = new Pagamento($pdo);
    }

    public function realizar()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id_conta = $_POST['id_conta'];
            $valor = $_POST['valor'];

            if ($this->pagamento->realizarPagamento($id_conta, $valor)) {
                header("Location: ../templates/consulta_pagamentos.php?success=Pagamento realizado com sucesso!");
                exit;
            } else {
                header("Location: ../templates/consulta_pagamentos.php?error=Saldo insuficiente!");
                exit;
            }
        }
    }
    public function atualizar()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = $_POST['id'];
            $id_conta = $_POST['id_conta'];
            $valor = $_POST['valor'];
            $dados [
                'id' => $id,
                'id_conta' => $id_conta,
                'valor' => $valor
            ];
            if ($this->pagamento->atualizarPagamento($id, $dados)) {
                header("Location: ../templates/consulta_pagamentos.php?success=Pagamento atualizado com sucesso!");
                exit;
            }
        }
    }

    public function listar()
    {
        return $this->pagamento->listarPagamentos();
    }
     public function listarId($id)
    {
        return $this->pagamento->listarId($id);
    }
    public function excluir()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = $_POST['id'];
            if ($this->pagamento->excluirPagamento($id)) {
                header("Location: ../templates/consulta_pagamentos.php?success=Pagamento excluído com sucesso!");
                exit;
            } else {
                header("Location: ../templates/consulta_pagamentos.php?error=Erro ao excluir pagamento!");
                exit;
            }
        }
    }
}
$controller = new PagamentoController($pdo);

if (isset($_GET['action']) && $_GET['action'] === 'realizar') {
    $controller->realizar();
} elseif (isset($_GET['action']) && $_GET['action'] === 'atualizar') {
    $controller->atualizar();
} elseif (isset($_GET['action']) && $_GET['action'] === 'excluir') {
    $controller->excluir();
}

