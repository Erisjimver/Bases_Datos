----------------------------Tipo_Usuario-------------------------------------------------
insert into Tipo_Usuario values(1,'Administrador');	
insert into Tipo_Usuario values(2,'Vendedor');	
	

----------------------------Empresa------------------------------------------------------
insert into Empresa values(1,'1207130889001','Zona Movil',052970665,'Av.Seminario');


----------------------------Empleados-----------------------------------------------------
insert into Empleados values(1,1,1,'Admin','59291',1207130889,'Israel','Jimenez',0980640987,'5 de agosto');
insert into Empleados values(2,2,1,'Yovendo','59291',0987554745,'Manuel','Cordoba',0998477454,'Malecon y 9 de octubre');
insert into Empleados values(3,2,1,'shardel','59291',1298745612,'Pikoro','Daimaku',0980142833,'3 de junio y martin ponce lupe');
insert into Empleados values(4,2,1,'Bellota','59291',1225488974,'Yardel','Galarza',0967090222,'Martin Icaza y Astudillo');
insert into Empleados values(5,2,1,'rafico','59291',1209875467,'Rafael','Correa',0981357871,'10de agosto y Sucre');
insert into Empleados values(6,2,1,'pacopa','59291',1207789586,'Paco','Moncallo',0978957496,'Av seminario y Hector Cabrera');
insert into Empleados values(7,2,1,'juanita','59291',0369857448,'Juana','Arcos',0936598745,'Cdla. 24 de mayo');
insert into Empleados values(8,2,1,'jin','59291','Jinna',0225987467,'Estasio',0975489768,'Sucre y calle Q');
insert into Empleados values(9,2,1,'rosita','59291',0225569874,'Rosa','Contreras',0980640987,'13 de octubre y Veintinilla');
insert into Empleados values(10,2,1,'mari','59291',0225874797,'Maribel','Suarez',0987851246,'Calle Quito y Rumichaca');



------------------------------Categoria-----------------------------------------------
insert into Categoria values(1,'Movil GB','Celulares gama baja');
insert into Categoria values(2,'Micas V','Micas de vidrio');
insert into Categoria values(3,'Micas P','Micas de plastico');
insert into Categoria values(4,'Auriculares','Celulares economicos');
insert into Categoria values(5,'Parlantes','Celulares economicos');
insert into Categoria values(6,'Movil GA','Celulares gama alta');
insert into Categoria values(7,'Movil GM','Celulares gama media');
insert into Categoria values(8,'Protectores P','Protectores de plastico');
insert into Categoria values(9,'Protectores AP','Protectores aluminio y plastico');
insert into Categoria values(10,'Cargadores','Tecnologia USB Tipo-C');	


--------------------------------Productos-------------------------------------
insert into Producto values(1,6,'LG G6','LG',452,5,'02/07/2017');
insert into Producto values(1,6,'LG G6','LG',452,5,'02/07/2017');
insert into Producto values(2,1,'Motorola Moto G4 Play','Motorola',30,5,'04/07/2017');
insert into Producto values(3,6,'Google Pixel','Google',700,5,'07/07/2017');
insert into Producto values(4,6,'Apple Iphone 7','Apple',749,5,'07/07/2017');
insert into Producto values(5,7,'LG V20','LG',480,5,'07/06/2017');
insert into Producto values(6,7,'Sansung J1','Sansung',180,5,'07/07/2017');
insert into Producto values(7,2,'Mica Sony Z3+','No marca',8,5,'07/05/2017');
insert into Producto values(8,3,'Mica Sansung J5','No marca',5,10,'11/02/2017');
insert into Producto values(9,3,'Mica Sansung J7','No marca',5,10,'07/04/2017');
insert into Producto values(10,10,'Cargador Sansung','Sansung',20,10,'03/03/2017');
insert into Producto values(11,8,'Protector Movil Z3','No marca',10,10,'07/07/2017');
insert into Producto values(12,8,'Protector Sansung J5','No marca',10,30,'07/07/2017');
insert into Producto values(13,4,'Auricular Sansung','Sansung',9,15,'22/04/2017');
insert into Producto values(14,5,'Parlante Bluetooth','LG',25,5,'11/04/2017');
insert into Producto values(15,1,'Celular Blue','Blue',40,10,'07/02/2017');
insert into Producto values(16,9,'Protector Huawei P9','No marca',13,5,'12/06/2017');
insert into Producto values(17,3,'Mica Huawei V3','No marca',5,15,'07/07/2017');
insert into Producto values(18,2,'Mica Sansung S7','No marca',10,5,'07/07/2017');
insert into Producto values(19,3,'Mica Sansung S5','No marca',8,5,'1/06/2017');
insert into Producto values(20,1,'Auriculares Sony','Sony',10,5,'2/05/2017');
insert into Producto values(21,3,'Mica Huawei P8','No marca',6,0,'07/07/2017');
insert into Producto values(22,3,'ayudaaa','No marca',6,0,'07/07/2017');


-----------------------clientes------------------------------------------
insert into Clientes values(1,1205789542,'Jimena','Jimenez',0991344530,'5 de agosto');
insert into Clientes values(2,0986654751,'Vanessa','Garcia',0912536548,'Sucre y Pechiche');





-----------------------Factura-------------------------------------------
insert into Factura values(1,2,1,'25/08/2017'); 
insert into Factura values(2,2,2,'26/08/2017'); 





--------------------------Detalle_Venta---------------------------------
insert into Detalle_Venta values(1,1,1,1,'celular',15.80,15.80);
insert into Detalle_Venta values(2,2,1,1,'mika',10,14);



