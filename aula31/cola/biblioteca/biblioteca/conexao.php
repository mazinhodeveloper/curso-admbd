<?php
    $HOST = "localhost"; 
    $USER = "root";
    $PASS = "";
    $PORT = 3306;
    $DB = "biblioteca";

    $conexao = new PDO("mysql:host=$HOST;dbname=$DB;port=$PORT", $USER, $PASS); 
    
    if ($conexao) {
        //echo "Connection successful!<br><br>"; 
    } 
    else {
        echo "Connection failed!<br><br>";
    }
    
    // CREATE TABLE teste 
    //$SQL = "CREATE TABLE IF NOT EXISTS teste (id_teste INT PRIMARY KEY AUTO_INCREMENT, teste VARCHAR(100))"; 
    //$CONNECTION->query($SQL); 

    /* // INSERT INTO teste 
    $SQL = "INSERT INTO teste (teste) VALUES ('Teste 01')";
    $INSERT = $CONNECTION->prepare($SQL); 
    $RESULT = $INSERT->execute();
    if ($RESULT) {  
        echo "Included with success!<br><br>"; 
    } 
    else {
        echo "Include failed!<br><br>";
    }
    */
?>
