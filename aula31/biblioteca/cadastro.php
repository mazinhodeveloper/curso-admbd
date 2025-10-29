<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UC2 Projeto</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 20px; /* Adjust for fixed navbar */
        }
        .container { 
            margin-bottom: 40px; 
        } 
        .jumbotron {
            padding: 2rem 1rem;
            margin-bottom: -1rem;
            background-color: #e9ecef;
            border-radius: .3rem;
        }
        .section-spacing {
            padding-top: 60px;
        }
        h2, h2 { 
            font-size: 1.6rem; 
        }
        pre {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
        }
        /* X-Small devices (portrait phones, less than 576px)
           No media query for `xs` since this is the default in Bootstrap */ 

        /* Small devices (landscape phones, 576px and up) */ 
        /* @media (min-width: 576px) { ul.navbar-nav li.nav-item { font-size: 0.9rem; } } */ 
        @media (min-width: 6px) { ul.navbar-nav li.nav-item { font-size: 0.9rem; } }

        /* Medium devices (tablets, 768px and up) */ 
        @media (min-width: 768px) { ul.navbar-nav li.nav-item { font-size: 0.9rem; } }

        /* Large devices (desktops, 992px and up) */ 
        @media (min-width: 992px) { ul.navbar-nav li.nav-item { font-size: 0.9rem; } }

        /* X-Large devices (large desktops, 1200px and up) */ 
        @media (min-width: 1200px) { ul.navbar-nav li.nav-item { font-size: 1rem; } }

        footer .container { margin-bottom: 0px; padding-bottom: 10px; font-size: 0.8rem; } 
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <a class="navbar-brand" href="#">PHP</a>
    </nav>

    <div class="container">
    <div>
        <h2>Formulário de cadastro</h2>
        <form method="post">
            <div>
                <label for="nome">Nome</label>
                <input type="text" name="nome">
            </div>
            <div>
                <label for="email">Email</label>
                <input type="text" name="email">
            </div>
            <div>
                <label for="senha">Senha</label>
                <input type="text" name="senha">
            </div>
            <div>
                <label for="nascimento">Nascimento</label>
                <input type="text" name="nascimento">
            </div>
            <div>
                <button type="submit">CADASTRAR</button>
            </div>
        </form>
    </div>
    <div>
        <h2>Cadastrados</h2>
        <table>
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Senha</th>
                    <th>Nascimento</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <!-- Essa parte será repetida para cada registro do banco -->
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><a href="#?id=">Editar</a> | <a href="#?id=">Deletar</a></td>
                </tr>
                <!-- fim repetição -->
            </tbody>
        </table>
    </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>