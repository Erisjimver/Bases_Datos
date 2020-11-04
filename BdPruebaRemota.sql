----------------------------Empresa------------------------------------------------------

CREATE TABLE Tipo_Usuario
(
	IdTipo_Usuario     	number NOT NULL PRIMARY KEY,
    Tipo_Usuario       	NVARCHAR2(13)  NOT NULL,
    Usuario       		NVARCHAR2(13)  NOT NULL,
    Contraseña       	NVARCHAR2(13)  NOT NULL
);



