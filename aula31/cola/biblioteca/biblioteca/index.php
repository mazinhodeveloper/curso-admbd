<!DOCTYPE html>
<html lang="pt-BR">
 
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca</title>
</head>
 
<body>
    <h1>Biblioteca</h1>
    <a href="livros.php">Livro</a>
    <?php
    include_once "conexao.php";

    if($_SERVER['REQUEST_METHOD'] == 'POST')
    {
        $nome = $_POST['nome'];
        $email = $_POST['email'];
        $nascimento = $_POST['nascimento'];
        $senha = $_POST['senha'];
        $insert = $conexao->prepare("INSERT INTO usuarios (nome, email, data_nascimento, senha) VALUES (?, ?, ?, ?)");
    
        $dados = [$nome, $email, $nascimento, $senha]; 
    
        if($insert->execute($dados)) {
            echo "Usuario $nome cadastrado com sucesso!";
        } else {
            echo "Não foi possivel cadastrar!";
        }
    }
 
    $select = $conexao->prepare("SELECT * FROM usuarios");
    $select->execute();
    $usuarios = $select->fetchAll(PDO::FETCH_ASSOC);
    echo "<pre>";
    print_r($usuarios);
    echo "</pre>";
    ?>
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
                <input type="password" name="senha">
            </div>
            <div>
                <label for="nascimento">Nascimento</label>
                <input type="date" name="nascimento">
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
                <?php
                foreach($usuarios AS $user)
                {
                    ?>
                    <tr>
                    <td><?=$user['id_usuario']?></td>
                    <td><?=$user['nome']?></td>
                    <td><?=$user['email']?></td>
                    <td><?=$user['senha']?></td>
                    <td><?=$user['data_nascimento']?></td>
                    <td><a href="#?id=">Editar</a> | <a href="#?id=">Deletar</a></td>
                    </tr>
                <?php
                }
                ?>
            </tbody>
        </table>
    </div>
</body>
 
</html>