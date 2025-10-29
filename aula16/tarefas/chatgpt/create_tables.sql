
CREATE TABLE usuario (
  id_cliente INT PRIMARY KEY,
  nome_cliente VARCHAR(100),
  nascimento_cliente DATE
);

CREATE TABLE endereco_cliente (
  id_endereco INT PRIMARY KEY,
  id_cliente INT,
  rua VARCHAR(100),
  cidade VARCHAR(100),
  estado VARCHAR(50),
  cep VARCHAR(20),
  FOREIGN KEY (id_cliente) REFERENCES usuario(id_cliente)
);

CREATE TABLE voo (
  id_voo INT PRIMARY KEY,
  codigo_voo VARCHAR(20),
  origem_voo VARCHAR(100),
  destino_voo VARCHAR(100),
  data_voo DATE,
  horario_voo TIME,
  valor_voo DECIMAL(10,2)
);

CREATE TABLE reserva (
  id_reserva INT PRIMARY KEY,
  id_cliente INT,
  id_voo INT,
  data_reserva DATE,
  status_reserva VARCHAR(20),
  FOREIGN KEY (id_cliente) REFERENCES usuario(id_cliente),
  FOREIGN KEY (id_voo) REFERENCES voo(id_voo)
);

CREATE TABLE assento_reservado (
  id_assento INT PRIMARY KEY,
  id_reserva INT,
  numero_assento VARCHAR(10),
  FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva)
);
