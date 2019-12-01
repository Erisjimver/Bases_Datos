create table persona(
cedula varchar(13),
nombre varchar(15),
apellido varchar(15),
fechaa varchar(15),
anio int,
mes int,
dia int
);

insert into persona(cedula,nombre,apellido,fechaa,anio,mes,dia) values('123456789','Juan','Ramirez','18/05/1997',20,05,16);
delete from persona where nombre='Marcelo';
ALTER TABLE public.persona ADD COLUMN edad varchar(50);