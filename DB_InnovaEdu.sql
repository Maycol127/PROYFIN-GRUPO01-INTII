USE [master]
GO
/****** Object:  Database [DBInnovaEdu]    Script Date: 05/12/2024 22:53:46 ******/
CREATE DATABASE [DBInnovaEdu]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBInnovaEdu', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DBInnovaEdu.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBInnovaEdu_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DBInnovaEdu_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DBInnovaEdu] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBInnovaEdu].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBInnovaEdu] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBInnovaEdu] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBInnovaEdu] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBInnovaEdu] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBInnovaEdu] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET RECOVERY FULL 
GO
ALTER DATABASE [DBInnovaEdu] SET  MULTI_USER 
GO
ALTER DATABASE [DBInnovaEdu] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBInnovaEdu] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBInnovaEdu] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBInnovaEdu] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBInnovaEdu] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBInnovaEdu] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DBInnovaEdu', N'ON'
GO
ALTER DATABASE [DBInnovaEdu] SET QUERY_STORE = ON
GO
ALTER DATABASE [DBInnovaEdu] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DBInnovaEdu]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 05/12/2024 22:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- CONFIGURACION ---

create FUNCTION [dbo].[SplitString]  ( 
	@string NVARCHAR(MAX), 
	@delimiter CHAR(1)  
)
RETURNS
@output TABLE(valor NVARCHAR(MAX)  ) 
BEGIN 
	DECLARE @start INT, @end INT 
	SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
	WHILE @start < LEN(@string) + 1
	BEGIN 
		IF @end = 0  
        SET @end = LEN(@string) + 1 

		INSERT INTO @output (valor)  
		VALUES(SUBSTRING(@string, @start, @end - @start)) 
		SET @start = @end + 1 
		SET @end = CHARINDEX(@delimiter, @string, @start) 
	END 
	RETURN
END


GO
/****** Object:  Table [dbo].[Asesoria]    Script Date: 05/12/2024 22:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asesoria](
	[IdAsesoria] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[IdDocenteHorarioDetalle] [int] NULL,
	[IdEstadoAsesoria] [int] NULL,
	[FechaAsesoria] [datetime] NULL,
	[Indicaciones] [varchar](1000) NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAsesoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Curso]    Script Date: 05/12/2024 22:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Curso](
	[IdCurso] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCurso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Docente]    Script Date: 05/12/2024 22:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Docente](
	[IdDocente] [int] IDENTITY(1,1) NOT NULL,
	[NumeroDocumentoIdentidad] [varchar](50) NULL,
	[Nombres] [varchar](50) NULL,
	[Apellidos] [varchar](50) NULL,
	[Genero] [varchar](1) NULL,
	[IdCurso] [int] NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDocente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocenteHorario]    Script Date: 05/12/2024 22:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocenteHorario](
	[IdDocenteHorario] [int] IDENTITY(1,1) NOT NULL,
	[IdDocente] [int] NULL,
	[NumeroMes] [int] NULL,
	[HoraInicioAM] [time](7) NULL,
	[HoraFinAM] [time](7) NULL,
	[HoraInicioPM] [time](7) NULL,
	[HoraFinPM] [time](7) NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDocenteHorario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocenteHorarioDetalle]    Script Date: 05/12/2024 22:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocenteHorarioDetalle](
	[IdDocenteHorarioDetalle] [int] IDENTITY(1,1) NOT NULL,
	[IdDocenteHorario] [int] NULL,
	[Fecha] [date] NULL,
	[Turno] [varchar](2) NULL,
	[TurnoHora] [time](7) NULL,
	[Reservado] [bit] NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDocenteHorarioDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadoAsesoria]    Script Date: 05/12/2024 22:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoAsesoria](
	[IdEstadoAsesoria] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEstadoAsesoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogOperacion]    Script Date: 05/12/2024 22:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogOperacion](
	[IdLog] [int] IDENTITY(1,1) NOT NULL,
	[Tabla] [nvarchar](50) NULL,
	[IdRegistroAfectado] [int] NULL,
	[Operacion] [nvarchar](10) NULL,
	[FechaOperacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolUsuario]    Script Date: 05/12/2024 22:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolUsuario](
	[IdRolUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRolUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 05/12/2024 22:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[NumeroDocumentoIdentidad] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Apellido] [varchar](50) NULL,
	[Correo] [varchar](50) NULL,
	[Clave] [varchar](50) NULL,
	[IdRolUsuario] [int] NULL,
	[FechaCreacion] [datetime] NULL,
	[UltimaConexion] [datetime] NULL,
	[Conexion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Asesoria] ON 

INSERT [dbo].[Asesoria] ([IdAsesoria], [IdUsuario], [IdDocenteHorarioDetalle], [IdEstadoAsesoria], [FechaAsesoria], [Indicaciones], [FechaCreacion]) VALUES (1, 2, 112, 3, CAST(N'2024-10-15T00:00:00.000' AS DateTime), NULL, CAST(N'2024-10-08T19:28:07.193' AS DateTime))
INSERT [dbo].[Asesoria] ([IdAsesoria], [IdUsuario], [IdDocenteHorarioDetalle], [IdEstadoAsesoria], [FechaAsesoria], [Indicaciones], [FechaCreacion]) VALUES (2, 2, 123, 3, CAST(N'2024-10-16T00:00:00.000' AS DateTime), NULL, CAST(N'2024-10-08T19:43:49.747' AS DateTime))
INSERT [dbo].[Asesoria] ([IdAsesoria], [IdUsuario], [IdDocenteHorarioDetalle], [IdEstadoAsesoria], [FechaAsesoria], [Indicaciones], [FechaCreacion]) VALUES (3, 2, 136, 3, CAST(N'2024-10-17T00:00:00.000' AS DateTime), NULL, CAST(N'2024-10-08T20:03:41.063' AS DateTime))
INSERT [dbo].[Asesoria] ([IdAsesoria], [IdUsuario], [IdDocenteHorarioDetalle], [IdEstadoAsesoria], [FechaAsesoria], [Indicaciones], [FechaCreacion]) VALUES (4, 2, 68, 3, CAST(N'2024-10-11T00:00:00.000' AS DateTime), NULL, CAST(N'2024-10-11T00:05:51.670' AS DateTime))
INSERT [dbo].[Asesoria] ([IdAsesoria], [IdUsuario], [IdDocenteHorarioDetalle], [IdEstadoAsesoria], [FechaAsesoria], [Indicaciones], [FechaCreacion]) VALUES (5, 1003, 163, 3, CAST(N'2024-10-19T00:00:00.000' AS DateTime), NULL, CAST(N'2024-10-11T00:11:12.230' AS DateTime))
INSERT [dbo].[Asesoria] ([IdAsesoria], [IdUsuario], [IdDocenteHorarioDetalle], [IdEstadoAsesoria], [FechaAsesoria], [Indicaciones], [FechaCreacion]) VALUES (1004, 2, 207, 3, CAST(N'2024-10-23T00:00:00.000' AS DateTime), NULL, CAST(N'2024-10-13T11:17:12.850' AS DateTime))
INSERT [dbo].[Asesoria] ([IdAsesoria], [IdUsuario], [IdDocenteHorarioDetalle], [IdEstadoAsesoria], [FechaAsesoria], [Indicaciones], [FechaCreacion]) VALUES (1005, 2, 313, 1, CAST(N'2024-10-15T00:00:00.000' AS DateTime), NULL, CAST(N'2024-10-14T13:40:46.960' AS DateTime))
INSERT [dbo].[Asesoria] ([IdAsesoria], [IdUsuario], [IdDocenteHorarioDetalle], [IdEstadoAsesoria], [FechaAsesoria], [Indicaciones], [FechaCreacion]) VALUES (1006, 2, 532, 3, CAST(N'2024-11-15T00:00:00.000' AS DateTime), NULL, CAST(N'2024-11-15T14:05:00.450' AS DateTime))
INSERT [dbo].[Asesoria] ([IdAsesoria], [IdUsuario], [IdDocenteHorarioDetalle], [IdEstadoAsesoria], [FechaAsesoria], [Indicaciones], [FechaCreacion]) VALUES (1007, 2, 658, 3, CAST(N'2024-11-30T00:00:00.000' AS DateTime), NULL, CAST(N'2024-11-30T15:34:17.613' AS DateTime))
INSERT [dbo].[Asesoria] ([IdAsesoria], [IdUsuario], [IdDocenteHorarioDetalle], [IdEstadoAsesoria], [FechaAsesoria], [Indicaciones], [FechaCreacion]) VALUES (1008, 2, 657, 1, CAST(N'2024-11-30T00:00:00.000' AS DateTime), NULL, CAST(N'2024-11-30T15:35:44.537' AS DateTime))
INSERT [dbo].[Asesoria] ([IdAsesoria], [IdUsuario], [IdDocenteHorarioDetalle], [IdEstadoAsesoria], [FechaAsesoria], [Indicaciones], [FechaCreacion]) VALUES (1009, 2, 713, 1, CAST(N'2024-12-04T00:00:00.000' AS DateTime), NULL, CAST(N'2024-12-04T18:10:37.180' AS DateTime))
SET IDENTITY_INSERT [dbo].[Asesoria] OFF
GO
SET IDENTITY_INSERT [dbo].[Curso] ON 

INSERT [dbo].[Curso] ([IdCurso], [Nombre], [FechaCreacion]) VALUES (1, N'Base de Datos', CAST(N'2024-09-02T16:39:26.640' AS DateTime))
INSERT [dbo].[Curso] ([IdCurso], [Nombre], [FechaCreacion]) VALUES (2, N'Calidad de Servicio de TI', CAST(N'2024-09-02T16:39:26.640' AS DateTime))
INSERT [dbo].[Curso] ([IdCurso], [Nombre], [FechaCreacion]) VALUES (3, N'Calidad de software', CAST(N'2024-09-02T16:39:26.640' AS DateTime))
INSERT [dbo].[Curso] ([IdCurso], [Nombre], [FechaCreacion]) VALUES (4, N'Costos y presupuestos', CAST(N'2024-09-02T16:39:26.640' AS DateTime))
INSERT [dbo].[Curso] ([IdCurso], [Nombre], [FechaCreacion]) VALUES (5, N'Desarrollo Web Integrado', CAST(N'2024-09-02T16:39:26.640' AS DateTime))
INSERT [dbo].[Curso] ([IdCurso], [Nombre], [FechaCreacion]) VALUES (6, N'Estadistica Inferencial', CAST(N'2024-09-02T16:39:26.640' AS DateTime))
INSERT [dbo].[Curso] ([IdCurso], [Nombre], [FechaCreacion]) VALUES (7, N'Investigación Académica', CAST(N'2024-09-02T16:39:26.640' AS DateTime))
INSERT [dbo].[Curso] ([IdCurso], [Nombre], [FechaCreacion]) VALUES (1002, N'Inteligencia de Negocios', CAST(N'2024-09-24T18:11:17.757' AS DateTime))
INSERT [dbo].[Curso] ([IdCurso], [Nombre], [FechaCreacion]) VALUES (1004, N'Matemática II', CAST(N'2024-10-14T13:38:36.227' AS DateTime))
SET IDENTITY_INSERT [dbo].[Curso] OFF
GO
SET IDENTITY_INSERT [dbo].[Docente] ON 

INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (1, N'10000000', N'Alexandra', N'Alvarez', N'F', 1, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (2, N'10000001', N'Abigail', N'Azizi', N'F', 1, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (3, N'10000002', N'Justina', N'Thiarre', N'F', 1, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (4, N'10000003', N'Alana', N'Gomez', N'F', 1, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (5, N'10000004', N'Ivana', N'Rojas', N'F', 2, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (6, N'10000005', N'Macon', N'Alonsos', N'M', 2, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (7, N'10000006', N'Herrod', N'Tapia', N'M', 2, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (8, N'10000007', N'Serena', N'Renato', N'F', 2, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (9, N'10000008', N'Herman', N'Trinidad', N'M', 3, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (10, N'10000009', N'Derek', N'Daniel', N'M', 3, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (11, N'10000010', N'Lani', N'Alvarez', N'F', 3, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (12, N'10000011', N'Blaze', N'Maximiliano', N'M', 3, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (13, N'10000012', N'Nicole', N'Atlas', N'F', 4, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (14, N'10000013', N'Nasim', N'Carrasco', N'F', 4, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (15, N'10000014', N'Karleigh', N'Javier', N'F', 4, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (16, N'10000015', N'Rooney', N'Zuniga', N'F', 4, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (17, N'10000016', N'Hasad', N'Joaquin', N'F', 4, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (18, N'10000017', N'Tamara', N'Contreras', N'F', 5, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (19, N'10000018', N'Rhoda', N'Castro', N'F', 5, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (20, N'10000019', N'Orli', N'Florencia', N'F', 5, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (21, N'10000020', N'Montana', N'Castro', N'F', 5, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (22, N'10000021', N'Aquila', N'Jara', N'F', 6, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (23, N'10000022', N'Jenette', N'Tomas', N'F', 6, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (24, N'10000023', N'Sylvester', N'Tapia', N'M', 6, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (25, N'10000024', N'Colin', N'Florencia', N'M', 6, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (26, N'10000025', N'Galvin', N'Francisco', N'M', 6, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (27, N'10000026', N'Glenna', N'Benjamin', N'F', 7, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (28, N'10000027', N'Kay', N'Carla', N'F', 7, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (29, N'10000028', N'Jacob', N'Augustin', N'M', 7, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (30, N'10000029', N'Travis', N'Martina', N'M', 7, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (31, N'10000051', N'Brady', N'Vega', N'F', 1, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (32, N'10000052', N'Hashim', N'Torres', N'M', 2, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (33, N'10000053', N'MacKenzie', N'Laura', N'F', 3, CAST(N'2024-09-02T16:39:26.670' AS DateTime))
INSERT [dbo].[Docente] ([IdDocente], [NumeroDocumentoIdentidad], [Nombres], [Apellidos], [Genero], [IdCurso], [FechaCreacion]) VALUES (2002, N'4242424', N'Maycol', N'Hinostroza', N'M', 1004, CAST(N'2024-10-14T13:39:21.390' AS DateTime))
SET IDENTITY_INSERT [dbo].[Docente] OFF
GO
SET IDENTITY_INSERT [dbo].[DocenteHorario] ON 

INSERT [dbo].[DocenteHorario] ([IdDocenteHorario], [IdDocente], [NumeroMes], [HoraInicioAM], [HoraFinAM], [HoraInicioPM], [HoraFinPM], [FechaCreacion]) VALUES (1004, 2, 10, CAST(N'08:00:00' AS Time), CAST(N'10:30:00' AS Time), CAST(N'16:00:00' AS Time), CAST(N'18:00:00' AS Time), CAST(N'2024-10-08T19:26:51.257' AS DateTime))
INSERT [dbo].[DocenteHorario] ([IdDocenteHorario], [IdDocente], [NumeroMes], [HoraInicioAM], [HoraFinAM], [HoraInicioPM], [HoraFinPM], [FechaCreacion]) VALUES (1005, 2002, 10, CAST(N'09:30:00' AS Time), CAST(N'12:00:00' AS Time), CAST(N'15:00:00' AS Time), CAST(N'18:00:00' AS Time), CAST(N'2024-10-14T13:40:15.547' AS DateTime))
INSERT [dbo].[DocenteHorario] ([IdDocenteHorario], [IdDocente], [NumeroMes], [HoraInicioAM], [HoraFinAM], [HoraInicioPM], [HoraFinPM], [FechaCreacion]) VALUES (1007, 1, 11, CAST(N'08:30:00' AS Time), CAST(N'09:30:00' AS Time), CAST(N'14:00:00' AS Time), CAST(N'14:30:00' AS Time), CAST(N'2024-10-25T14:05:49.153' AS DateTime))
INSERT [dbo].[DocenteHorario] ([IdDocenteHorario], [IdDocente], [NumeroMes], [HoraInicioAM], [HoraFinAM], [HoraInicioPM], [HoraFinPM], [FechaCreacion]) VALUES (1008, 2, 11, CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), CAST(N'16:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'2024-11-15T14:03:02.063' AS DateTime))
INSERT [dbo].[DocenteHorario] ([IdDocenteHorario], [IdDocente], [NumeroMes], [HoraInicioAM], [HoraFinAM], [HoraInicioPM], [HoraFinPM], [FechaCreacion]) VALUES (1009, 3, 12, CAST(N'08:30:00' AS Time), CAST(N'09:30:00' AS Time), CAST(N'14:30:00' AS Time), CAST(N'21:00:00' AS Time), CAST(N'2024-12-04T18:08:26.747' AS DateTime))
SET IDENTITY_INSERT [dbo].[DocenteHorario] OFF
GO
SET IDENTITY_INSERT [dbo].[DocenteHorarioDetalle] ON 

INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (34, 1004, CAST(N'2024-10-08' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (35, 1004, CAST(N'2024-10-08' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (36, 1004, CAST(N'2024-10-08' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (37, 1004, CAST(N'2024-10-08' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (38, 1004, CAST(N'2024-10-08' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (39, 1004, CAST(N'2024-10-08' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (40, 1004, CAST(N'2024-10-08' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (41, 1004, CAST(N'2024-10-08' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (42, 1004, CAST(N'2024-10-08' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (43, 1004, CAST(N'2024-10-08' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (44, 1004, CAST(N'2024-10-08' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (45, 1004, CAST(N'2024-10-09' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (46, 1004, CAST(N'2024-10-09' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (47, 1004, CAST(N'2024-10-09' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (48, 1004, CAST(N'2024-10-09' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (49, 1004, CAST(N'2024-10-09' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (50, 1004, CAST(N'2024-10-09' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (51, 1004, CAST(N'2024-10-09' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (52, 1004, CAST(N'2024-10-09' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (53, 1004, CAST(N'2024-10-09' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (54, 1004, CAST(N'2024-10-09' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (55, 1004, CAST(N'2024-10-09' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (56, 1004, CAST(N'2024-10-10' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (57, 1004, CAST(N'2024-10-10' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (58, 1004, CAST(N'2024-10-10' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (59, 1004, CAST(N'2024-10-10' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (60, 1004, CAST(N'2024-10-10' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (61, 1004, CAST(N'2024-10-10' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (62, 1004, CAST(N'2024-10-10' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (63, 1004, CAST(N'2024-10-10' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (64, 1004, CAST(N'2024-10-10' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (65, 1004, CAST(N'2024-10-10' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (66, 1004, CAST(N'2024-10-10' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (67, 1004, CAST(N'2024-10-11' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (68, 1004, CAST(N'2024-10-11' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (69, 1004, CAST(N'2024-10-11' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (70, 1004, CAST(N'2024-10-11' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (71, 1004, CAST(N'2024-10-11' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (72, 1004, CAST(N'2024-10-11' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (73, 1004, CAST(N'2024-10-11' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (74, 1004, CAST(N'2024-10-11' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (75, 1004, CAST(N'2024-10-11' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (76, 1004, CAST(N'2024-10-11' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (77, 1004, CAST(N'2024-10-11' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (78, 1004, CAST(N'2024-10-12' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (79, 1004, CAST(N'2024-10-12' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (80, 1004, CAST(N'2024-10-12' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (81, 1004, CAST(N'2024-10-12' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (82, 1004, CAST(N'2024-10-12' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (83, 1004, CAST(N'2024-10-12' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (84, 1004, CAST(N'2024-10-12' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (85, 1004, CAST(N'2024-10-12' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (86, 1004, CAST(N'2024-10-12' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (87, 1004, CAST(N'2024-10-12' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (88, 1004, CAST(N'2024-10-12' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (89, 1004, CAST(N'2024-10-13' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (90, 1004, CAST(N'2024-10-13' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (91, 1004, CAST(N'2024-10-13' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (92, 1004, CAST(N'2024-10-13' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (93, 1004, CAST(N'2024-10-13' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (94, 1004, CAST(N'2024-10-13' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (95, 1004, CAST(N'2024-10-13' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (96, 1004, CAST(N'2024-10-13' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (97, 1004, CAST(N'2024-10-13' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (98, 1004, CAST(N'2024-10-13' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (99, 1004, CAST(N'2024-10-13' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (100, 1004, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (101, 1004, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (102, 1004, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (103, 1004, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (104, 1004, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (105, 1004, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (106, 1004, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (107, 1004, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (108, 1004, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (109, 1004, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (110, 1004, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (111, 1004, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (112, 1004, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (113, 1004, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (114, 1004, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (115, 1004, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (116, 1004, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (117, 1004, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (118, 1004, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (119, 1004, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (120, 1004, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (121, 1004, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (122, 1004, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (123, 1004, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (124, 1004, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (125, 1004, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (126, 1004, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (127, 1004, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (128, 1004, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (129, 1004, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (130, 1004, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (131, 1004, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (132, 1004, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
GO
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (133, 1004, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (134, 1004, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (135, 1004, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (136, 1004, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (137, 1004, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (138, 1004, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (139, 1004, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (140, 1004, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (141, 1004, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (142, 1004, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (143, 1004, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (144, 1004, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (145, 1004, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (146, 1004, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (147, 1004, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (148, 1004, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (149, 1004, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (150, 1004, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (151, 1004, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (152, 1004, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (153, 1004, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (154, 1004, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (155, 1004, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (156, 1004, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (157, 1004, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (158, 1004, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (159, 1004, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (160, 1004, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (161, 1004, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (162, 1004, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (163, 1004, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (164, 1004, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (165, 1004, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (166, 1004, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (167, 1004, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (168, 1004, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (169, 1004, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (170, 1004, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (171, 1004, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (172, 1004, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (173, 1004, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (174, 1004, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (175, 1004, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (176, 1004, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (177, 1004, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (178, 1004, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (179, 1004, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (180, 1004, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (181, 1004, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (182, 1004, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (183, 1004, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (184, 1004, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (185, 1004, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (186, 1004, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (187, 1004, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (188, 1004, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (189, 1004, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (190, 1004, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (191, 1004, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (192, 1004, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (193, 1004, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (194, 1004, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (195, 1004, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (196, 1004, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (197, 1004, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (198, 1004, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (199, 1004, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (200, 1004, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (201, 1004, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (202, 1004, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (203, 1004, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (204, 1004, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (205, 1004, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (206, 1004, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (207, 1004, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (208, 1004, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (209, 1004, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (210, 1004, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (211, 1004, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (212, 1004, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (213, 1004, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (214, 1004, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (215, 1004, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (216, 1004, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (217, 1004, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (218, 1004, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (219, 1004, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (220, 1004, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (221, 1004, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (222, 1004, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (223, 1004, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (224, 1004, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (225, 1004, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (226, 1004, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (227, 1004, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (228, 1004, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (229, 1004, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (230, 1004, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (231, 1004, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (232, 1004, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
GO
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (233, 1004, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (234, 1004, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (235, 1004, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (236, 1004, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (237, 1004, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (238, 1004, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (239, 1004, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (240, 1004, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (241, 1004, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (242, 1004, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (243, 1004, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (244, 1004, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (245, 1004, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (246, 1004, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (247, 1004, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (248, 1004, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (249, 1004, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (250, 1004, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (251, 1004, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (252, 1004, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (253, 1004, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (254, 1004, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (255, 1004, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (256, 1004, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (257, 1004, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (258, 1004, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (259, 1004, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (260, 1004, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (261, 1004, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (262, 1004, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (263, 1004, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (264, 1004, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (265, 1004, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (266, 1004, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (267, 1004, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (268, 1004, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (269, 1004, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (270, 1004, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (271, 1004, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (272, 1004, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (273, 1004, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (274, 1004, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (275, 1004, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (276, 1004, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (277, 1004, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (278, 1004, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (279, 1004, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (280, 1004, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (281, 1004, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (282, 1004, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (283, 1004, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (284, 1004, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (285, 1004, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (286, 1004, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (287, 1004, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (288, 1004, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (289, 1004, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (290, 1004, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (291, 1004, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (292, 1004, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (293, 1004, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (294, 1004, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (295, 1004, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (296, 1004, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (297, 1004, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-08T19:26:51.277' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (298, 1005, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (299, 1005, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (300, 1005, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (301, 1005, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (302, 1005, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (303, 1005, CAST(N'2024-10-14' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (304, 1005, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (305, 1005, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (306, 1005, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (307, 1005, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (308, 1005, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (309, 1005, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (310, 1005, CAST(N'2024-10-14' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (311, 1005, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (312, 1005, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (313, 1005, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'10:30:00' AS Time), 1, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (314, 1005, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (315, 1005, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (316, 1005, CAST(N'2024-10-15' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (317, 1005, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (318, 1005, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (319, 1005, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (320, 1005, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (321, 1005, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (322, 1005, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (323, 1005, CAST(N'2024-10-15' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (324, 1005, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (325, 1005, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (326, 1005, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (327, 1005, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (328, 1005, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (329, 1005, CAST(N'2024-10-16' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (330, 1005, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (331, 1005, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (332, 1005, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
GO
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (333, 1005, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (334, 1005, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (335, 1005, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (336, 1005, CAST(N'2024-10-16' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (337, 1005, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (338, 1005, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (339, 1005, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (340, 1005, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (341, 1005, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (342, 1005, CAST(N'2024-10-17' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (343, 1005, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (344, 1005, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (345, 1005, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (346, 1005, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (347, 1005, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (348, 1005, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (349, 1005, CAST(N'2024-10-17' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (350, 1005, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (351, 1005, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (352, 1005, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (353, 1005, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (354, 1005, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (355, 1005, CAST(N'2024-10-18' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (356, 1005, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (357, 1005, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (358, 1005, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (359, 1005, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (360, 1005, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (361, 1005, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (362, 1005, CAST(N'2024-10-18' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (363, 1005, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (364, 1005, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (365, 1005, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (366, 1005, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (367, 1005, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (368, 1005, CAST(N'2024-10-19' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (369, 1005, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (370, 1005, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (371, 1005, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (372, 1005, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (373, 1005, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (374, 1005, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (375, 1005, CAST(N'2024-10-19' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (376, 1005, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (377, 1005, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (378, 1005, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (379, 1005, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (380, 1005, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (381, 1005, CAST(N'2024-10-20' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (382, 1005, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (383, 1005, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (384, 1005, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (385, 1005, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (386, 1005, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (387, 1005, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (388, 1005, CAST(N'2024-10-20' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (389, 1005, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (390, 1005, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (391, 1005, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (392, 1005, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (393, 1005, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (394, 1005, CAST(N'2024-10-21' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (395, 1005, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (396, 1005, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (397, 1005, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (398, 1005, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (399, 1005, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (400, 1005, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (401, 1005, CAST(N'2024-10-21' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (402, 1005, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (403, 1005, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (404, 1005, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (405, 1005, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (406, 1005, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (407, 1005, CAST(N'2024-10-22' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (408, 1005, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (409, 1005, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (410, 1005, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (411, 1005, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (412, 1005, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (413, 1005, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (414, 1005, CAST(N'2024-10-22' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (415, 1005, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (416, 1005, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (417, 1005, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (418, 1005, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (419, 1005, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (420, 1005, CAST(N'2024-10-23' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (421, 1005, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (422, 1005, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (423, 1005, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (424, 1005, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (425, 1005, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (426, 1005, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (427, 1005, CAST(N'2024-10-23' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (428, 1005, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (429, 1005, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (430, 1005, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (431, 1005, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (432, 1005, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
GO
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (433, 1005, CAST(N'2024-10-24' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (434, 1005, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (435, 1005, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (436, 1005, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (437, 1005, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (438, 1005, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (439, 1005, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (440, 1005, CAST(N'2024-10-24' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (441, 1005, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (442, 1005, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (443, 1005, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (444, 1005, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (445, 1005, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (446, 1005, CAST(N'2024-10-25' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (447, 1005, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (448, 1005, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (449, 1005, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (450, 1005, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (451, 1005, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (452, 1005, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (453, 1005, CAST(N'2024-10-25' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (454, 1005, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (455, 1005, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (456, 1005, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (457, 1005, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (458, 1005, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (459, 1005, CAST(N'2024-10-26' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (460, 1005, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (461, 1005, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (462, 1005, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (463, 1005, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (464, 1005, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (465, 1005, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (466, 1005, CAST(N'2024-10-26' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (467, 1005, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (468, 1005, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (469, 1005, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (470, 1005, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (471, 1005, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (472, 1005, CAST(N'2024-10-27' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (473, 1005, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (474, 1005, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (475, 1005, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (476, 1005, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (477, 1005, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (478, 1005, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (479, 1005, CAST(N'2024-10-27' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (480, 1005, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (481, 1005, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (482, 1005, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (483, 1005, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (484, 1005, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (485, 1005, CAST(N'2024-10-28' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (486, 1005, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (487, 1005, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (488, 1005, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (489, 1005, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (490, 1005, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (491, 1005, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (492, 1005, CAST(N'2024-10-28' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (493, 1005, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (494, 1005, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (495, 1005, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (496, 1005, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (497, 1005, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (498, 1005, CAST(N'2024-10-29' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (499, 1005, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (500, 1005, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (501, 1005, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (502, 1005, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (503, 1005, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (504, 1005, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (505, 1005, CAST(N'2024-10-29' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (506, 1005, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (507, 1005, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (508, 1005, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (509, 1005, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (510, 1005, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (511, 1005, CAST(N'2024-10-30' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (512, 1005, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (513, 1005, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (514, 1005, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (515, 1005, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (516, 1005, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (517, 1005, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (518, 1005, CAST(N'2024-10-30' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (519, 1005, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (520, 1005, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (521, 1005, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'10:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (522, 1005, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'11:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (523, 1005, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'11:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (524, 1005, CAST(N'2024-10-31' AS Date), N'AM', CAST(N'12:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (525, 1005, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (526, 1005, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (527, 1005, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (528, 1005, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (529, 1005, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (530, 1005, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (531, 1005, CAST(N'2024-10-31' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-10-14T13:40:15.550' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (532, 1008, CAST(N'2024-11-15' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
GO
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (533, 1008, CAST(N'2024-11-15' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (534, 1008, CAST(N'2024-11-15' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (535, 1008, CAST(N'2024-11-15' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (536, 1008, CAST(N'2024-11-15' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (537, 1008, CAST(N'2024-11-15' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (538, 1008, CAST(N'2024-11-15' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (539, 1008, CAST(N'2024-11-15' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (540, 1008, CAST(N'2024-11-16' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (541, 1008, CAST(N'2024-11-16' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (542, 1008, CAST(N'2024-11-16' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (543, 1008, CAST(N'2024-11-16' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (544, 1008, CAST(N'2024-11-16' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (545, 1008, CAST(N'2024-11-16' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (546, 1008, CAST(N'2024-11-16' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (547, 1008, CAST(N'2024-11-16' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (548, 1008, CAST(N'2024-11-17' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (549, 1008, CAST(N'2024-11-17' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (550, 1008, CAST(N'2024-11-17' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (551, 1008, CAST(N'2024-11-17' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (552, 1008, CAST(N'2024-11-17' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (553, 1008, CAST(N'2024-11-17' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (554, 1008, CAST(N'2024-11-17' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (555, 1008, CAST(N'2024-11-17' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (556, 1008, CAST(N'2024-11-18' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (557, 1008, CAST(N'2024-11-18' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (558, 1008, CAST(N'2024-11-18' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (559, 1008, CAST(N'2024-11-18' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (560, 1008, CAST(N'2024-11-18' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (561, 1008, CAST(N'2024-11-18' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (562, 1008, CAST(N'2024-11-18' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (563, 1008, CAST(N'2024-11-18' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (564, 1008, CAST(N'2024-11-19' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (565, 1008, CAST(N'2024-11-19' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (566, 1008, CAST(N'2024-11-19' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (567, 1008, CAST(N'2024-11-19' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (568, 1008, CAST(N'2024-11-19' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (569, 1008, CAST(N'2024-11-19' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (570, 1008, CAST(N'2024-11-19' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (571, 1008, CAST(N'2024-11-19' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (572, 1008, CAST(N'2024-11-20' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (573, 1008, CAST(N'2024-11-20' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (574, 1008, CAST(N'2024-11-20' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (575, 1008, CAST(N'2024-11-20' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (576, 1008, CAST(N'2024-11-20' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (577, 1008, CAST(N'2024-11-20' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (578, 1008, CAST(N'2024-11-20' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (579, 1008, CAST(N'2024-11-20' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (580, 1008, CAST(N'2024-11-21' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (581, 1008, CAST(N'2024-11-21' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (582, 1008, CAST(N'2024-11-21' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (583, 1008, CAST(N'2024-11-21' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (584, 1008, CAST(N'2024-11-21' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (585, 1008, CAST(N'2024-11-21' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (586, 1008, CAST(N'2024-11-21' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (587, 1008, CAST(N'2024-11-21' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (588, 1008, CAST(N'2024-11-22' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (589, 1008, CAST(N'2024-11-22' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (590, 1008, CAST(N'2024-11-22' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (591, 1008, CAST(N'2024-11-22' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (592, 1008, CAST(N'2024-11-22' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (593, 1008, CAST(N'2024-11-22' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (594, 1008, CAST(N'2024-11-22' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (595, 1008, CAST(N'2024-11-22' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (596, 1008, CAST(N'2024-11-23' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (597, 1008, CAST(N'2024-11-23' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (598, 1008, CAST(N'2024-11-23' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (599, 1008, CAST(N'2024-11-23' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (600, 1008, CAST(N'2024-11-23' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (601, 1008, CAST(N'2024-11-23' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (602, 1008, CAST(N'2024-11-23' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (603, 1008, CAST(N'2024-11-23' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (604, 1008, CAST(N'2024-11-24' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (605, 1008, CAST(N'2024-11-24' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (606, 1008, CAST(N'2024-11-24' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (607, 1008, CAST(N'2024-11-24' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (608, 1008, CAST(N'2024-11-24' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (609, 1008, CAST(N'2024-11-24' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (610, 1008, CAST(N'2024-11-24' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (611, 1008, CAST(N'2024-11-24' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (612, 1008, CAST(N'2024-11-25' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (613, 1008, CAST(N'2024-11-25' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (614, 1008, CAST(N'2024-11-25' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (615, 1008, CAST(N'2024-11-25' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (616, 1008, CAST(N'2024-11-25' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (617, 1008, CAST(N'2024-11-25' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (618, 1008, CAST(N'2024-11-25' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (619, 1008, CAST(N'2024-11-25' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (620, 1008, CAST(N'2024-11-26' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (621, 1008, CAST(N'2024-11-26' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (622, 1008, CAST(N'2024-11-26' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (623, 1008, CAST(N'2024-11-26' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (624, 1008, CAST(N'2024-11-26' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (625, 1008, CAST(N'2024-11-26' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (626, 1008, CAST(N'2024-11-26' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (627, 1008, CAST(N'2024-11-26' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (628, 1008, CAST(N'2024-11-27' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (629, 1008, CAST(N'2024-11-27' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (630, 1008, CAST(N'2024-11-27' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (631, 1008, CAST(N'2024-11-27' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (632, 1008, CAST(N'2024-11-27' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
GO
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (633, 1008, CAST(N'2024-11-27' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (634, 1008, CAST(N'2024-11-27' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (635, 1008, CAST(N'2024-11-27' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (636, 1008, CAST(N'2024-11-28' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (637, 1008, CAST(N'2024-11-28' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (638, 1008, CAST(N'2024-11-28' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (639, 1008, CAST(N'2024-11-28' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (640, 1008, CAST(N'2024-11-28' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (641, 1008, CAST(N'2024-11-28' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (642, 1008, CAST(N'2024-11-28' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (643, 1008, CAST(N'2024-11-28' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (644, 1008, CAST(N'2024-11-29' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (645, 1008, CAST(N'2024-11-29' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (646, 1008, CAST(N'2024-11-29' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (647, 1008, CAST(N'2024-11-29' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (648, 1008, CAST(N'2024-11-29' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (649, 1008, CAST(N'2024-11-29' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (650, 1008, CAST(N'2024-11-29' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (651, 1008, CAST(N'2024-11-29' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (652, 1008, CAST(N'2024-11-30' AS Date), N'AM', CAST(N'08:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (653, 1008, CAST(N'2024-11-30' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (654, 1008, CAST(N'2024-11-30' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (655, 1008, CAST(N'2024-11-30' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (656, 1008, CAST(N'2024-11-30' AS Date), N'AM', CAST(N'10:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (657, 1008, CAST(N'2024-11-30' AS Date), N'PM', CAST(N'16:00:00' AS Time), 1, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (658, 1008, CAST(N'2024-11-30' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (659, 1008, CAST(N'2024-11-30' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-11-15T14:03:02.070' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (660, 1009, CAST(N'2024-12-01' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (661, 1009, CAST(N'2024-12-01' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (662, 1009, CAST(N'2024-12-01' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (663, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (664, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (665, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (666, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (667, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (668, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (669, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (670, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (671, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (672, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (673, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (674, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (675, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (676, 1009, CAST(N'2024-12-01' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (677, 1009, CAST(N'2024-12-02' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (678, 1009, CAST(N'2024-12-02' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (679, 1009, CAST(N'2024-12-02' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (680, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (681, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (682, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (683, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (684, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (685, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (686, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (687, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (688, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (689, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (690, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (691, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (692, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (693, 1009, CAST(N'2024-12-02' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (694, 1009, CAST(N'2024-12-03' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (695, 1009, CAST(N'2024-12-03' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (696, 1009, CAST(N'2024-12-03' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (697, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (698, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (699, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (700, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (701, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (702, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (703, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (704, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (705, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (706, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (707, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (708, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (709, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (710, 1009, CAST(N'2024-12-03' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (711, 1009, CAST(N'2024-12-04' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (712, 1009, CAST(N'2024-12-04' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (713, 1009, CAST(N'2024-12-04' AS Date), N'AM', CAST(N'09:30:00' AS Time), 1, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (714, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (715, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (716, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (717, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (718, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (719, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (720, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (721, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (722, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (723, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (724, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (725, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (726, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (727, 1009, CAST(N'2024-12-04' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (728, 1009, CAST(N'2024-12-05' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (729, 1009, CAST(N'2024-12-05' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (730, 1009, CAST(N'2024-12-05' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (731, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (732, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
GO
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (733, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (734, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (735, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (736, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (737, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (738, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (739, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (740, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (741, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (742, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (743, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (744, 1009, CAST(N'2024-12-05' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (745, 1009, CAST(N'2024-12-06' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (746, 1009, CAST(N'2024-12-06' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (747, 1009, CAST(N'2024-12-06' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (748, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (749, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (750, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (751, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (752, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (753, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (754, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (755, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (756, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (757, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (758, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (759, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (760, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (761, 1009, CAST(N'2024-12-06' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (762, 1009, CAST(N'2024-12-07' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (763, 1009, CAST(N'2024-12-07' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (764, 1009, CAST(N'2024-12-07' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (765, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (766, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (767, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (768, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (769, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (770, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (771, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (772, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (773, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (774, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (775, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (776, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (777, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (778, 1009, CAST(N'2024-12-07' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (779, 1009, CAST(N'2024-12-08' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (780, 1009, CAST(N'2024-12-08' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (781, 1009, CAST(N'2024-12-08' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (782, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (783, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (784, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (785, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (786, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (787, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (788, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (789, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (790, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (791, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (792, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (793, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (794, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (795, 1009, CAST(N'2024-12-08' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (796, 1009, CAST(N'2024-12-09' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (797, 1009, CAST(N'2024-12-09' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (798, 1009, CAST(N'2024-12-09' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (799, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (800, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (801, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (802, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (803, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (804, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (805, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (806, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (807, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (808, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (809, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (810, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (811, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (812, 1009, CAST(N'2024-12-09' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (813, 1009, CAST(N'2024-12-10' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (814, 1009, CAST(N'2024-12-10' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (815, 1009, CAST(N'2024-12-10' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (816, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (817, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (818, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (819, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (820, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (821, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (822, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (823, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (824, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (825, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (826, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (827, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (828, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (829, 1009, CAST(N'2024-12-10' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (830, 1009, CAST(N'2024-12-11' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (831, 1009, CAST(N'2024-12-11' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (832, 1009, CAST(N'2024-12-11' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
GO
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (833, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (834, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (835, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (836, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (837, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (838, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (839, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (840, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (841, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (842, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (843, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (844, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (845, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (846, 1009, CAST(N'2024-12-11' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (847, 1009, CAST(N'2024-12-12' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (848, 1009, CAST(N'2024-12-12' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (849, 1009, CAST(N'2024-12-12' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (850, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (851, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (852, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (853, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (854, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (855, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (856, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (857, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (858, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (859, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (860, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (861, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (862, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (863, 1009, CAST(N'2024-12-12' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (864, 1009, CAST(N'2024-12-13' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (865, 1009, CAST(N'2024-12-13' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (866, 1009, CAST(N'2024-12-13' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (867, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (868, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (869, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (870, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (871, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (872, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (873, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (874, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (875, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (876, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (877, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (878, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (879, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (880, 1009, CAST(N'2024-12-13' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (881, 1009, CAST(N'2024-12-14' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (882, 1009, CAST(N'2024-12-14' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (883, 1009, CAST(N'2024-12-14' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (884, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (885, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (886, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (887, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (888, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (889, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (890, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (891, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (892, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (893, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (894, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (895, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (896, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (897, 1009, CAST(N'2024-12-14' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (898, 1009, CAST(N'2024-12-15' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (899, 1009, CAST(N'2024-12-15' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (900, 1009, CAST(N'2024-12-15' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (901, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (902, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (903, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (904, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (905, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (906, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (907, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (908, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (909, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (910, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (911, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (912, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (913, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (914, 1009, CAST(N'2024-12-15' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (915, 1009, CAST(N'2024-12-16' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (916, 1009, CAST(N'2024-12-16' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (917, 1009, CAST(N'2024-12-16' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (918, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (919, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (920, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (921, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (922, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (923, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (924, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (925, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (926, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (927, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (928, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (929, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (930, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (931, 1009, CAST(N'2024-12-16' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (932, 1009, CAST(N'2024-12-17' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
GO
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (933, 1009, CAST(N'2024-12-17' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (934, 1009, CAST(N'2024-12-17' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (935, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (936, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (937, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (938, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (939, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (940, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (941, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (942, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (943, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (944, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (945, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (946, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (947, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (948, 1009, CAST(N'2024-12-17' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (949, 1009, CAST(N'2024-12-18' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (950, 1009, CAST(N'2024-12-18' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (951, 1009, CAST(N'2024-12-18' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (952, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (953, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (954, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (955, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (956, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (957, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (958, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (959, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (960, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (961, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (962, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (963, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (964, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (965, 1009, CAST(N'2024-12-18' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (966, 1009, CAST(N'2024-12-19' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (967, 1009, CAST(N'2024-12-19' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (968, 1009, CAST(N'2024-12-19' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (969, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (970, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (971, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (972, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (973, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (974, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (975, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (976, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (977, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (978, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (979, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (980, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (981, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (982, 1009, CAST(N'2024-12-19' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (983, 1009, CAST(N'2024-12-20' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (984, 1009, CAST(N'2024-12-20' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (985, 1009, CAST(N'2024-12-20' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (986, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (987, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (988, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (989, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (990, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (991, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (992, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (993, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (994, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (995, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (996, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (997, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (998, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (999, 1009, CAST(N'2024-12-20' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1000, 1009, CAST(N'2024-12-21' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1001, 1009, CAST(N'2024-12-21' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1002, 1009, CAST(N'2024-12-21' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1003, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1004, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1005, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1006, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1007, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1008, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1009, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1010, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1011, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1012, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1013, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1014, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1015, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1016, 1009, CAST(N'2024-12-21' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1017, 1009, CAST(N'2024-12-22' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1018, 1009, CAST(N'2024-12-22' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1019, 1009, CAST(N'2024-12-22' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1020, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1021, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1022, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1023, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1024, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1025, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1026, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1027, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1028, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1029, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1030, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1031, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1032, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
GO
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1033, 1009, CAST(N'2024-12-22' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1034, 1009, CAST(N'2024-12-23' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1035, 1009, CAST(N'2024-12-23' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1036, 1009, CAST(N'2024-12-23' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1037, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1038, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1039, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1040, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1041, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1042, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1043, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1044, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1045, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1046, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1047, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1048, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1049, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1050, 1009, CAST(N'2024-12-23' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1051, 1009, CAST(N'2024-12-24' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1052, 1009, CAST(N'2024-12-24' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1053, 1009, CAST(N'2024-12-24' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1054, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1055, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1056, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1057, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1058, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1059, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1060, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1061, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1062, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1063, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1064, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1065, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1066, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1067, 1009, CAST(N'2024-12-24' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1068, 1009, CAST(N'2024-12-25' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1069, 1009, CAST(N'2024-12-25' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1070, 1009, CAST(N'2024-12-25' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1071, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1072, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1073, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1074, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1075, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1076, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1077, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1078, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1079, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1080, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1081, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1082, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1083, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1084, 1009, CAST(N'2024-12-25' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1085, 1009, CAST(N'2024-12-26' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1086, 1009, CAST(N'2024-12-26' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1087, 1009, CAST(N'2024-12-26' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1088, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1089, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1090, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1091, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1092, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1093, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1094, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1095, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1096, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1097, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1098, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1099, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1100, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1101, 1009, CAST(N'2024-12-26' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1102, 1009, CAST(N'2024-12-27' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1103, 1009, CAST(N'2024-12-27' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1104, 1009, CAST(N'2024-12-27' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1105, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1106, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1107, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1108, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1109, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1110, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1111, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1112, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1113, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1114, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1115, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1116, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1117, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1118, 1009, CAST(N'2024-12-27' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1119, 1009, CAST(N'2024-12-28' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1120, 1009, CAST(N'2024-12-28' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1121, 1009, CAST(N'2024-12-28' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1122, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1123, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1124, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1125, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1126, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1127, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1128, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1129, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1130, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1131, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1132, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
GO
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1133, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1134, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1135, 1009, CAST(N'2024-12-28' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1136, 1009, CAST(N'2024-12-29' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1137, 1009, CAST(N'2024-12-29' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1138, 1009, CAST(N'2024-12-29' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1139, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1140, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1141, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1142, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1143, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1144, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1145, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1146, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1147, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1148, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1149, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1150, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1151, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1152, 1009, CAST(N'2024-12-29' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1153, 1009, CAST(N'2024-12-30' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1154, 1009, CAST(N'2024-12-30' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1155, 1009, CAST(N'2024-12-30' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1156, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1157, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1158, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1159, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1160, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1161, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1162, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1163, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1164, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1165, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1166, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1167, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1168, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1169, 1009, CAST(N'2024-12-30' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1170, 1009, CAST(N'2024-12-31' AS Date), N'AM', CAST(N'08:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1171, 1009, CAST(N'2024-12-31' AS Date), N'AM', CAST(N'09:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1172, 1009, CAST(N'2024-12-31' AS Date), N'AM', CAST(N'09:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1173, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'14:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1174, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'15:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1175, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'15:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1176, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'16:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1177, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'16:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1178, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'17:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1179, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'17:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1180, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'18:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1181, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'18:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1182, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'19:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1183, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'19:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1184, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'20:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1185, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'20:30:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
INSERT [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle], [IdDocenteHorario], [Fecha], [Turno], [TurnoHora], [Reservado], [FechaCreacion]) VALUES (1186, 1009, CAST(N'2024-12-31' AS Date), N'PM', CAST(N'21:00:00' AS Time), 0, CAST(N'2024-12-04T18:08:26.757' AS DateTime))
SET IDENTITY_INSERT [dbo].[DocenteHorarioDetalle] OFF
GO
SET IDENTITY_INSERT [dbo].[EstadoAsesoria] ON 

INSERT [dbo].[EstadoAsesoria] ([IdEstadoAsesoria], [Nombre], [FechaCreacion]) VALUES (1, N'Pendiente', CAST(N'2024-09-02T16:39:26.690' AS DateTime))
INSERT [dbo].[EstadoAsesoria] ([IdEstadoAsesoria], [Nombre], [FechaCreacion]) VALUES (2, N'Atendido', CAST(N'2024-09-02T16:39:26.690' AS DateTime))
INSERT [dbo].[EstadoAsesoria] ([IdEstadoAsesoria], [Nombre], [FechaCreacion]) VALUES (3, N'Anulado', CAST(N'2024-09-02T16:39:26.690' AS DateTime))
SET IDENTITY_INSERT [dbo].[EstadoAsesoria] OFF
GO
SET IDENTITY_INSERT [dbo].[LogOperacion] ON 

INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (1, N'Usuario', 3011, N'INSERT', CAST(N'2024-10-26T14:00:10.310' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (2, N'Usuario', 3012, N'INSERT', CAST(N'2024-10-26T14:04:38.913' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (3, N'Usuario', 3013, N'INSERT', CAST(N'2024-10-26T14:19:02.423' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (4, N'Usuario', 3014, N'INSERT', CAST(N'2024-10-26T14:24:27.187' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (5, N'Usuario', 3015, N'INSERT', CAST(N'2024-10-26T14:37:52.420' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (6, N'Usuario', 1, N'UPDATE', CAST(N'2024-10-26T16:00:57.623' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (7, N'Usuario', 3018, N'INSERT', CAST(N'2024-10-26T16:18:28.197' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (8, N'Usuario', 1, N'UPDATE', CAST(N'2024-10-26T16:19:16.410' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (9, N'Usuario', 2, N'UPDATE', CAST(N'2024-10-26T16:19:59.193' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (10, N'Usuario', 3019, N'INSERT', CAST(N'2024-10-26T16:27:10.033' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (11, N'Usuario', 1, N'UPDATE', CAST(N'2024-10-26T16:31:56.163' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (12, N'Usuario', 1, N'UPDATE', CAST(N'2024-10-26T16:32:27.313' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (13, N'Usuario', 3020, N'INSERT', CAST(N'2024-10-26T17:09:22.183' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (14, N'Usuario', 3020, N'DELETE', CAST(N'2024-10-26T17:09:46.077' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (15, N'Usuario', 3017, N'UPDATE', CAST(N'2024-10-26T17:10:10.607' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (16, N'Usuario', 1, N'UPDATE', CAST(N'2024-10-26T17:21:14.070' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (17, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-15T13:56:58.017' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (18, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-15T14:01:40.710' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (19, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-15T14:01:43.223' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (20, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-15T14:02:11.380' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (21, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-15T14:02:13.620' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (22, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-15T14:02:26.923' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (23, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-15T14:02:29.127' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (24, N'DocenteHorario', 1008, N'INSERT', CAST(N'2024-11-15T14:03:02.067' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (25, N'DocenteHorarioDetalle', 659, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (26, N'DocenteHorarioDetalle', 658, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (27, N'DocenteHorarioDetalle', 657, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (28, N'DocenteHorarioDetalle', 656, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (29, N'DocenteHorarioDetalle', 655, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (30, N'DocenteHorarioDetalle', 654, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (31, N'DocenteHorarioDetalle', 653, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (32, N'DocenteHorarioDetalle', 652, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (33, N'DocenteHorarioDetalle', 651, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (34, N'DocenteHorarioDetalle', 650, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (35, N'DocenteHorarioDetalle', 649, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (36, N'DocenteHorarioDetalle', 648, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (37, N'DocenteHorarioDetalle', 647, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (38, N'DocenteHorarioDetalle', 646, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (39, N'DocenteHorarioDetalle', 645, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (40, N'DocenteHorarioDetalle', 644, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (41, N'DocenteHorarioDetalle', 643, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (42, N'DocenteHorarioDetalle', 642, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (43, N'DocenteHorarioDetalle', 641, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (44, N'DocenteHorarioDetalle', 640, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (45, N'DocenteHorarioDetalle', 639, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (46, N'DocenteHorarioDetalle', 638, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (47, N'DocenteHorarioDetalle', 637, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (48, N'DocenteHorarioDetalle', 636, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (49, N'DocenteHorarioDetalle', 635, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (50, N'DocenteHorarioDetalle', 634, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (51, N'DocenteHorarioDetalle', 633, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (52, N'DocenteHorarioDetalle', 632, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (53, N'DocenteHorarioDetalle', 631, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (54, N'DocenteHorarioDetalle', 630, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (55, N'DocenteHorarioDetalle', 629, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (56, N'DocenteHorarioDetalle', 628, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (57, N'DocenteHorarioDetalle', 627, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (58, N'DocenteHorarioDetalle', 626, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (59, N'DocenteHorarioDetalle', 625, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (60, N'DocenteHorarioDetalle', 624, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (61, N'DocenteHorarioDetalle', 623, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (62, N'DocenteHorarioDetalle', 622, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (63, N'DocenteHorarioDetalle', 621, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (64, N'DocenteHorarioDetalle', 620, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (65, N'DocenteHorarioDetalle', 619, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (66, N'DocenteHorarioDetalle', 618, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (67, N'DocenteHorarioDetalle', 617, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (68, N'DocenteHorarioDetalle', 616, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (69, N'DocenteHorarioDetalle', 615, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (70, N'DocenteHorarioDetalle', 614, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (71, N'DocenteHorarioDetalle', 613, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (72, N'DocenteHorarioDetalle', 612, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (73, N'DocenteHorarioDetalle', 611, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (74, N'DocenteHorarioDetalle', 610, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (75, N'DocenteHorarioDetalle', 609, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (76, N'DocenteHorarioDetalle', 608, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (77, N'DocenteHorarioDetalle', 607, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (78, N'DocenteHorarioDetalle', 606, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (79, N'DocenteHorarioDetalle', 605, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (80, N'DocenteHorarioDetalle', 604, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (81, N'DocenteHorarioDetalle', 603, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (82, N'DocenteHorarioDetalle', 602, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (83, N'DocenteHorarioDetalle', 601, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (84, N'DocenteHorarioDetalle', 600, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (85, N'DocenteHorarioDetalle', 599, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (86, N'DocenteHorarioDetalle', 598, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (87, N'DocenteHorarioDetalle', 597, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (88, N'DocenteHorarioDetalle', 596, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (89, N'DocenteHorarioDetalle', 595, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (90, N'DocenteHorarioDetalle', 594, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (91, N'DocenteHorarioDetalle', 593, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (92, N'DocenteHorarioDetalle', 592, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (93, N'DocenteHorarioDetalle', 591, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (94, N'DocenteHorarioDetalle', 590, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (95, N'DocenteHorarioDetalle', 589, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (96, N'DocenteHorarioDetalle', 588, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (97, N'DocenteHorarioDetalle', 587, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (98, N'DocenteHorarioDetalle', 586, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (99, N'DocenteHorarioDetalle', 585, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
GO
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (100, N'DocenteHorarioDetalle', 584, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (101, N'DocenteHorarioDetalle', 583, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (102, N'DocenteHorarioDetalle', 582, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (103, N'DocenteHorarioDetalle', 581, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (104, N'DocenteHorarioDetalle', 580, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (105, N'DocenteHorarioDetalle', 579, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (106, N'DocenteHorarioDetalle', 578, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (107, N'DocenteHorarioDetalle', 577, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (108, N'DocenteHorarioDetalle', 576, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (109, N'DocenteHorarioDetalle', 575, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (110, N'DocenteHorarioDetalle', 574, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (111, N'DocenteHorarioDetalle', 573, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (112, N'DocenteHorarioDetalle', 572, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (113, N'DocenteHorarioDetalle', 571, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (114, N'DocenteHorarioDetalle', 570, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (115, N'DocenteHorarioDetalle', 569, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (116, N'DocenteHorarioDetalle', 568, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (117, N'DocenteHorarioDetalle', 567, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (118, N'DocenteHorarioDetalle', 566, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (119, N'DocenteHorarioDetalle', 565, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (120, N'DocenteHorarioDetalle', 564, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (121, N'DocenteHorarioDetalle', 563, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (122, N'DocenteHorarioDetalle', 562, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (123, N'DocenteHorarioDetalle', 561, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (124, N'DocenteHorarioDetalle', 560, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (125, N'DocenteHorarioDetalle', 559, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (126, N'DocenteHorarioDetalle', 558, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (127, N'DocenteHorarioDetalle', 557, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (128, N'DocenteHorarioDetalle', 556, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (129, N'DocenteHorarioDetalle', 555, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (130, N'DocenteHorarioDetalle', 554, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (131, N'DocenteHorarioDetalle', 553, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (132, N'DocenteHorarioDetalle', 552, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (133, N'DocenteHorarioDetalle', 551, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (134, N'DocenteHorarioDetalle', 550, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (135, N'DocenteHorarioDetalle', 549, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (136, N'DocenteHorarioDetalle', 548, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (137, N'DocenteHorarioDetalle', 547, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (138, N'DocenteHorarioDetalle', 546, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (139, N'DocenteHorarioDetalle', 545, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (140, N'DocenteHorarioDetalle', 544, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (141, N'DocenteHorarioDetalle', 543, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (142, N'DocenteHorarioDetalle', 542, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (143, N'DocenteHorarioDetalle', 541, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (144, N'DocenteHorarioDetalle', 540, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (145, N'DocenteHorarioDetalle', 539, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (146, N'DocenteHorarioDetalle', 538, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (147, N'DocenteHorarioDetalle', 537, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (148, N'DocenteHorarioDetalle', 536, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (149, N'DocenteHorarioDetalle', 535, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (150, N'DocenteHorarioDetalle', 534, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (151, N'DocenteHorarioDetalle', 533, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (152, N'DocenteHorarioDetalle', 532, N'INSERT', CAST(N'2024-11-15T14:03:02.073' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (153, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-15T14:03:07.533' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (154, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-15T14:03:10.917' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (155, N'DocenteHorarioDetalle', 532, N'UPDATE', CAST(N'2024-11-15T14:05:00.450' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (156, N'Asesoria', 1006, N'INSERT', CAST(N'2024-11-15T14:05:00.453' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (157, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-15T14:05:52.503' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (158, N'Usuario', 1003, N'UPDATE', CAST(N'2024-11-15T14:05:55.450' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (159, N'Usuario', 1003, N'UPDATE', CAST(N'2024-11-15T14:05:58.483' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (160, N'Usuario', 4, N'UPDATE', CAST(N'2024-11-15T14:06:04.180' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (161, N'Usuario', 4, N'UPDATE', CAST(N'2024-11-15T14:33:04.717' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (162, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-15T14:37:05.920' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (163, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-15T15:28:51.117' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (164, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-15T18:59:56.860' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (165, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-15T19:00:02.327' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (166, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-15T19:00:04.350' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (167, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-15T19:01:51.063' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (168, N'Usuario', 1003, N'UPDATE', CAST(N'2024-11-15T19:01:55.140' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (169, N'Usuario', 1003, N'UPDATE', CAST(N'2024-11-15T19:01:57.383' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (170, N'Usuario', 4, N'UPDATE', CAST(N'2024-11-15T19:02:04.257' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (171, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-15T19:30:31.867' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (172, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-23T17:06:10.123' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (173, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-23T17:06:12.190' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (174, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-23T17:06:14.773' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (175, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-23T17:06:16.163' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (176, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-24T10:42:51.517' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (177, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-30T15:33:06.970' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (178, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-30T15:34:01.207' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (179, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-30T15:34:03.417' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (180, N'DocenteHorarioDetalle', 658, N'UPDATE', CAST(N'2024-11-30T15:34:17.613' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (181, N'Asesoria', 1007, N'INSERT', CAST(N'2024-11-30T15:34:17.617' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (182, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-30T15:34:26.683' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (183, N'Usuario', 4, N'UPDATE', CAST(N'2024-11-30T15:34:31.100' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (184, N'Asesoria', 1007, N'UPDATE', CAST(N'2024-11-30T15:34:38.980' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (185, N'DocenteHorarioDetalle', 658, N'UPDATE', CAST(N'2024-11-30T15:34:38.983' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (186, N'Usuario', 4, N'UPDATE', CAST(N'2024-11-30T15:34:50.180' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (187, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-30T15:34:52.680' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (188, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-30T15:34:57.890' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (189, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-30T15:35:06.767' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (190, N'DocenteHorarioDetalle', 657, N'UPDATE', CAST(N'2024-11-30T15:35:44.537' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (191, N'Asesoria', 1008, N'INSERT', CAST(N'2024-11-30T15:35:44.540' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (192, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-30T15:36:05.030' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (193, N'Usuario', 4, N'UPDATE', CAST(N'2024-11-30T15:36:18.757' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (194, N'Asesoria', 1007, N'UPDATE', CAST(N'2024-11-30T15:36:31.517' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (195, N'DocenteHorarioDetalle', 658, N'UPDATE', CAST(N'2024-11-30T15:36:31.517' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (196, N'Asesoria', 1007, N'UPDATE', CAST(N'2024-11-30T15:36:36.167' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (197, N'DocenteHorarioDetalle', 658, N'UPDATE', CAST(N'2024-11-30T15:36:36.167' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (198, N'Asesoria', 1007, N'UPDATE', CAST(N'2024-11-30T15:37:12.330' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (199, N'DocenteHorarioDetalle', 658, N'UPDATE', CAST(N'2024-11-30T15:37:12.330' AS DateTime))
GO
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (200, N'Asesoria', 1007, N'UPDATE', CAST(N'2024-11-30T15:37:17.817' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (201, N'DocenteHorarioDetalle', 658, N'UPDATE', CAST(N'2024-11-30T15:37:17.817' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (202, N'Asesoria', 1006, N'UPDATE', CAST(N'2024-11-30T15:37:30.433' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (203, N'DocenteHorarioDetalle', 532, N'UPDATE', CAST(N'2024-11-30T15:37:30.433' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (204, N'Asesoria', 1007, N'UPDATE', CAST(N'2024-11-30T15:37:39.240' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (205, N'DocenteHorarioDetalle', 658, N'UPDATE', CAST(N'2024-11-30T15:37:39.240' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (206, N'Usuario', 4, N'UPDATE', CAST(N'2024-11-30T15:37:41.070' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (207, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-30T15:37:52.160' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (208, N'Usuario', 1, N'UPDATE', CAST(N'2024-11-30T15:37:54.890' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (209, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-30T15:37:59.950' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (210, N'Usuario', 2, N'UPDATE', CAST(N'2024-11-30T15:39:54.553' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (211, N'Usuario', 4, N'UPDATE', CAST(N'2024-11-30T15:40:05.990' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (212, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T16:37:51.603' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (213, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T17:20:18.903' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (214, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T17:21:15.763' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (215, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T17:26:18.510' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (216, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T17:26:49.103' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (217, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T17:26:56.330' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (218, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T17:51:34.873' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (219, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T18:02:39.830' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (220, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T18:02:47.960' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (221, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T18:06:17.030' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (222, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T18:06:38.090' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (223, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T18:06:57.880' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (224, N'Usuario', 2, N'UPDATE', CAST(N'2024-12-04T18:07:02.720' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (225, N'Usuario', 2, N'UPDATE', CAST(N'2024-12-04T18:07:37.110' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (226, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T18:07:39.220' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (227, N'DocenteHorario', 1009, N'INSERT', CAST(N'2024-12-04T18:08:26.750' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (228, N'DocenteHorarioDetalle', 1186, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (229, N'DocenteHorarioDetalle', 1185, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (230, N'DocenteHorarioDetalle', 1184, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (231, N'DocenteHorarioDetalle', 1183, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (232, N'DocenteHorarioDetalle', 1182, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (233, N'DocenteHorarioDetalle', 1181, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (234, N'DocenteHorarioDetalle', 1180, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (235, N'DocenteHorarioDetalle', 1179, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (236, N'DocenteHorarioDetalle', 1178, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (237, N'DocenteHorarioDetalle', 1177, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (238, N'DocenteHorarioDetalle', 1176, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (239, N'DocenteHorarioDetalle', 1175, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (240, N'DocenteHorarioDetalle', 1174, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (241, N'DocenteHorarioDetalle', 1173, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (242, N'DocenteHorarioDetalle', 1172, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (243, N'DocenteHorarioDetalle', 1171, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (244, N'DocenteHorarioDetalle', 1170, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (245, N'DocenteHorarioDetalle', 1169, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (246, N'DocenteHorarioDetalle', 1168, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (247, N'DocenteHorarioDetalle', 1167, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (248, N'DocenteHorarioDetalle', 1166, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (249, N'DocenteHorarioDetalle', 1165, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (250, N'DocenteHorarioDetalle', 1164, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (251, N'DocenteHorarioDetalle', 1163, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (252, N'DocenteHorarioDetalle', 1162, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (253, N'DocenteHorarioDetalle', 1161, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (254, N'DocenteHorarioDetalle', 1160, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (255, N'DocenteHorarioDetalle', 1159, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (256, N'DocenteHorarioDetalle', 1158, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (257, N'DocenteHorarioDetalle', 1157, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (258, N'DocenteHorarioDetalle', 1156, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (259, N'DocenteHorarioDetalle', 1155, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (260, N'DocenteHorarioDetalle', 1154, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (261, N'DocenteHorarioDetalle', 1153, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (262, N'DocenteHorarioDetalle', 1152, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (263, N'DocenteHorarioDetalle', 1151, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (264, N'DocenteHorarioDetalle', 1150, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (265, N'DocenteHorarioDetalle', 1149, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (266, N'DocenteHorarioDetalle', 1148, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (267, N'DocenteHorarioDetalle', 1147, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (268, N'DocenteHorarioDetalle', 1146, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (269, N'DocenteHorarioDetalle', 1145, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (270, N'DocenteHorarioDetalle', 1144, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (271, N'DocenteHorarioDetalle', 1143, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (272, N'DocenteHorarioDetalle', 1142, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (273, N'DocenteHorarioDetalle', 1141, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (274, N'DocenteHorarioDetalle', 1140, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (275, N'DocenteHorarioDetalle', 1139, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (276, N'DocenteHorarioDetalle', 1138, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (277, N'DocenteHorarioDetalle', 1137, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (278, N'DocenteHorarioDetalle', 1136, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (279, N'DocenteHorarioDetalle', 1135, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (280, N'DocenteHorarioDetalle', 1134, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (281, N'DocenteHorarioDetalle', 1133, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (282, N'DocenteHorarioDetalle', 1132, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (283, N'DocenteHorarioDetalle', 1131, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (284, N'DocenteHorarioDetalle', 1130, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (285, N'DocenteHorarioDetalle', 1129, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (286, N'DocenteHorarioDetalle', 1128, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (287, N'DocenteHorarioDetalle', 1127, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (288, N'DocenteHorarioDetalle', 1126, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (289, N'DocenteHorarioDetalle', 1125, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (290, N'DocenteHorarioDetalle', 1124, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (291, N'DocenteHorarioDetalle', 1123, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (292, N'DocenteHorarioDetalle', 1122, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (293, N'DocenteHorarioDetalle', 1121, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (294, N'DocenteHorarioDetalle', 1120, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (295, N'DocenteHorarioDetalle', 1119, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (296, N'DocenteHorarioDetalle', 1118, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (297, N'DocenteHorarioDetalle', 1117, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (298, N'DocenteHorarioDetalle', 1116, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (299, N'DocenteHorarioDetalle', 1115, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
GO
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (300, N'DocenteHorarioDetalle', 1114, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (301, N'DocenteHorarioDetalle', 1113, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (302, N'DocenteHorarioDetalle', 1112, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (303, N'DocenteHorarioDetalle', 1111, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (304, N'DocenteHorarioDetalle', 1110, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (305, N'DocenteHorarioDetalle', 1109, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (306, N'DocenteHorarioDetalle', 1108, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (307, N'DocenteHorarioDetalle', 1107, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (308, N'DocenteHorarioDetalle', 1106, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (309, N'DocenteHorarioDetalle', 1105, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (310, N'DocenteHorarioDetalle', 1104, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (311, N'DocenteHorarioDetalle', 1103, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (312, N'DocenteHorarioDetalle', 1102, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (313, N'DocenteHorarioDetalle', 1101, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (314, N'DocenteHorarioDetalle', 1100, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (315, N'DocenteHorarioDetalle', 1099, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (316, N'DocenteHorarioDetalle', 1098, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (317, N'DocenteHorarioDetalle', 1097, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (318, N'DocenteHorarioDetalle', 1096, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (319, N'DocenteHorarioDetalle', 1095, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (320, N'DocenteHorarioDetalle', 1094, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (321, N'DocenteHorarioDetalle', 1093, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (322, N'DocenteHorarioDetalle', 1092, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (323, N'DocenteHorarioDetalle', 1091, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (324, N'DocenteHorarioDetalle', 1090, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (325, N'DocenteHorarioDetalle', 1089, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (326, N'DocenteHorarioDetalle', 1088, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (327, N'DocenteHorarioDetalle', 1087, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (328, N'DocenteHorarioDetalle', 1086, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (329, N'DocenteHorarioDetalle', 1085, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (330, N'DocenteHorarioDetalle', 1084, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (331, N'DocenteHorarioDetalle', 1083, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (332, N'DocenteHorarioDetalle', 1082, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (333, N'DocenteHorarioDetalle', 1081, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (334, N'DocenteHorarioDetalle', 1080, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (335, N'DocenteHorarioDetalle', 1079, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (336, N'DocenteHorarioDetalle', 1078, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (337, N'DocenteHorarioDetalle', 1077, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (338, N'DocenteHorarioDetalle', 1076, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (339, N'DocenteHorarioDetalle', 1075, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (340, N'DocenteHorarioDetalle', 1074, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (341, N'DocenteHorarioDetalle', 1073, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (342, N'DocenteHorarioDetalle', 1072, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (343, N'DocenteHorarioDetalle', 1071, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (344, N'DocenteHorarioDetalle', 1070, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (345, N'DocenteHorarioDetalle', 1069, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (346, N'DocenteHorarioDetalle', 1068, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (347, N'DocenteHorarioDetalle', 1067, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (348, N'DocenteHorarioDetalle', 1066, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (349, N'DocenteHorarioDetalle', 1065, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (350, N'DocenteHorarioDetalle', 1064, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (351, N'DocenteHorarioDetalle', 1063, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (352, N'DocenteHorarioDetalle', 1062, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (353, N'DocenteHorarioDetalle', 1061, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (354, N'DocenteHorarioDetalle', 1060, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (355, N'DocenteHorarioDetalle', 1059, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (356, N'DocenteHorarioDetalle', 1058, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (357, N'DocenteHorarioDetalle', 1057, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (358, N'DocenteHorarioDetalle', 1056, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (359, N'DocenteHorarioDetalle', 1055, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (360, N'DocenteHorarioDetalle', 1054, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (361, N'DocenteHorarioDetalle', 1053, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (362, N'DocenteHorarioDetalle', 1052, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (363, N'DocenteHorarioDetalle', 1051, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (364, N'DocenteHorarioDetalle', 1050, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (365, N'DocenteHorarioDetalle', 1049, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (366, N'DocenteHorarioDetalle', 1048, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (367, N'DocenteHorarioDetalle', 1047, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (368, N'DocenteHorarioDetalle', 1046, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (369, N'DocenteHorarioDetalle', 1045, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (370, N'DocenteHorarioDetalle', 1044, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (371, N'DocenteHorarioDetalle', 1043, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (372, N'DocenteHorarioDetalle', 1042, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (373, N'DocenteHorarioDetalle', 1041, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (374, N'DocenteHorarioDetalle', 1040, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (375, N'DocenteHorarioDetalle', 1039, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (376, N'DocenteHorarioDetalle', 1038, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (377, N'DocenteHorarioDetalle', 1037, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (378, N'DocenteHorarioDetalle', 1036, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (379, N'DocenteHorarioDetalle', 1035, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (380, N'DocenteHorarioDetalle', 1034, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (381, N'DocenteHorarioDetalle', 1033, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (382, N'DocenteHorarioDetalle', 1032, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (383, N'DocenteHorarioDetalle', 1031, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (384, N'DocenteHorarioDetalle', 1030, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (385, N'DocenteHorarioDetalle', 1029, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (386, N'DocenteHorarioDetalle', 1028, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (387, N'DocenteHorarioDetalle', 1027, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (388, N'DocenteHorarioDetalle', 1026, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (389, N'DocenteHorarioDetalle', 1025, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (390, N'DocenteHorarioDetalle', 1024, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (391, N'DocenteHorarioDetalle', 1023, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (392, N'DocenteHorarioDetalle', 1022, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (393, N'DocenteHorarioDetalle', 1021, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (394, N'DocenteHorarioDetalle', 1020, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (395, N'DocenteHorarioDetalle', 1019, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (396, N'DocenteHorarioDetalle', 1018, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (397, N'DocenteHorarioDetalle', 1017, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (398, N'DocenteHorarioDetalle', 1016, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (399, N'DocenteHorarioDetalle', 1015, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
GO
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (400, N'DocenteHorarioDetalle', 1014, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (401, N'DocenteHorarioDetalle', 1013, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (402, N'DocenteHorarioDetalle', 1012, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (403, N'DocenteHorarioDetalle', 1011, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (404, N'DocenteHorarioDetalle', 1010, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (405, N'DocenteHorarioDetalle', 1009, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (406, N'DocenteHorarioDetalle', 1008, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (407, N'DocenteHorarioDetalle', 1007, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (408, N'DocenteHorarioDetalle', 1006, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (409, N'DocenteHorarioDetalle', 1005, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (410, N'DocenteHorarioDetalle', 1004, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (411, N'DocenteHorarioDetalle', 1003, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (412, N'DocenteHorarioDetalle', 1002, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (413, N'DocenteHorarioDetalle', 1001, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (414, N'DocenteHorarioDetalle', 1000, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (415, N'DocenteHorarioDetalle', 999, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (416, N'DocenteHorarioDetalle', 998, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (417, N'DocenteHorarioDetalle', 997, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (418, N'DocenteHorarioDetalle', 996, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (419, N'DocenteHorarioDetalle', 995, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (420, N'DocenteHorarioDetalle', 994, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (421, N'DocenteHorarioDetalle', 993, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (422, N'DocenteHorarioDetalle', 992, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (423, N'DocenteHorarioDetalle', 991, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (424, N'DocenteHorarioDetalle', 990, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (425, N'DocenteHorarioDetalle', 989, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (426, N'DocenteHorarioDetalle', 988, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (427, N'DocenteHorarioDetalle', 987, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (428, N'DocenteHorarioDetalle', 986, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (429, N'DocenteHorarioDetalle', 985, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (430, N'DocenteHorarioDetalle', 984, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (431, N'DocenteHorarioDetalle', 983, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (432, N'DocenteHorarioDetalle', 982, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (433, N'DocenteHorarioDetalle', 981, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (434, N'DocenteHorarioDetalle', 980, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (435, N'DocenteHorarioDetalle', 979, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (436, N'DocenteHorarioDetalle', 978, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (437, N'DocenteHorarioDetalle', 977, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (438, N'DocenteHorarioDetalle', 976, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (439, N'DocenteHorarioDetalle', 975, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (440, N'DocenteHorarioDetalle', 974, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (441, N'DocenteHorarioDetalle', 973, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (442, N'DocenteHorarioDetalle', 972, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (443, N'DocenteHorarioDetalle', 971, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (444, N'DocenteHorarioDetalle', 970, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (445, N'DocenteHorarioDetalle', 969, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (446, N'DocenteHorarioDetalle', 968, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (447, N'DocenteHorarioDetalle', 967, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (448, N'DocenteHorarioDetalle', 966, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (449, N'DocenteHorarioDetalle', 965, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (450, N'DocenteHorarioDetalle', 964, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (451, N'DocenteHorarioDetalle', 963, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (452, N'DocenteHorarioDetalle', 962, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (453, N'DocenteHorarioDetalle', 961, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (454, N'DocenteHorarioDetalle', 960, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (455, N'DocenteHorarioDetalle', 959, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (456, N'DocenteHorarioDetalle', 958, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (457, N'DocenteHorarioDetalle', 957, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (458, N'DocenteHorarioDetalle', 956, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (459, N'DocenteHorarioDetalle', 955, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (460, N'DocenteHorarioDetalle', 954, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (461, N'DocenteHorarioDetalle', 953, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (462, N'DocenteHorarioDetalle', 952, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (463, N'DocenteHorarioDetalle', 951, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (464, N'DocenteHorarioDetalle', 950, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (465, N'DocenteHorarioDetalle', 949, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (466, N'DocenteHorarioDetalle', 948, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (467, N'DocenteHorarioDetalle', 947, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (468, N'DocenteHorarioDetalle', 946, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (469, N'DocenteHorarioDetalle', 945, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (470, N'DocenteHorarioDetalle', 944, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (471, N'DocenteHorarioDetalle', 943, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (472, N'DocenteHorarioDetalle', 942, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (473, N'DocenteHorarioDetalle', 941, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (474, N'DocenteHorarioDetalle', 940, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (475, N'DocenteHorarioDetalle', 939, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (476, N'DocenteHorarioDetalle', 938, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (477, N'DocenteHorarioDetalle', 937, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (478, N'DocenteHorarioDetalle', 936, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (479, N'DocenteHorarioDetalle', 935, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (480, N'DocenteHorarioDetalle', 934, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (481, N'DocenteHorarioDetalle', 933, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (482, N'DocenteHorarioDetalle', 932, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (483, N'DocenteHorarioDetalle', 931, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (484, N'DocenteHorarioDetalle', 930, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (485, N'DocenteHorarioDetalle', 929, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (486, N'DocenteHorarioDetalle', 928, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (487, N'DocenteHorarioDetalle', 927, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (488, N'DocenteHorarioDetalle', 926, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (489, N'DocenteHorarioDetalle', 925, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (490, N'DocenteHorarioDetalle', 924, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (491, N'DocenteHorarioDetalle', 923, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (492, N'DocenteHorarioDetalle', 922, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (493, N'DocenteHorarioDetalle', 921, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (494, N'DocenteHorarioDetalle', 920, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (495, N'DocenteHorarioDetalle', 919, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (496, N'DocenteHorarioDetalle', 918, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (497, N'DocenteHorarioDetalle', 917, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (498, N'DocenteHorarioDetalle', 916, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (499, N'DocenteHorarioDetalle', 915, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
GO
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (500, N'DocenteHorarioDetalle', 914, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (501, N'DocenteHorarioDetalle', 913, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (502, N'DocenteHorarioDetalle', 912, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (503, N'DocenteHorarioDetalle', 911, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (504, N'DocenteHorarioDetalle', 910, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (505, N'DocenteHorarioDetalle', 909, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (506, N'DocenteHorarioDetalle', 908, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (507, N'DocenteHorarioDetalle', 907, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (508, N'DocenteHorarioDetalle', 906, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (509, N'DocenteHorarioDetalle', 905, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (510, N'DocenteHorarioDetalle', 904, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (511, N'DocenteHorarioDetalle', 903, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (512, N'DocenteHorarioDetalle', 902, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (513, N'DocenteHorarioDetalle', 901, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (514, N'DocenteHorarioDetalle', 900, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (515, N'DocenteHorarioDetalle', 899, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (516, N'DocenteHorarioDetalle', 898, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (517, N'DocenteHorarioDetalle', 897, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (518, N'DocenteHorarioDetalle', 896, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (519, N'DocenteHorarioDetalle', 895, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (520, N'DocenteHorarioDetalle', 894, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (521, N'DocenteHorarioDetalle', 893, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (522, N'DocenteHorarioDetalle', 892, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (523, N'DocenteHorarioDetalle', 891, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (524, N'DocenteHorarioDetalle', 890, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (525, N'DocenteHorarioDetalle', 889, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (526, N'DocenteHorarioDetalle', 888, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (527, N'DocenteHorarioDetalle', 887, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (528, N'DocenteHorarioDetalle', 886, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (529, N'DocenteHorarioDetalle', 885, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (530, N'DocenteHorarioDetalle', 884, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (531, N'DocenteHorarioDetalle', 883, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (532, N'DocenteHorarioDetalle', 882, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (533, N'DocenteHorarioDetalle', 881, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (534, N'DocenteHorarioDetalle', 880, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (535, N'DocenteHorarioDetalle', 879, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (536, N'DocenteHorarioDetalle', 878, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (537, N'DocenteHorarioDetalle', 877, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (538, N'DocenteHorarioDetalle', 876, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (539, N'DocenteHorarioDetalle', 875, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (540, N'DocenteHorarioDetalle', 874, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (541, N'DocenteHorarioDetalle', 873, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (542, N'DocenteHorarioDetalle', 872, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (543, N'DocenteHorarioDetalle', 871, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (544, N'DocenteHorarioDetalle', 870, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (545, N'DocenteHorarioDetalle', 869, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (546, N'DocenteHorarioDetalle', 868, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (547, N'DocenteHorarioDetalle', 867, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (548, N'DocenteHorarioDetalle', 866, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (549, N'DocenteHorarioDetalle', 865, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (550, N'DocenteHorarioDetalle', 864, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (551, N'DocenteHorarioDetalle', 863, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (552, N'DocenteHorarioDetalle', 862, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (553, N'DocenteHorarioDetalle', 861, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (554, N'DocenteHorarioDetalle', 860, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (555, N'DocenteHorarioDetalle', 859, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (556, N'DocenteHorarioDetalle', 858, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (557, N'DocenteHorarioDetalle', 857, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (558, N'DocenteHorarioDetalle', 856, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (559, N'DocenteHorarioDetalle', 855, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (560, N'DocenteHorarioDetalle', 854, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (561, N'DocenteHorarioDetalle', 853, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (562, N'DocenteHorarioDetalle', 852, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (563, N'DocenteHorarioDetalle', 851, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (564, N'DocenteHorarioDetalle', 850, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (565, N'DocenteHorarioDetalle', 849, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (566, N'DocenteHorarioDetalle', 848, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (567, N'DocenteHorarioDetalle', 847, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (568, N'DocenteHorarioDetalle', 846, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (569, N'DocenteHorarioDetalle', 845, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (570, N'DocenteHorarioDetalle', 844, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (571, N'DocenteHorarioDetalle', 843, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (572, N'DocenteHorarioDetalle', 842, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (573, N'DocenteHorarioDetalle', 841, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (574, N'DocenteHorarioDetalle', 840, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (575, N'DocenteHorarioDetalle', 839, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (576, N'DocenteHorarioDetalle', 838, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (577, N'DocenteHorarioDetalle', 837, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (578, N'DocenteHorarioDetalle', 836, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (579, N'DocenteHorarioDetalle', 835, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (580, N'DocenteHorarioDetalle', 834, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (581, N'DocenteHorarioDetalle', 833, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (582, N'DocenteHorarioDetalle', 832, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (583, N'DocenteHorarioDetalle', 831, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (584, N'DocenteHorarioDetalle', 830, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (585, N'DocenteHorarioDetalle', 829, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (586, N'DocenteHorarioDetalle', 828, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (587, N'DocenteHorarioDetalle', 827, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (588, N'DocenteHorarioDetalle', 826, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (589, N'DocenteHorarioDetalle', 825, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (590, N'DocenteHorarioDetalle', 824, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (591, N'DocenteHorarioDetalle', 823, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (592, N'DocenteHorarioDetalle', 822, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (593, N'DocenteHorarioDetalle', 821, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (594, N'DocenteHorarioDetalle', 820, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (595, N'DocenteHorarioDetalle', 819, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (596, N'DocenteHorarioDetalle', 818, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (597, N'DocenteHorarioDetalle', 817, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (598, N'DocenteHorarioDetalle', 816, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (599, N'DocenteHorarioDetalle', 815, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
GO
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (600, N'DocenteHorarioDetalle', 814, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (601, N'DocenteHorarioDetalle', 813, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (602, N'DocenteHorarioDetalle', 812, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (603, N'DocenteHorarioDetalle', 811, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (604, N'DocenteHorarioDetalle', 810, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (605, N'DocenteHorarioDetalle', 809, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (606, N'DocenteHorarioDetalle', 808, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (607, N'DocenteHorarioDetalle', 807, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (608, N'DocenteHorarioDetalle', 806, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (609, N'DocenteHorarioDetalle', 805, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (610, N'DocenteHorarioDetalle', 804, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (611, N'DocenteHorarioDetalle', 803, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (612, N'DocenteHorarioDetalle', 802, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (613, N'DocenteHorarioDetalle', 801, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (614, N'DocenteHorarioDetalle', 800, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (615, N'DocenteHorarioDetalle', 799, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (616, N'DocenteHorarioDetalle', 798, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (617, N'DocenteHorarioDetalle', 797, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (618, N'DocenteHorarioDetalle', 796, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (619, N'DocenteHorarioDetalle', 795, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (620, N'DocenteHorarioDetalle', 794, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (621, N'DocenteHorarioDetalle', 793, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (622, N'DocenteHorarioDetalle', 792, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (623, N'DocenteHorarioDetalle', 791, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (624, N'DocenteHorarioDetalle', 790, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (625, N'DocenteHorarioDetalle', 789, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (626, N'DocenteHorarioDetalle', 788, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (627, N'DocenteHorarioDetalle', 787, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (628, N'DocenteHorarioDetalle', 786, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (629, N'DocenteHorarioDetalle', 785, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (630, N'DocenteHorarioDetalle', 784, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (631, N'DocenteHorarioDetalle', 783, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (632, N'DocenteHorarioDetalle', 782, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (633, N'DocenteHorarioDetalle', 781, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (634, N'DocenteHorarioDetalle', 780, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (635, N'DocenteHorarioDetalle', 779, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (636, N'DocenteHorarioDetalle', 778, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (637, N'DocenteHorarioDetalle', 777, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (638, N'DocenteHorarioDetalle', 776, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (639, N'DocenteHorarioDetalle', 775, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (640, N'DocenteHorarioDetalle', 774, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (641, N'DocenteHorarioDetalle', 773, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (642, N'DocenteHorarioDetalle', 772, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (643, N'DocenteHorarioDetalle', 771, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (644, N'DocenteHorarioDetalle', 770, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (645, N'DocenteHorarioDetalle', 769, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (646, N'DocenteHorarioDetalle', 768, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (647, N'DocenteHorarioDetalle', 767, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (648, N'DocenteHorarioDetalle', 766, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (649, N'DocenteHorarioDetalle', 765, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (650, N'DocenteHorarioDetalle', 764, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (651, N'DocenteHorarioDetalle', 763, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (652, N'DocenteHorarioDetalle', 762, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (653, N'DocenteHorarioDetalle', 761, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (654, N'DocenteHorarioDetalle', 760, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (655, N'DocenteHorarioDetalle', 759, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (656, N'DocenteHorarioDetalle', 758, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (657, N'DocenteHorarioDetalle', 757, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (658, N'DocenteHorarioDetalle', 756, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (659, N'DocenteHorarioDetalle', 755, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (660, N'DocenteHorarioDetalle', 754, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (661, N'DocenteHorarioDetalle', 753, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (662, N'DocenteHorarioDetalle', 752, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (663, N'DocenteHorarioDetalle', 751, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (664, N'DocenteHorarioDetalle', 750, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (665, N'DocenteHorarioDetalle', 749, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (666, N'DocenteHorarioDetalle', 748, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (667, N'DocenteHorarioDetalle', 747, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (668, N'DocenteHorarioDetalle', 746, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (669, N'DocenteHorarioDetalle', 745, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (670, N'DocenteHorarioDetalle', 744, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (671, N'DocenteHorarioDetalle', 743, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (672, N'DocenteHorarioDetalle', 742, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (673, N'DocenteHorarioDetalle', 741, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (674, N'DocenteHorarioDetalle', 740, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (675, N'DocenteHorarioDetalle', 739, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (676, N'DocenteHorarioDetalle', 738, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (677, N'DocenteHorarioDetalle', 737, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (678, N'DocenteHorarioDetalle', 736, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (679, N'DocenteHorarioDetalle', 735, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (680, N'DocenteHorarioDetalle', 734, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (681, N'DocenteHorarioDetalle', 733, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (682, N'DocenteHorarioDetalle', 732, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (683, N'DocenteHorarioDetalle', 731, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (684, N'DocenteHorarioDetalle', 730, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (685, N'DocenteHorarioDetalle', 729, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (686, N'DocenteHorarioDetalle', 728, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (687, N'DocenteHorarioDetalle', 727, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (688, N'DocenteHorarioDetalle', 726, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (689, N'DocenteHorarioDetalle', 725, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (690, N'DocenteHorarioDetalle', 724, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (691, N'DocenteHorarioDetalle', 723, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (692, N'DocenteHorarioDetalle', 722, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (693, N'DocenteHorarioDetalle', 721, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (694, N'DocenteHorarioDetalle', 720, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (695, N'DocenteHorarioDetalle', 719, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (696, N'DocenteHorarioDetalle', 718, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (697, N'DocenteHorarioDetalle', 717, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (698, N'DocenteHorarioDetalle', 716, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (699, N'DocenteHorarioDetalle', 715, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
GO
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (700, N'DocenteHorarioDetalle', 714, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (701, N'DocenteHorarioDetalle', 713, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (702, N'DocenteHorarioDetalle', 712, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (703, N'DocenteHorarioDetalle', 711, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (704, N'DocenteHorarioDetalle', 710, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (705, N'DocenteHorarioDetalle', 709, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (706, N'DocenteHorarioDetalle', 708, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (707, N'DocenteHorarioDetalle', 707, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (708, N'DocenteHorarioDetalle', 706, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (709, N'DocenteHorarioDetalle', 705, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (710, N'DocenteHorarioDetalle', 704, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (711, N'DocenteHorarioDetalle', 703, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (712, N'DocenteHorarioDetalle', 702, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (713, N'DocenteHorarioDetalle', 701, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (714, N'DocenteHorarioDetalle', 700, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (715, N'DocenteHorarioDetalle', 699, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (716, N'DocenteHorarioDetalle', 698, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (717, N'DocenteHorarioDetalle', 697, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (718, N'DocenteHorarioDetalle', 696, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (719, N'DocenteHorarioDetalle', 695, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (720, N'DocenteHorarioDetalle', 694, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (721, N'DocenteHorarioDetalle', 693, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (722, N'DocenteHorarioDetalle', 692, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (723, N'DocenteHorarioDetalle', 691, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (724, N'DocenteHorarioDetalle', 690, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (725, N'DocenteHorarioDetalle', 689, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (726, N'DocenteHorarioDetalle', 688, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (727, N'DocenteHorarioDetalle', 687, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (728, N'DocenteHorarioDetalle', 686, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (729, N'DocenteHorarioDetalle', 685, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (730, N'DocenteHorarioDetalle', 684, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (731, N'DocenteHorarioDetalle', 683, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (732, N'DocenteHorarioDetalle', 682, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (733, N'DocenteHorarioDetalle', 681, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (734, N'DocenteHorarioDetalle', 680, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (735, N'DocenteHorarioDetalle', 679, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (736, N'DocenteHorarioDetalle', 678, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (737, N'DocenteHorarioDetalle', 677, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (738, N'DocenteHorarioDetalle', 676, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (739, N'DocenteHorarioDetalle', 675, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (740, N'DocenteHorarioDetalle', 674, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (741, N'DocenteHorarioDetalle', 673, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (742, N'DocenteHorarioDetalle', 672, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (743, N'DocenteHorarioDetalle', 671, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (744, N'DocenteHorarioDetalle', 670, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (745, N'DocenteHorarioDetalle', 669, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (746, N'DocenteHorarioDetalle', 668, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (747, N'DocenteHorarioDetalle', 667, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (748, N'DocenteHorarioDetalle', 666, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (749, N'DocenteHorarioDetalle', 665, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (750, N'DocenteHorarioDetalle', 664, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (751, N'DocenteHorarioDetalle', 663, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (752, N'DocenteHorarioDetalle', 662, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (753, N'DocenteHorarioDetalle', 661, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (754, N'DocenteHorarioDetalle', 660, N'INSERT', CAST(N'2024-12-04T18:08:26.760' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (755, N'Usuario', 1, N'UPDATE', CAST(N'2024-12-04T18:10:24.850' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (756, N'Usuario', 2, N'UPDATE', CAST(N'2024-12-04T18:10:27.247' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (757, N'DocenteHorarioDetalle', 713, N'UPDATE', CAST(N'2024-12-04T18:10:37.180' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (758, N'Asesoria', 1009, N'INSERT', CAST(N'2024-12-04T18:10:37.200' AS DateTime))
INSERT [dbo].[LogOperacion] ([IdLog], [Tabla], [IdRegistroAfectado], [Operacion], [FechaOperacion]) VALUES (759, N'Usuario', 2, N'UPDATE', CAST(N'2024-12-04T18:11:06.287' AS DateTime))
SET IDENTITY_INSERT [dbo].[LogOperacion] OFF
GO
SET IDENTITY_INSERT [dbo].[RolUsuario] ON 

INSERT [dbo].[RolUsuario] ([IdRolUsuario], [Nombre], [FechaCreacion]) VALUES (1, N'Administrador', CAST(N'2024-09-02T16:39:26.620' AS DateTime))
INSERT [dbo].[RolUsuario] ([IdRolUsuario], [Nombre], [FechaCreacion]) VALUES (2, N'Alumno', CAST(N'2024-09-02T16:39:26.620' AS DateTime))
INSERT [dbo].[RolUsuario] ([IdRolUsuario], [Nombre], [FechaCreacion]) VALUES (3, N'Docente', CAST(N'2024-09-02T16:39:26.620' AS DateTime))
SET IDENTITY_INSERT [dbo].[RolUsuario] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (1, N'75757575', N'Jose', N'Mendez', N'Jose@clinica.pe', N'123', 1, CAST(N'2024-09-02T16:39:26.713' AS DateTime), CAST(N'2024-12-04T18:10:24.850' AS DateTime), 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (2, N'74747474', N'Maria', N'Espinoza', N'maria@clinica.pe', N'123', 2, CAST(N'2024-09-02T16:39:26.713' AS DateTime), CAST(N'2024-12-04T18:11:06.287' AS DateTime), 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (3, N'10000000', N'Alexandra', N'Alvarez', N'', N'10000000', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (4, N'10000001', N'Abigail', N'Azizi', N'', N'10000001', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), CAST(N'2024-11-30T15:40:05.990' AS DateTime), 1)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (5, N'10000002', N'Justina', N'Thiarre', N'', N'10000002', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (6, N'10000003', N'Alana', N'Gomez', N'', N'10000003', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (8, N'10000005', N'Macon', N'Alonsos', N'', N'10000005', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (10, N'10000007', N'Serena', N'Renato', N'', N'10000007', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (11, N'10000008', N'Herman', N'Trinidad', N'', N'10000008', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (12, N'10000009', N'Derek', N'Daniel', N'', N'10000009', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (13, N'10000010', N'Lani', N'Alvarez', N'', N'10000010', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (14, N'10000011', N'Blaze', N'Maximiliano', N'', N'10000011', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (15, N'10000012', N'Nicole', N'Atlas', N'', N'10000012', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (16, N'10000013', N'Nasim', N'Carrasco', N'', N'10000013', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (17, N'10000014', N'Karleigh', N'Javier', N'', N'10000014', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (18, N'10000015', N'Rooney', N'Zuniga', N'', N'10000015', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (19, N'10000016', N'Hasad', N'Joaquin', N'', N'10000016', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (20, N'10000017', N'Tamara', N'Contreras', N'', N'10000017', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (21, N'10000018', N'Rhoda', N'Castro', N'', N'10000018', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (22, N'10000019', N'Orli', N'Florencia', N'', N'10000019', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (23, N'10000020', N'Montana', N'Castro', N'', N'10000020', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (24, N'10000021', N'Aquila', N'Jara', N'', N'10000021', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (25, N'10000022', N'Jenette', N'Tomas', N'', N'10000022', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (26, N'10000023', N'Sylvester', N'Tapia', N'', N'10000023', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (27, N'10000024', N'Colin', N'Florencia', N'', N'10000024', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (28, N'10000025', N'Galvin', N'Francisco', N'', N'10000025', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (29, N'10000026', N'Glenna', N'Benjamin', N'', N'10000026', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (30, N'10000027', N'Kay', N'Carla', N'', N'10000027', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (31, N'10000028', N'Jacob', N'Augustin', N'', N'10000028', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (32, N'10000029', N'Travis', N'Martina', N'', N'10000029', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (33, N'10000051', N'Brady', N'Vega', N'', N'10000051', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (34, N'10000052', N'Hashim', N'Torres', N'', N'10000052', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (35, N'10000053', N'MacKenzie', N'Laura', N'', N'10000053', 3, CAST(N'2024-09-02T16:39:26.720' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (1002, N'64212312', N'Johan', N'Zela', N'johanzela@gmail.com', N'123', 1, CAST(N'2024-09-04T21:54:02.583' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (1003, N'23232323', N'Maycol', N'Saavedra', N'maycolninaja@gmail.com', N'123', 2, CAST(N'2024-09-04T23:23:56.430' AS DateTime), CAST(N'2024-11-15T19:01:57.383' AS DateTime), 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (2005, N'72727272', N'Johan', N'Zela', N'johanzela@gmail.com', N'123', 3, CAST(N'2024-10-08T19:51:48.500' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (2006, N'32323223', N'Michael', N'Ninaja', N'ninaja@gmail.com', N'123', 3, CAST(N'2024-10-11T00:02:38.500' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (3007, N'42424242', N'Maycol', N'Hinostroza', N'maycolhinostroza@gmail.com', N'123', 3, CAST(N'2024-10-14T13:37:53.873' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (3009, N'12121212', N'Sol', N'Velasquez', N'sol123@gmail.com', N'123', 1, CAST(N'2024-10-26T01:00:12.217' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (3010, N'43434343', N'Yomaira', N'Moran', N'yomaira@gmail.com', N'123', 1, CAST(N'2024-10-26T12:42:15.190' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (3011, N'11111111', N'Alonso', N'Torres', N'alonso@gmail.com', N'123', 3, CAST(N'2024-10-26T14:00:10.307' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (3015, N'55555555', N'aw', N'aw', N'aw@gmail.com', N'123', 1, CAST(N'2024-10-26T14:37:52.420' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (3016, N'12345678', N'Juan', N'Pérez', N'juan.perez@example.com', N'1234', 1, CAST(N'2024-10-26T16:08:04.170' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (3017, N'5341213', N'as', N'as', N'as@gmail.com', N'123', 1, CAST(N'2024-10-26T16:12:37.057' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (3018, N'12345679', N'nose', N'Nose', N'nose@gmail.com', N'123', 1, CAST(N'2024-10-26T16:18:28.197' AS DateTime), NULL, 0)
INSERT [dbo].[Usuario] ([IdUsuario], [NumeroDocumentoIdentidad], [Nombre], [Apellido], [Correo], [Clave], [IdRolUsuario], [FechaCreacion], [UltimaConexion], [Conexion]) VALUES (3019, N'23232324', N'saq', N'as', N'saq@gmail.com', N'123', 1, CAST(N'2024-10-26T16:27:10.033' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
ALTER TABLE [dbo].[Asesoria] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Curso] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Docente] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[DocenteHorario] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[DocenteHorarioDetalle] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[EstadoAsesoria] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[LogOperacion] ADD  DEFAULT (getdate()) FOR [FechaOperacion]
GO
ALTER TABLE [dbo].[RolUsuario] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_Conexion]  DEFAULT ((0)) FOR [Conexion]
GO
ALTER TABLE [dbo].[Asesoria]  WITH CHECK ADD FOREIGN KEY([IdDocenteHorarioDetalle])
REFERENCES [dbo].[DocenteHorarioDetalle] ([IdDocenteHorarioDetalle])
GO
ALTER TABLE [dbo].[Asesoria]  WITH CHECK ADD FOREIGN KEY([IdEstadoAsesoria])
REFERENCES [dbo].[EstadoAsesoria] ([IdEstadoAsesoria])
GO
ALTER TABLE [dbo].[Asesoria]  WITH CHECK ADD FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[Docente]  WITH CHECK ADD FOREIGN KEY([IdCurso])
REFERENCES [dbo].[Curso] ([IdCurso])
GO
ALTER TABLE [dbo].[DocenteHorario]  WITH CHECK ADD FOREIGN KEY([IdDocente])
REFERENCES [dbo].[Docente] ([IdDocente])
GO
ALTER TABLE [dbo].[DocenteHorarioDetalle]  WITH CHECK ADD FOREIGN KEY([IdDocenteHorario])
REFERENCES [dbo].[DocenteHorario] ([IdDocenteHorario])
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD FOREIGN KEY([IdRolUsuario])
REFERENCES [dbo].[RolUsuario] ([IdRolUsuario])
GO
/****** Object:  StoredProcedure [dbo].[sp_CambiarEstadoAsesoria]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_CambiarEstadoAsesoria]
(
@IdAsesoria int,
@IdEstadoAsesoria int,
@Indicaciones varchar(100) = '',
@msgError varchar(100) OUTPUT
)
as
begin
	set @msgError = ''
	set dateformat dmy

	begin try
		begin tran

		update Asesoria  set IdEstadoAsesoria  = @IdEstadoAsesoria, Indicaciones = iif(@Indicaciones='',Indicaciones,@Indicaciones) where IdAsesoria  = @IdAsesoria

		commit tran
	end try
	begin catch
		rollback tran
		set @msgError = 'No se pudo cambiar el estado'
	end catch

end



GO
/****** Object:  StoredProcedure [dbo].[sp_CancelarAsesoria]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_CancelarAsesoria]
(
@IdAsesoria int,
@msgError varchar(100) OUTPUT
)
as
begin
	set @msgError = ''
	set dateformat dmy

	begin try
		begin tran

		update Asesoria set IdEstadoAsesoria = 3 where IdAsesoria = @IdAsesoria

		declare @IdDocenteHorarioDetalle int = (
			select c.IdDocenteHorarioDetalle from Asesoria c
			inner join DocenteHorarioDetalle dhd on dhd.IdDocenteHorarioDetalle = c.IdDocenteHorarioDetalle
			where c.IdAsesoria = @IdAsesoria
		)

		update DocenteHorarioDetalle set Reservado = 0 where IdDocenteHorarioDetalle = @IdDocenteHorarioDetalle

		commit tran
	end try
	begin catch
		rollback tran
		set @msgError = 'Error al cancelar la asesoria'
	end catch

end


GO
/****** Object:  StoredProcedure [dbo].[sp_editarCurso]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_editarCurso]
(
@IdCurso int,
@Nombre varchar(100),
@msgError varchar(100) OUTPUT
)
as
begin
	set @msgError = ''
	if(not exists(select IdCurso from Curso where Nombre = @Nombre and IdCurso != @IdCurso))
		update Curso set
		Nombre = @Nombre
		where IdCurso = @IdCurso
	else
		set @msgError = 'El curso ya existe'
end


GO
/****** Object:  StoredProcedure [dbo].[sp_editarDocente]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_editarDocente]
(
@IdDocente int,
@NumeroDocumentoIdentidad varchar(50),
@Nombres varchar(50),
@Apellidos varchar(50),
@Genero varchar(50),
@IdCurso int,
@msgError varchar(100) OUTPUT
)
as
begin
	set @msgError = ''

	if(not exists(select IdDocente from Docente where NumeroDocumentoIdentidad = @NumeroDocumentoIdentidad and IdDocente != @IdDocente))
		update Docente set 
		NumeroDocumentoIdentidad = @NumeroDocumentoIdentidad,
		Nombres  = @Nombres,
		Apellidos = @Apellidos,
		Genero = @Genero,
		IdCurso = @IdCurso
		where IdDocente = @IdDocente
	else
		set @msgError = 'El docente ya existe'
end


GO
/****** Object:  StoredProcedure [dbo].[sp_editarUsuario]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_editarUsuario]
(
@IdUsuario int,
@NumeroDocumentoIdentidad varchar(50),
@Nombre varchar(50),
@Apellido varchar(50),
@Correo varchar(50),
@Clave varchar(50),
@IdRolUsuario int,
@MsgError varchar(100) OUTPUT
)
as
begin
	set @MsgError = ''
	if(not exists(select IdUsuario from Usuario where NumeroDocumentoIdentidad = @NumeroDocumentoIdentidad and IdUsuario != @IdUsuario))
		update Usuario set
		NumeroDocumentoIdentidad = @NumeroDocumentoIdentidad,
		Nombre = @Nombre,
		Apellido = @Apellido,
		Correo = @Correo,
		Clave = @Clave,
		IdRolUsuario = @IdRolUsuario
		where IdUsuario = @IdUsuario
	else
		set @MsgError = 'El usuario ya existe'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminarCurso]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_eliminarCurso]
(
@IdCurso int
)
as
begin
 delete top (1) from Curso
 where IdCurso = @IdCurso
end


GO
/****** Object:  StoredProcedure [dbo].[sp_eliminarDocente]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_eliminarDocente]
(
@IdDocente int
)
as
begin
 delete top (1) from Docente
 where IdDocente = @IdDocente
end


GO
/****** Object:  StoredProcedure [dbo].[sp_eliminarDocenteHorario]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_eliminarDocenteHorario](
@IdDocenteHorario int,
@msgError varchar(100) OUTPUT
)
as
begin
	set @msgError = ''
	if ((select count(*) from DocenteHorarioDetalle 
	where IdDocenteHorario = @IdDocenteHorario and Reservado = 1) > 0
	)
	begin
		set @msgError = 'No se puede eliminar porque un turno ya fue reservado'
	end
	else
	begin
		delete from DocenteHorarioDetalle where IdDocenteHorario = @IdDocenteHorario
		delete from DocenteHorario where IdDocenteHorario = @IdDocenteHorario
	end
end



GO
/****** Object:  StoredProcedure [dbo].[sp_eliminarUsuario]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_eliminarUsuario]
(
@IdUsuario int
)
as
begin
 delete top (1) from Usuario
 where IdUsuario = @IdUsuario
end


GO
/****** Object:  StoredProcedure [dbo].[sp_guardarAsesoria]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- PROCEDIMIENTOS PARA DOCENTE ---

create procedure [dbo].[sp_guardarAsesoria]
(
@IdUsuario int,
@IdDocenteHorarioDetalle int,
@IdEstadoAsesoria int,
@FechaAsesoria varchar(10),
@msgError varchar(100) OUTPUT
)
as
declare  @fecha date
set @fecha = ( select fecha from DocenteHorarioDetalle where IdDocenteHorarioDetalle = @IdDocenteHorarioDetalle)
declare @hora time
set @hora = (select TurnoHora from DocenteHorarioDetalle where IdDocenteHorarioDetalle = @IdDocenteHorarioDetalle)

begin
	set @msgError = ''
	set dateformat dmy

	begin try
		begin tran

--agregado por JDiaz el 20240418----
		 if ( exists(select x.Fecha, x.TurnoHora from DocenteHorarioDetalle x join Asesoria y on x.IdDocenteHorarioDetalle = y.IdDocenteHorarioDetalle where y.IdUsuario = @IdUsuario and x.Fecha = @fecha and x.TurnoHora = @hora) )
		begin

			set @msgError = 'Ya tiene una asesoria para el mismo dia y hora, por favor anularla'
		end
		else
-------
		if(not exists(select IdDocenteHorarioDetalle from DocenteHorarioDetalle where IdDocenteHorarioDetalle = @IdDocenteHorarioDetalle and Reservado = 1))
		begin

			update DocenteHorarioDetalle set
			Reservado = 1
			where IdDocenteHorarioDetalle = @IdDocenteHorarioDetalle

			insert into Asesoria(IdUsuario,IdDocenteHorarioDetalle,IdEstadoAsesoria,FechaAsesoria) values
			(@IdUsuario,@IdDocenteHorarioDetalle,@IdEstadoAsesoria,convert(date,@FechaAsesoria))

		end
	
		else
			set @msgError = 'El horario no esta disponible'

		commit tran
	end try
	begin catch
		rollback tran
		set @msgError = 'Error al registrar el horario'
	end catch

end




GO
/****** Object:  StoredProcedure [dbo].[sp_guardarCurso]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_guardarCurso]
(
@Nombre varchar(100),
@msgError varchar(100) OUTPUT
)
as
begin
	set @msgError = ''

	if(not exists(select IdCurso from Curso where Nombre = @Nombre))
		insert into Curso(Nombre) values(@Nombre)
	else
		set @msgError = 'El curso ya existe'
end


GO
/****** Object:  StoredProcedure [dbo].[sp_guardarDocente]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_guardarDocente]
(
@NumeroDocumentoIdentidad varchar(50),
@Nombres varchar(50),
@Apellidos varchar(50),
@Genero varchar(50),
@IdCurso int,
@msgError varchar(100) OUTPUT
)
as
begin
	set @msgError = ''

	if(not exists(select IdDocente from Docente where NumeroDocumentoIdentidad = @NumeroDocumentoIdentidad))
	begin
		insert into Docente(NumeroDocumentoIdentidad,Nombres,Apellidos,Genero,IdCurso) values
		(@NumeroDocumentoIdentidad,@Nombres,@Apellidos,@Genero,@IdCurso)

		if(not exists(select IdUsuario from Usuario where NumeroDocumentoIdentidad = @NumeroDocumentoIdentidad))
			insert into Usuario(NumeroDocumentoIdentidad,Nombre,Apellido,Correo,Clave,IdRolUsuario) values
			(@NumeroDocumentoIdentidad,@Nombres,@Apellidos,'',@NumeroDocumentoIdentidad,3)

	end
	else
		set @msgError = 'El docente ya existe'
end


GO
/****** Object:  StoredProcedure [dbo].[sp_guardarUsuario]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_guardarUsuario]
(
@NumeroDocumentoIdentidad varchar(50),
@Nombre varchar(50),
@Apellido varchar(50),
@Correo varchar(50),
@Clave varchar(50),
@IdRolUsuario int,
@MsgError varchar(100) OUTPUT
)
as
begin
	set @MsgError = ''

	if(not exists(select IdUsuario from Usuario where NumeroDocumentoIdentidad = @NumeroDocumentoIdentidad))
		insert into Usuario(NumeroDocumentoIdentidad,Nombre,Apellido,Correo,Clave,IdRolUsuario) values
		(@NumeroDocumentoIdentidad,@Nombre,@Apellido,@Correo,@Clave,@IdRolUsuario)
	else
		set @MsgError = 'El usuario ya existe'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ListaAsesoriasAsignadas]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_ListaAsesoriasAsignadas](
@IdDocente int,
@IdEstadoAsesoria int
)
as
begin
	select c.IdAsesoria, convert(char(10),c.FechaAsesoria,103)[FechaAsesoria],convert(char(5),dhd.TurnoHora,108)[HoraAsesoria],
	u.Nombre,u.Apellido,ec.Nombre[EstadoAsesoria],c.Indicaciones from Asesoria c
	inner join Usuario u on u.IdUsuario = c.IdUsuario
	inner join EstadoAsesoria ec on ec.IdEstadoAsesoria = c.IdEstadoAsesoria
	inner join DocenteHorarioDetalle dhd on dhd.IdDocenteHorarioDetalle = c.IdDocenteHorarioDetalle
	inner join DocenteHorario dh on dh.IdDocenteHorario = dhd.IdDocenteHorario
	inner join Docente d on d.IdDocente = dh.IdDocente
	inner join Usuario u2 on u2.NumeroDocumentoIdentidad = d.NumeroDocumentoIdentidad
	where c.IdEstadoAsesoria = @IdEstadoAsesoria and u2.IdUsuario = @IdDocente
	order by c.FechaAsesoria desc
end


GO
/****** Object:  StoredProcedure [dbo].[sp_ListaAsesoriasPendiente]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ListaAsesoriasPendiente]
(
    @IdUsuario INT
)
AS
BEGIN
    SELECT 
        c.IdAsesoria, 
        CONVERT(CHAR(10), c.FechaAsesoria, 103) AS FechaAsesoria, -- Cambia el alias a FechaAsesoria
        e.Nombre AS NombreCurso, 
        d.Nombres, 
        d.Apellidos, 
        CONVERT(CHAR(5), dhd.TurnoHora, 108) AS HoraAsesoria 
    FROM Asesoria c
    INNER JOIN DocenteHorarioDetalle dhd ON dhd.IdDocenteHorarioDetalle = c.IdDocenteHorarioDetalle
    INNER JOIN DocenteHorario dh ON dh.IdDocenteHorario = dhd.IdDocenteHorario
    INNER JOIN Docente d ON d.IdDocente = dh.IdDocente
    INNER JOIN Curso e ON e.IdCurso = d.IdCurso
    WHERE c.FechaAsesoria >= GETDATE() 
    AND c.IdEstadoAsesoria = 1 
    AND c.IdUsuario = @IdUsuario
END
GO
/****** Object:  StoredProcedure [dbo].[sp_listaCurso]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--- PROCEDIMIENTOS PARA CURSO ---

create procedure [dbo].[sp_listaCurso]
as
begin
 select IdCurso,Nombre,convert(char(10),FechaCreacion,103)[FechaCreacion] from Curso
end


GO
/****** Object:  StoredProcedure [dbo].[sp_listaDocente]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--- PROCEDIMIENTOS PARA DOCENTE ---

create procedure [dbo].[sp_listaDocente]
as
begin
	select d.IdDocente,d.NumeroDocumentoIdentidad,d.Nombres,d.Apellidos,d.Genero,e.IdCurso,e.Nombre[NombreCurso],
	convert(char(10),d.FechaCreacion,103)[FechaCreacion]
	from Docente d
	inner join Curso e on e.IdCurso = d.IdCurso
end


GO
/****** Object:  StoredProcedure [dbo].[sp_listaDocenteHorario]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_listaDocenteHorario]
as
begin
	select dh.IdDocenteHorario, d.NumeroDocumentoIdentidad,d.Nombres,d.Apellidos,dh.NumeroMes,
	convert(char(5),dh.HoraInicioAM,108)HoraInicioAM,convert(char(5),dh.HoraFinAM,108)HoraFinAM,
	convert(char(5),dh.HoraInicioPM,108)HoraInicioPM,convert(char(5),dh.HoraFinPM,108)HoraFinPM,
	convert(char(10),dh.FechaCreacion,103)[FechaCreacion]
	from DocenteHorario dh
	inner join Docente d on d.IdDocente = dh.IdDocente
end


GO
/****** Object:  StoredProcedure [dbo].[sp_listaDocenteHorarioDetalle]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_listaDocenteHorarioDetalle]
@IdDocente INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        CONVERT(char(10), dhd.fecha, 103) AS [Fecha],
        (
            SELECT
				dhd2.IdDocenteHorarioDetalle,
				dhd2.Turno,
                CONVERT(char(5), dhd2.TurnoHora, 108) AS [TurnoHora]
            FROM
                DocenteHorarioDetalle dhd2
				INNER JOIN DocenteHorario dh2 ON dh2.IdDocenteHorario = dhd2.IdDocenteHorario
            WHERE
                dhd2.fecha = dhd.fecha
				and dhd2.Reservado = 0
				and dh2.IdDocente = @IdDocente
            FOR XML PATH('Hora'), TYPE, ROOT('Horarios')
        )
    FROM
        DocenteHorarioDetalle dhd
        INNER JOIN DocenteHorario dh ON dh.IdDocenteHorario = dhd.IdDocenteHorario
    WHERE
        dh.IdDocente = @IdDocente
    GROUP BY
    dhd.fecha
    FOR XML PATH('FechaAtencion'), ROOT('HorarioDocente'), TYPE;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ListaHistorialAsesorias]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_ListaHistorialAsesorias](
@IdUsuario int
)
as
begin
	select c.IdAsesoria, convert(char(10),FechaAsesoria,103)[FechaAsesoria],e.Nombre[NombreCurso],d.Nombres,d.Apellidos,convert(char(5),dhd.TurnoHora,108)[HoraAsesoria],
	isnull(c.Indicaciones,'')[Indicaciones]
	from Asesoria c
	inner join DocenteHorarioDetalle dhd on dhd.IdDocenteHorarioDetalle = c.IdDocenteHorarioDetalle
	inner join DocenteHorario dh on dh.IdDocenteHorario = dhd.IdDocenteHorario
	inner join Docente d on d.IdDocente = dh.IdDocente
	inner join Curso e on e.IdCurso = d.IdCurso
	where c.FechaAsesoria < GETDATE() and c.IdEstadoAsesoria = 2 and c.IdUsuario = @IdUsuario
end


GO
/****** Object:  StoredProcedure [dbo].[sp_listaRolUsuario]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--- PROCEDIMIENTOS PARA ROLUSUARIO ---
create procedure [dbo].[sp_listaRolUsuario]
as
begin
 select IdRolUsuario,Nombre,convert(char(10),FechaCreacion,103)[FechaCreacion] from RolUsuario
end


GO
/****** Object:  StoredProcedure [dbo].[sp_listaUsuario]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--- PROCEDIMIENTOS PARA USUARIO ---

create procedure [dbo].[sp_listaUsuario](
@IdRolUsuario int
)
as
begin
	select u.IdUsuario,u.NumeroDocumentoIdentidad,u.Nombre,u.Apellido,u.Correo,u.Clave,ru.IdRolUsuario,ru.Nombre[NombreRol],
	convert(char(10),u.FechaCreacion,103)[FechaCreacion]
	from Usuario u
	inner join RolUsuario ru on ru.IdRolUsuario = u.IdRolUsuario
	where u.IdRolUsuario = iif(@IdRolUsuario=0,u.IdRolUsuario,@IdRolUsuario)
end


GO
/****** Object:  StoredProcedure [dbo].[sp_loginUsuario]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_loginUsuario]
(
    @DocumentoIdentidad VARCHAR(50),
    @Clave VARCHAR(50)
)
AS
BEGIN
    -- Seleccionar los datos del usuario y verificar las credenciales
    SELECT u.IdUsuario, u.NumeroDocumentoIdentidad, u.Nombre, u.Apellido, u.Correo, ru.Nombre AS NombreRol
    FROM Usuario u
    INNER JOIN RolUsuario ru ON ru.IdRolUsuario = u.IdRolUsuario
    WHERE u.NumeroDocumentoIdentidad = @DocumentoIdentidad AND u.Clave = @Clave;

    -- Actualizar el estado de conexión y la última conexión si las credenciales son correctas
    IF @@ROWCOUNT > 0  -- Verifica que la consulta anterior encontró un usuario
    BEGIN
        UPDATE Usuario
        SET Conexion = 1, UltimaConexion = GETDATE()
        WHERE NumeroDocumentoIdentidad = @DocumentoIdentidad AND Clave = @Clave;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_obtenerDashboard]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_obtenerDashboard]
as
begin
	select
	(select count(*) from Docente)[TotalDocentes],
	(select count(*) from Curso)[TotalCursos],
	(select count(*) from Asesoria where IdEstadoAsesoria = 1)[TotalAsesoriaPendientes],
		(select count(*) from Asesoria where IdEstadoAsesoria = 2)[TotalAsesoriaAtendidas],
			(select count(*) from Asesoria where IdEstadoAsesoria = 3)[TotalAsesoriaAnuladas]

end
GO
/****** Object:  StoredProcedure [dbo].[sp_registrarDocenteHorario]    Script Date: 05/12/2024 22:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_registrarDocenteHorario]
(
@IdDocente int,
@NumeroMes int,
@HoraInicioAM varchar(5),
@HoraFinAM varchar(5),
@HoraInicioPM varchar(5),
@HoraFinPM varchar(5),
@Fechas varchar(max),
@msgError varchar(100) OUTPUT
)
as
begin
	set dateformat dmy
	set @msgError = ''
	declare @IdDocenteHorario int
	declare @HI_AM time = convert(time,@HoraInicioAM)
	declare @HF_AM time = convert(time,@HoraFinAM)
	declare @HI_PM time = convert(time,@HoraInicioPM)
	declare @HF_PM time = convert(time,@HoraFinPM)

	begin try

			begin tran
	
			if(exists(select convert(date,a.valor)[fecha],month(convert(date,a.valor))[mes],b.valor
			from dbo.SplitString(@Fechas, ',')a
			left join dbo.SplitString(@NumeroMes, ',') b on convert(int, month(convert(date,a.valor))) =  b.valor
			where b.valor is null))
			begin
				set @msgError = 'Todas las fechas deben estar dentro del mismo mes'
			end

			if(exists(select IdDocente from DocenteHorario where IdDocente = @IdDocente and NumeroMes = @NumeroMes))
			begin
				set @msgError = 'El docente ya tiene registrado su horario para el mes seleccionado'
			end

			if(@msgError='')
			begin
				insert into DocenteHorario(IdDocente,NumeroMes,HoraInicioAM,HoraFinAM,HoraInicioPM,HoraFinPM) values
				(@IdDocente,@NumeroMes,@HoraInicioAM,@HoraFinAM,@HoraInicioPM,@HoraFinPM)
			
				set @IdDocenteHorario = SCOPE_IDENTITY()
	
				;WITH HORAS_AM AS (
					SELECT @HI_AM AS HoraTurno
					UNION ALL
					SELECT  DATEADD(MINUTE, 30, HoraTurno) FROM HORAS_AM WHERE DATEADD(MINUTE, 30, HoraTurno)<=@HF_AM
				)
				SELECT HoraTurno into #HorarioAM FROM HORAS_AM
	
				;WITH HORAS_PM AS (
					SELECT @HI_PM AS HoraTurno
					UNION ALL
					SELECT  DATEADD(MINUTE, 30, HoraTurno) FROM HORAS_PM WHERE DATEADD(MINUTE, 30, HoraTurno)<=@HF_PM
				)
				SELECT HoraTurno into #HorarioPM FROM HORAS_PM
	
	
				select @IdDocenteHorario[IdDocenteHorario],'AM'[Turno],HoraTurno[TurnoHora],0[Reservado] into #Horario from #HorarioAM
				UNION ALL
				select @IdDocenteHorario,'PM',HoraTurno,0 from #HorarioPM
	
				
				insert into DocenteHorarioDetalle(IdDocenteHorario,Fecha,Turno,TurnoHora,Reservado)
				select @IdDocenteHorario,CONVERT(date,f.valor),h.Turno,h.TurnoHora,h.Reservado
				from dbo.SplitString(@Fechas, ',') f
				CROSS JOIN #Horario h
				order by CONVERT(date,f.valor),TurnoHora asc
	
			end
				
			commit tran
	end try
	begin catch
		rollback tran
		set @msgError = ERROR_MESSAGE()
	end catch

end


GO
USE [master]
GO
ALTER DATABASE [DBInnovaEdu] SET  READ_WRITE 
GO
