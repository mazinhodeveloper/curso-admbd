<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Welcome to CodeIgniter 4!</title>
    <meta name="description" content="The small framework with powerful features">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" type="image/png" href="/favicon.ico">
    <link rel="stylesheet" href="<?= base_url('assets/css/style.css'); ?>">
</head>
<body>

<!-- HEADER: MENU + HEROE SECTION -->
<header>
    <div class="menu">
        <ul>
            <li class="logo">
                <a href="/">
                    <img src="<?= base_url('assets/images/logo-controle-financeiro.png'); ?>" alt="Controle Financeiro" width="150" />
                </a>
            </li>
            <li class="menu-toggle">
                <button id="menuToggle">&#9776;</button>
            </li>
            <li class="menu-item hidden"><a href="/">Início</a></li>
            <li class="menu-item hidden"><a href="/projeto">Projeto</a></li>
            <li class="menu-item hidden"><a href="/participantes">Participantes</a></li>
        </ul>
    </div>
</header>
