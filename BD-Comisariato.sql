disconnect;
connect system/59291;

drop tablespace TspComisariat including contents and datafiles; 

drop user isra cascade;

create tablespace TspComisariat
datafile 'data_Comisariat.dbf'
size  30M autoextend on;

create user isra
identified by 59291
default tablespace TspComisariat;

grant connect  to isra;
grant resource to isra;
grant create view to isra;

disconnect;

connect isra/59291;



CREATE TABLE Clientes
(
	IdCliente             number NOT NULL PRIMARY KEY,
	NombreCompania        varchar(40) NOT NULL,
	NombreContacto        varchar(40) NOT NULL,
	CargoContacto         varchar(40) NOT NULL,
	Direccion             varchar(40) NOT NULL ,
	Ciudad                varchar(40) NOT NULL ,
	Region                varchar(40) NOT NULL,
	CodPostal          	  number NOT NULL,
	Pais                  varchar(40) NOT NULL,
    Telefono              number NOT NULL,
    Fax                   varchar(40) NOT NULL
);

CREATE TABLE Companias_de_envios
(
	IdCompaniaEnvios      number NOT NULL PRIMARY KEY,
	NombreCompania        varchar(40) NOT NULL,
    Telefono              number NOT NULL
);

CREATE TABLE Empleados
(
	IdEmpleado        	number NOT NULL PRIMARY KEY,
	Apellidos         	varchar(40) NOT NULL,
	Nombres           	varchar(40) NOT NULL,
	Cargo             	varchar(40) NOT NULL,
    Tratamiento       	varchar(40) NOT NULL,
    FechaNacimiento   	date NOT NULL,
    FechaContratacion 	date NOT NULL,
	Direccion         	varchar(40) NOT NULL ,
	Ciudad            	varchar(40) NOT NULL ,
	Region            	varchar(40) NOT NULL,
	CodPostal      	  	number NOT NULL,
	Pais              	varchar(40) NOT NULL,
    TelDomicilio      	number NOT NULL,
    Extension         	varchar(40) NOT NULL,
    Notas             	varchar(40) NOT NULL,
    Jefe              	varchar(40) NOT NULL
);

CREATE TABLE Pedidos(
    IdPedido			number NOT NULL PRIMARY KEY,
    IdCliente			number NOT NULL,
    IdCompaniaEnvios	number NOT NULL,
    IdEmpleado			number NOT NULL,
    FechaPedido			date NOT NULL,
    FechaEntrega		date NOT NULL,
    FechaEnvio			date NOT NULL,
    Cargo				varchar(40) NOT NULL,
    Destinatario		varchar(40) NOT NULL,
    DireccionDestinatario	varchar(40) NOT NULL,
    CiudadDestinatario		varchar(40) NOT NULL,
    RegionDestinatario		varchar(40) NOT NULL,
    CodPostalDestinatario	number NOT NULL,
    PaisDestinatario		varchar(40) NOT NULL,
constraint CF_Client_Pedidos foreign key(IdCliente) references Clientes(IdCliente),
constraint CF_Compania_Envios_Pedidos foreign key(IdCompaniaEnvios) references Companias_de_envios(IdCompaniaEnvios),
constraint CF_Empleado_Pedidos foreign key(IdEmpleado) references Empleados(IdEmpleado)
);


CREATE TABLE Proveedores
(
	IdProveedor			number NOT NULL PRIMARY KEY,
	NombreCompania		varchar(40) NOT NULL,
	NombreContacto		varchar(40) NOT NULL,
	CargoContacto		varchar(40) NOT NULL,
	Direccion			varchar(40) NOT NULL ,
	Ciudad				varchar(40) NOT NULL ,
	Region				varchar(40) NOT NULL,
	CodPostal			number NOT NULL,
	Pais				varchar(40) NOT NULL,
    Telefono			number NOT NULL,
    Fax					varchar(40) NOT NULL,
    PaginaPrincipal		varchar(40) NOT NULL
);

CREATE TABLE Categorias
(
	IdCategorias        number NOT NULL PRIMARY KEY,
	NombreCategoria     varchar(40) NOT NULL,
	Descripcion         varchar(40) NOT NULL);

CREATE TABLE Productos
(
	IdProducto			number NOT NULL PRIMARY KEY,
	IdCategorias		number NOT NULL,
    IdProveedor			number NOT NULL,
	NombreProducto		varchar(40) NOT NULL,
    CantidadPorUnidad	number NOT NULL,
    PrecioUnidad 		number NOT NULL,
    UnidadesExistencias number NOT NULL,
    UnidadesPedido		number NOT NULL,
    NivelNuevoPedido	number NOT NULL,
    Suspendido			varchar(40) NOT NULL,
constraint CF_Proveedores_Productos foreign key(IdProveedor) references Proveedores(IdProveedor),
constraint CF_categorias_Productos foreign key(IdCategorias) references Categorias(IdCategorias)
);
  
CREATE TABLE Detalle_Pedidos
( 
	IdPedido     		number NOT NULL,
	IdProducto   		number NOT NULL,
	PrecioUnidad 		number NOT NULL,
	Cantidad     		number NOT NULL,
	Descuento    		number NOT NULL,
constraint CF_Productos_Detalles foreign key(IdProducto) references Productos(IdProducto),
constraint CF_Pedidos_Detalles foreign key(IdPedido) references Pedidos(IdPedido));



commit;
