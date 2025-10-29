<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banco Digital</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/index.css">
</head>
<body>

<div class="container-fluid">
    <div class="container">
        <div class="text-center mb-5 text-white">
            <h1>Banco Digital Interativo</h1>
            <p>Gerencie clientes, contas, bancos e pagamentos de forma prática e rápida!</p>
        </div>

        <div class="row g-4">
            <!-- Clientes -->
            <div class="col-md-3">
                <div class="card text-center p-4">
                    <i class="fa-solid fa-users fa-3x mb-3"></i>
                    <h3 class="card-title">Clientes</h3>
                    <a href="templates/consulta_clientes.php" class="btn btn-custom mt-3">Acessar</a>
                </div>
            </div>
            
            <!-- Contas -->
            <div class="col-md-3">
                <div class="card text-center p-4">
                    <i class="fa-solid fa-wallet fa-3x mb-3"></i>
                    <h3 class="card-title">Contas</h3>
                    <a href="templates/consulta_contas.php" class="btn btn-custom mt-3">Acessar</a>
                </div>
            </div>
            
            <!-- Bancos -->
            <div class="col-md-3">
                <div class="card text-center p-4">
                    <i class="fa-solid fa-university fa-3x mb-3"></i>
                    <h3 class="card-title">Bancos</h3>
                    <a href="templates/consulta_bancos.php" class="btn btn-custom mt-3">Acessar</a>
                </div>
            </div>
            
            <!-- Pagamentos -->
            <div class="col-md-3">
                <div class="card text-center p-4">
                    <i class="fa-solid fa-cash-register fa-3x mb-3"></i>
                    <h3 class="card-title">Pagamentos</h3>
                    <a href="templates/consulta_pagamentos.php" class="btn btn-custom mt-3">Acessar</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="assets/js/index.js"></script>
</body>
</html>