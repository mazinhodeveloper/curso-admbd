Aula 08 
Professor: Celso  



MySQL Workbench 
USER: root 
PASS: senac 
HOST: localhost:3307 

Banco de Dados: escola 
CREATE DATABASE IF NOT EXISTS escola; 
USE escola; 


##### CREATE TABLE alunos ##### TABELA DO PROFESSOR 
USE escola; 
CREATE TABLE alunos ( 
	id_aluno INT AUTO_INCREMENT PRIMARY KEY, 
	aluno_nome VARCHAR(100), 
	aluno_cpf VARCHAR(20), 
	aluno_email VARCHAR(100), 
	aluno_nascimeno DATE, 
	aluno_telefone VARCHAR(20), 
	aluno_senha VARCHAR(255) 
); 

##### CREATE TABLE docentes 
CREATE TABLE docentes ( 
	id_docente INT AUTO_INCREMENT PRIMARY KEY, 
	docente_nome VARCHAR(100), 
	docente_cpf VARCHAR(20), 
	docente_email VARCHAR(100), 
	docente_formacao VARCHAR(100), 
	docente_telefone VARCHAR(20)
); 

##### CREATE TABLE ucs 
CREATE TABLE ucs ( 
	id_uc INT AUTO_INCREMENT PRIMARY KEY, 
	uc_titulo VARCHAR(100), 
	id_docente INT, 
    FOREIGN KEY (id_docente) REFERENCES docentes(id_docente)
); 

##### CREATE TABLE aulas 
CREATE TABLE aulas ( 
	id_aula INT AUTO_INCREMENT PRIMARY KEY, 
	aula_data date 
); 

##### CREATE TABLE aluno e turma 
CREATE TABLE aluno_turma (
	id_aluno INT, 
    	id_turma INT, 
    	PRIMARY KEY (id_aluno, id_turma), 
    	FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno), 
    	FOREIGN KEY (id_turma) REFERENCES turmas(id_turma)
);

##### CREATE TABLE turma e aula 
CREATE TABLE turma_aula (
    id_turma INT, 
    id_aula INT, 
    PRIMARY KEY (id_turma, id_aula), 
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma), 
    FOREIGN KEY (id_aula) REFERENCES aulas(id_aula) 
);





########################### SQL / PROFESSOR / AULA 

DROP DATABASE escola; 

########################### SQL / PROFESSOR / AULA / PARA IGUALAR TODOS 

CREATE DATABASE escola;
 
USE escola;
 
CREATE TABLE alunos ( 
	id_aluno int auto_increment primary key, 
	aluno_nome varchar(100), 
	aluno_cpf varchar(20), 
	aluno_email varchar(100), 
	aluno_nascimento date, 
	aluno_telefone varchar(20), 
	aluno_senha varchar(255) 
); 
 
CREATE TABLE docentes ( 
	id_docente int auto_increment primary key, 
	docente_nome varchar(100), 
	docente_cpf varchar(20), 
	docente_email varchar(100), 
	docente_formacao varchar(100), 
	decente_telefone varchar(20) 
);
 
CREATE TABLE cursos ( 
	id_curso INT AUTO_INCREMENT PRIMARY KEY, 
	CURSO_NOME varchar(70) NOT NULL, 
	CURSO_AREA varchar(70) NOT NULL 
); 
 
CREATE TABLE turmas ( 
	id_turma INT AUTO_INCREMENT PRIMARY KEY, 
	id_curso INT, 
	turma_data_inicio DATE, 
	turma_data_fim date, 
	horario varchar(10), 
	FOREIGN KEY (id_curso) REFERENCES cursos(id_curso) 
); 
 
CREATE TABLE ucs( 
	id_uc int auto_increment primary key, 
	uc_titulo varchar(100), 
	id_docente int, 
	foreign key (id_docente) references docentes(id_docente) 
); 
 
CREATE TABLE aulas ( 
	id_aula int auto_increment primary key, 
	aula_data date 
); 
 
CREATE TABLE aluno_turma ( 
	id_aluno int, 
	id_turma int, 
	primary key (id_aluno, id_turma), 
	foreign key (id_aluno) references alunos(id_aluno), 
	foreign key (id_turma) references turmas(id_turma) 
); 
 
CREATE TABLE turma_aula ( 
	id_turma int, 
	id_aula int, 
	primary key (id_turma,id_aula), 
	foreign key (id_turma) references turmas(id_turma), 
	foreign key (id_aula) references aulas(id_aula) 
); 
 
CREATE TABLE aula_uc ( 
	id_aula INT, 
	id_uc INT, 
 	PRIMARY KEY (id_aula, id_uc), 
	FOREIGN KEY (id_aula) REFERENCES aulas(id_aula), 
	FOREIGN KEY (id_uc) REFERENCES ucs(id_uc) 
); 
 
CREATE TABLE docente_uc ( 
	id_docente INT, 
	id_uc INT, 
	PRIMARY KEY (id_docente, id_uc), 
	FOREIGN KEY (id_docente) REFERENCES docentes(id_docente), 
	FOREIGN KEY (id_uc) REFERENCES ucs(id_uc) 
); 


INSERT INTO `alunos` (
	`id_aluno`, 
	`aluno_nome`, 
	`aluno_cpf`, 
	`aluno_email`, 
	`aluno_nascimento`, 
	`aluno_telefone`, 
	`aluno_senha`
) VALUES (NULL, 'Maria José da Silva', '11.111.11-11', 'msj@hotmail.com', '2015-01-08', '11 999999999', '123456'); 


INSERT INTO `cursos` (
	`id_curso`, 
	`CURSO_NOME`, 
	`CURSO_AREA`
) VALUES (NULL, 'Administrador de Banco de Dados', 'Informática Para Internet');

INSERT INTO `turmas` (`id_turma`, `id_curso`, `turma_data_inicio`, `turma_data_fim`, `horario`) VALUES (NULL, '1', '2025-07-01', '2025-07-31', '13:30');

INSERT INTO `aulas` (`id_aula`, `aula_data`) VALUES (NULL, '2025-06-27');

INSERT INTO `docentes` (`id_docente`, `docente_nome`, `docente_cpf`, `docente_email`, `docente_formacao`, `decente_telefone`) VALUES (NULL, 'Celso Caldeira', '111.111.222.22', 'celso@senac.com.br', 'Internet', '11 923443333');

INSERT INTO `ucs` (`id_uc`, `uc_titulo`, `id_docente`) VALUES (NULL, 'UC2 - Teste e melhorias em BD', '1');


INSERT INTO `turma_aula` (`id_turma`, `id_aula`) VALUES ('1', '1');

INSERT INTO `docente_uc` (`id_docente`, `id_uc`) VALUES ('1', '1');

INSERT INTO `aula_uc` (`id_aula`, `id_uc`) VALUES ('1', '1');

INSERT INTO `aluno_turma` (`id_aluno`, `id_turma`) VALUES ('1', '1');



















