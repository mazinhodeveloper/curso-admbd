<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>Livros</h1>
    <?php
    include_once "conexao.php";

    if(isset($_POST['titulo']))
    {
        $titulo = $_POST['titulo'];        
        $autor = $_POST['autor'];
        $descricao = $_POST['descricao'];        
        $ano = $_POST['ano'];

        $dados = [$titulo, $autor, $descricao, $ano];
        $insert = $conexao->prepare("INSERT INTO livros (titulo, id_autor, descricao, ano_publicacao) values (?, ?, ?, ?)");
        
        if($insert->execute($dados))
        {
            echo "Livro cadastrado com sucesso!";
        }
        else
        {
            echo "ERRO: O livro não foi cadastrado!";
        }       

    }
    if(isset($_POST['filtrar']))
    {
        $filtro = $_POST['filtrar'] ?? '';
        $pesquisar = $conexao->prepare("SELECT * FROM livros WHERE titulo LIKE '%$filtro%'");
        $pesquisar->execute();
        
        //echo "<pre>";
       //print_r($f);
       // echo "</pre>";

    }
    else
    {
        $filtro = $_POST['filtrar'] ?? '';
        $pesquisar = $conexao->prepare("SELECT * FROM livros");
        $pesquisar->execute();
    }
    ?>
    <div>
        <form method="post">
            <div>
                <label for="titulo">Titulo</label>
                <input type="text" name="titulo">
            </div>
            <div>
                <label for="autor">Autor</label>
                <select name="autor" id="autor">
                <?php
                $select = $conexao->query("SELECT * FROM autor");
                while($autores = $select->fetch())
                {
                    echo "<option value=".$autores['id_autor'].">";
                    echo $autores['nome']." ".$autores['sobrenome']."</option>";
                }
                ?>
                </select>

            </div>
            <div>
                <label for="ano">Ano</label>
                <input type="number" name="ano">
            </div>
            <div>
                <label for="descricao">Descricao</label>
                <textarea name="descricao"></textarea>
            </div>
            <div>
                <button type="submit">CADASTRAR</button>
            </div>
        </form>
    </div>

    <div>

        <form method = "post">        
            <div>
                <label for="filtro">Filtrar</label>
                <input type="text" name="filtrar" id="filtrar">
                <button type="submit">OK</button>
            </div>

        </form>
        <table>
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Titulo</th>
                    <th>Autor</th>
                    <th>Disponivel</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <?php
                    while($f = $pesquisar->fetch()){
                ?>
                <tr>
                    <td><?=$f['id_livro']?></td>
                    <td><?=$f['titulo']?></td>
                    <td><?=$f['id_autor']?></td>
                    <td><?=$f['disponivel']?"Sim":"Não"?></td>
                    <td>Editar | Deletar</td>
                </tr>
                <?php
                }
                ?>
            </tbody>
        </table>
    </div>
</body>
</html>