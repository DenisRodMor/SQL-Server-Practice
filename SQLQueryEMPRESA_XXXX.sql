USE [master]
GO
/****** Object:  Database [EMPRESAXXXXX]    Script Date: 25/4/2022 15:35:47 ******/
CREATE DATABASE [EMPRESAXXXXX]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EMPRESAXXXXX', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\EMPRESAXXXXX.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EMPRESAXXXXX_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\EMPRESAXXXXX_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [EMPRESAXXXXX] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EMPRESAXXXXX].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EMPRESAXXXXX] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET ARITHABORT OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EMPRESAXXXXX] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EMPRESAXXXXX] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EMPRESAXXXXX] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EMPRESAXXXXX] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EMPRESAXXXXX] SET  MULTI_USER 
GO
ALTER DATABASE [EMPRESAXXXXX] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EMPRESAXXXXX] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EMPRESAXXXXX] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EMPRESAXXXXX] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EMPRESAXXXXX] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EMPRESAXXXXX] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [EMPRESAXXXXX] SET QUERY_STORE = OFF
GO
USE [EMPRESAXXXXX]
GO
/****** Object:  Table [dbo].[db_Formulario]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON /******Creacion de tabla Formulario para solicitar vacaciones al encargado ******/
GO
CREATE TABLE [dbo].[db_Formulario](
	[IdFormulario] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NULL,
	[Encargado] [nchar](20) NULL, /******CAMPOS que contiene la tabla FORMULARIO******/
	[FechaSolicitud] [date] NULL,
	[DiasTotales] [nchar](10) NULL,
	[Descripcion] [nchar](20) NULL,
 CONSTRAINT [PK_Formulario] PRIMARY KEY CLUSTERED 
(
	[IdFormulario] ASC /****** DECLARACION DEL ID DE LA TABLA COMO LLAVE PRIMARIA AUTOINCREMENTAL  ******/
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Dias_disfrutados]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
CREATE FUNCTION [dbo].[Dias_disfrutados]
(	
	-- Add the parameters for the function here
	@IdEmpleado int
)
RETURNS TABLE  /******CCREACION DE LA FUNCION PARA LA VISTA Y RETORNAR LOS DIAS QUE LLEVA CADA EMPLEADO, SE DIGITA EL ID DEL EMPLEADO Y DEVUELVE LOS DIAS  ******/
AS
RETURN 
(
	SELECT IdEmpleado, DiasTotales
FROM     db_Formulario
WHERE  (IdEmpleado = @IdEmpleado)
)
GO
/****** Object:  Table [dbo].[db_Departamento]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO             /******CREACION DE TABLA DEPARTAMENTO  PARA TENER CONOCIMIENTO DE QUE DEPARTAMENTOS EXISTEN EN LA EMPRESA XXXX******/
CREATE TABLE [dbo].[db_Departamento](
	[CodDepartamento] [int] IDENTITY(1,1) NOT NULL, /****** CAMPOS DE LA TABLA DEPARTAMENTO ******/
	[NombreDepartamento] [nchar](20) NULL,
 CONSTRAINT [PK_db_Departamento] PRIMARY KEY CLUSTERED 
(						/****** DECLARACION DEL ID DEL DEPARTAMENTO COMO LLAVE PRIMARIA Y AUTOINCREMENTAL******/
	[CodDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[db_Empleado]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO					/******CREACION DE TABLA EMPLEADOS PARA LLEVAR UN REGISTRO DE LOS MISMOS ******/
CREATE TABLE [dbo].[db_Empleado](
	[IdEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[NombreEmpleado] [nchar](20) NULL,
	[CodDepartamento] [int] NULL,		/******CAMPOS DE LA TABLA EMPLEADO PARA TENER MAS CONOCIMIENTO DEL MISMO ******/
	[Cedula] [nchar](10) NULL,
	[Telefono] [nchar](10) NULL,
 CONSTRAINT [PK_db_Empleado] PRIMARY KEY CLUSTERED 
( /******DELCARACION DEL ID DE LA TABLA EMPLEADO COMO LLAVE PRIMARIA Y AUTOINCREMENTAL ******/
	[IdEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[db_Solicitud]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO  /******CREACION DE TABLA SOLICITUD DONDE EL ENCARGADO PODRA APROBAR O DENEGAR LAS VACACIONES AL EMPLEADO ******/
CREATE TABLE [dbo].[db_Solicitud](
	[IdSolicitud] [int] IDENTITY(1,1) NOT NULL, /****** LLAVE PRIMARIA DE LA TABLA ******/
	[CodFormulario] [int] NULL, /****** cAMPOS PARA DIGITAR A CUAL FORMULARIO NOS ESTAMOS REFIRIENDO ******/
	[EstadoSolicitud] [nchar](20) NULL, /****** SI LA SOLICITUD ESTA APROBADA O DENEGADA ******/
	[Motivo] [nchar](20) NULL, /******SI ESTA APROBADA DEJAR EN NLANCO SI SE RECHAZA SE DA UN MOTIVO DEL PORQUE ******/
	[NombreEmpleado] [nchar](20) NULL, /******CAMPOS NOMBRE DEL EMPLEADO PARA TENER MAYOR REFERENCIA ******/
 CONSTRAINT [PK_Solicitud] PRIMARY KEY CLUSTERED 
(				/******DECLARACION DEL CAMPO ID SOLICITUD COMO LLAVE PRIMARIA Y AUTO INCREMENTAL ******/
	[IdSolicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InicioSesion]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO /******CREACION DE TABLA INCICIO DE SESION ******/
CREATE TABLE [dbo].[InicioSesion](
	[usuario] [varchar](max) NULL, /****** CAMPO USUARIO PARA EL IDENTIFICADOR DE CADA UNO******/
	[clave] [varbinary](max) NULL /******CAMPO CLAVE ENCRIPTADO PARA QUE NO TENGAN CONOCIMIENTO DE LA CLAVE OTROS USUARIOS ******/
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[db_Departamento] ON /****** INSERTAR DEPARTAMENTOS EN LA TABLA DEPARTAMENTO ******/
GO
INSERT [dbo].[db_Departamento] ([CodDepartamento], [NombreDepartamento]) VALUES (1, N'Desarrollo          ')
GO
INSERT [dbo].[db_Departamento] ([CodDepartamento], [NombreDepartamento]) VALUES (2, N'Soporte             ')
GO
INSERT [dbo].[db_Departamento] ([CodDepartamento], [NombreDepartamento]) VALUES (3, N'DevOps              ')
GO
INSERT [dbo].[db_Departamento] ([CodDepartamento], [NombreDepartamento]) VALUES (4, N'Seguridad           ')
GO
INSERT [dbo].[db_Departamento] ([CodDepartamento], [NombreDepartamento]) VALUES (5, N'Validacion          ')
GO
INSERT [dbo].[db_Departamento] ([CodDepartamento], [NombreDepartamento]) VALUES (6, N'Recursos H          ')
GO
INSERT [dbo].[db_Departamento] ([CodDepartamento], [NombreDepartamento]) VALUES (7, N'Capital Hu          ')
GO
INSERT [dbo].[db_Departamento] ([CodDepartamento], [NombreDepartamento]) VALUES (8, N'Inteligenc          ')
GO
INSERT [dbo].[db_Departamento] ([CodDepartamento], [NombreDepartamento]) VALUES (9, N'Contabilid          ')
GO
INSERT [dbo].[db_Departamento] ([CodDepartamento], [NombreDepartamento]) VALUES (10, N'Administra          ')
GO
SET IDENTITY_INSERT [dbo].[db_Departamento] OFF
GO
SET IDENTITY_INSERT [dbo].[db_Empleado] ON  /****** INSERTAR EMPLEADOS EN LA TABLA EMPLEADOS ******/
GO
INSERT [dbo].[db_Empleado] ([IdEmpleado], [NombreEmpleado], [CodDepartamento], [Cedula], [Telefono]) VALUES (1, N'Denis RodMor        ', 1, N'2         ', N'83655072  ')
GO
INSERT [dbo].[db_Empleado] ([IdEmpleado], [NombreEmpleado], [CodDepartamento], [Cedula], [Telefono]) VALUES (2, N'Robin RodChin       ', 3, N'1         ', N'86973521  ')
GO
INSERT [dbo].[db_Empleado] ([IdEmpleado], [NombreEmpleado], [CodDepartamento], [Cedula], [Telefono]) VALUES (3, N'Monkey D Luffy      ', 6, N'2         ', N'24500052  ')
GO
INSERT [dbo].[db_Empleado] ([IdEmpleado], [NombreEmpleado], [CodDepartamento], [Cedula], [Telefono]) VALUES (4, N'Zoro Sanji          ', 9, N'2         ', N'24502223  ')
GO
INSERT [dbo].[db_Empleado] ([IdEmpleado], [NombreEmpleado], [CodDepartamento], [Cedula], [Telefono]) VALUES (5, N'Franky Usopp        ', 8, N'2         ', N'24502278  ')
GO
INSERT [dbo].[db_Empleado] ([IdEmpleado], [NombreEmpleado], [CodDepartamento], [Cedula], [Telefono]) VALUES (6, N'Jinbe Chopper       ', 5, N'20210721  ', N'85847940  ')
GO
SET IDENTITY_INSERT [dbo].[db_Empleado] OFF
GO
SET IDENTITY_INSERT [dbo].[db_Formulario] ON /******INSERCION DE FROMULARIOS DE SOLICITUD DE VACACIONES ******/
GO
INSERT [dbo].[db_Formulario] ([IdFormulario], [IdEmpleado], [Encargado], [FechaSolicitud], [DiasTotales], [Descripcion]) VALUES (1, 1, N'Alexander           ', CAST(N'2022-04-22' AS Date), N'5         ', N'Paseo Familiar      ')
GO
INSERT [dbo].[db_Formulario] ([IdFormulario], [IdEmpleado], [Encargado], [FechaSolicitud], [DiasTotales], [Descripcion]) VALUES (2, 3, N'Alexander           ', CAST(N'2022-05-02' AS Date), N'2         ', N'Partido Sele        ')
GO
INSERT [dbo].[db_Formulario] ([IdFormulario], [IdEmpleado], [Encargado], [FechaSolicitud], [DiasTotales], [Descripcion]) VALUES (3, 5, N'Alexander           ', CAST(N'2022-05-22' AS Date), N'8         ', N'Salida del pais     ')
GO
INSERT [dbo].[db_Formulario] ([IdFormulario], [IdEmpleado], [Encargado], [FechaSolicitud], [DiasTotales], [Descripcion]) VALUES (4, 6, N'Alexander           ', CAST(N'2022-06-20' AS Date), N'4         ', N'Necesito dias de des')
GO
INSERT [dbo].[db_Formulario] ([IdFormulario], [IdEmpleado], [Encargado], [FechaSolicitud], [DiasTotales], [Descripcion]) VALUES (5, 2, N'Alexander           ', CAST(N'2022-12-01' AS Date), N'7         ', N'Ir al Mundial Qatar ')
GO
INSERT [dbo].[db_Formulario] ([IdFormulario], [IdEmpleado], [Encargado], [FechaSolicitud], [DiasTotales], [Descripcion]) VALUES (6, 2, N'Alexander           ', CAST(N'2022-04-25' AS Date), N'4         ', N'Vivir la vida loca  ')
GO
SET IDENTITY_INSERT [dbo].[db_Formulario] OFF
GO
SET IDENTITY_INSERT [dbo].[db_Solicitud] ON  /****** INSERCION DE REVISION DE SOLICITUDES DE VACACIONES******/
GO
INSERT [dbo].[db_Solicitud] ([IdSolicitud], [CodFormulario], [EstadoSolicitud], [Motivo], [NombreEmpleado]) VALUES (1, 1, N'Aprobado            ', N'Disfrute            ', N'Denis RM            ')
GO
INSERT [dbo].[db_Solicitud] ([IdSolicitud], [CodFormulario], [EstadoSolicitud], [Motivo], [NombreEmpleado]) VALUES (2, 3, N'Denegado            ', N'Lo necesitamos esos ', N'Franky Usopp        ')
GO
INSERT [dbo].[db_Solicitud] ([IdSolicitud], [CodFormulario], [EstadoSolicitud], [Motivo], [NombreEmpleado]) VALUES (3, 6, N'Aprobada            ', NULL, N'Robin RodChin       ')
GO
SET IDENTITY_INSERT [dbo].[db_Solicitud] OFF
GO
INSERT [dbo].[InicioSesion] ([usuario], [clave]) VALUES (N'Luis', 0x0200000016A6A351D9EDFCAA626A3D3F470A00409304ACCB71093F8A845F77B5F32F8427) /****** INSERCION DE USUARIO LUIS CON CLAVE ENCRIPTADA ******/
GO 
INSERT [dbo].[InicioSesion] ([usuario], [clave]) VALUES (N'Denis', 0x02000000A8C85222CF8CD894F6965130A0A12FF12DD0789381120E57C6CCE926C5D99A50AD44266E2D19E412B2144ABD5B638839) /******INSERCION DE USUARIO DENIS CON CLAVE ENCRIPTADA ******/
GO
ALTER TABLE [dbo].[db_Empleado]  WITH CHECK ADD  CONSTRAINT [FK_db_Empleado_db_Departamento] FOREIGN KEY([CodDepartamento])
REFERENCES [dbo].[db_Departamento] ([CodDepartamento]) /******CREACION DE RELACION ENTRE LA TABLA DEPARTAMENTO CON LA TABLA EMPLEADO PARA SU DEBIDA CONEXION ******/
GO
ALTER TABLE [dbo].[db_Empleado] CHECK CONSTRAINT [FK_db_Empleado_db_Departamento]
GO
ALTER TABLE [dbo].[db_Formulario]  WITH CHECK ADD  CONSTRAINT [FK_db_Formulario_db_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[db_Empleado] ([IdEmpleado]) /****** CREACION DE RELACION ENTRE LA TABLA EMPLEADO CON LA TABLA FORMULARIO PARA SU DEBIDA CONEXION******/
GO
ALTER TABLE [dbo].[db_Formulario] CHECK CONSTRAINT [FK_db_Formulario_db_Empleado]
GO
ALTER TABLE [dbo].[db_Solicitud]  WITH CHECK ADD  CONSTRAINT [FK_db_Solicitud_db_Formulario] FOREIGN KEY([CodFormulario])
REFERENCES [dbo].[db_Formulario] ([IdFormulario]) /****** CREACION DE RELACION ENTRE LA TABLA FORMULARIO CON LA TABLA SOLICITUD PARA SU DEBIDA CONEXION ******/
GO
ALTER TABLE [dbo].[db_Solicitud] CHECK CONSTRAINT [FK_db_Solicitud_db_Formulario]
GO
/****** Object:  StoredProcedure [dbo].[BusquedaxFiltro]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BusquedaxFiltro] /******PROCEDIMIENTO ALMACENADO PARA LA BUSQUEDA FILTRADA YA SEA POR NOMBRE, DEPARTAMENTO, CEDULA O TELEFONO******/
@Dato varchar(50) /****** VARIABLE A UTILIZAR ******/

AS
SELECT IdEmpleado ,NombreEmpleado, CodDepartamento, Cedula, Telefono /******LOS CAMPOS QUE DEBERA MOSTRAR A LA HORA DE VER EL LISTADO ******/
FROM db_Empleado /****** LA TABLA DE LA CUAL QUEREMOS ESOS CAMPOS ******/
WHERE NombreEmpleado LIKE @Dato OR CodDepartamento LIKE @Dato OR Cedula LIKE @Dato OR Telefono LIKE @Dato + '%' /******CUANDO ALGUNO DE LOS CAMPOS SEA IGUAL AL VALOR INGRESADO COMO DATO ******/

GO
/****** Object:  StoredProcedure [dbo].[Insertar_Departamento]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Insertar_Departamento] /****** PROCEDIMIENTO ALMACENADO PARA INSERTAR NUEVOS DEPARTAMENTOS ******/

@nombredepartamento char(10) /****** VARIABLE A UTILIZAR ******/

As begin

insert into db_Departamento /****** INSERTAR EN LA TABLA DEPARTAMENTO******/
([NombreDepartamento])

values 
(@nombredepartamento) /****** VALOR A INGRESAR COMO NOMBRE ******/
SELECT @@IDENTITY AS CodDepartamento
END
GO
/****** Object:  StoredProcedure [dbo].[Insertar_Empleado]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Insertar_Empleado] /****** PROCEDIMIENTO ALMACENADO PARA LA INSERCION DE NUEVOS EMPLEADOS  ******/
--campos a ingresar
@nombreempleado nchar(40),
@coddepartamento int,
@cedula nchar (20),
@telefono nchar (20)

As
Begin
Insert into dbo. db_Empleado
-- campos de las tablas 
([NombreEmpleado]
,[CodDepartamento]
,[Cedula]
,[Telefono])


values 
(@nombreempleado, @coddepartamento, @cedula, @telefono) /****** VALORES A INGRESAR EN EL MOMENTO DE LA INSERCION ******/
SELECT @@IDENTITY AS IdEmpleado
END
GO
/****** Object:  StoredProcedure [dbo].[Lista_Empleados]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Lista_Empleados] /****** PROCEDIMIENTO ALMACENADO PARA EL LISTADO COMPLETO DE LOS EMPLEADOS SIN FILTRO NI NADA ******/
as
select * from db_Empleado
GO
/****** Object:  StoredProcedure [dbo].[Nuevo_Formulario]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON /****** PROCEDIMIENTO ALMACENADO PARA LA CREACION DE UN NUEVO FRORMULARIO PARA SOLICITAR VACACIONES ******/
GO
CREATE procedure [dbo].[Nuevo_Formulario]
--campos a ingresar
@idempleado int,
@encargado nchar(40),
@fechaSolicitud date,
@Diastotales nchar (20),
@descripcion nchar (40)
As
Begin
Insert into dbo. db_Formulario
-- campos de las tablas 
([IdEmpleado]
,[Encargado]
,[FechaSolicitud]
,[DiasTotales]
,[Descripcion])


values 
(@idempleado, @encargado, @fechaSolicitud, @Diastotales, @descripcion) /****** VALORES A INGRESAR AL MOMENTO DE LLENAR EL FORMULARIO ******/
SELECT @@IDENTITY AS CodFormulario
END
GO
/****** Object:  StoredProcedure [dbo].[Revisar_SolicitudVacaciones]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Revisar_SolicitudVacaciones] /****** PROCEDIMIENTO ALMACENADO PARA LAREVISION DE SOLICITUDES DE VACACIONES POR MEDIO DEL FORMULARIO ******/
--campos a ingresar
@CodFormulario int,
@EstadoSolicitud nchar (50),
@Motivo nchar(50),
@NombreEmpleado nchar(50)

As
Begin
Insert into dbo. db_Solicitud
-- campos de las tablas 
([CodFormulario]
,[EstadoSolicitud]
,[Motivo]
,[NombreEmpleado])


values 
(@CodFormulario, @EstadoSolicitud, @Motivo, @NombreEmpleado) /******VALORES A INGRESAR E EL MOMENTO DE ACTUALIZAR LA SOLICTUD RECIBIDA ******/
Select @@IDENTITY AS IdSolicitud

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 25/4/2022 15:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Login] /******PROCEDIMIENTO ALMACENADO PARA LA CREACION DE UN USUARIO Y CLAVE ******/
@users varchar(max),
@pss varchar (max) /****** CAMPOS A INGRESAR ******/

as declare

@pssb varbinary (max) 
begin
set @pssb=(ENCRYPTBYPASSPHRASE('encriptacion', @pss)); /******ENCRIPTACION DE LA CLAVE DEL USUARIO ******/
insert into InicioSesion values (@users, @pssb) /****** VALORES A INGRESAR EN EL MOMENTO DEL LOGIN ******/
end
GO
USE [master]
GO
ALTER DATABASE [EMPRESAXXXXX] SET  READ_WRITE 
GO
