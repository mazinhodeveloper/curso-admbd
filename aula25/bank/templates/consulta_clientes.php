<?php
include 'header.php';
require_once '../config/database.php';
require_once '../models/Cliente.php';

$cliente = new Cliente($pdo);
$clientes = $cliente->listarClientes();
?>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Clientes Cadastrados</h2>
        <a href="cadastro_cliente.php" class="btn btn-add">+ Add Cliente</a>
    </div>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Email</th>
                <th>CPF</th>
                <th>Telefone</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php
            foreach ($clientes as $cliente) {
                echo "<tr>
                    <td>{$cliente['id_cliente']}</td>
                    <td>{$cliente['nome']}</td>
                    <td>{$cliente['email']}</td>
                    <td>{$cliente['cpf']}</td>
                    <td>{$cliente['telefone']}</td>
                    <td>
                        <a href='cadastro_cliente.php?action=salvar&id={$cliente['id_cliente']}' class='btn btn-sm btn-warning'>Editar</a>
                        <a href='../controllers/ClienteController.php?action=deletar&id={$cliente['id_cliente']}' class='btn btn-sm btn-danger'>Excluir</a>
                    </td>
                </tr>";
            }
            ?>
        </tbody>
    </table>
    <a href="../" class="btn btn-add">&lArr; voltar</a>
</div>

<?php include 'footer.php'; ?>