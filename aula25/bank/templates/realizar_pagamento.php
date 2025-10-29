<?php
include 'header.php';
require_once '../config/database.php';
require_once '../models/Conta.php';

$contaModel = new Conta($pdo);
$contas = $contaModel->listarContas();
?>

<div class="container mt-5">
    <h2>Realizar Pagamento</h2>
    <form action="../controllers/PagamentoController.php?action=realizar" method="POST">
        <div class="mb-3">
            <label for="id_conta" class="form-label">Conta:</label>
            <select name="id_conta" id="id_conta" class="form-control" required>
                <?php foreach ($contas as $conta): ?>
                    <option value="<?= $conta['id_conta'] ?>">
                        <?= $conta['nome'] ?> (<?= $conta['tipo'] ?> - Saldo: R$ <?= number_format($conta['saldo'], 2, ',', '.') ?>)
                    </option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="mb-3">
            <label for="valor" class="form-label">Valor do Pagamento:</label>
            <input type="number" step="0.01" name="valor" id="valor" class="form-control" required>
        </div>
        <a href="../" class="btn btn-danger">CANCELAR</a>  <button type="submit" class="btn btn-success">PAGAR</button>
    </form>
</div>

<?php include 'footer.php'; ?>
