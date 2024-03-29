USE [master]
GO
/****** Object:  Database [Apellidos_Nombre_Memes]    Script Date: 02/02/2024 9:51:04 ******/
CREATE DATABASE [Apellidos_Nombre_Memes]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Apellidos_Nombre_Memes', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Apellidos_Nombre_Memes.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Apellidos_Nombre_Memes_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Apellidos_Nombre_Memes_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Apellidos_Nombre_Memes].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET ARITHABORT OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET  MULTI_USER 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET QUERY_STORE = OFF
GO
USE [Apellidos_Nombre_Memes]
GO
/****** Object:  Table [dbo].[Alumno]    Script Date: 02/02/2024 9:51:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alumno](
	[AlumnoID] [int] NOT NULL,
	[NombreAlumno] [varchar](70) NOT NULL,
	[ApellidoAlumno] [varchar](70) NOT NULL,
	[EmailAlumno] [varchar](70) NOT NULL,
	[Usuario] [varchar](70) NOT NULL,
	[Edad] [int] NOT NULL,
 CONSTRAINT [PK_Alumno] PRIMARY KEY CLUSTERED 
(
	[AlumnoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profesor]    Script Date: 02/02/2024 9:51:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profesor](
	[ProfesorID] [int] NOT NULL,
	[NombreProfesor] [varchar](70) NOT NULL,
	[ApellidoProfesor] [varchar](70) NOT NULL,
	[EmailProfesor] [varchar](70) NOT NULL,
	[DireccionProfesor] [varchar](70) NOT NULL,
	[Antigüedad] [int] NOT NULL,
 CONSTRAINT [PK_Profesor] PRIMARY KEY CLUSTERED 
(
	[ProfesorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Alumno]  WITH CHECK ADD  CONSTRAINT [CK_Alumno_AlumnoID] CHECK  (([AlumnoID]>(0)))
GO
ALTER TABLE [dbo].[Alumno] CHECK CONSTRAINT [CK_Alumno_AlumnoID]
GO
ALTER TABLE [dbo].[Alumno]  WITH CHECK ADD  CONSTRAINT [CK_Alumno_Edad] CHECK  (([Edad]>(16) AND [Edad]<(100)))
GO
ALTER TABLE [dbo].[Alumno] CHECK CONSTRAINT [CK_Alumno_Edad]
GO
ALTER TABLE [dbo].[Profesor]  WITH CHECK ADD  CONSTRAINT [CK_Profesor_Antigüedad] CHECK  (([Antigüedad]>(0)))
GO
ALTER TABLE [dbo].[Profesor] CHECK CONSTRAINT [CK_Profesor_Antigüedad]
GO
ALTER TABLE [dbo].[Profesor]  WITH CHECK ADD  CONSTRAINT [CK_Profesor_ProfesorID] CHECK  (([ProfesorID]>(0)))
GO
ALTER TABLE [dbo].[Profesor] CHECK CONSTRAINT [CK_Profesor_ProfesorID]
GO
USE [master]
GO
ALTER DATABASE [Apellidos_Nombre_Memes] SET  READ_WRITE 
GO
