Aula 07 
Professor: Celso  



MySQL Workbench 
USER: root 
PASS: senac 
HOST: localhost:3307 

Banco de Dados: escola 
CREATE DATABASE IF NOT EXISTS escola; 
USE escola; 

DROP DATABASE escola; 

CREATE DATABASE IF NOT EXISTS escola; 
USE escola; 

##### CREATE TABLE cursos
CREATE TABLE cursos (
	id_curso INT AUTO_INCREMENT PRIMARY KEY, 
	CURSO_NOME varchar(70) NOT NULL, 
	CURSO_AREA varchar(70) NOT NULL
);

SELECT * FROM cursos; 
USE cursos; 
INSERT INTO cursos (CURSO_NOME, CURSO_AREA) VALUES ('ADM Banco de Dados','Inf. Internet'); 
SELECT * FROM cursos; 
INSERT INTO cursos (CURSO_NOME, CURSO_AREA) VALUES ('PHP com MySQL','Inf. Internet');  
SELECT * FROM cursos; 
INSERT INTO cursos (CURSO_NOME, CURSO_AREA) VALUES ('Logistica','Negocios'); 
SELECT * FROM cursos; 
INSERT INTO cursos (CURSO_NOME, CURSO_AREA) VALUES ('Jardinagem','Paisagismo'); 
SELECT * FROM cursos; 

SELECT * FROM escola.cursos; 
UPDATE cursos SET curso_nome='Csharp' WHERE id_curso=2; 
SELECT * FROM escola.cursos; 

INSERT INTO cursos (CURSO_NOME, CURSO_AREA) VALUES ('Abobrinha', 'Hortaliças'); 
SELECT * FROM escola.cursos; 

DELETE FROM cursos WHERE id_curso=5;  
SELECT * FROM escola.cursos; 

ALTER TABLE cursos MODIFY CURSO_NOME VARCHAR(90); 
SELECT * FROM cursos;


SELECT COUNT(id_curso) as total FROM cursos; 

SELECT * FROM cursos; 
SELECT COUNT(id_curso) as total FROM cursos; 
SELECT CURSO_AREA, COUNT(id_curso) as total FROM cursos GROUP BY CURSO_AREA; 
SELECT * FROM cursos ORDER BY CURSO_NOME; 
SELECT * FROM cursos ORDER BY CURSO_NOME DESC; 


##### CREATE TABLE turmas
CREATE TABLE turmas ( 
	id_turma INT AUTO_INCREMENT PRIMARY KEY,
	id_curso INT, 
	turma_data_inicio DATE NOT NULL, 
	turma_data_fim DATE, 
	horario VARCHAR(10), 
	FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
); 

##### INSERT INTO turmas 
INSERT INTO turmas (
	id_curso, 
	turma_data_inicio, 
	turma_data_fim, 
	horario
) VALUES (1,'2025-07-01','2025-09-30','13:30'); 

INSERT INTO turmas (
	id_curso, 
	turma_data_inicio, 
	turma_data_fim, 
	horario
) VALUES (2,'2025-08-01','2025-10-30','13:30'); 


SELECT * FROM turmas; 

SELECT * FROM turmas INNER JOIN cursos ON turmas.id_curso=cursos.id_curso; 

SELECT * FROM turmas; 

##### CREATE TABLE alunos
CREATE TABLE alunos ( 
	id_aluno INT AUTO_INCREMENT PRIMARY KEY, 
	aluno_nome VARCHAR(70) NOT NULL, 
	aluno_cpf VARCHAR(20) UNIQUE NOT NULL, 
	aluno_email VARCHAR(70) UNIQUE NOT NULL, 
	aluno_nascimeno DATE, 
	aluno_telefone VARCHAR(20), 
	aluno_senha VARCHAR(255) NOT NULL 
); 

SELECT * FROM alunos; 

##### INSERT INTO alunos 
INSERT INTO alunos (
	aluno_nome, 
	aluno_cpf, 
	aluno_email, 
	aluno_nascimeno, 
	aluno_telefone, 
	aluno_senha
) VALUES ('Douglas Augusto','33212376523','douglas@gmail.com','2005-02-04','+55 (11) 93456-8532','01:30'); 

INSERT INTO alunos (
	aluno_nome, 
	aluno_cpf, 
	aluno_email, 
	aluno_nascimeno, 
	aluno_telefone, 
	aluno_senha
) VALUES ('Regiane Dias','78912323255','regiane@outlook.com','2001-08-11','+55 (12) 93456-8588','11:22'); 

INSERT INTO alunos (
	aluno_nome, 
	aluno_cpf, 
	aluno_email, 
	aluno_nascimeno, 
	aluno_telefone, 
	aluno_senha
) VALUES ('Hugo Dias','43287694323','hugo@outlook.com','1998-04-02','+55 (12) 93433-9901','00:46'); 

INSERT INTO alunos (
	aluno_nome, 
	aluno_cpf, 
	aluno_email, 
	aluno_nascimeno, 
	aluno_telefone, 
	aluno_senha
) VALUES ('Gilmar Menezes','12343294953','gilmar@uol.com.br','1992-09-01','+55 (22) 99841-9458','12:18'); 






