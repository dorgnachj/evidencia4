ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'root';
CREATE TABLE Biodigestor (
    id_biodigestor SERIAL PRIMARY KEY,
    temperatura_optima_minima DECIMAL(5, 2) NOT NULL,
    temperatura_optima_maxima DECIMAL(5, 2) NOT NULL,
    ph_optimo_minimo DECIMAL(5, 2) NOT NULL,
    ph_optimo_maximo DECIMAL(5, 2) NOT NULL,
    cantidad_ideal_minima DECIMAL(5, 2) NOT NULL,
    cantidad_ideal_maxima DECIMAL(5, 2) NOT NULL
);

CREATE TABLE Sensores (
    id_sensor SERIAL PRIMARY KEY,
    tipo_sensor VARCHAR(50) NOT NULL,
    valor_actual DECIMAL(5, 2) NOT NULL,
    id_biodigestor INT REFERENCES Biodigestor(id_biodigestor)
);

CREATE TABLE Historico_Lecturas (
    id_lectura SERIAL PRIMARY KEY,
    fecha_lectura TIMESTAMP NOT NULL,
    valor_lectura DECIMAL(5, 2) NOT NULL,
    id_sensor INT REFERENCES Sensores(id_sensor)
);
-- Insertar datos en la tabla Biodigestor
INSERT INTO Biodigestor (temperatura_optima_minima, temperatura_optima_maxima, ph_optimo_minimo, ph_optimo_maximo, cantidad_ideal_minima, cantidad_ideal_maxima)
VALUES (30.00, 40.00, 6.50, 7.50, 50.00, 100.00);

INSERT INTO Biodigestor (temperatura_optima_minima, temperatura_optima_maxima, ph_optimo_minimo, ph_optimo_maximo, cantidad_ideal_minima, cantidad_ideal_maxima)
VALUES (28.00, 38.00, 6.00, 7.00, 60.00, 120.00);

-- Insertar datos en la tabla Sensores
INSERT INTO Sensores (tipo_sensor, valor_actual, id_biodigestor) VALUES ('Temperatura', 32.50, 1);
INSERT INTO Sensores (tipo_sensor, valor_actual, id_biodigestor) VALUES ('PH', 6.80, 1);
INSERT INTO Sensores (tipo_sensor, valor_actual, id_biodigestor) VALUES ('Nivel', 55.00, 1);
INSERT INTO Sensores (tipo_sensor, valor_actual, id_biodigestor) VALUES ('Temperatura', 35.00, 2);
INSERT INTO Sensores (tipo_sensor, valor_actual, id_biodigestor) VALUES ('PH', 6.50, 2);
INSERT INTO Sensores (tipo_sensor, valor_actual, id_biodigestor) VALUES ('Nivel', 70.00, 2);

-- Insertar datos en la tabla Historico_Lecturas
INSERT INTO Historico_Lecturas (fecha_lectura, valor_lectura, id_sensor) VALUES ('2024-09-01 12:00:00', 32.50, 1);
INSERT INTO Historico_Lecturas (fecha_lectura, valor_lectura, id_sensor) VALUES ('2024-09-01 13:00:00', 33.00, 1);
INSERT INTO Historico_Lecturas (fecha_lectura, valor_lectura, id_sensor) VALUES ('2024-09-01 12:30:00', 6.80, 2);
INSERT INTO Historico_Lecturas (fecha_lectura, valor_lectura, id_sensor) VALUES ('2024-09-01 13:30:00', 6.75, 2);
INSERT INTO Historico_Lecturas (fecha_lectura, valor_lectura, id_sensor) VALUES ('2024-09-01 14:00:00', 55.00, 3);

SELECT s.tipo_sensor, s.valor_actual
FROM Sensores s
JOIN Biodigestor b ON s.id_biodigestor = b.id_biodigestor
WHERE b.id_biodigestor = 1;

SELECT h.fecha_lectura, h.valor_lectura
FROM Historico_Lecturas h
JOIN Sensores s ON h.id_sensor = s.id_sensor
WHERE s.tipo_sensor = 'Temperatura' AND s.id_biodigestor = 1;

SELECT b.id_biodigestor, s.valor_actual AS temperatura
FROM Sensores s
JOIN Biodigestor b ON s.id_biodigestor = b.id_biodigestor
WHERE s.tipo_sensor = 'Temperatura' 
AND (s.valor_actual < b.temperatura_optima_minima OR s.valor_actual > b.temperatura_optima_maxima);

SELECT b.id_biodigestor, s.valor_actual AS ph_actual
FROM Sensores s
JOIN Biodigestor b ON s.id_biodigestor = b.id_biodigestor
WHERE s.tipo_sensor = 'PH' 
AND (s.valor_actual < b.ph_optimo_minimo OR s.valor_actual > b.ph_optimo_maximo);

SELECT AVG(h.valor_lectura) AS promedio_temperatura
FROM Historico_Lecturas h
JOIN Sensores s ON h.id_sensor = s.id_sensor
WHERE s.tipo_sensor = 'Temperatura' 
AND s.id_biodigestor = 1 
