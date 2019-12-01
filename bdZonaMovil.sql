disconnect;
connect system/59291;

drop tablespace TspZonaMovil including contents and datafiles; 
drop user proyecto cascade;


create tablespace TspZonaMovil
datafile 'data_ZonaMovil.dbf'
size  30M autoextend on;

create user proyecto
identified by 59291
default tablespace TspZonaMovil;

grant connect  to proyecto;
grant resource to proyecto;
grant create view to proyecto;
disconnect;

connect proyecto/59291;



CREATE TABLE Empresa
(
	IdEmpresa          number NOT NULL PRIMARY KEY,
	Ruc                NVARCHAR2(13) NOT NULL,
	NombreEmpresa      NVARCHAR2(40) NOT NULL,
	Telefono           number NOT NULL,
	Direccion          NVARCHAR2(40) NOT NULL
);

----------------------------Empresa------------------------------------------------------
insert into Empresa values(1,'1207130889001','Zona Movil',052970665,'Av.Seminario');


CREATE TABLE Tipo_Usuario
(
	IdTipo_Usuario     number NOT NULL PRIMARY KEY,
    Tipo_Usuario       NVARCHAR2(13)  NOT NULL
);

----------------------------Tipo_Usuario-------------------------------------------------
insert into Tipo_Usuario values(1,'Administrador');	
insert into Tipo_Usuario values(2,'Vendedor');


CREATE TABLE Vendedor
(
	IdVendedor        number NOT NULL PRIMARY KEY,
	IdTipo_Usuario	  number not null,	
	IdEmpresa         number NOT NULL,
	Contrasena        NVARCHAR2(15) NOT NULL,	
	Cedula            number NOT NULL,
	Nombres           NVARCHAR2(40) NOT NULL,
	Apellidos         NVARCHAR2(40) NOT NULL,
	Telefono          NVARCHAR2(13) null,
    Direccion         NVARCHAR2(40) NOT NULL,
	constraint CF_Empresa_Empleados foreign key(IdEmpresa) references Empresa (IdEmpresa),
	constraint CF_Tipo_usuario_Empleados foreign key(IdTipo_Usuario) references Tipo_Usuario (IdTipo_Usuario)
);
insert into Vendedor values(1,1,1,'59291',1207130889,'Israel','Jimenez',0980640987,'5 de agosto');
insert into Vendedor values(2,2,1,'59291',0987554745,'Manuel','Cordoba',0998477454,'Malecon y 9 de octubre');

CREATE TABLE Categoria
(
	IdCategoria      number NOT NULL PRIMARY KEY,
	descripcion      NVARCHAR2(20) NOT NULL
);


CREATE TABLE Producto
(
	IdProducto        number NOT NULL PRIMARY KEY,
	IdCategoria       number NOT NULL,
	NombreProducto    NVARCHAR2 (40) NOT NULL,
	Marca			  NVARCHAR2(15)NOT NULL,
	Costo			  number not null,
	Precio            number NOT NULL,
	Stock             number NOT NULL,			  
    FechaIngreso      DATE NOT NULL,
	constraint CF_Categoria_Producto foreign key(IdCategoria) references Categoria(IdCategoria)
);

CREATE TABLE Clientes
( 
	IdCliente         number NOT NULL PRIMARY KEY,
	Cedula            NVARCHAR2(13) NOT NULL,
	Nombre            NVARCHAR2(40) NOT NULL,
	Telefono          NVARCHAR2(15) NOT NULL,
	Direccion         NVARCHAR2(40) NOT NULL
);

CREATE TABLE Factura
(
	IdFactura         number NOT NULL PRIMARY KEY,
	IdVendedor        number NOT NULL,
	IdCliente         number NOT NULL,
	FechaEmision      date NOT NULL,
constraint CF_Clientes_Factura foreign key(IdCliente) references Clientes(IdCliente),
constraint CF_Vendedor_DFactura foreign key(IdVendedor) references Vendedor(IdVendedor)
);
  
CREATE TABLE Detalle_Venta
(
  IdDetalle_Venta	   number NOT NULL PRIMARY KEY,
  IdFactura            number NOT NULL,
  IdProducto		   number NOT NULL,
  Cantidad             number NOT NULL,
  ValorUnitario		   number NOT NULL,
  ValorTotal		   number NOT NULL,
constraint CF_Factura_Detalle_Ventas foreign key(IdFactura) references Factura (IdFactura),
constraint CF_Producto_Detalle_Venta foreign key(IdProducto) references Producto (IdProducto)
);

create table ControlEventos(
  usuario varchar2(13),
  fecha date,
  codigo number,
  precioanterior number,
  precionuevo number
 );
 
create table ControlPrecios(
  mensaje varchar2(40),
  precioanterior number,
  precionuevo number,
  fecha date
 );
--select dv.IdDetalle_Venta, dv.Cantidad, dv.Detalle,dv.ValorTotal from Factura f inner join Detalle_Venta dv on dv.IdFactura = f.IdFactura where f.fecha='26/08/2017';
commit;