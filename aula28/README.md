Aula 28 
Professor: Lilian 
Data: 18/08/2025 


# Biblioteca: livros, autores, usuarios, emprestimos 
## Cria banco de dados 
CREATE DATABASE biblioteca; 

USE biblioteca;

## Cria tabela usuarios 
CREATE TABLE usuarios ( 
	id_usuario int PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(120) NOT NULL, 
    email VARCHAR(120) UNIQUE, 
    data_nascimento DATE, 
    idade int 
); 

## Cria tabela autor 
CREATE TABLE autor ( 
	id_autor int PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(150) NOT NULL, 
    sobrenome VARCHAR(150), 
    nacionalidade VARCHAR(70) 
); 

## Cria tabela livros 
CREATE TABLE livros ( 
	id_livro int PRIMARY KEY AUTO_INCREMENT, 
    titulo VARCHAR(150), 
    descricao TEXT, 
    id_autor INT, 
    ano_publicacao VARCHAR(4), 
    disponivel BOOLEAN DEFAULT true, 
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor) ON DELETE CASCADE 
); 

## Cria tabela emprestimo 
CREATE TABLE emprestimo ( 
	id_emprestimo int PRIMARY KEY AUTO_INCREMENT, 
    id_usuario int, 
    id_livro int, 
    data_emprestimo DATE DEFAULT current_timestamp, 
    data_devolucao DATE NULL, 
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE, 
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro) ON DELETE CASCADE 
); 




