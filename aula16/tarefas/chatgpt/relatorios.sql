
-- View com reservas completas
CREATE VIEW vw_reservas_completas AS
SELECT
  r.id_reserva,
  u.nome_cliente,
  v.codigo_voo,
  v.origem_voo,
  v.destino_voo,
  r.data_reserva,
  r.status_reserva,
  ar.numero_assento
FROM reserva r
JOIN usuario u ON r.id_cliente = u.id_cliente
JOIN voo v ON r.id_voo = v.id_voo
JOIN assento_reservado ar ON r.id_reserva = ar.id_reserva;

-- Top 5 clientes com mais reservas
SELECT
  u.nome_cliente,
  COUNT(r.id_reserva) AS total_reservas
FROM usuario u
JOIN reserva r ON u.id_cliente = r.id_cliente
GROUP BY u.nome_cliente
ORDER BY total_reservas DESC
LIMIT 5;

-- Total de reservas por voo
SELECT
  v.codigo_voo,
  COUNT(r.id_reserva) AS total_reservas
FROM voo v
JOIN reserva r ON v.id_voo = r.id_voo
GROUP BY v.codigo_voo
ORDER BY total_reservas DESC;

-- Reservas por status
SELECT
  status_reserva,
  COUNT(*) AS quantidade
FROM reserva
GROUP BY status_reserva;

-- Clientes que viajaram para 'Salvador'
SELECT DISTINCT u.nome_cliente
FROM usuario u
JOIN reserva r ON u.id_cliente = r.id_cliente
JOIN voo v ON r.id_voo = v.id_voo
WHERE v.destino_voo = 'Salvador';
