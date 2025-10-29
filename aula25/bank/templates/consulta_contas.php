<?php
include 'header.php';
require_once '../config/database.php';
require_once '../models/Conta.php';

$contaModel = new Conta($pdo);
$contas = $contaModel->listarContas();
?>

<div class="container mt-5">
    <h2>Consulta de Contas</h2>
    <a href="cadastro_conta.php" class="btn btn-add">+ Add Conta</a>
    <?php if (isset($_GET['success'])): ?>
        <div class="alert alert-success"><?= $_GET['success'] ?></div>
    <?php endif; ?>
    
    <table class="table table-bordered mt-3">
        <thead>
            <tr>
                <th>ID</th>
                <th>Cliente</th>
                <th>Banco</th>
                <th>Tipo de Conta</th>
                <th>Saldo</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($contas as $conta): ?>
                <tr>
                    <td><?= $conta['id_conta'] ?></td>
                    <td><?= $conta['nome'] ?></td>
                    <td><?= $conta['banco'] ?></td>
                    <td><?= $conta['tipo'] ?></td>
                    <td>R$ <?= number_format($conta['saldo'], 2, ',', '.') ?></td>
                    <td>
                        <!-- <a href="cadastro_conta.php?id=< ?= $conta['id_conta'] ?>" class="btn btn-primary btn-sm">Editar</a> -->
                        <a href="../controllers/ContaController.php?action=excluir&id=<?= $conta['id_conta'] ?>" 
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Tem certeza que deseja excluir esta conta?')">Encerrar conta</a>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <a href="../" class="btn btn-add">&lArr; voltar</a>
</div>

<?php include 'footer.php'; ?>
