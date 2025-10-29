Aula 09 
Professor: Lilian 
Data: 30/06/2025 


http://sis4.com/brModelo 
https://www.brmodeloweb.com/lang/pt-br/index.html 


Modelagem Conceitual 
Modelagem conceitual, Lógica, Física 
Modelo Entidade Relacionamento (ER) 
Diagrama Entidade Relacionamento (DER) 


Levantamento de Requisitos 
 - Funcionais 
 - Não Funcionais 


Cardinalidade 
 - Um-para-um (1:1) 
   Uma ocorrência de uma entidade está associada a no máximo uma ocorrência de outra entidade. 

 - Um-papa-muitos (1:m) 
   Uma ocorrência de uma entidade pode estar associada a várias ocorrências de outra entidade. 

 - Muitos-para-muitos (m:n) 
   Várias ocorrências de uma entidade podem estar associadas a várias ocorrências de outra entidade. 


Vamos praticar 
 - Levantamento de Requisitos 
 - Site Games 
   usuario (id_usuario, nome, codnome, data_nascimanto, cpf, telefone, email, senha, data_cadastro) 
   jogo (id_jogo, id_usuario, nome_jogo, tela_jogo, nivel_jogo, pontuacao_jogo, data_jogo, validade_jogo) 

 - Levantamento de Requisitos 
 - Banco (Genérico) 
   - SenaBanco (Banco Digital)
     - Cliente (Nome, CPF, Telefone, CNPJ, Data-Nascimento, Endereço, Email, Senha) 
     - Conta (agencia, Número-Conta, Data-Abertura, Titular, Saldo) 
     - Transacões (Valor, Data, Cliente, Conta) 
     - Serviços (Nome, Tipo, Taxa) 
     - Compra (Serviço, Data, Cliente, Conta, Valor) 

     - Modelo De Entidade Relacional (MER) 
       - Cliente: 
                 PK: id_cliente 
                 CPF: Unico 
                 CNPJ: Unico 

       - Conta: 
                 PK: id_conta 
                 FK: id_cliente 
                 Numero-Conta: Unico 

       - Transações: 
                 PK: id_transacoes 
                 FK: id_cliente 
                 FK: id_conta 

       - Serviços: 
                 PK: id_servicos 

       - Compra: 
                 PK: id_compra 
                 FK: id_cliente 
                 FK: id_conta 

       - Relacionamentos: 
           Cliente -> Conta (1,1 - 1,N) 
           Cliente -> Transações (1,1 - 1,N) 
           Cliente -> Compra (1,1 - 1,N) 
           Conta -> Transações (1,1 - 1,N) 
           Conta -> Compra (1,1 - 1,N) 


Diagrama de Entidade Relacional (DER) 






