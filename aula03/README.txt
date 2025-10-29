Aula 03

Professor: Celso 

UC2: Realizar monitoramento do uso e desempenho dos sistemas de banco de dados 

XAMPP 
MySQL Workbench 

http://localhost/dashboard
http://localhost/phpmyadmin


DROP TABLE clientes; 
DROP TABLE fornecedores;
DROP DATABASE financeiro;

CREATE DATABASE senac; 

USE senac; 
CREATE TABLE alunos(
    id_aluno int(11) PRIMARY KEY AUTO_INCREMENT,
    nome_aluno varchar(60),
    cpf varchar(20),
    rg varchar(20),
    email varchar(20),
    celular varchar(25)
);


USE senac; 
INSERT INTO `alunos` (
    `id_aluno`, `nome_aluno`, `cpf`, `rg`, `email`, `celular`
  ) 
  VALUES (
    1, 'Celso Caldeira', '111.111.111-11', '11.111.111-11', 'celso.caldeira@gmail.com', '+55(11)1111-1111'
);
INSERT INTO `alunos` (
    `id_aluno`, `nome_aluno`, `cpf`, `rg`, `email`, `celular`
  ) 
  VALUES (
    2,'Maria Carlota', '222.222.222-22', '22.222.222-22', 'maria.carlota@gmail.com', '+55(11)2222-2222'
);

USE senac; 
SELECT * FROM `alunos` WHERE id_aluno=1; 
SELECT * FROM `alunos` WHERE nome_aluno LIKE '%celso%'; 
UPDATE alunos SET celular='+55 (11) 8888-6666', email='celso@senac.com.br' WHERE id_aluno=1;


### INSERT 
USE senac; 
INSERT INTO `alunos` (
    `nome_aluno`, `cpf`, `rg`, `celular`, `email`
  ) 
  VALUES (
    'José Manuel da Silva', '333.333333-33', '33.444.444-44', '11 2222-2222', 'zesilva@hotmail.com'
);


### UPDATE 
USE senac; 
UPDATE `alunos` SET celular='11 8888-6666', email='celso@senac.com.br' WHERE id_aluno=1;



### DELETE 
DELETE FROM alunos WHERE id_aluno=2; 
# Cuidado com esse comando! 

### ALTER TABLE 
ALTER TABLE `alunos` ADD `oculto` INT NOT NULL AFTER `celular`;
SELECT * FROM alunos oculto=0;

SELECT * FROM `alunos` WHERE oculto=0 AND id_aluno=1;

### INSERT 
USE senac; 
INSERT INTO `alunos` (
    `nome_aluno`, `cpf`, `rg`, `celular`, `email`
  ) 
  VALUES (
    'Joaquim da Silva Neto', '444.333333-33', '33.444.444-44', '11 4444-2222', 'joaquim@hotmail.com'
);

SELECT *,SUBSTRING(nome_aluno,1,LOCATE(' ', nome_aluno)) as primeiro_nome FROM alunos;


### INSERT 
INSERT INTO `cursos` (id_curso, nome_curso, descricao) VALUES (NULL, 'PHP', ''); 
INSERT INTO `cursos` (id_curso, nome_curso, descricao) VALUES (NULL, 'MYSQL', ''); 
INSERT INTO `cursos` (id_curso, nome_curso, descricao) VALUES (NULL, 'JAVA', ''); 


### RELACIONANDO TABELAS 
ALTER TABLE alunos ADD CONSTRAINT fk_alunos_curso FOREIGN KEY (id_curso) REFERENCES cursos (id_curso); 


### DROP DATABASE 
DROP DATABASE senac; 

CREATE DATABASE senac; 




