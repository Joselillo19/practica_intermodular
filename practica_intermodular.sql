DROP DATABASE IF EXISTS practica_intermodular;

CREATE DATABASE practica_intermodular;

USE practica_intermodular;

-- Creación de la tabla Estrellas
CREATE TABLE Estrellas (
    id_estrella INT PRIMARY KEY,
    nombre VARCHAR(50),
    tipo VARCHAR(50),
    radio DECIMAL(10, 2),
    temperatura INT,
    composicion VARCHAR(100),
    fecha_creacion date null
);

-- Creación de la tabla Planetas
CREATE TABLE Planetas (
    id_planeta INT PRIMARY KEY,
    nombre VARCHAR(50),
    tipo VARCHAR(50),
    radio DECIMAL(10, 2),
    temperatura INT,
    distancia DECIMAL(10, 2),
    periodo_orbital INT,
    id_estrella INT,
    numero_satelites INT,
    fecha_creacion date null,
    FOREIGN KEY (id_estrella) REFERENCES Estrellas(id_estrella)
);

-- Creación de la tabla Satelites
CREATE TABLE Satelites (
    id_satelite INT PRIMARY KEY,
    nombre VARCHAR(50),
    planeta VARCHAR(50),
    radio DECIMAL(10, 2),
    distancia_media DECIMAL(10,2),
    periodo_orbital INT,
    temperatura_media INT,
    tipo_cuerpo VARCHAR(50),
    id_planeta INT,
    fecha_creacion date null,
    FOREIGN KEY (id_planeta) REFERENCES Planetas(id_planeta)
);

-- Inserción de datos de ejemplo en las tablas (puedes personalizar los datos)
INSERT INTO Estrellas (id_estrella, nombre, tipo, radio, temperatura, composicion) VALUES (1, 'Sol', 'Estrella principal', 696342, 5505, 'Hidrógeno, Helio');
-- Inserción de datos de los Planetas
INSERT INTO Planetas (id_planeta, nombre, tipo, radio, temperatura, distancia, periodo_orbital, id_estrella, numero_satelites) 
VALUES 
(1, 'Mercurio', 'Rocoso', 2439.7, 167, 57.9, 88, 1, 1),
(2, 'Venus', 'Rocoso', 6051.8, 464, 108.2, 225, 1, 0),
(3, 'Tierra', 'Rocoso', 6371, 15, 149.6, 365, 1, 1),
(4, 'Marte', 'Rocoso', 3389.5, -65, 227.9, 687, 1, 2),
(5, 'Júpiter', 'Gaseoso', 69911, -145, 778.6, 4331, 1, 79),
(6, 'Saturno', 'Gaseoso', 58232, -178, 1433.5, 10747, 1, 82),
(7, 'Urano', 'Gaseoso', 25362, -224, 2872.5, 30660, 1, 27),
(8, 'Neptuno', 'Gaseoso', 24622, -218, 4495.1, 60152, 1, 14);

INSERT INTO Satelites (id_satelite, nombre, planeta, radio, distancia_media, periodo_orbital, temperatura_media, tipo_cuerpo) VALUES
(1, 'Luna', 'Tierra', 1737.4, 384400, 27.3, -53, 'Sólido/Rocoso'),
(2, 'Fobos', 'Marte', 11.1, 9378, 0.3, -40, 'Sólido/Rocoso'),
(3, 'Deimos', 'Marte', 6.2, 23460, 1.3, -40, 'Sólido/Rocoso'),
(4, 'Ío', 'Jupiter', 1821.6, 421700, 1.8, -143, 'Sólido/Rocoso'),
(5, 'Europa', 'Jupiter', 1560.8, 670900, 3.5, -160, 'Sólido/Hielo'),
(6, 'Ganimedes', 'Jupiter', 2634.1, 1070400, 7.2, -163, 'Sólido/Hielo'),
(7, 'Calisto', 'Jupiter', 2410.3, 1882700, 16.7, -139, 'Sólido/Hielo'),
(8, 'Titán', 'Saturno', 2575.5, 1222000, 15.9, -179, 'Sólido/Hielo'),
(9, 'Encélado', 'Saturno', 252.1, 238000, 1.4, -201, 'Sólido/Hielo'),
(10, 'Titania', 'Urano', 788.4, 435900, 8.7, -203, 'Sólido/Hielo'),
(11, 'Oberón', 'Urano', 761.4, 583500, 13.5, -203, 'Sólido/Hielo');


DELIMITER //

CREATE TRIGGER act_num_satelites
BEFORE INSERT ON satelites
FOR EACH ROW
BEGIN
    update Planetas
    SET numero_satelites = numero_satelites + 1
    where nombre = new.planeta;
END;
//

DELIMITER //

CREATE TRIGGER nueva_fecha_estrellas
BEFORE INSERT ON estrellas
FOR EACH ROW
BEGIN
    SET new.fecha_creacion = NOW();
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER nueva_fecha_planetas
BEFORE INSERT ON planetas
FOR EACH ROW
BEGIN
    SET new.fecha_creacion = NOW();
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER nueva_fecha_satelites
BEFORE INSERT ON satelites
FOR EACH ROW
BEGIN
    SET new.fecha_creacion = NOW();
END;
//

DELIMITER ;


