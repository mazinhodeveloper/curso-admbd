Aula 19 
Professor: Lilian 
Data: 28/07/2025 


Integridade Referencial 
 - Dados Íntegros 
 - Restrições de Integridade Referencial 
 - Restrict / Cascade / Set Null 

InnoDB 




DELETE FROM usuario WHERE 'id_usuario' = 1;


CREATE TABLE fornecedor (
	id_fornecedor INT AUTO_INCREMENT,
	fornecedor_nome VARCHAR(100)
);

INSERT INTO `fornecedor` (`id_fornecedor`, `fornecedor_nome`) VALUES (1, 'Amazon'), (2, 'Americanas');



ALTER TABLE `pagamentos` ADD FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor); 












