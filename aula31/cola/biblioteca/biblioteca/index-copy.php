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

        <section id="banco-tabelas" class="section-spacing">
            <div class="card">
                <div class="card-header">
                    <h2>Biblioteca</h2>
                </div>
                <div class="card-body">
                    <?php
                        include_once 'config.php'; // Include the database connection file
                        /*

                        $name = "Bia Developer";
                        $email = "developer@gmail.com"; 
                        $birth = "1997-12-30";
                        $INSERT = $CONNECTION->prepare("INSERT INTO usuarios (nome, email, data_nascimento) VALUES (?,?,?)");
                        $dados = [$name, $email, $birth];
                        if ($INSERT->execute($dados)) {  
                            echo "User $name included!";
                        } else {
                            echo "Can't insert!"; 
                        }*/
                        
                        $SELECT = $CONNECTION->prepare("SELECT * FROM usuarios");
                        $SELECT->execute();
                        //$usuarios = $SELECT->fetch(PDO::FETCH_ASSOC);
                        $usuarios = $SELECT->fetchAll(PDO::FETCH_ASSOC);
                        echo "<pre>";
                        print_r($usuarios);
                        //echo "<p>This is a PHP script embedded in HTML.</p>";
                    ?>
                </div>
            </div>
        </section>
        <!--
        <section id="mer" class="section-spacing">
            <div class="card">
                <div class="card-header">
                    <h2>Modelo de Entidade Relacionamento (MER)</h2>
                </div>
                <div class="card-body">
                    <p>Projeto de Banco de Dados de E-commerce</p> 
                    <img src="images/LojaVirtual-1.svg" alt="Modelo de Entidade Relacionamento (MER) - E-commerce" width="100%">
                </div>
            </div>
        </section>
        -->
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>