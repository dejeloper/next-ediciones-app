DROP DATABASE IF EXISTS siglas;
CREATE DATABASE IF NOT EXISTS siglas;
USE siglas;

CREATE TABLE IF NOT EXISTS StateTypes(
    Id INT AUTO_INCREMENT primary key, 
    Name varchar(50) NOT NULL,
    Enabled smallint DEFAULT 1, 
    CreationUser varchar(30) NOT NULL DEFAULT 'ADMIN',
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdateUser varchar(30),
    UpdateDate datetime
) ENGINE=InnoDB AUTO_INCREMENT=101; 
 
CREATE TABLE IF NOT EXISTS PermitTypes(
    Id INT AUTO_INCREMENT primary key, 
    Name varchar(50) NOT NULL,
    Enabled smallint DEFAULT 1, 
    CreationUser varchar(30) NOT NULL DEFAULT 'ADMIN',
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdateUser varchar(30),
    UpdateDate datetime
) ENGINE=InnoDB AUTO_INCREMENT=101;

CREATE TABLE IF NOT EXISTS States(
    Id INT AUTO_INCREMENT primary key, 
    Name varchar(50) NOT NULL,
    Type INT NOT NULL, 
    Enabled smallint DEFAULT 1, 
    CreationUser varchar(30) NOT NULL DEFAULT 'ADMIN',
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdateUser varchar(30),
    UpdateDate datetime
) ENGINE=InnoDB AUTO_INCREMENT=101;

CREATE TABLE IF NOT EXISTS Permits(
    Id INT AUTO_INCREMENT primary key, 
    Name varchar(50) NOT NULL,
    Type INT NOT NULL, 
    Controller varchar(50) NOT NULL, 
    Enabled smallint DEFAULT 1, 
    CreationUser varchar(30) NOT NULL DEFAULT 'ADMIN',
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdateUser varchar(30),
    UpdateDate datetime
) ENGINE=InnoDB AUTO_INCREMENT=101;
 
CREATE TABLE IF NOT EXISTS DocumentTypes(
    Id INT AUTO_INCREMENT primary key, 
    Name varchar(50) NOT NULL,
    Code varchar(5) NOT NULL unique key,    
    Enabled smallint DEFAULT 1, 
    CreationUser varchar(30) NOT NULL DEFAULT 'ADMIN',
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdateUser varchar(30),
    UpdateDate datetime
) ENGINE=InnoDB AUTO_INCREMENT=101;

CREATE TABLE IF NOT EXISTS UserProfiles(
    Id INT AUTO_INCREMENT primary key, 
    Name varchar(50) NOT NULL,
    Enabled smallint DEFAULT 1, 
    CreationUser varchar(30) NOT NULL DEFAULT 'ADMIN',
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdateUser varchar(30),
    UpdateDate datetime
) ENGINE=InnoDB AUTO_INCREMENT=101;

CREATE TABLE IF NOT EXISTS Managers(
    Id INT AUTO_INCREMENT primary key, 
    Name varchar(50) NOT NULL,    
    Address varchar(30) NOT NULL,
    Phone1 varchar(10) NOT NULL,
    Phone2 varchar(10) NULL,
    Phone3 varchar(10) NULL,
    Job varchar(20) NOT NULL,
    Enabled smallint DEFAULT 1, 
    CreationUser varchar(30) NOT NULL DEFAULT 'ADMIN',
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdateUser varchar(30),
    UpdateDate datetime
) ENGINE=InnoDB AUTO_INCREMENT=101;

CREATE TABLE IF NOT EXISTS Users(
    Id INT AUTO_INCREMENT primary key, 
    User varchar(30) NOT NULL unique key,
    Pass varchar(100) NOT NULL, 
    Salt varchar(100) NOT NULL, 
    Name varchar(50) NOT NULL,
    DocumentType INT NOT NULL, 
    Document varchar(15) NOT NULL, 
    Profile INT NOT NULL, 
    Manager INT NOT NULL, 
    State INT NOT NULL, 
    ChangePass smallint DEFAULT 1, 
    Enabled smallint DEFAULT 1, 
    CreationUser varchar(30) NOT NULL DEFAULT 'ADMIN',
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdateUser varchar(30),
    UpdateDate datetime
) ENGINE=InnoDB AUTO_INCREMENT=101;

CREATE TABLE IF NOT EXISTS PermitByUsers(
    Id INT AUTO_INCREMENT primary key, 
    Permit INT NOT NULL, 
    User INT NOT NULL, 
    Enabled smallint DEFAULT 1, 
    CreationUser varchar(30) NOT NULL DEFAULT 'ADMIN',
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdateUser varchar(30),
    UpdateDate datetime
) ENGINE=InnoDB AUTO_INCREMENT=101;
 
CREATE TABLE IF NOT EXISTS Log(
    Id INT AUTO_INCREMENT primary key,  
    Module varchar(50) NOT NULL,
    Collection varchar(50) NOT NULL,
    Document INT NOT NULL,
    Action varchar(50) NOT NULL,
    Data varchar(5000) DEFAULT NULL,
    Description varchar(5000) DEFAULT NULL,
    User INT NOT NULL,
    UserName varchar(30) NOT NULL,
    Date datetime DEFAULT CURRENT_TIMESTAMP NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10000001;

CREATE TABLE IF NOT EXISTS LogError(
    Id INT AUTO_INCREMENT primary key,  
    Message varchar(5000),
    Collection varchar(50),
    Method varchar(50),
    Type varchar(50),
    Action varchar(50),
    Params varchar(5000), 
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10000001;

CREATE TABLE IF NOT EXISTS Parameters(
    Id INT AUTO_INCREMENT primary key, 
    Name varchar(100) NOT NULL,
    Value varchar(5000) NOT NULL,
    Description varchar(5000) NOT NULL,
    Enabled smallint DEFAULT 1, 
    CreationUser varchar(30) NOT NULL DEFAULT 'ADMIN',
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdateUser varchar(30),
    UpdateDate datetime
) ENGINE=InnoDB AUTO_INCREMENT=1001;
 
CREATE TABLE IF NOT EXISTS Labels(
    Id INT AUTO_INCREMENT primary key, 
    Name varchar(100) NOT NULL,
    Value varchar(5000) NOT NULL,
    Language varchar(10) NOT NULL DEFAULT 'ES_CO',
    Enabled smallint DEFAULT 1, 
    CreationUser varchar(30) NOT NULL DEFAULT 'ADMIN',
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdateUser varchar(30),
    UpdateDate datetime
) ENGINE=InnoDB AUTO_INCREMENT=10001;

ALTER TABLE States ADD CONSTRAINT serStates_StateTypes 
FOREIGN KEY (Type) REFERENCES StateTypes(Id); 

ALTER TABLE Permits ADD CONSTRAINT FK_Permits_PermitTypes
FOREIGN KEY (Type) REFERENCES PermitTypes(Id);

ALTER TABLE Users ADD CONSTRAINT FK_Users_DocumentTypes
FOREIGN KEY (DocumentType) REFERENCES DocumentTypes(Id); 

ALTER TABLE Users ADD CONSTRAINT FK_Users_UserProfiles
FOREIGN KEY (Profile) REFERENCES UserProfiles(Id); 

ALTER TABLE Users ADD CONSTRAINT FK_Users_Managers 
FOREIGN KEY (Manager) REFERENCES Managers(Id);  

ALTER TABLE Users ADD CONSTRAINT sers_UserStates 
FOREIGN KEY (State) REFERENCES States(Id);

ALTER TABLE PermitByUsers ADD CONSTRAINT FK_PermitByUsers_Users
FOREIGN KEY (User) REFERENCES Users(Id); 

ALTER TABLE PermitByUsers ADD CONSTRAINT FK_PermitByUsers_Permit 
FOREIGN KEY (Permit) REFERENCES Permits(Id);

ALTER TABLE Log ADD CONSTRAINT FK_Log_Users 
FOREIGN KEY (User) REFERENCES Users(Id); 

INSERT INTO `DocumentTypes` 
(`Name`, `Code`) 
VALUES 
('Cédula de Ciudadanía', 'CC'), 
('Cédula de Extranjería', 'CE'), 
('Pasaporte', 'PP'), 
('Nit', 'NIT');

INSERT INTO `UserProfiles` 
(`Name`) 
VALUES 
('Desarrollador'),
('Manager'),
('Coordinador'),
('Auxiliar'); 

INSERT INTO `StateTypes`
(`Name`) 
VALUES 
('Users'),
('Clientes'); 

INSERT INTO `States` 
(`Name`, `Type`) 
VALUES 
('Activo', 101),
('Inactivo', 101), 
('Bloqueado', 101); 

INSERT INTO `PermitTypes`
(`Name`) 
VALUES
('Página'),
('Acción'),
('Botón'),
('Menú'); 

INSERT INTO `Permits` 
(`Name`, `Type`, `Controller`) 
VALUES
('List Users', 101, 'Users'); 

INSERT INTO `Managers` 
(`Name`, `Address`, `Phone1`, `Phone2`, `Job`) 
VALUES 
('Jhonatan Guerrero', 'Cl 17 Sur 6 - 22', '3138227185', '5700426', 'Developer');

INSERT INTO `Users` 
(`Id`, `User`, `Pass`, `Salt`, `Name`, `DocumentType`, `Document`, `Profile`, `Manager`, `State`) 
VALUES 
(100, 'Desarrollador', '$2y$10$9g/9ajCbElCnpDYhuFqX7uK98q7VdyED4xQ7kslYfBPIVDUk3GyFe', '$2y$10$9g/9ajCbElCnpDYhuFqX7u3.rS/pxw==$', 'Jhonatan Guerrero', 101, '1024526544', 101, 101, 101); 
  
INSERT INTO `Parameters`
(`Name`, `Value`, `Description`) 
VALUES
('current_language', 'ES_CO', 'Current language of the application');

INSERT INTO `Labels`
(`Name`, `Value`, `Language`) 
VALUES
('LOGIN_REQUIRED_USER_PASS', 'Usuario y Contraseña Requerido', 'ES_CO'),
('LOGIN_ERROR_INVALID_USER_PASS', 'Usuario y Contraseña no válido', 'ES_CO'),
('USERS_ERROR_GET_ALL_USERS', 'Error al Consultar los usuarios', 'ES_CO'),  
('LOGIN_REQUIRED_USER_PASS', 'Usuario y Contraseña Requerido', 'ES_CO'),
('LOGIN_ERROR_INVALID_USER_PASS', 'Usuario y Contraseña no válido', 'ES_CO'),
('USERS_ERROR_GET_ALL_USERS', 'Error al Consultar los usuarios', 'ES_CO'),  
('LOGIN_TITLE', 'Inicio Sesión', 'ES_CO'),
('LOGIN_INPUT_USER', 'Usuario', 'ES_CO'),
('LOGIN_INPUT_PASS', 'Contraseña', 'ES_CO'),
('LOGIN_BUTTON_LOGIN', 'Iniciar sesión', 'ES_CO');