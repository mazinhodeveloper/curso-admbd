<?php include 'header.php'; ?>

<div class="container mt-5">
    <h2>Cadastrar Banco</h2>
    <form action="../controllers/BancoController.php?action=cadastrar" method="POST">
        <div class="mb-3">
            <label for="nome_banco" class="form-label">Nome do Banco:</label>
            <input type="text" name="nome_banco" id="nome_banco" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="codigo_banco" class="form-label">Código do Banco:</label>
            <input type="text" name="codigo_banco" id="codigo_banco" class="form-control" required>
        </div>
       <a href="../" class="btn btn-danger">CANCELAR</a> <button type="submit" class="btn btn-success">Cadastrar</button>
    </form>
</div>

<?php include 'footer.php'; ?>
