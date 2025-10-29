<?php

require_once '../config/database.php';
require_once '../models/Cliente.php';

class ClienteController
{
    private $cliente;

    public function __construct($pdo)
    {
        $this->cliente = new Cliente($pdo);
    }

    public function cadastrar()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $nome = $_POST['nome'];
            $email = $_POST['email'];
            $cpf = $_POST['cpf'];
            $telefone = $_POST['telefone'];

            if ($this->cliente->cadastrarCliente($nome, $email, $cpf, $telefone)) {
                header("Location: ../templates/consulta_clientes.php?success=Cliente cadastrado com sucesso!");
                exit;
            } else {
                echo "Erro ao cadastrar cliente.";
            }
        }
    }

    public function atualizar()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = $_POST['id'];
            $nome = $_POST['nome'];
            $email = $_POST['email'];
            $cpf = $_POST['cpf'];
            $telefone = $_POST['telefone'];

            if ($this->cliente->atualizarCliente($nome, $email, $cpf, $telefone, $id)) {
                header("Location: ../templates/consulta_clientes.php?success=Cliente atualizado com sucesso!");
                exit;
            } else {
                echo "Erro ao atualizar cliente.";
            }
        }
    }

    public function listar()
    {
        return $this->cliente->listarClientes();
    }
    public function listarId($id)
    {
        return $this->cliente->listarClienteId($id);
    }

    public function excluir()
    {
        if (isset($_GET['id'])) {
            $id_cliente = $_GET['id'];

            if ($this->cliente->excluirCliente($id_cliente)) {
                header("Location: ../templates/consulta_clientes.php?success=Cliente excluído com sucesso!");
                exit;
            } else {
                echo "Erro ao excluir cliente.";
            }
        }
    }
}

$controller = new ClienteController($pdo);

if (isset($_GET['action']) && $_GET['action'] === 'cadastrar') {
    $controller->cadastrar();
} elseif (isset($_GET['action']) && $_GET['action'] === 'deletar') {
    $controller->excluir();
} elseif (isset($_GET['action']) && $_GET['action'] === 'salvar') {
    $controller->atualizar();
}
