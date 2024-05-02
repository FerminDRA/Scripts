DROP DATABASE IF EXISTS arebofitness;
CREATE DATABASE arebofitness;
\c arebofitness

-- Crear la tabla Planes
CREATE TABLE Planes (
    id_plan SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    duracion VARCHAR(50) NOT NULL,
    costo NUMERIC(10, 2) NOT NULL,
    maxmembers SMALLINT NOT NULL,
    days SMALLINT NOT NULL
);

-- Crear la tabla Horario_empleados
CREATE TABLE Horarios_emp (
    id_horario SERIAL PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL
);
/*
CREATE TABLE users (
    tipo character varying(31) NOT NULL,
    user_id character varying(30)UNIQUE NOT NULL PRIMARY KEY,
    age character varying(255),
    email character varying(255),
    foto TEXT,
    lastname character varying(255),
    name character varying(255),
    phone character varying(255),
    qr TEXT,
    cargo SMALLINT,
    id_plan integer REFERENCES planes(id_plan),
    id_horario integer REFERENCES horarios_emp(id_horario)
);
*/
CREATE TABLE users (
    tipo character varying(31) NOT NULL,
    user_id character varying(30)UNIQUE NOT NULL PRIMARY KEY,
    direction character varying(255),
    foto TEXT,
    lastname character varying(255),
    name character varying(255),
    phone character varying(255),
    qr TEXT,
    fnac character varying(255),
    cargo SMALLINT,
    email character varying(255),
    id_plan integer REFERENCES planes(id_plan),
    id_horario integer REFERENCES horarios_emp(id_horario)
);

--Credenciales
CREATE TABLE credentials (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    user_type VARCHAR(255),
    user_id character varying(30) REFERENCES users(user_id)
);


-- Crear la tabla Registro_Entradas
CREATE TABLE Registro_Entradas (
    id_registros SERIAL PRIMARY KEY,
    hora_entrada TIME NOT NULL,
    hora_salida TIME,
    fecha DATE NOT NULL,
    user_id VARCHAR(30) REFERENCES users(user_id)
);

-- Crear la tabla Pagos
CREATE TABLE Pagos (
    id_pago CHAR(20) PRIMARY KEY,
    usuarios bytea,
    user_id VARCHAR(30) REFERENCES users(user_id),
    id_plan INTEGER REFERENCES Planes(id_plan),
    f_inicio DATE NOT NULL,
    f_fin DATE NOT NULL,
    fecha_pago DATE NOT NULL,
    comprobante TEXT,
    monto_pago NUMERIC(10, 2)
);

CREATE TABLE pago_usuario (
    id_pg_usr SERIAL PRIMARY KEY,
    id_pago CHAR(20),
    user_id VARCHAR(30),
    FOREIGN KEY (id_pago) REFERENCES Pagos(id_pago),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

/*
--Crea la vista allUsers
CREATE OR REPLACE VIEW allUsers AS 
SELECT 
    ROW_NUMBER() OVER() AS id,
    u.user_id AS id_usuario,
    u.name AS nombres,
    u.phone AS telefono,
    u.direction as direccion,
    pl.nombre AS nombrePlan,
    MAX(pg.f_fin) AS termino,
    pl.duracion AS duracion,
    pl.costo AS costo
FROM
    users u
JOIN
    planes pl ON u.id_plan = pl.id_plan
LEFT JOIN
    pagos pg ON pl.id_plan = pg.id_plan
WHERE
    u.tipo = 'Cliente'
GROUP BY
    u.user_id, u.name, u.phone, u.direction, pl.nombre, pl.duracion, pl.costo
ORDER BY u.user_id ASC; */

CREATE OR REPLACE VIEW allUsers AS 
SELECT 
    ROW_NUMBER() OVER() AS id,
    u.user_id AS id_usuario,
    u.name AS nombres,
    u.phone AS telefono,
    u.direction AS direccion,
    pl.nombre AS nombrePlan,
    MAX(pg.f_fin) AS termino,
    pl.duracion AS duracion,
    pl.costo AS costo
FROM
    users u
JOIN
    planes pl ON u.id_plan = pl.id_plan
LEFT JOIN
    pago_usuario pu ON u.user_id = pu.user_id
LEFT JOIN
    pagos pg ON pu.id_pago = pg.id_pago
WHERE
    u.tipo = 'Cliente'
GROUP BY
    u.user_id, u.name, u.phone, u.direction, pl.nombre, pl.duracion, pl.costo
ORDER BY
    u.user_id ASC;



--Crea la vista allRegisters
create or replace view allRegisters as 
select
	re.id_registros as id_reg,
	u.user_id as id_usuario,
	u.name as nombres,
	re.hora_entrada as hora_entrada,
	re.hora_salida as hora_salida,
	re.fecha as fecha
	from users u 
	join registro_entradas re on u.user_id=re.user_id
	where u.tipo='Cliente'
	order by re.hora_entrada ASC
	;
