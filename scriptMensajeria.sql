USE [master]
GO
/****** Object:  Database [Mensajeria]    Script Date: 25/01/2024 04:35:09 p. m. ******/
CREATE DATABASE [Mensajeria]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Mensajeria', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Mensajeria.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Mensajeria_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Mensajeria_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Mensajeria] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Mensajeria].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Mensajeria] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Mensajeria] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Mensajeria] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Mensajeria] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Mensajeria] SET ARITHABORT OFF 
GO
ALTER DATABASE [Mensajeria] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Mensajeria] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Mensajeria] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Mensajeria] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Mensajeria] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Mensajeria] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Mensajeria] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Mensajeria] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Mensajeria] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Mensajeria] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Mensajeria] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Mensajeria] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Mensajeria] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Mensajeria] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Mensajeria] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Mensajeria] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Mensajeria] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Mensajeria] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Mensajeria] SET RECOVERY FULL 
GO
ALTER DATABASE [Mensajeria] SET  MULTI_USER 
GO
ALTER DATABASE [Mensajeria] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Mensajeria] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Mensajeria] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Mensajeria] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Mensajeria', N'ON'
GO
USE [Mensajeria]
GO
/****** Object:  StoredProcedure [dbo].[AddConversacion]    Script Date: 25/01/2024 04:35:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddConversacion]
@IdReceptor INT,
@IdEmisor INT
AS
INSERT INTO Conversacion VALUES (@IdReceptor, @IdEmisor)
GO
/****** Object:  StoredProcedure [dbo].[AddMensaje]    Script Date: 25/01/2024 04:35:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddMensaje]
---propiedades de Mensaje  
@Mensaje VARCHAR (500),
---Propiedades de Envio
@UltimoMensaje INT,
@IdEmisor INT,
@IdReceptor INT,
@IdConversacion INT
AS
INSERT INTO Mensaje VALUES (@Mensaje)
SELECT @UltimoMensaje = IDENT_CURRENT('Mensaje');
INSERT INTO Envio VALUES (@UltimoMensaje, @IdConversacion, @IdEmisor, @IdReceptor)
GO
/****** Object:  StoredProcedure [dbo].[AddUsusario]    Script Date: 25/01/2024 04:35:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddUsusario]
@Nombre VARCHAR(80),
@ApellidoPaterno VARCHAR(80),
@ApellidoMaterno VARCHAR(80),
@Email VARCHAR(80),
@Password VARCHAR(20)
AS
INSERT INTO Usuario VALUES (@Nombre, @ApellidoPaterno, @ApellidoMaterno,@Email, @Password)
GO
/****** Object:  StoredProcedure [dbo].[BusquedaUsuario]    Script Date: 25/01/2024 04:35:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BusquedaUsuario]
@Usuario VARCHAR(80)
AS
SELECT IdUsuario, Nombre, Email FROM Usuario
WHERE Nombre LIKE '%'+ @Usuario +'%' OR Email LIKE '%'+ @Usuario +'%'
GO
/****** Object:  StoredProcedure [dbo].[GetByIdConversacioEnvios]    Script Date: 25/01/2024 04:35:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByIdConversacioEnvios]
@IdConversacion INT
AS
SELECT E.IdMensaje, M.Mensaje , Emisor, Receptor, E.IdConversacion  FROM Envio E
INNER JOIN Mensaje M ON E.IdMensaje = M.IdMensaje
WHERE E.IdConversacion = @IdConversacion
GO
/****** Object:  StoredProcedure [dbo].[GetByIdConversacionUsuario]    Script Date: 25/01/2024 04:35:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByIdConversacionUsuario]
@IdUsuario INT
AS 
SELECT IdConversacion, IdEmisor, IdReceptor, U1.Nombre AS Emisor, U2.Nombre AS Receptor FROM Conversacion c
INNER JOIN Usuario U1 ON IdEmisor =  U1.IdUsuario
INNER JOIN Usuario U2 ON IdReceptor = U2.IdUsuario  
WHERE IdEmisor = @IdUsuario OR IdReceptor = @IdUsuario	
GO
/****** Object:  StoredProcedure [dbo].[GetEmail]    Script Date: 25/01/2024 04:35:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmail]
@Email VARCHAR(80)
AS
SELECT Email, Password, IdUsuario FROM Usuario
WHERE Email = @Email
GO
/****** Object:  Table [dbo].[Conversacion]    Script Date: 25/01/2024 04:35:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conversacion](
	[IdConversacion] [int] IDENTITY(1,1) NOT NULL,
	[IdReceptor] [int] NULL,
	[IdEmisor] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdConversacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Envio]    Script Date: 25/01/2024 04:35:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Envio](
	[IdEnvio] [int] IDENTITY(1,1) NOT NULL,
	[IdMensaje] [int] NULL,
	[IdConversacion] [int] NULL,
	[Emisor] [int] NULL,
	[Receptor] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEnvio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Mensaje]    Script Date: 25/01/2024 04:35:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mensaje](
	[IdMensaje] [int] IDENTITY(1,1) NOT NULL,
	[Mensaje] [varchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 25/01/2024 04:35:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](80) NOT NULL,
	[ApellidoPaterno] [varchar](80) NOT NULL,
	[ApellidoMaterno] [varchar](80) NULL,
	[Email] [varchar](80) NOT NULL,
	[Password] [varchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Conversacion]  WITH CHECK ADD FOREIGN KEY([IdEmisor])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[Conversacion]  WITH CHECK ADD FOREIGN KEY([IdReceptor])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[Envio]  WITH CHECK ADD FOREIGN KEY([Emisor])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[Envio]  WITH CHECK ADD FOREIGN KEY([IdConversacion])
REFERENCES [dbo].[Conversacion] ([IdConversacion])
GO
ALTER TABLE [dbo].[Envio]  WITH CHECK ADD FOREIGN KEY([IdMensaje])
REFERENCES [dbo].[Mensaje] ([IdMensaje])
GO
ALTER TABLE [dbo].[Envio]  WITH CHECK ADD FOREIGN KEY([Receptor])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
USE [master]
GO
ALTER DATABASE [Mensajeria] SET  READ_WRITE 
GO
