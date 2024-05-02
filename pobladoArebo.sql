--Planes
INSERT INTO planes (nombre,duracion,costo,maxmembers,days) VALUES ('Semana','1 Semana',150.00,1,7);
INSERT INTO planes (nombre,duracion,costo,maxmembers,days) VALUES ('Quincena','2 Semanas',300.00,1,15);
INSERT INTO planes (nombre,duracion,costo,maxmembers,days) VALUES ('Individual','1 Mes',400.00,1,30);
INSERT INTO planes (nombre,duracion,costo,maxmembers,days) VALUES ('Semestre','6 Meses',150.00,1,183);
INSERT INTO planes (nombre,duracion,costo,maxmembers,days) VALUES ('Anualidad','12 Meses',150.00,1,365);

INSERT INTO planes (nombre,duracion,costo,maxmembers,days) VALUES ('Estudiante','1 Mes',360.00,1,30);

INSERT INTO planes (nombre,duracion,costo,maxmembers,days) VALUES ('Pareja','1 Mes',360.00,1,30);

INSERT INTO planes (nombre,duracion,costo,maxmembers,days) VALUES ('Familiar','1 Mes',320.00,1,30);

--Horarios empleado
INSERT INTO horarios_emp (nombre,hora_entrada,hora_salida) VALUES ('Mañana','07:00:00','14:59:00');
INSERT INTO horarios_emp (nombre,hora_entrada,hora_salida) VALUES ('Tarde','15:00:00','22:59:00');
INSERT INTO horarios_emp (nombre,hora_entrada,hora_salida) VALUES ('Madrugada','23:00:00','6:59:00');

--Administrador(User)
INSERT INTO users (tipo, user_id, name, lastname, phone, direction, email, foto, qr, cargo, id_horario)
VALUES ('Personal','IDADAD12','Admin','Admin','Arebofitness','Poniente 20','arebofitness@gmail.com','','',1,1
);

INSERT INTO credentials (email, password, user_type, user_id) VALUES ('admin','Arebofitness','Personal','IDADAD12');
