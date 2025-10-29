<?php include 'header.php';
require_once "../config/database.php";
require_once "../controllers/ClienteController.php";
$acao = "cadastrar";
$id = $_GET['id'] ?? "";
if($id) {
    $controller = new ClienteController($pdo);
    $c = $controller->listarId($id);
    $acao = "salvar";
}
?>

<div class="container mt-5">
    <h2>Cadastrar Cliente</h2>
    <form action="../controllers/ClienteController.php?action=<?=$acao?>" method="POST">
        <input type="hidden" name="id" id="id" value="<?=$id??""?>">
        <div class="mb-3">
            <label for="nome" class="form-label">Nome:</label>
            <input type="text" name="nome" id="nome" class="form-control" value="<?=$c['nome']??""?>" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">E-mail:</label>
            <input type="email" name="email" id="email" class="form-control" value="<?=$c['email']??""?>" required>
        </div>
        <div class="mb-3">
            <label for="cpf" class="form-label">CPF:</label>
            <input type="text" name="cpf" id="cpf" class="form-control" value="<?=$c['cpf']??""?>" required>
        </div>
        <div class="mb-3">
            <label for="telefone" class="form-label">Telefone:</label>
            <input type="text" name="telefone" id="telefone" value="<?=$c['telefone']??""?>" class="form-control">
        </div>
        <a href="../" class="btn btn-danger">CANCELAR</a> <button type="submit" class="btn btn-success"><?=strtoupper($acao)?></button>
    </form>
</div>

<?php include 'footer.php'; ?>