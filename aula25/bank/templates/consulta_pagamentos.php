<?php
include 'header.php';
require_once '../config/database.php';
require_once '../models/Pagamento.php';

$pagamentoModel = new Pagamento($pdo);
$pagamentos = $pagamentoModel->listarPagamentos();
?>

<div class="container mt-5">
    <h2>Consulta de Pagamentos</h2>
    <a href="realizar_pagamento.php" class="btn btn-add">+ Pagar</a>
    <?php if (isset($_GET['success'])): ?>
        <div class="alert alert-success"><?= $_GET['success'] ?></div>
    <?php elseif (isset($_GET['error'])): ?>
        <div class="alert alert-danger"><?= $_GET['error'] ?></div>
    <?php endif; ?>
    
    <table class="table table-bordered mt-3">
        <thead>
            <tr>
                <th>ID</th>
                <th>ID Conta</th>
                <th>Valor</th>
                <th>Data</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($pagamentos as $pagamento): ?>
                <tr>
                    <td><?= $pagamento['id_pagamento'] ?></td>
                    <td><?= $pagamento['id_conta'] ?></td>
                    <td>R$ <?= number_format($pagamento['valor'], 2, ',', '.') ?></td>
                    <td><?= $pagamento['data_pagamento'] ?></td>
                    <td><?= $pagamento['status_pagamento'] ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <a href="../" class="btn btn-add">&lArr; voltar</a>
</div>

<?php include 'footer.php'; ?>
