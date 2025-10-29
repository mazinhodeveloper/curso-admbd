<?php
include 'header.php';
require_once '../config/database.php';
require_once '../models/Cliente.php';
require_once '../models/Banco.php';
require_once '../models/Conta.php';
require_once '../controllers/ContaController.php';
$id = $_GET['id'] ?? "";
if($id) {
    $controller = new ContaController($pdo);
    $c = $controller->listarId($id);
    $acao = "atualizar";
} else {
    $acao = "cadastrar";
    $conta = [];
}
$clienteModel = new Cliente($pdo);
$bancoModel = new Banco($pdo);
$clientes = $clienteModel->listarClientes();
$bancos = $bancoModel->listarBancos();
?>

<div class="container mt-5">
    <h2>Cadastrar Conta</h2>
    <form action="../controllers/ContaController.php?action=<?=$acao?>" method="POST">
        <input type="hidden" name="id_conta" id="id_conta" value="<?= $c['id_conta'] ?? "" ?>">
        <div class="mb-3">
            <label for="id_cliente" class="form-label">Cliente:</label>
            <select name="id_cliente" id="id_cliente" class="form-control" required>
                <?php foreach ($clientes as $cliente): ?>
                    <option value="<?= $cliente['id_cliente'] ?>"><?= $cliente['nome'] ?></option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="mb-3">
            <label for="id_banco" class="form-label">Banco:</label>
            <select name="id_banco" id="id_banco" class="form-control" required>
                <?php foreach ($bancos as $banco): ?>
                    <option value="<?= $banco['id_banco'] ?>"><?= $banco['nome'] ?></option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="mb-3">
            <label for="tipo_conta" class="form-label">Tipo de Conta:</label>
            <input type="text" name="tipo_conta" id="tipo_conta" class="form-control" required value="<?= $c['tipo'] ?? "" ?>">
        </div>

        <div class="mb-3">
            <label for="saldo" class="form-label">Saldo Inicial:</label>
            <input type="number" step="0.01" name="saldo" id="saldo" class="form-control" value="<?= $c['saldo'] ?? "" ?>">
        </div>
        <a href="../" class="btn btn-danger">CANCELAR</a>  
        <button type="submit" class="btn btn-success"><?=strtoupper($acao)?></button>
    </form>
</div>

<?php include 'footer.php'; ?>
