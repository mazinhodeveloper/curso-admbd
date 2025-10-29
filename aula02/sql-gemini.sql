-- Table for Users
CREATE TABLE usuarios (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Books
CREATE TABLE livros (
    livro_id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    ano_publicacao INT,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE
);

-- Table for Loans (linking Users and Books)
CREATE TABLE emprestimos (
    emprestimo_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    livro_id INT NOT NULL,
    data_emprestimo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_devolucao_prevista DATE,
    data_devolucao_real DATE,
    status ENUM('emprestado', 'devolvido', 'atrasado') DEFAULT 'emprestado',
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
    FOREIGN KEY (livro_id) REFERENCES livros(livro_id)
);

