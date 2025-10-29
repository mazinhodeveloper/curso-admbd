<?php
include 'header.php';
require_once '../config/database.php';
require_once '../models/Banco.php';

$banco = new Banco($pdo);
$bancos = $banco->listarBancos();
?>

<div class="container mt-5">
    <h2>Consulta de Bancos</h2>
    <a href="cadastro_banco.php" class="btn btn-add">+ Add Banco</a>
    <?php if (isset($_GET['success'])): ?>
        <div class="alert alert-success"><?= $_GET['success'] ?></div>
    <?php endif; ?>
    
    <table class="table table-bordered mt-3">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome do Banco</th>
                <th>Código do Banco</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($bancos as $b): ?>
                <tr>
                    <td><?= $b['id_banco'] ?></td>
                    <td><?= $b['nome'] ?></td>
                    <td><?= $b['codigo'] ?></td>
                    <td>
                        <a href="cadastro_banco.php?id=<?= $b['id_banco'] ?>" class="btn btn-primary btn-sm">Editar</a>

                        <a href="../controllers/BancoController.php?action=excluir&id=<?= $b['id_banco'] ?>" class="btn btn-danger btn-sm"
                           onclick="return confirm('Tem certeza que deseja excluir este banco?')">Excluir</a>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <a href="../" class="btn btn-add">&lArr; voltar</a>
</div>

<?php include 'footer.php'; ?>
