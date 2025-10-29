<?php include 'header.php';
$id = isset($_GET['id']) ? $_GET['id'] : null;
$acao = 'cadastrar';
if ($id) {
    require_once __DIR__ . '/../models/Banco.php';
    $bancoModel = new Banco($pdo);
    $banco = $bancoModel->buscarBancoPorId($id);
    $acao = 'atualizar';
    if (!$banco) {
        echo "<div class='alert alert-danger'>Banco não encontrado.</div>";
        exit;
    }
} else {
    $acao = 'cadastrar';
}
?>

<div class="container mt-5">
    <h2>Cadastrar Banco</h2>
    <form action="../controllers/BancoController.php?action=<?=$acao?>" method="POST">
        <input type="hidden" name="id_banco" value="<?=$banco['id_banco'] ?? ''?>">
        <div class="mb-3">
            <label for="nome_banco" class="form-label">Nome do Banco:</label>
            <input type="text" name="nome_banco" id="nome_banco" class="form-control" value="<?=$banco['nome']?>" required>
        </div>
        <div class="mb-3">
            <label for="codigo_banco" class="form-label">Código do Banco:</label>
            <input type="text" name="codigo_banco" id="codigo_banco" class="form-control" value="<?=$banco['codigo']?>" required>
        </div>
       <a href="../" class="btn btn-danger">CANCELAR</a> <button type="submit" class="btn btn-success"><?=strtoupper($acao)?></button>
    </form>
</div>

<?php include 'footer.php'; ?>
