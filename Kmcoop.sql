disconnect;
connect system/kevinmejia;

drop tablespace KmCoop including contents and datafiles; 
drop user kmcoop cascade;


create tablespace KmCoop 
datafile 'data_TKmCoop.dbf'
size  30M autoextend on;

create user kmcoop
identified by 12345
default tablespace KmCoop;

grant connect  to kmcoop;
grant resource to kmcoop;
grant create view to kmcoop;
disconnect;

connect kmcoop/12345;


CREATE TABLE Tipos_Cuentas
(
	codigo_tipo        number NOT NULL PRIMARY KEY,
	tipo_cuenta        NVARCHAR2(20) NOT NULL
);

insert into Tipos_Cuentas values(1,'credito');
insert into Tipos_Cuentas values(2,'ahorro');

CREATE TABLE Clientes
(
	n_cuenta           number NOT NULL PRIMARY KEY,
	cedula             NVARCHAR2(13) NOT NULL,
	nombres            NVARCHAR2(40) NOT NULL,
	apellido           NVARCHAR2(40) NOT NULL,
	direccion          NVARCHAR2(40) NOT NULL,
	telefono           NVARCHAR2(15) NOT NULL,
	celular            NVARCHAR2(15) NOT NULL,
	saldo              number NOT NULL,
	estado			   NVARCHAR2(15) NOT NULL,
	codigo_tipo		   number NOT NULL,
	constraint CF_TipoC_Clientes foreign key(codigo_tipo) references Tipos_Cuentas(codigo_tipo)
);


insert into Clientes values(1,'0987654321','Manuel','Medrano','cdla. 5 esquinas','123456789','099874568',500,'activa',1);
insert into Clientes values(2,'1234567890','kevin','mejia','vicente rocafuerte y calle q','052970889','099999999',300,'inactiva',2);


  update clientes set saldo = 400 where n_cuenta =(select s.n_cuenta from servicios  s inner join emsaba e on s.codigo_servicio = e.codigo_servicio where e.numero_medidor=1);
CREATE TABLE Servicios
(
	codigo_servicio	   number NOT NULL PRIMARY KEY,
	tipo_servicios     NVARCHAR2(20) NOT NULL,
	n_cuenta           number NOT NULL,
	constraint CF_Clientes_Servicios foreign key(n_cuenta) references Clientes(n_cuenta)
);

insert into Servicios values(1,'agua',1);
insert into Servicios values(2,'luz',1);
insert into Servicios values(3,'agua',2);
insert into Servicios values(4,'luz',2);


CREATE TABLE Emsaba
(
	numero_medidor     number NOT NULL PRIMARY KEY,
	tipo_medidor       NVARCHAR2(20) NOT NULL,
	valor_m3           number NOT NULL,
	codigo_servicio	   number NOT NULL,
	constraint CF_Emsaba_Servicios foreign key(codigo_servicio) references Servicios(codigo_servicio)
);


--primer usuario
insert into Emsaba values(1,'viejo',80,1);
--segundo usuario
insert into Emsaba values(2,'viejo',80,3);


CREATE TABLE Cnel
(
	numero_medidor     number NOT NULL PRIMARY KEY,
	tipo_medidor       NVARCHAR2(20) NOT NULL,
	valor_kwh          number NOT NULL,
	codigo_servicio	   number  NOT NULL,
	constraint CF_Cnel_Servicios foreign key(codigo_servicio) references Servicios(codigo_servicio)
);
--primer usuario
insert into cnel values(1,'viejo',140,2);
--segundo usuario
insert into cnel values(2,'viejo',280,4);

CREATE TABLE Pagos_Emsaba
(
	numero_pago        number NOT NULL PRIMARY KEY,
	fecha              date NOT NULL,
	consumo            number NOT NULL,
	cancelado	       number NOT NULL,
	numero_medidor	   number NOT NULL,
	constraint CF_PagosE_Emsaba foreign key(numero_medidor) references Emsaba(numero_medidor)
);


CREATE TABLE Pagos_Cnel
(
	numero_pago        number NOT NULL PRIMARY KEY,
	fecha              date NOT NULL,
	consumo            number NOT NULL,
	cancelado	       number NOT NULL,
	numero_medidor	   number NOT NULL,
	constraint CF_PagosC_Cnel foreign key(numero_medidor) references Cnel(numero_medidor)
);


CREATE TABLE Movimientos
(
	nregistro		   number NOT NULL PRIMARY KEY,
	fecha              date NOT NULL,
	movimiento         NVARCHAR2(40) NOT NULL,
	cantidad           number NOT NULL,
	numero_documento   number NOT NULL,
	n_cuenta           number NOT NULL,
	constraint CF_Clientes_Movimientos foreign key(n_cuenta) references Clientes(n_cuenta)
);

CREATE TABLE Prestamos
(
	numero_prestamo    number NOT NULL PRIMARY KEY,
	monto              number NOT NULL,
	fecha_inicio       date NOT NULL,
	fecha_fin          date NOT NULL,
	cancelado          number NOT NULL,
	numeros_pagos      number NOT NULL,
	interes			   number NOT NULL,
	n_cuenta           number NOT NULL,
	constraint CF_CLientes_Prestamos foreign key(n_cuenta) references Clientes(n_cuenta)
);

CREATE TABLE Pagos_Prestamo
(
	numero_pago        number NOT NULL PRIMARY KEY,
	fecha              number NOT NULL,
	cantidad           number NOT NULL,
	numero_prestamo    number NOT NULL,
	constraint CF_Prestamos_PagosP foreign key(numero_prestamo) references Prestamos(numero_prestamo)
);


-----------procedimientos almacenados---------


--procedimiento transaccion

create or replace procedure transaccion (cantidad number,co number,cd number)
as
   begin
      savepoint inicio;

	  UPDATE Clientes SET saldo = saldo - cantidad where n_cuenta=co;
	  UPDATE Clientes SET saldo = saldo + cantidad where n_cuenta=cd;
commit;	  
exception 
when others then
rollback to savepoint inicio;
commit;
end transaccion;
/

--transaccionresta el saldo segun el dinero que se desea enviar a la otra cuenta
--aumenta el saldo a la cuenta que recibe el dinero


------------secuencia codigo pagos_emsaba------------------
CREATE SEQUENCE secuencia_numero_pago
START WITH 1
INCREMENT BY 1 
NOMAXVALUE;

--secuencia que incrementa en 1 la id de la tabla pagos_emsaba

----------procedimientos pagar servicios Agua-----------------
create or replace procedure pagosServiciosAgua (nm in number,consu in number, cancelado in number)
as
   begin
      savepoint inicio;

	  UPDATE emsaba SET valor_m3= 0 where numero_medidor=nm;
	  insert into pagos_emsaba values(secuencia_numero_pago.NEXTVAL,Sysdate, consu,cancelado,nm);
	  update clientes set saldo = saldo-cancelado where n_cuenta =(select s.n_cuenta from servicios  s inner join emsaba e on s.codigo_servicio = e.codigo_servicio where e.numero_medidor=nm);

commit;	  
exception 
when others then
rollback to savepoint inicio;
commit;
end pagosServiciosAgua;
/

-- procedimiento almacenado que alpagar la deuda de agua reinicia a 0 el consumo lo cual es interpretado como cancelacion de ladeuda
--inserta los datos de pago en la tabla pagos emsaba
--actualiza el saldo del cliente restando el valor cancelado

------------secuencia codigo pagos_cnel------------------
CREATE SEQUENCE secuencia_numero_pago_cnel
START WITH 1
INCREMENT BY 1 
NOMAXVALUE;

----------procedimientos pagar servicios Luz-----------------
create or replace procedure pagosServiciosLuz (nm in number,consu in number, cancelado in number)
as
   begin
      savepoint inicio;

	  UPDATE cnel SET valor_kwh= 0 where numero_medidor=nm;
	  insert into pagos_cnel values(secuencia_numero_pago_cnel.NEXTVAL,Sysdate, consu,cancelado,nm);
	  update clientes set saldo = saldo-cancelado where n_cuenta =(select s.n_cuenta from servicios  s inner join emsaba e on s.codigo_servicio = e.codigo_servicio where e.numero_medidor=nm);

commit;	  
exception 
when others then
rollback to savepoint inicio;
commit;
end pagosServiciosLuz;
/
--procedimiento almacenadoretiro----
create or replace procedure retiro(cantidad number,nc number)
as
   begin
      savepoint puntouno;

	  UPDATE Clientes SET saldo = saldo - cantidad where n_cuenta=nc;
	  
commit;	  
exception 
when others then
rollback to savepoint puntouno;
commit;
end retiro;
/

commit;

--select c.saldo, e.valor_m3 from Clientes c inner join servicios s on c.n_cuenta = s.n_cuenta inner join emsaba e on e.codigo_servicio = s.codigo_servicio where e.numero_medidor=1;
--select c.saldo, e.valor_kwh from Clientes c inner join servicios s on c.n_cuenta = s.n_cuenta inner join emsaba e on e.codigo_servicio = s.codigo_servicio where e.numero_medidor=1;
--update clientes set saldo = 500 where n_cuenta =(select s.n_cuenta from servicios  s inner join emsaba e on s.codigo_servicio = e.codigo_servicio where e.numero_medidor=1);
--update cliente set saldo=400 where n_cuenta=1;
--update cnel set valor_kwho=190 where numero_medidor=1;
--select c.saldo, e.valor_m3 from Clientes c inner join servicios s on c.n_cuenta = s.n_cuenta inner join emsaba e on e.codigo_servicio = s.codigo_servicio where c.cedula='1802846145';