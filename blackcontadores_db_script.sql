USE [BLACKCONTADORES]
GO
/****** Object:  User [black_user]    Script Date: 25/07/2025 02:30:24 p. m. ******/
CREATE USER [black_user] FOR LOGIN [black_user] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [black_user]
GO
/****** Object:  UserDefinedFunction [dbo].[Func_GetDate]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      RAUL EMMANUEL JUAREZ PARRA
-- Create Date: 25/05/2020
-- Description: RECUPERA LA FECHA Y HORA ACTUAL 
--              DE LA REGION
-- =============================================
CREATE FUNCTION [dbo].[Func_GetDate]()
RETURNS datetime
AS
BEGIN
   declare @current_day datetime

   set @current_day = (select GETDATE())

    -- Return the result of the function
    RETURN @current_day
END
GO
/****** Object:  Table [dbo].[MtoCat_BalanceGeneralEmpresa]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_BalanceGeneralEmpresa](
	[EmpresaTransID] [int] NOT NULL,
	[Efectivo] [decimal](18, 2) NOT NULL,
	[Bancos] [decimal](18, 2) NOT NULL,
	[DeudasCobrar] [decimal](18, 2) NOT NULL,
	[ActivoFijo] [decimal](18, 2) NOT NULL,
	[DeudasPagar] [decimal](18, 2) NOT NULL,
	[CapitalInicial] [decimal](18, 2) NOT NULL,
	[CreadoPor] [varchar](50) NOT NULL,
	[CreadoEl] [datetime] NOT NULL,
	[ModificadoPor] [varchar](50) NOT NULL,
	[ModificadoEl] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_Clasificaciones]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_Clasificaciones](
	[ClasificacionID] [int] IDENTITY(1,1) NOT NULL,
	[Clasificacion] [varchar](100) NOT NULL,
	[EsIngreso] [bit] NOT NULL,
 CONSTRAINT [PK_MtoCat_Clasificaciones] PRIMARY KEY CLUSTERED 
(
	[ClasificacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_Cuentas]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_Cuentas](
	[CuentaID] [int] IDENTITY(1,1) NOT NULL,
	[EmpresaTransID] [int] NOT NULL,
	[TipoCuentaID] [int] NULL,
	[EsActivo] [bit] NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[EsCuentaEmpresa] [bit] NOT NULL,
	[CreadoPor] [varchar](50) NOT NULL,
	[CreadoEl] [datetime] NOT NULL,
	[ModificadoPor] [varchar](50) NOT NULL,
	[ModifcadoEl] [datetime] NOT NULL,
 CONSTRAINT [PK_MtoCat_Cuentas] PRIMARY KEY CLUSTERED 
(
	[CuentaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_EmpresaActividadesSubGiro]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_EmpresaActividadesSubGiro](
	[ActividadID] [int] IDENTITY(1,1) NOT NULL,
	[SubGiroID] [int] NOT NULL,
	[NombreActividad] [varchar](300) NOT NULL,
 CONSTRAINT [PK_MtoCat_EmpresaActividadesSubGiro] PRIMARY KEY CLUSTERED 
(
	[ActividadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_EmpresaGiros]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_EmpresaGiros](
	[GiroID] [int] IDENTITY(1,1) NOT NULL,
	[NombreGiro] [varchar](200) NOT NULL,
 CONSTRAINT [PK_MtoCat_EmpresaGiros] PRIMARY KEY CLUSTERED 
(
	[GiroID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_Empresas]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_Empresas](
	[EmpresaID] [int] IDENTITY(1,1) NOT NULL,
	[EmpresaTransID] [int] NOT NULL,
	[MembresiaID] [int] NOT NULL,
	[GiroID] [int] NULL,
	[SubGiroID] [int] NULL,
	[ActividadGiroID] [int] NULL,
	[OtraActividad] [varchar](100) NULL,
	[CustomerConektaID] [varchar](100) NULL,
	[EsActivo] [bit] NOT NULL,
	[Periodo] [varchar](20) NOT NULL,
	[NombreEmpresa] [varchar](1000) NOT NULL,
	[Telefono] [varchar](15) NULL,
	[FechaActivacion] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NULL,
	[AnioOperacion] [varchar](10) NULL,
	[CreadoPor] [varchar](500) NOT NULL,
	[CreadoEl] [datetime] NOT NULL,
	[ModificadoPor] [varchar](500) NOT NULL,
	[ModificadoEl] [datetime] NOT NULL,
 CONSTRAINT [PK_MtoCat_Empresas] PRIMARY KEY CLUSTERED 
(
	[EmpresaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_EmpresaSubGiros]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_EmpresaSubGiros](
	[SubGiroID] [int] IDENTITY(1,1) NOT NULL,
	[GiroID] [int] NOT NULL,
	[NombreSubGiro] [varchar](400) NOT NULL,
 CONSTRAINT [PK_MtoCat_EmpresaSubGiros] PRIMARY KEY CLUSTERED 
(
	[SubGiroID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_Estatus]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_Estatus](
	[EstatusID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[CreadoEl] [datetime] NOT NULL,
	[CreadoPor] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MtoCat_Estatus] PRIMARY KEY CLUSTERED 
(
	[EstatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_Membresias]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_Membresias](
	[MembresiaID] [int] IDENTITY(1,1) NOT NULL,
	[TipoMembresiaID] [int] NOT NULL,
	[EstatusID] [int] NOT NULL,
	[PrecioMes] [decimal](18, 2) NOT NULL,
	[PrecioAnual] [decimal](18, 2) NOT NULL,
	[NoUsuarios] [int] NOT NULL,
	[NoReportes] [int] NULL,
	[CreadoEl] [datetime] NOT NULL,
	[CreadoPor] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MtoCat_Membresias] PRIMARY KEY CLUSTERED 
(
	[MembresiaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_OtrosGirosEmpresa]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_OtrosGirosEmpresa](
	[OtrosID] [int] IDENTITY(1,1) NOT NULL,
	[EmpresaTransID] [int] NOT NULL,
	[NombreOtro] [varchar](500) NOT NULL,
 CONSTRAINT [PK_MtoCat_OtrosGirosEmpresa] PRIMARY KEY CLUSTERED 
(
	[OtrosID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_RegistroDiario]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_RegistroDiario](
	[RegistroID] [int] IDENTITY(1,1) NOT NULL,
	[EmpresaTransID] [int] NOT NULL,
	[ClasificacionID] [int] NOT NULL,
	[SubClasificacionID] [int] NULL,
	[CuentaID] [int] NOT NULL,
	[SubCuentaID] [int] NULL,
	[EstatusID] [int] NULL,
	[FolioInterno] [int] NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[Referencia] [nvarchar](100) NOT NULL,
	[FechaRegistro] [varchar](15) NOT NULL,
	[Observaciones] [varchar](400) NOT NULL,
	[Importe] [decimal](18, 2) NOT NULL,
	[CreadoEl] [datetime] NOT NULL,
	[CreadoPor] [varchar](50) NULL,
 CONSTRAINT [PK_MtoCat_RegistroDiario] PRIMARY KEY CLUSTERED 
(
	[RegistroID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_SaldosInicialesEmpresa]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_SaldosInicialesEmpresa](
	[SaldoInicialID] [int] IDENTITY(1,1) NOT NULL,
	[EmpresaTransID] [int] NOT NULL,
	[Efectivo] [decimal](18, 2) NOT NULL,
	[Bancos] [decimal](18, 2) NOT NULL,
	[DeudasCobrar] [decimal](18, 2) NOT NULL,
	[ActivoFijo] [decimal](18, 2) NOT NULL,
	[DeudasPagar] [decimal](18, 2) NOT NULL,
	[CapitalInicial] [decimal](18, 2) NOT NULL,
	[CapitalFinal] [decimal](18, 2) NULL,
	[CreadoPor] [varchar](50) NOT NULL,
	[CreadoEl] [datetime] NOT NULL,
	[ModificadoPor] [varchar](50) NOT NULL,
	[ModificadoEl] [datetime] NOT NULL,
 CONSTRAINT [PK_MtoCat_SaldosInicialesEmpresa] PRIMARY KEY CLUSTERED 
(
	[SaldoInicialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_TipoCuentas]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_TipoCuentas](
	[TipoCuentaID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_TipoMembresias]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_TipoMembresias](
	[TipoMembresiaID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](320) NULL,
	[EsSugerido] [bit] NULL,
	[CreadoEl] [datetime] NOT NULL,
	[CreadoPor] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MtoCat_TipoMembresias] PRIMARY KEY CLUSTERED 
(
	[TipoMembresiaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoCat_Usuarios]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoCat_Usuarios](
	[UsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[EmpresaTransID] [int] NOT NULL,
	[EsActivo] [bit] NOT NULL,
	[NombreUsuario] [varchar](500) NOT NULL,
	[CorreoUsuario] [varchar](500) NOT NULL,
	[Contrasena] [varchar](200) NOT NULL,
	[CreadoPor] [varchar](500) NOT NULL,
	[CreadoEl] [datetime] NOT NULL,
 CONSTRAINT [PK_MtoCat_Usuarios] PRIMARY KEY CLUSTERED 
(
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoTra_Cobranza]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoTra_Cobranza](
	[CxCID] [int] IDENTITY(1,1) NOT NULL,
	[EmpresaTransID] [int] NOT NULL,
	[RegistroID] [int] NOT NULL,
	[EsCobranzaInicial] [bit] NULL,
	[EsCxC] [bit] NULL,
	[Total] [decimal](18, 2) NOT NULL,
	[Abono] [decimal](18, 2) NOT NULL,
	[Saldo] [decimal](18, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoTra_EmpresaReportesMensual]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoTra_EmpresaReportesMensual](
	[EmpresaTransID] [int] NOT NULL,
	[NoReportesRestantes] [int] NOT NULL,
	[Mes] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoTra_MembresiaCaracteristicas]    Script Date: 25/07/2025 02:30:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoTra_MembresiaCaracteristicas](
	[MembresiaID] [int] NULL,
	[Caracteristica] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoTra_PagoMembresias]    Script Date: 25/07/2025 02:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoTra_PagoMembresias](
	[PagoID] [int] IDENTITY(1,1) NOT NULL,
	[TransactioID] [int] NOT NULL,
	[EmpresaID] [int] NOT NULL,
	[MembresiaID] [int] NOT NULL,
	[Pago] [decimal](18, 2) NOT NULL,
	[NoCuenta] [varchar](5) NOT NULL,
	[CreadoPor] [varchar](200) NOT NULL,
	[CreadoEl] [datetime] NOT NULL,
 CONSTRAINT [PK_MtoTra_PagoMembresias] PRIMARY KEY CLUSTERED 
(
	[PagoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoTra_Pagos]    Script Date: 25/07/2025 02:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoTra_Pagos](
	[PagoID] [int] IDENTITY(1,1) NOT NULL,
	[CxCID] [int] NOT NULL,
	[TipoCuentaPagoID] [int] NOT NULL,
	[RegistroID] [int] NULL,
	[Abono] [decimal](18, 2) NOT NULL,
	[Saldo] [decimal](18, 2) NOT NULL,
	[CreadoPor] [varchar](50) NOT NULL,
	[CreadoEl] [datetime] NOT NULL,
 CONSTRAINT [PK_MtoTra_Pagos] PRIMARY KEY CLUSTERED 
(
	[PagoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoTra_SubClasificaciones]    Script Date: 25/07/2025 02:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoTra_SubClasificaciones](
	[ConceptoID] [int] IDENTITY(1,1) NOT NULL,
	[EmpresaTransID] [int] NOT NULL,
	[ClasificacionID] [int] NOT NULL,
	[EsActivo] [bit] NULL,
	[Concepto] [varchar](300) NOT NULL,
 CONSTRAINT [PK_MtoCat_ConceptosRegistrosDiarios] PRIMARY KEY CLUSTERED 
(
	[ConceptoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MtoTra_UsuariosToken]    Script Date: 25/07/2025 02:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MtoTra_UsuariosToken](
	[TokenID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[Token] [nvarchar](max) NOT NULL,
	[CreadoEl] [datetime] NOT NULL,
 CONSTRAINT [PK_MtoTra_UsuariosToken] PRIMARY KEY CLUSTERED 
(
	[TokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[MtoCat_BalanceGeneralEmpresa] ([EmpresaTransID], [Efectivo], [Bancos], [DeudasCobrar], [ActivoFijo], [DeudasPagar], [CapitalInicial], [CreadoPor], [CreadoEl], [ModificadoPor], [ModificadoEl]) VALUES (1702307804, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Sistema', CAST(N'2023-05-17T12:39:11.050' AS DateTime), N'Sistema', CAST(N'2023-05-17T12:39:11.050' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Clasificaciones] ON 
GO
INSERT [dbo].[MtoCat_Clasificaciones] ([ClasificacionID], [Clasificacion], [EsIngreso]) VALUES (1, N'Ingreso', 1)
GO
INSERT [dbo].[MtoCat_Clasificaciones] ([ClasificacionID], [Clasificacion], [EsIngreso]) VALUES (2, N'Gasto', 0)
GO
INSERT [dbo].[MtoCat_Clasificaciones] ([ClasificacionID], [Clasificacion], [EsIngreso]) VALUES (3, N'Compra', 0)
GO
INSERT [dbo].[MtoCat_Clasificaciones] ([ClasificacionID], [Clasificacion], [EsIngreso]) VALUES (4, N'Pagos', 0)
GO
INSERT [dbo].[MtoCat_Clasificaciones] ([ClasificacionID], [Clasificacion], [EsIngreso]) VALUES (5, N'Prestamos', 1)
GO
INSERT [dbo].[MtoCat_Clasificaciones] ([ClasificacionID], [Clasificacion], [EsIngreso]) VALUES (6, N'Transferencia entre cuenta', 1)
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Clasificaciones] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Cuentas] ON 
GO
INSERT [dbo].[MtoCat_Cuentas] ([CuentaID], [EmpresaTransID], [TipoCuentaID], [EsActivo], [Descripcion], [EsCuentaEmpresa], [CreadoPor], [CreadoEl], [ModificadoPor], [ModifcadoEl]) VALUES (100, 1702307804, 1, 1, N'Efectivo', 0, N'Sistema', CAST(N'2023-05-17T12:39:11.050' AS DateTime), N'Sistema', CAST(N'2023-05-17T12:39:11.050' AS DateTime))
GO
INSERT [dbo].[MtoCat_Cuentas] ([CuentaID], [EmpresaTransID], [TipoCuentaID], [EsActivo], [Descripcion], [EsCuentaEmpresa], [CreadoPor], [CreadoEl], [ModificadoPor], [ModifcadoEl]) VALUES (101, 1702307804, 2, 1, N'Banco 1', 0, N'Sistema', CAST(N'2023-05-17T12:39:11.050' AS DateTime), N'Sistema', CAST(N'2023-05-17T12:39:11.050' AS DateTime))
GO
INSERT [dbo].[MtoCat_Cuentas] ([CuentaID], [EmpresaTransID], [TipoCuentaID], [EsActivo], [Descripcion], [EsCuentaEmpresa], [CreadoPor], [CreadoEl], [ModificadoPor], [ModifcadoEl]) VALUES (102, 1702307804, 3, 1, N'Deudas por cobrar', 0, N'Sistema', CAST(N'2023-05-17T12:39:11.050' AS DateTime), N'allan@maqallan.com', CAST(N'2023-05-18T11:01:15.667' AS DateTime))
GO
INSERT [dbo].[MtoCat_Cuentas] ([CuentaID], [EmpresaTransID], [TipoCuentaID], [EsActivo], [Descripcion], [EsCuentaEmpresa], [CreadoPor], [CreadoEl], [ModificadoPor], [ModifcadoEl]) VALUES (103, 1702307804, 4, 1, N'Deudas por pagar', 0, N'Sistema', CAST(N'2023-05-17T12:39:11.050' AS DateTime), N'allan@maqallan.com', CAST(N'2023-05-18T08:10:37.153' AS DateTime))
GO
INSERT [dbo].[MtoCat_Cuentas] ([CuentaID], [EmpresaTransID], [TipoCuentaID], [EsActivo], [Descripcion], [EsCuentaEmpresa], [CreadoPor], [CreadoEl], [ModificadoPor], [ModifcadoEl]) VALUES (104, 1702307804, 2, 1, N'ALTAGRACIA ', 1, N'allan@maqallan.com', CAST(N'2023-05-19T09:09:46.393' AS DateTime), N'allan@maqallan.com', CAST(N'2023-05-19T09:09:46.393' AS DateTime))
GO
INSERT [dbo].[MtoCat_Cuentas] ([CuentaID], [EmpresaTransID], [TipoCuentaID], [EsActivo], [Descripcion], [EsCuentaEmpresa], [CreadoPor], [CreadoEl], [ModificadoPor], [ModifcadoEl]) VALUES (105, 1702307804, 2, 1, N'CUENTA FISCAL ALLAN ', 1, N'allan@maqallan.com', CAST(N'2023-05-26T09:22:23.070' AS DateTime), N'allan@maqallan.com', CAST(N'2023-05-26T09:22:23.070' AS DateTime))
GO
INSERT [dbo].[MtoCat_Cuentas] ([CuentaID], [EmpresaTransID], [TipoCuentaID], [EsActivo], [Descripcion], [EsCuentaEmpresa], [CreadoPor], [CreadoEl], [ModificadoPor], [ModifcadoEl]) VALUES (106, 1702307804, 2, 1, N'TARJETA DAVID ', 1, N'allan@maqallan.com', CAST(N'2023-05-29T09:32:18.077' AS DateTime), N'allan@maqallan.com', CAST(N'2023-05-29T09:32:18.077' AS DateTime))
GO
INSERT [dbo].[MtoCat_Cuentas] ([CuentaID], [EmpresaTransID], [TipoCuentaID], [EsActivo], [Descripcion], [EsCuentaEmpresa], [CreadoPor], [CreadoEl], [ModificadoPor], [ModifcadoEl]) VALUES (1109, 1702307804, 2, 1, N'TARJETA MARIANA', 1, N'allan@maqallan.com', CAST(N'2023-06-13T08:35:58.463' AS DateTime), N'allan@maqallan.com', CAST(N'2023-06-13T08:35:58.463' AS DateTime))
GO
INSERT [dbo].[MtoCat_Cuentas] ([CuentaID], [EmpresaTransID], [TipoCuentaID], [EsActivo], [Descripcion], [EsCuentaEmpresa], [CreadoPor], [CreadoEl], [ModificadoPor], [ModifcadoEl]) VALUES (1132, 1702307804, 1, 1, N'DOLARES ', 1, N'allan@maqallan.com', CAST(N'2024-06-24T18:22:19.397' AS DateTime), N'allan@maqallan.com', CAST(N'2024-06-24T18:22:19.397' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Cuentas] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ON 
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (1, 9, N'Autobuses')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (2, 9, N'Camiones')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (3, 9, N'Mudanzas')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (4, 9, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (5, 10, N'Hotel')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (6, 10, N'Restaurante')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (7, 10, N'Centro Nocturno')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (8, 10, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (9, 11, N'Banco')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (10, 11, N'Financieras')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (11, 11, N'Inmobiliaria')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (12, 11, N'Hipotecaria')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (13, 11, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (14, 12, N'Agua y Drenaje')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (15, 12, N'Luz')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (16, 12, N'Gas')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (17, 12, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (18, 13, N'Asesoria')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (19, 13, N'Despacho Contables')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (20, 13, N'Despacho Júridicos')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (21, 13, N'Despacho Administrativo')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (22, 13, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (23, 14, N'Escuela')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (24, 14, N'Academia')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (25, 14, N'Instituto')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (26, 14, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (27, 15, N'Clinica')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (28, 15, N'Hospitales')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (29, 15, N'Puesto de socorro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (30, 15, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (31, 16, N'Periódico')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (32, 16, N'Tv')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (33, 16, N'Radio')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (34, 16, N'Telégrafo')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (35, 16, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (36, 1, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (37, 2, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (38, 3, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (39, 4, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (40, 5, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (41, 6, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (42, 7, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] ([ActividadID], [SubGiroID], [NombreActividad]) VALUES (43, 8, N'Otro')
GO
SET IDENTITY_INSERT [dbo].[MtoCat_EmpresaActividadesSubGiro] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_EmpresaGiros] ON 
GO
INSERT [dbo].[MtoCat_EmpresaGiros] ([GiroID], [NombreGiro]) VALUES (1, N'Industrial')
GO
INSERT [dbo].[MtoCat_EmpresaGiros] ([GiroID], [NombreGiro]) VALUES (2, N'Comercial')
GO
INSERT [dbo].[MtoCat_EmpresaGiros] ([GiroID], [NombreGiro]) VALUES (3, N'De servicios')
GO
INSERT [dbo].[MtoCat_EmpresaGiros] ([GiroID], [NombreGiro]) VALUES (4, N'Otros')
GO
SET IDENTITY_INSERT [dbo].[MtoCat_EmpresaGiros] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Empresas] ON 
GO
INSERT [dbo].[MtoCat_Empresas] ([EmpresaID], [EmpresaTransID], [MembresiaID], [GiroID], [SubGiroID], [ActividadGiroID], [OtraActividad], [CustomerConektaID], [EsActivo], [Periodo], [NombreEmpresa], [Telefono], [FechaActivacion], [FechaVencimiento], [AnioOperacion], [CreadoPor], [CreadoEl], [ModificadoPor], [ModificadoEl]) VALUES (19, 1702307804, 4, NULL, NULL, NULL, N'', N'', 1, N'Me', N'Maqallan Machinery & Tools ', N'3310213880', CAST(N'2023-05-17T12:39:11.050' AS DateTime), CAST(N'2025-04-28T13:34:38.173' AS DateTime), N'2023', N'allan@maqallan.com', CAST(N'2023-05-17T12:39:11.050' AS DateTime), N'allan@maqallan.com', CAST(N'2023-05-18T06:19:44.423' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Empresas] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_EmpresaSubGiros] ON 
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (1, 1, N'Extractiva')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (2, 1, N'Manufacturera')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (3, 1, N'Agropecuaria')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (4, 1, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (5, 2, N'Mayorista')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (6, 2, N'Minorista')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (7, 2, N'Comisionista')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (8, 2, N'Otro')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (9, 3, N'Transporte')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (10, 3, N'Turismo')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (11, 3, N'Instituciones Financieras')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (12, 3, N'Servicios Públicos Varios')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (13, 3, N'Servicios Profesionales')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (14, 3, N'Educación')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (15, 3, N'Salud')
GO
INSERT [dbo].[MtoCat_EmpresaSubGiros] ([SubGiroID], [GiroID], [NombreSubGiro]) VALUES (16, 3, N'Comunicación')
GO
SET IDENTITY_INSERT [dbo].[MtoCat_EmpresaSubGiros] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Estatus] ON 
GO
INSERT [dbo].[MtoCat_Estatus] ([EstatusID], [Descripcion], [CreadoEl], [CreadoPor]) VALUES (1, N'Activo', CAST(N'2021-03-04T08:13:18.750' AS DateTime), N'Sistemas')
GO
INSERT [dbo].[MtoCat_Estatus] ([EstatusID], [Descripcion], [CreadoEl], [CreadoPor]) VALUES (2, N'Inactivo', CAST(N'2021-03-04T08:13:24.967' AS DateTime), N'Sistemas')
GO
INSERT [dbo].[MtoCat_Estatus] ([EstatusID], [Descripcion], [CreadoEl], [CreadoPor]) VALUES (3, N'Eliminado', CAST(N'2021-07-19T00:00:00.000' AS DateTime), N'Sistemas')
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Estatus] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Membresias] ON 
GO
INSERT [dbo].[MtoCat_Membresias] ([MembresiaID], [TipoMembresiaID], [EstatusID], [PrecioMes], [PrecioAnual], [NoUsuarios], [NoReportes], [CreadoEl], [CreadoPor]) VALUES (1, 1, 1, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, CAST(N'2021-03-04T08:23:19.537' AS DateTime), N'Sistemas')
GO
INSERT [dbo].[MtoCat_Membresias] ([MembresiaID], [TipoMembresiaID], [EstatusID], [PrecioMes], [PrecioAnual], [NoUsuarios], [NoReportes], [CreadoEl], [CreadoPor]) VALUES (2, 2, 1, CAST(200.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), 1, 1, CAST(N'2021-03-04T08:23:37.880' AS DateTime), N'Sistemas')
GO
INSERT [dbo].[MtoCat_Membresias] ([MembresiaID], [TipoMembresiaID], [EstatusID], [PrecioMes], [PrecioAnual], [NoUsuarios], [NoReportes], [CreadoEl], [CreadoPor]) VALUES (3, 3, 1, CAST(250.00 AS Decimal(18, 2)), CAST(2500.00 AS Decimal(18, 2)), 2, 99, CAST(N'2021-03-04T08:24:02.493' AS DateTime), N'Sistemas')
GO
INSERT [dbo].[MtoCat_Membresias] ([MembresiaID], [TipoMembresiaID], [EstatusID], [PrecioMes], [PrecioAnual], [NoUsuarios], [NoReportes], [CreadoEl], [CreadoPor]) VALUES (4, 4, 1, CAST(300.00 AS Decimal(18, 2)), CAST(3000.00 AS Decimal(18, 2)), 3, 99, CAST(N'2021-03-04T08:24:26.600' AS DateTime), N'Sistemas')
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Membresias] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_RegistroDiario] ON 
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1034, 1702307804, 3, 152, 103, NULL, 3, 1, N'David Gonzalez ', N'D-001', N'31/12/2022', N'', CAST(600000.00 AS Decimal(18, 2)), CAST(N'2023-05-17T12:58:21.090' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1035, 1702307804, 3, 152, 103, NULL, 3, 2, N'Deudas pendientes por descripción ', N'', N'31/12/2022', N'', CAST(7761550.00 AS Decimal(18, 2)), CAST(N'2023-05-17T12:59:43.793' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1036, 1702307804, 1, 153, 102, NULL, 3, 3, N'Venta de Perfiladora Cnc Bridgeport ', N'12345', N'17/05/2023', N'Maquina con pendiente te de pago', CAST(115000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T09:03:50.310' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1037, 1702307804, 4, 154, 102, NULL, 3, 4, N'ANTICIPO DE PERFILADORA ', N'129', N'17/05/2023', N'', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T09:22:46.090' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1038, 1702307804, 3, 155, 103, NULL, 3, 5, N'PINTURA ', N'P-AZUL ', N'17/05/2023', N'PINTURA PAGADA CON TARJETA DE CRÉDITO DE ALTAGRACIA ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T09:31:08.043' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1039, 1702307804, 3, 152, 103, NULL, 3, 6, N'SERRANO', N'PP-02', N'31/12/2022', N'PRÉSTAMO PARA COMPRA DE MAQUINARIA', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:16:04.577' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1040, 1702307804, 3, 152, 103, NULL, 3, 7, N'CAYETANO', N'PP-003', N'31/12/2022', N'PRESTAMO PARA COMPRA DE MAQUINARIA INDUSTRIAL', CAST(600000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:16:54.980' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1041, 1702307804, 5, 1217, 103, NULL, 3, 8, N'SERRANO ', N'D-002', N'01/01/2023', N'PRÉSTAMO PARA COMPRA DE MÁQUINARIA INDUSTRIAL', CAST(350000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T10:36:29.263' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1042, 1702307804, 3, 152, 103, NULL, 3, 9, N'CAYETANO', N'D-003', N'31/12/2022', N'PRESTAMO PARA COMPRA DE MAQUINARIA INDUSTRIAL', CAST(700000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:19:19.703' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1043, 1702307804, 5, 1218, 103, NULL, 3, 10, N'DOÑA BERTHA', N'D-004', N'01/01/2023', N'PRÉSTAMO PARA COMPRA DE MAQUINARIA ', CAST(160000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T10:37:16.987' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1044, 1702307804, 3, 152, 103, NULL, 3, 11, N'OSVALDO BARBA', N'D-005', N'31/12/2022', N'PRESTAMO PARA COMPRA DE MAQUINARIA ', CAST(175000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:22:19.380' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1045, 1702307804, 3, 152, 103, NULL, 3, 12, N'SUSANA', N'D-006', N'31/12/2022', N'PRÉSTAMO PARA COMPRA DE MAQUINARIA INDUSTRIAL ', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:34:03.733' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1046, 1702307804, 3, 152, 103, NULL, 3, 13, N'ALFREDO ÁVILA ', N'D-007', N'31/12/2022', N'PRÉSTAMO PARA COMPRA DE MAQUINARIA INDUSTRIAL', CAST(750000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:34:58.310' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1047, 1702307804, 3, 152, 103, NULL, 3, 14, N'JORGE CABRERA ', N'D-008', N'31/12/2022', N'PRÉSTAMO PARA COMPRA DE MAQUINARIA INDUSTRIAL ', CAST(1500000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:35:46.970' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1048, 1702307804, 3, 152, 103, NULL, 3, 15, N'ANTONIO TOBY', N'D-009', N'31/12/2022', N'PRÉSTAMO PARA COMPRA DE MAQUINARIA INDUSTRIAL ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:36:57.333' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1049, 1702307804, 3, 152, 103, NULL, 3, 16, N'CUCO', N'D-010', N'31/12/2022', N'PRÉSTAMO ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:37:36.403' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1050, 1702307804, 3, 152, 103, NULL, 3, 17, N'TOBY', N'D-011', N'31/12/2022', N'PRESTAMO PARA COMPRA DE MAQUINARIA INDUSTRIAL ', CAST(760000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:39:05.870' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1051, 1702307804, 3, 152, 103, NULL, 1, 18, N'TARJETA BANCOMER', N'D-012', N'01/01/2023', N'', CAST(120000.00 AS Decimal(18, 2)), CAST(N'2024-02-09T09:35:52.393' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1052, 1702307804, 3, 152, 103, NULL, 3, 19, N'ASPIRIA', N'85000', N'31/12/2022', N'FINANCIAMIENTO', CAST(83000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:43:31.917' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1053, 1702307804, 3, 152, 103, NULL, 3, 20, N'ALTAGRACIA ', N'D-013', N'31/12/2022', N'', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2024-02-08T16:40:59.390' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1054, 1702307804, 3, 152, 103, NULL, 3, 21, N'ALTAGRACIA 2', N'D-014', N'31/12/2022', N'', CAST(220000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:44:56.503' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1055, 1702307804, 5, 1211, 103, NULL, 3, 22, N'LUIS CASILLAS', N'D-015', N'01/01/2023', N'', CAST(84000.00 AS Decimal(18, 2)), CAST(N'2024-02-09T10:15:09.240' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1056, 1702307804, 5, 2291, 103, NULL, 3, 23, N'PRESTAMO BBVA 1', N'D-015', N'01/01/2023', N'', CAST(122000.00 AS Decimal(18, 2)), CAST(N'2024-02-15T11:37:01.343' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1057, 1702307804, 3, 152, 103, NULL, 3, 24, N'CUPRA ', N'D-016', N'31/12/2022', N'', CAST(300000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:51:11.380' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1058, 1702307804, 3, 152, 103, NULL, 3, 25, N'BMW', N'D-017', N'31/12/2022', N'', CAST(350000.00 AS Decimal(18, 2)), CAST(N'2023-05-18T08:52:58.610' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1059, 1702307804, 5, 2291, 103, NULL, 1, 26, N'PRESTAMO BBVA 2', N'D-018', N'01/01/2023', N'', CAST(78000.00 AS Decimal(18, 2)), CAST(N'2024-02-15T11:36:45.953' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1060, 1702307804, 5, 2291, 103, NULL, 1, 27, N'PRESTAMO BBVA 3 ', N'D-019', N'01/01/2023', N'', CAST(78000.00 AS Decimal(18, 2)), CAST(N'2024-02-15T13:20:25.033' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1061, 1702307804, 3, 152, 103, NULL, 3, 28, N'NELSON ', N'D-020', N'31/12/2022', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2024-02-09T10:23:48.703' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1062, 1702307804, 3, 152, 103, NULL, 3, 29, N'PENDIENTE DEFINIR', N'D', N'31/12/2022', N'', CAST(157551.00 AS Decimal(18, 2)), CAST(N'2023-05-18T09:45:20.550' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1063, 1702307804, 2, 152, 103, NULL, 3, 30, N'TOTAL DE INTERESES', N'INTERES-001', N'31/12/2022', N'', CAST(271750.00 AS Decimal(18, 2)), CAST(N'2023-05-18T10:33:30.440' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1064, 1702307804, 1, 156, 100, NULL, 3, 31, N'VENTA DE FRESADORA ', N'V-0001', N'19/05/2023', N'SE PAGÓ $20,000 EN EFECTIVO Y $5,000 EN TRANSFERENCIA ', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-05-26T07:23:54.420' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1065, 1702307804, 4, 157, 103, NULL, 3, 32, N'PAGO A BMW', N'PD-001', N'18/05/2023', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T10:46:10.607' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1066, 1702307804, 3, 152, 100, NULL, 3, 33, N'REFACCIONES PARA RECTIFICADORA ', N'RF-001', N'19/05/2023', N'CABLES Y GLEMAS PARA RECTIFICADORA VERDE, DINERO ENTREGADO A BENITO REAL.', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:07:27.453' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1067, 1702307804, 2, 176, 100, NULL, 1, 34, N'PAQUETERÍA TARJETAS', N'RF-002', N'19/05/2023', N'EFECTIVO PARA MARIO PEREZ, ENVÍO A MEXICO DE REPARACIÓN DE TARJETAS.  ', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T11:21:54.137' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1068, 1702307804, 2, 160, 100, NULL, 1, 35, N'PAGO SAT ', N'P-002', N'19/05/2023', N'PAGO DE IMPUESTOS FEDERALES', CAST(68.00 AS Decimal(18, 2)), CAST(N'2023-05-19T08:57:28.100' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1069, 1702307804, 3, 152, 100, NULL, 3, 36, N'Llave para Vf-6', N'G-003', N'19/05/2023', N'RICARDO COMPRÓ UNA LLAVE PARA QUITAR MESA DE VF-6 RECIEN LLEGADA ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:07:33.650' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1070, 1702307804, 1, 156, 104, NULL, 3, 37, N'VENTA DE FRESADORA ', N'V-0001', N'19/05/2023', N'DIFERENCIA DE FRESADORA PAGADA EN TRANSFERENCIA A CUENTA DE ALTAGRACIA ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-26T10:43:16.400' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1071, 1702307804, 2, 161, 104, NULL, 1, 38, N'GASTO PERSONAL ALLAN ', N'', N'19/05/2023', N'DINERO PARA MAMÁ DE ALLAN ', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T09:45:56.830' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1072, 1702307804, 2, 161, 103, NULL, 3, 39, N'PRÉSTAMO PERSONAL MARCO MONTES ', N'', N'31/12/2022', N'PRÉSTAMOS DE MONTES', CAST(323546.00 AS Decimal(18, 2)), CAST(N'2023-05-19T10:01:27.873' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1073, 1702307804, 2, 1221, 103, NULL, 1, 40, N'FLETE De Montes ', N'', N'19/05/2023', N'SE PAGO A TRAVESD DEL PRESTAMO DE MONTES ', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:08:14.670' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1074, 1702307804, 3, 162, 103, NULL, 3, 41, N'PRESTAMO NUEVO MONTES PARA FLETE ', N'FL-001 ', N'19/05/2023', N'', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T10:15:20.790' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1075, 1702307804, 4, 163, 103, NULL, 1, 42, N'PAGO DE PRÉSTAMO ALTAGRACIA', N'', N'19/05/2023', N'', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T10:19:09.817' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1076, 1702307804, 2, 161, 100, NULL, 3, 43, N'PAGO PRÉSTAMO PAPÁ DE ALLAN ', N'', N'19/05/2023', N'', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T13:51:36.763' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1077, 1702307804, 1, 164, 101, NULL, 1, 44, N'VENTA DE VENTILADOR INDUSTRIAL Y COMPRESOR DE TORNILLO ', N'NS-005-83004806', N'02/01/2023', N'VENTA DE VENTILADOR INDUSTRIAL Y COMPRESOR DE TORNILLO, AL CLIENTE INDUSTRIA MUELLERA VAZQUEZ', CAST(92800.00 AS Decimal(18, 2)), CAST(N'2023-05-19T12:55:44.477' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1078, 1702307804, 1, 153, 100, NULL, 1, 45, N'VENTA DE PERFILADORA HART-FORD, AMERICANA', N'NS-801351', N'05/01/2023', N'VENTA DE UNA PERFILADORA AL CLIENTE TEODORO ALEJANDRO CASADOS FLORES', CAST(65000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T13:25:44.347' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1079, 1702307804, 1, 165, 100, NULL, 1, 46, N'VENTA DE CENTRO DE MAQUINADO HAAS', N'NS-VF-4', N'20/01/2023', N'VENTA DE CENTRO DE MAQUINADO HAAS AL CLIENTE JOSE REYES SE DIO UN ADELANTO DE 10,000.00', CAST(450000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T13:28:32.880' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1080, 1702307804, 1, 166, 100, NULL, 1, 47, N'VENTA DE TORNO CNC FEMCO', N'NS-L5E214', N'20/01/2023', N'VENTA DE TORNO CNC FEMCO AL CLIENTE EDGAR IVÁN TORNERO DÍAZ ', CAST(265000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T13:30:38.043' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1081, 1702307804, 2, 176, 100, NULL, 1, 48, N'CUBETA PARA ACEITE', N'', N'15/05/2023', N'CUBETA DE ACEITE PARA RECTIFICADORA VERDE', CAST(1250.00 AS Decimal(18, 2)), CAST(N'2023-09-22T11:41:04.080' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1082, 1702307804, 1, 166, 100, NULL, 1, 49, N'VENTA DE TORNO CNC MORI SEIKI MODELO SL-3', N'NS-4142', N'27/01/2023', N'VENTA DE TORNO CNC MORI SEIKI MODELO SL-3 AL CLIENTE DSM INGENIERÍA ', CAST(225000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T13:44:33.833' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1083, 1702307804, 3, 167, 100, NULL, 3, 50, N'REFACCIONES RECTIFICADORA VERDE', N'', N'19/05/2023', N'BARRILES Y CONTRATUERCA PARA RECTIFICADORA ALEMANA (VERDE)', CAST(600.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:08:54.233' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1084, 1702307804, 2, 161, 100, NULL, 1, 51, N'PAGO A PAPÁ DE ALLAN', N'', N'19/05/2023', N'DINERO QUE AGARRÓ ALLAN PARA PAGAR PRESTAMO A SU PAPÁ ', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-05-19T13:47:34.693' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1085, 1702307804, 1, 165, 100, NULL, 3, 52, N'PAGO DE CENTRO DE MAQUINADO VF-4', N'NO. SERIE 7943', N'06/05/2023', N'SEGUNDO PAGO DEL CENTRO DE MAQUINADO EL DÍA SÁBADO ', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2023-05-25T13:38:27.153' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1086, 1702307804, 2, 168, 100, NULL, 1, 53, N'PRÉSTAMO Y NÓMINA ', N'', N'20/05/2023', N'PRESTAMO DE ALLAN A RICARDO CRUZ ', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-05-22T09:47:13.230' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1087, 1702307804, 3, 152, 100, NULL, 3, 54, N'PAGO DE PERFILADORA SHIZUOKA', N'', N'20/05/2023', N'PAGO DE LA PERFILADORA SHIZUOKA', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:09:31.757' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1088, 1702307804, 2, 176, 100, NULL, 1, 55, N'REPARACIONES BENITO', N'', N'20/05/2023', N'FINIQUITO DE REPARACIÓN DE FRESADORA SHIZUOKA, TORNO CHUY Y TORNO TOBY', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:10:14.710' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1089, 1702307804, 3, 152, 100, NULL, 3, 56, N'PAGO A MARIO PEREZ', N'', N'20/05/2023', N'PAGO PARA DON MARIO DEL VF4 DE BRAZO ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:10:32.953' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1090, 1702307804, 2, 176, 100, NULL, 1, 57, N'REPARACIONES BENITO', N'', N'22/05/2023', N'$12,000 PARA TORNO TOBY 
$3,000 RECTIFICADORA VERDE ', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:11:48.177' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1091, 1702307804, 1, 165, 102, NULL, 3, 58, N'VENTA CENTRO DE MAQUINADO VF4 ', N'NO. SERIE 7943', N'25/05/2023', N'SE VENDIÓ CENTRO DE MAQUINADO EN $460,000.00 EN FORMA DE PAGOS, EL PRIMERO ES EL DÍA 06 DE MAYO DE $160,000.00 ', CAST(160000.00 AS Decimal(18, 2)), CAST(N'2023-05-25T12:58:28.490' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1092, 1702307804, 1, 165, 102, NULL, 3, 59, N'VENTA DE CENTRO DE MAQUINADO SUPER VF-3', N'NO. SERIE 44083', N'07/02/2023', N'VENTA DE CENTRO DE MAQUINADO SUPER VF3 POR $900,000.00', CAST(900000.00 AS Decimal(18, 2)), CAST(N'2023-05-23T11:00:00.080' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1093, 1702307804, 1, 165, 102, NULL, 3, 60, N'PAGO SUPER VF3', N'NO. SERIE 44083', N'08/02/2023', N'PRIMER PAGO DE SUPER VF3 ', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2023-05-22T13:52:28.323' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1094, 1702307804, 4, 157, 103, NULL, 3, 61, N'PAGO A INTERESES HERMANO BETO', N'', N'22/05/2023', N'PAGO DE LOS INTERESES DEL HERMANO DE BETO ', CAST(6500.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:19:13.053' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1095, 1702307804, 2, 168, 100, NULL, 1, 62, N'PRESTAMO PARA RAÚL ', N'', N'22/05/2023', N'PRESTAMO QUE LE HIZO ALLAN A RAÚL EL PINTOR ', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-05-23T08:19:19.573' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1096, 1702307804, 2, 161, 100, NULL, 1, 63, N'COMIDA ALLAN ', N'', N'22/05/2023', N'ALLAN AGARRÓ DINERO PARA IR A COMER ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-05-23T08:20:06.860' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1097, 1702307804, 2, 176, 100, NULL, 1, 64, N'POLINES ', N'', N'22/05/2023', N'DINERO QUE SE LE DIÓ A RICARDO PARA COMPRAR POLINES ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T11:58:34.587' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1098, 1702307804, 3, 167, 100, NULL, 3, 65, N'MOTOR PARA TORNO', N'', N'22/05/2023', N'COMPRA DE MOTOR PARA TORNO CONVENCIONAL DMTG 40" X 120" ', CAST(3700.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:12:06.647' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1099, 1702307804, 2, 161, 100, NULL, 1, 66, N'ESCUELA DE CHRISTOPHER', N'', N'23/05/2023', N'DINERO QUE TOMÓ ALLAN PARA PAGAR LA COLEGIATURA DE SU HIJO ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-05-23T10:13:12.477' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1100, 1702307804, 1, 166, 100, NULL, 1, 67, N'VENTA DE TORNO CNC FEMCO ', N'NO. SERIE L5E214', N'01/02/2023', N'VENTA DE TORNO CNC FEMCO DURGA 15E ', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T09:05:05.727' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1101, 1702307804, 1, 166, 100, NULL, 1, 68, N'VENTA DE TORNO LOGAN ', N'NO. SERIE MN07TL', N'07/02/2023', N'VENTA DE UN TORNO LOGAN ', CAST(32000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T09:52:29.600' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1102, 1702307804, 1, 165, 100, NULL, 1, 69, N'VENTA DE MINI VF2 ', N'NO. SERIE 5214', N'12/02/2023', N'VENTA EN CENTRO DE MAQUINADO MINI VF2 ', CAST(250000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T09:53:01.350' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1103, 1702307804, 1, 165, 100, NULL, 1, 70, N'VENTA DE CENTRO DE MAQUINADO TAKUMI', N'NO. SERIE V180223', N'18/02/2023', N'VENTA DE TAKUMI ', CAST(700000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T09:53:14.870' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1104, 1702307804, 1, 166, 100, NULL, 1, 71, N'VENTA DE TORNO CONVENCIONAL CLARK ', N'NO. SERIE TC2402', N'24/02/2023', N'SE VENDIÓ EL TORNO CONVENCIONAL CLARK ', CAST(160000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T09:53:33.017' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1105, 1702307804, 1, 165, 100, NULL, 1, 72, N'VENTA DE CENTRO DE MAQUINADO VF1', N'NO. SERIE 43256', N'23/02/2023', N'VENTA DE CENTRO DE MAQUINADO, SE DIÓ LA DIFERENCIA EN EFECTIVO $100,000.00 YA QUE SE NOS ENTREGÓ UN TORNO CNC HL-4 ', CAST(375000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T09:53:48.780' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1106, 1702307804, 1, 165, 100, NULL, 1, 73, N'VENTA DE CENTRO DE MAQUINADO VF3 ', N'NO. SERIE 3393', N'28/02/2023', N'VENTA DE CENTRO DE MAQUINADO HAAS VF3 ', CAST(415000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T09:56:04.050' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1107, 1702307804, 1, 166, 100, NULL, 1, 74, N'VENTA DE TORNO CNC ST-30', N'S/N ', N'28/02/2023', N'VENTA DE TORNO CNC ST-3O HAAS', CAST(650000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T09:57:43.073' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1108, 1702307804, 1, 172, 100, NULL, 1, 75, N'VENTA DE SIERRA-CINTA HYD-MECH', N'S/N', N'28/02/2023', N'VENTA DE SIERRA-CINTA HYD-MECH ', CAST(175000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T10:02:10.967' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1109, 1702307804, 1, 165, 100, NULL, 1, 76, N'VENTA DE CENTRO DE MAQUINADO VF4 ', N'NO. SERIE 6345', N'02/03/2023', N'VENTA DE CENTRO DE MAQUINADO VF4 HAAS', CAST(450000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T10:09:43.047' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1110, 1702307804, 1, 166, 100, NULL, 1, 77, N'VENTA DE TORNO CONVENCIONAL CLOUSING COLCHESTER', N'S/N', N'02/03/2023', N'VENTA DE TORNO COLCHESTER ', CAST(180000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T10:56:27.803' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1111, 1702307804, 1, 153, 100, NULL, 1, 78, N'VENTA DE PERFILADORA GORTON ', N'NO. SERIE 41536', N'02/03/2023', N'VENTA DE PERFILADORA GORTON ', CAST(39000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T10:57:51.043' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1112, 1702307804, 1, 173, 100, NULL, 3, 79, N'VENTA DE CEPILLO DE CODO ', N'NO. SERIE 20440', N'10/03/2023', N'VENTA DE CEPILLO DE CODO AMERICANO 24" ', CAST(75000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T11:09:19.160' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1113, 1702307804, 1, 173, 100, NULL, 1, 80, N'VENTA DE CEPILLO DE CODO AMERICANO', N'NO. SERIE 20440', N'10/04/2023', N'VENTA DE CEPILLO DE CODO AMERICANO DE 24"', CAST(75000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T11:09:07.127' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1114, 1702307804, 1, 166, 100, NULL, 1, 81, N'VENTA DE TORNO CNC FEMCO ', N'NO. SERIE L5E080', N'13/04/2023', N'VENTA DE TORNO CNC FEMCO DURGA-25E', CAST(240000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T11:10:25.710' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1115, 1702307804, 1, 166, 100, NULL, 1, 82, N'VENTA DE TORNO CONVENCIONAL 14 X 40', N'S/N', N'28/04/2023', N'VENTA DE TORNO CONVENCIONAL, SE DIÓ UN ANTICIPO DE $2,000', CAST(80000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T11:13:37.113' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1116, 1702307804, 1, 153, 102, NULL, 3, 83, N'VENTA DE PERFILADORA TITANIUM ', N'NO. SERIE 214MR1A', N'28/04/2023', N'SE VENDIÓ PERFILADORA EN $140,000.00 SE DIÓ UN ANTICIPO DE $100,000.00', CAST(140000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:43:22.120' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1117, 1702307804, 1, 165, 102, NULL, 1, 84, N'VENTA DE CENTRO DE MAQUINADO SUPER VF3 ', N'NS-44083', N'07/02/2023', N'VENTA DE CENTRO DE MAQUINADO SUPER VF3 AL CLIENTE GILBERTO LARA ANGELES, SE DIO UN ANTICIPO DE 500,000.00', CAST(900000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T11:58:10.713' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1118, 1702307804, 4, 154, 102, NULL, 1, 85, N'ANTICIPO DE CENTRO DE MAQUINADO SUPER VF3', N'EFE', N'07/02/2023', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T11:59:32.823' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1119, 1702307804, 4, 154, 102, NULL, 1, 86, N'ABONO DE CENTRO DE MAQUINADO SUPER VF3', N'EFE', N'22/03/2023', N'', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T12:01:35.730' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1120, 1702307804, 4, 154, 102, NULL, 1, 87, N'ABONO CENTRO DE MAQUINADO SUPER VF3', N'EFE', N'13/04/2023', N'', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T12:03:30.397' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1121, 1702307804, 3, 155, 103, NULL, 3, 88, N'PINTURA ', N'TC-BBVA ', N'24/05/2023', N'COMPRA DE PINTURA PARA TORNO TOBI', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T14:02:23.077' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1122, 1702307804, 2, 161, 101, NULL, 3, 89, N'PAGO DE TARJETA BBVA', N'', N'24/05/2023', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T14:02:21.123' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1123, 1702307804, 4, 163, 103, NULL, 3, 90, N'PAGO DE COMPRAS CON TARJETA DE BBVA', N'BBVA', N'24/05/2023', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-05-24T14:02:18.690' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1124, 1702307804, 3, 167, 100, NULL, 3, 91, N'COMPRA DE POLEA PARA TORNO DMTG', N'C-0001', N'23/05/2023', N'SE COMPRÓ UNA POLEA PARA EL TORNO DMTG QUE SE VENDIÓ ', CAST(900.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:12:24.100' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1125, 1702307804, 2, 161, 100, NULL, 3, 92, N'PAGO DE PRESTAMO PERSONAL ', N'PP-0001', N'23/05/2023', N'ALLAN LE PIDIÓ $8,500 PESOS A DAVID GONZALEZ ', CAST(8500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:29:09.413' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1126, 1702307804, 2, 174, 100, NULL, 1, 93, N'DEVOLUCIÓN DE DINERO ', N'', N'23/05/2023', N'SE DEVOLVIÓ EL ANTICIPO DEL MONTACARGAS', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-05-25T07:13:10.703' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1127, 1702307804, 3, 155, 100, NULL, 3, 94, N'PINTURA PARA VF6 Y TORNO', N'', N'24/05/2023', N'SE COMPRÓ PINTURA PARA EL CENTRO DE MAQUINADO VF6 Y TORNO CNC NUEVO AZUL NUEVOS ', CAST(5500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:12:33.287' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1128, 1702307804, 2, 161, 100, NULL, 1, 95, N'COMPRA DE BANDA PARA TORNO', N'', N'24/05/2023', N'LE DIMOS DINERO A BENITO PARA COMPRAR BANDAS PARA TORNO', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:13:21.787' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1129, 1702307804, 2, 176, 100, NULL, 1, 96, N'DINERO PARA LOS DE LA BASURA', N'', N'24/05/2023', N'PAGO QUE SE LE DA A LAS PERSONAS ENCARGADAS DE RECOGER LA BASURA DE LA BODEGA', CAST(300.00 AS Decimal(18, 2)), CAST(N'2023-05-25T10:33:50.960' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1130, 1702307804, 3, 167, 100, NULL, 3, 97, N'COMPRA DE TORNILLOS ', N'', N'24/05/2023', N'SE COMPRARON TORNILLOS PARA EL CENTRO DE MAQUINADO VF6 ', CAST(100.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:18:27.637' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1131, 1702307804, 2, 176, 100, NULL, 1, 98, N'COMPRA DE CEMENTO Y ARENA', N'', N'22/05/2023', N'SE COMPRÓ MATERIAL PARA EL ALBAÑIL QUE ESTÁ EMBOQUILLANDO LA VENTANA DEL SEGUNDO PISO', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:32:33.090' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1132, 1702307804, 3, 167, 100, NULL, 3, 99, N'COMPRA DE REFACCIONES PARA RECT', N'', N'24/05/2023', N'COMPRA DE DOS BOTONES, POTENCIOMETRO Y CABLE PARA RECTIFICADORA KENT', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:18:33.850' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1133, 1702307804, 2, 176, 100, NULL, 1, 100, N'LIMPIEZA BODEGA', N'', N'25/05/2023', N'SE COMPRÓ JABÓN, PINOL Y PAPEL DE BAÑO PARA BODEGA', CAST(100.00 AS Decimal(18, 2)), CAST(N'2023-05-25T10:35:42.493' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1134, 1702307804, 2, 161, 100, NULL, 1, 101, N'PAGO DE TELEFONO DE ALLAN ', N'', N'25/05/2023', N'SE PAGÓ LA LINEA DE TELEFONO DE ALLAN GALVAN ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-05-25T10:36:55.700' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1135, 1702307804, 2, 161, 100, NULL, 1, 102, N'GASTO PERSONAL DE ALLAN', N'', N'25/05/2023', N'GASTO PERSONAL DE ALLAN ', CAST(50.00 AS Decimal(18, 2)), CAST(N'2023-05-25T10:37:25.167' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1136, 1702307804, 2, 1220, 100, NULL, 1, 103, N'PAGO DE TELMEX', N'', N'25/05/2023', N'SE PAGÓ LA MENSUALIDAD DE TELMEX', CAST(700.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:38:44.303' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1137, 1702307804, 3, 167, 100, NULL, 3, 104, N'COMPRA DE CALCAS PARA VF6', N'', N'25/05/2023', N'SE COMPRARON CALCAS PARA EL NUEVO CENTRO DE MAQUINADO VF6', CAST(550.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:18:55.497' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1138, 1702307804, 4, 154, 103, NULL, 3, 105, N'PAGO A SERRANO DE INTERESES', N'', N'25/05/2023', N'EL PAGO DE INTERESES DE SERRANO', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:23:03.303' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1139, 1702307804, 3, 152, 103, NULL, 3, 106, N'2DO SERRANO', N'', N'31/12/2022', N'SEGUNDO PRESTAMO PARA ALLAN GALVÁN', CAST(250000.00 AS Decimal(18, 2)), CAST(N'2023-09-14T08:06:46.163' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1140, 1702307804, 1, 165, 102, NULL, 1, 107, N'VENTA DE CENTRO DE MAQUINADO VF4', N'NO. SERIE 7943', N'06/05/2023', N'MAQUINA VENDIDA Y DIVIDIDA EN PAGOS ', CAST(460000.00 AS Decimal(18, 2)), CAST(N'2023-05-25T13:15:33.627' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1141, 1702307804, 1, 165, 100, NULL, 3, 108, N'PRIMER PAGO DE VF4', N'NO. SERIE 7943 ', N'06/05/2023', N'PRIMER PAGO DE VF4', CAST(160000.00 AS Decimal(18, 2)), CAST(N'2023-05-25T13:38:24.367' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1142, 1702307804, 4, 154, 102, NULL, 1, 109, N'PRIMER PAGO DE VF4', N'NO. SERIE 7943', N'06/05/2023', N'PRIMER PAGO DE VF4', CAST(160000.00 AS Decimal(18, 2)), CAST(N'2023-05-25T13:43:14.580' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1143, 1702307804, 1, 156, 102, NULL, 1, 110, N'VENTA DE FRESADORA CHINERIK ', N'NO. SERIE X8130', N'18/05/2023', N'VENTA DE FRESADORA CHINERIK EN 2 PAGOS, VENDIDA SIN CABEZAL ', CAST(45000.00 AS Decimal(18, 2)), CAST(N'2023-05-26T07:27:05.780' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1144, 1702307804, 4, 154, 102, NULL, 1, 111, N'PRIMER PAGO DE FRESADORA CHINERIK', N'NO. SERIE X813O', N'18/05/2023', N'PRIMER PAGO DE FRESADORA CHINERIK, 20,000 EN EFECTIVO Y 5 EN CUENTA DE ALTAGRACIA', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-05-26T07:28:40.627' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1145, 1702307804, 4, 154, 102, NULL, 1, 112, N'SEGUNDO PAGO DE VF4', N'NO. SERIE 7943 ', N'20/05/2023', N'SEGUNDO PAGO DE VF4', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2023-05-26T07:30:12.047' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1146, 1702307804, 1, 156, 100, NULL, 1, 113, N'VENTA DE FRESADORAS A BENITO REAL', N'', N'05/05/2023', N'FRESADORA  BRIDGEPORT NO. SERIE J147982
FRESADORA FAMCO NO. SERIE J240444.
FRESADORA BRIDGEPORT NO. SERIE J241286
FRESADORA TREE NO. SERIE 2491940', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T10:44:49.810' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1147, 1702307804, 1, 166, 102, NULL, 1, 114, N'VENTA DE TORNO ROMI', N'NO. SERIE 287664', N'24/05/2023', N'VENTA DE DAVID, DE TORNO ROMI ', CAST(255000.00 AS Decimal(18, 2)), CAST(N'2023-05-26T07:57:26.007' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1148, 1702307804, 4, 154, 102, NULL, 1, 115, N'ABONO DE TORNO ROMI', N'NO. SERIE 287664', N'24/05/2023', N'PRIMER PAGO DEL TORNO ROMI ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-05-26T07:58:27.260' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1149, 1702307804, 1, 178, 105, NULL, 1, 116, N'VENTA DE RECTIFICADORA KENT ', N'NO. SERIE 840504-2', N'19/05/2023', N'PAGO DE RECTIFICADORA KENT $130,000.00 MÁS IVA ', CAST(150800.00 AS Decimal(18, 2)), CAST(N'2023-05-26T09:23:32.933' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1150, 1702307804, 1, 166, 105, NULL, 1, 117, N'VENTA DE TORNO DMTG ', N'NO. SERIE K07095', N'22/05/2023', N'VENDIDA POR LA CANTIDAD DE $550,000.00 MÁS IVA ', CAST(638000.00 AS Decimal(18, 2)), CAST(N'2023-05-26T09:25:19.050' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1151, 1702307804, 1, 153, 105, NULL, 1, 118, N'VENTA DE PERFILADORA SHIZUOKA', N'NO. SERIE 8196', N'22/05/2023', N'VENTA DE PERFILADORA POR $115,000.00 MÁS IVA', CAST(133400.00 AS Decimal(18, 2)), CAST(N'2023-05-26T09:31:26.077' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1152, 1702307804, 1, 166, 102, NULL, 1, 119, N'VENTA DE TORNO TB-32120C', N'S/N', N'22/05/2023', N'SE DIÓ UN ADELANTO DE $415,000.00 MÁS IVA', CAST(481400.00 AS Decimal(18, 2)), CAST(N'2023-05-26T09:44:31.087' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1153, 1702307804, 4, 179, 102, NULL, 1, 120, N'ANTICIPO DE TORNO TB-32120-C', N'S/N', N'22/05/2023', N'SE DIÓ UN ANTICIPO Y SE REALIZÓ FACTIRA DE ESE ANTICIPO ', CAST(5800.00 AS Decimal(18, 2)), CAST(N'2023-05-26T09:46:33.017' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1154, 1702307804, 4, 154, 102, NULL, 1, 121, N'SEGUNDO PAGO TORNO ROMI ', N'NO. SERIE 287664', N'26/05/2023', N'SEGUNDO PAGO DE TORNO ROMI ', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2023-05-26T13:04:04.253' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1155, 1702307804, 4, 180, 102, NULL, 1, 122, N'TERCER PAGO DE SUPER VF3', N'', N'29/05/2023', N'TERCER PAGO DE SUPER VF3 A CUENTA DE DAVID (TRANSFERENCIA)', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-05-29T09:33:22.190' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1156, 1702307804, 2, 159, 106, NULL, 1, 123, N'PAGO DE TARJETA LAMINA ', N'', N'29/05/2023', N'PAGO DE TARJETA LAMINA DE ALLAN GALVÁN ', CAST(17300.00 AS Decimal(18, 2)), CAST(N'2023-05-29T09:36:29.477' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1157, 1702307804, 2, 159, 106, NULL, 1, 124, N'PAGO DE TARJETA AMERICAN EXPRESS ', N'', N'29/05/2023', N'PAGO MENSUAL DE TARJETA DE ALLAN ', CAST(25800.00 AS Decimal(18, 2)), CAST(N'2023-05-29T09:37:21.993' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1158, 1702307804, 2, 159, 106, NULL, 1, 125, N'PAGO DE TARJETA PALACIO DE HIERRO', N'', N'29/05/2023', N'PAGO DE TARJETA DE CRÉDITO DE ALLAN GALVAN ', CAST(9900.00 AS Decimal(18, 2)), CAST(N'2023-05-29T09:38:23.490' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1159, 1702307804, 2, 1221, 106, NULL, 1, 126, N'PAGO DE FLETE MAKAKO', N'', N'29/05/2023', N'PAGO PARA EL FLETE, SE IRÁN MITAD Y MITAD ALLAN Y DAVID ', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:48:05.657' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (1160, 1702307804, 4, 180, 102, NULL, 1, 127, N'PAGO DE TORNO ROMI', N'', N'29/05/2023', N'SE TERMINÓ DE PAGAR EL TORNO ROMI, SE DEPISTÓ A TARJETA DE DAVID ', CAST(45000.00 AS Decimal(18, 2)), CAST(N'2023-05-29T11:51:55.850' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2155, 1702307804, 2, 161, 100, NULL, 1, 128, N'GASTO PERSONAL DE ALLAN', N'', N'26/05/2023', N'SE COMPRÓ UN RZR ALLAN ', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2023-05-30T06:35:17.153' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2156, 1702307804, 3, 152, 103, NULL, 3, 129, N'DEUDA PERSONAL CON MONTES ', N'', N'31/12/2022', N'PRESTAMO PERSONAL QUELE HIZO MARCO MONTE A ALLAN ', CAST(301000.00 AS Decimal(18, 2)), CAST(N'2023-05-30T10:02:02.160' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2157, 1702307804, 5, 1206, 103, NULL, 1, 130, N'OSVALDO BARBA', N'', N'01/01/2023', N'', CAST(350000.00 AS Decimal(18, 2)), CAST(N'2024-02-15T15:28:18.710' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2158, 1702307804, 4, 154, 103, NULL, 1, 131, N'PAGO DE PRESTAMO CON MONTES', N'', N'26/05/2023', N'SE LE PAGÓ EN EFECTIVO A ', CAST(316000.00 AS Decimal(18, 2)), CAST(N'2023-05-31T06:28:09.337' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2159, 1702307804, 4, 154, 103, NULL, 1, 132, N'PAGO DE TRABAJO A HECTOR CARRILLO', N'', N'27/05/2023', N'SE LE PAGÓ DINERO DE SU TRABAJO A HECTOR CARRILLO, SE LO DIÓ ALLAN', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-05-31T07:16:46.097' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2160, 1702307804, 3, 158, 103, NULL, 3, 133, N'BBVA DAVID PRÉSTAMO', N'', N'31/12/2022', N'PRESTAMO QUE PIDIÓ ALLAN CON LA CUENTA DE DAVID PARA PAGARLE A LALO GUERRERO', CAST(90000.00 AS Decimal(18, 2)), CAST(N'2023-05-31T07:56:56.670' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2161, 1702307804, 2, 176, 100, NULL, 1, 134, N'COMPRA DE MATERIAL', N'', N'30/05/2023', N'RICARDO COMPRÓ UNAS LIJAS PARA EL ACRILICO', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:58:56.397' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2162, 1702307804, 2, 176, 100, NULL, 1, 135, N'PAGO DE TRABAJO A NETO', N'', N'29/05/2023', N'SE LE DIÓ EFECTIVO A NETO POR LOS TRABAJOS QUE HA HECHO: ELIMINADOR, CASCO DE CHASIS, TACOS, TAMARO. ', CAST(4600.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:56:53.120' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2163, 1702307804, 3, 152, 103, NULL, 3, 136, N'TOBY', N'', N'31/12/2022', N'PRESTAMO DE INGENIERO LUIS ANTONIO SIERRA CASTELLANOS ', CAST(1000000.00 AS Decimal(18, 2)), CAST(N'2023-05-31T08:15:16.420' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2164, 1702307804, 4, 154, 103, NULL, 3, 137, N'PAGO A INGENIERON LUIS ANTONIO SIERRA', N'', N'24/05/2023', N'PAGO EN EFECTIVO CON PAGARÉ AL HIJO DEL INGENIERO LUIS ANTONIO, POR VENTA DE TORNO DMTG ', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2023-12-20T12:28:23.463' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2165, 1702307804, 4, 179, 102, NULL, 1, 138, N'MAQUINA PAGADA', N'', N'31/05/2023', N'SE PAGÓ LA MAQUINARIA A LA CUÁL SE LE REALIZÓ A LA CUENTA FISCAL', CAST(475600.00 AS Decimal(18, 2)), CAST(N'2023-05-31T10:08:22.217' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2166, 1702307804, 2, 176, 106, NULL, 1, 139, N'PAGO DE CASETA', N'', N'27/05/2023', N'ALLAN PAGÓ LA CASETA DEL FLETE', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:52:00.940' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2167, 1702307804, 2, 168, 106, NULL, 1, 140, N'RESTO EN TARJETA DE DAVID', N'', N'27/05/2023', N'DINERO QUE SE QUEDÓ EN LA TARJETA DE DAVID ', CAST(9500.00 AS Decimal(18, 2)), CAST(N'2023-06-01T09:43:07.757' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2168, 1702307804, 3, 152, 106, NULL, 3, 141, N'PAGO A BENITO ', N'', N'27/05/2023', N'DINERO PARA BENITO REAL, TRABAJO DE RECT.', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:19:19.340' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2169, 1702307804, 2, 176, 106, NULL, 1, 142, N'PAGO A JORGE FLORES (MORENO PINTURAS)', N'', N'27/05/2023', N'PAGO A MORENO PINTURAS', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:37:39.920' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2170, 1702307804, 3, 152, 106, NULL, 3, 143, N'ADELANTO DE COMISIONES DAVID ', N'', N'27/05/2023', N'SE QUEDÓ CON EL ADELANTO DEL TORNO ROMI', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:44:39.163' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2171, 1702307804, 2, 176, 106, NULL, 1, 144, N'PAGO A MARIO PEREZ POR VF4', N'', N'27/05/2023', N'PAGO A MARIO PEREZ POR SU TRABAJO EN EL VF4', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:45:33.400' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2172, 1702307804, 2, 176, 100, NULL, 1, 145, N'CALCAS', N'', N'26/05/2023', N'SE COMPRARON CALCAS PARA MAQUINARIA', CAST(550.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:45:59.783' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2173, 1702307804, 2, 176, 100, NULL, 1, 146, N'CABLES', N'', N'26/05/2023', N'SE COMPRARON CABLES PARA RECT', CAST(100.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:46:11.500' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2174, 1702307804, 2, 161, 100, NULL, 1, 147, N'PLACAS DE RZR', N'', N'26/05/2023', N'SE COMPRARON PLACAS PARA EL NUEVO RZR', CAST(6000.00 AS Decimal(18, 2)), CAST(N'2023-06-01T11:35:56.430' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2175, 1702307804, 2, 168, 100, NULL, 1, 148, N'DINERO PARA CELULAR DE RICHARD', N'', N'26/05/2023', N'PRESTAMO PERSONAL PARA RICHARD PARTE DE COMISIONES DE DAVID', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-06-01T11:36:50.420' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2176, 1702307804, 1, 1180, 100, NULL, 3, 149, N'EFECTIVO QUE TRAJO FREDDY', N'', N'24/05/2023', N'DINERO EN EFECTIVO QUE ENTREGÓ FREDDY A MARIANA', CAST(350000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:36:25.297' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2177, 1702307804, 1, 1180, 100, NULL, 3, 150, N'EFECTIVO ATZHIRI', N'', N'24/05/2023', N'EFECTIVO QUE TRAJO RICARDO CRUZ', CAST(336000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:36:29.663' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2178, 1702307804, 1, 1180, 100, NULL, 3, 151, N'DINERO DE ATZHIRI ', N'', N'24/05/2023', N'OTRO DINERO QUE TRAJO RICARDO EN EFECTIVO', CAST(192000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:36:32.557' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2179, 1702307804, 1, 1180, 100, NULL, 3, 152, N'DINERO EN EFECTIVO DE PRESTAMO DE SERRANO', N'', N'24/05/2023', N'DINERO DEL PRÉSTAMO QUE SE LE DEPOSITÓ A ALEX MENDOZA', CAST(122500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:37:28.813' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2180, 1702307804, 2, 161, 100, NULL, 1, 153, N'GASTO PERSONAL DE ALLAN', N'', N'24/05/2023', N'EFECTIVO PAR ALLAN QUE LE DIÓ RICARDO ', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2023-06-01T12:06:14.537' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2181, 1702307804, 2, 161, 100, NULL, 1, 154, N'DINERO PARA COMPLEMENTAR EL RZR', N'', N'25/05/2023', N'AGARRÓ DINERO PARA COMPLETAR EL PAGO DEL RZR', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-06-01T12:09:12.250' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2182, 1702307804, 2, 1221, 100, NULL, 1, 155, N'PAGO FLETE ZACARIAS ', N'', N'25/05/2023', N'DINERO DEL FLETE QUE ENTREGÓ DAVID CRUZ', CAST(6000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:42:26.740' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2183, 1702307804, 2, 1221, 100, NULL, 1, 156, N'PROPINA FLETE ', N'', N'25/05/2023', N'PROPINA QUE DIÓ ALLAN A ZACARIAS POR FLETE ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:42:40.543' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2184, 1702307804, 2, 176, 100, NULL, 1, 157, N'MATERIALES', N'', N'25/05/2023', N'DINERO PARA ALLAN PARA COMPRAR MATERIALES', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:43:34.167' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2185, 1702307804, 2, 1222, 100, NULL, 1, 158, N'NOMINAS DE SEMANA ', N'', N'25/05/2023', N'NOMINAS DE SEMANA, PENDIENTE VER CON FREDDY', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:44:17.030' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2186, 1702307804, 2, 1223, 100, NULL, 1, 159, N'PAGO JUAN TREJO', N'', N'26/05/2023', N'DINERO DEL ULTIMO TRABAJO QUE HIZO JUAN TREJO ', CAST(11000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:47:06.460' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2187, 1702307804, 2, 161, 100, NULL, 1, 160, N'SOBRE DE ALLAN ', N'', N'26/05/2023', N'SOBRE DE ALLAN DE AHORRO PARA PAGAR A SU PADRINO ', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2023-06-01T12:28:58.700' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2188, 1702307804, 2, 176, 100, NULL, 1, 161, N'PAGO AL DE LOS ALUMINIOS', N'', N'26/05/2023', N'PAGAMOS AL DE ALUMINIOS ', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2023-06-01T12:30:05.370' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2189, 1702307804, 2, 176, 100, NULL, 1, 162, N'PAGO FINIQUITO BENITO', N'', N'29/05/2023', N'PAGO DE MAQUINARIA QUE REPARÓ BENITO REAL', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:55:46.157' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2190, 1702307804, 2, 176, 100, NULL, 1, 163, N'DAVID GONZALEZ', N'', N'29/05/2023', N'DINERO DE ANTICIPO Y PALANCAS', CAST(5900.00 AS Decimal(18, 2)), CAST(N'2023-06-01T12:36:04.667' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2191, 1702307804, 2, 176, 100, NULL, 1, 164, N'PAGO DE TRABAJO A RAMIRO', N'', N'30/05/2023', N'PAGO DE ARREGLOS QUE HIZO EL ALBAÑIL', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:58:06.350' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2192, 1702307804, 2, 176, 100, NULL, 1, 165, N'PAGO A BENITO', N'', N'30/05/2023', N'PAGO DE TRABAJO A BENITO', CAST(2600.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:59:31.753' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2193, 1702307804, 2, 176, 100, NULL, 1, 166, N'LIJAS', N'', N'31/05/2023', N'DINERO QUE SE USÓ PARA COMPRAR LIJAS PARA CORTE DE ACRILICOS', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:59:59.487' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2194, 1702307804, 2, 1225, 100, NULL, 1, 167, N'FLETE MAKAKO', N'', N'31/05/2023', N'PAGO DE MANIOBRAS A MAKAKO', CAST(9000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:00:41.390' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2195, 1702307804, 2, 176, 100, NULL, 1, 168, N'FUMIGACIÓN ', N'', N'31/05/2023', N'PAGO DE FUMIGACIÓN QUE MANDÓ ALLAN ', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-06-01T12:45:46.830' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2196, 1702307804, 2, 161, 100, NULL, 1, 169, N'EFECTIVO DEPOSITADO A ALLAN', N'', N'01/06/2023', N'SE LE DEPOSITÓ A LA CUENTA FISCAL A ALLAN', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T12:39:14.577' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2197, 1702307804, 2, 161, 100, NULL, 1, 170, N'DINERO DEPOSITADO A ALTAGRACIA', N'', N'01/06/2023', N'dinero en efectivo depositado a Altagracia', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2023-06-01T12:44:33.607' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2198, 1702307804, 2, 176, 100, NULL, 1, 171, N'FIBRAS PARA MAQUINARIA', N'', N'02/06/2023', N'DINERO PARA COMPRAR FIBRAS ROJAS', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-09-27T08:54:00.690' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2200, 1702307804, 2, 161, 100, NULL, 1, 172, N'PAGO TOTOTLÁN', N'', N'02/06/2023', N'ALLAN LE PAGÓ AL ING DE TOTOTLÁN ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-06-05T10:26:08.097' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2201, 1702307804, 2, 176, 100, NULL, 1, 173, N'GAS ', N'', N'02/06/2023', N'ALLAN MANDÓ A RICARDO POR GAS ', CAST(800.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:05:33.727' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2202, 1702307804, 4, 154, 103, NULL, 3, 174, N'INTERESES DAVID GONZALEZ', N'', N'02/06/2023', N'ALLAN PAGÓ INTERESES DE DAVID GONZALEZ', CAST(120500.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:48:52.763' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2203, 1702307804, 2, 176, 100, NULL, 1, 175, N'DIESEL', N'', N'02/06/2023', N'ALLAN MANDÓ A RICARDO A COMPRAR DIESEL', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:14:17.963' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2204, 1702307804, 2, 1222, 100, NULL, 1, 176, N'NOMINAS ', N'', N'02/06/2023', N'ALLAN PAGÓ LAS NOMINAS', CAST(5500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T08:54:27.587' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2205, 1702307804, 2, 161, 100, NULL, 1, 177, N'PRESTAMO ALTAGRACIA', N'', N'02/06/2023', N'PAGO DE PRESTAMO DE ALTAGRACIA PENDIENTE VER SI YA ESTÁ REGISTRADO', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-06-05T10:43:03.660' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2206, 1702307804, 3, 167, 100, NULL, 3, 178, N'NETO MONTACARGAS', N'', N'02/06/2023', N'PAGO POR TRABAJO A NETO', CAST(1300.00 AS Decimal(18, 2)), CAST(N'2023-09-26T12:37:44.633' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2207, 1702307804, 3, 1183, 100, NULL, 3, 179, N'COMISION TB-32120C', N'', N'03/06/2023', N'ALLAN PAGÓ EL RESTO DE LAS COMISIONES DE DAVID', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-09-26T13:07:48.017' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2208, 1702307804, 2, 176, 100, NULL, 1, 180, N'RAMIRO FACHADA', N'', N'03/06/2023', N'PAGO DE TRABAJO ', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-26T13:08:13.597' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2209, 1702307804, 4, 154, 103, NULL, 3, 181, N'PAGO PRESTAMO ASPIRIA', N'', N'03/06/2023', N'PAGO DE PRESTAMO ASPIRIA', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:54:28.720' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2210, 1702307804, 2, 1222, 100, NULL, 1, 182, N'NOMINA ALLAN', N'', N'03/06/2023', N'ALLAN SE PAGÓ SU NOMINA', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-26T13:08:40.393' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2211, 1702307804, 4, 154, 103, NULL, 3, 183, N'INTERESES OSVALDO', N'', N'03/06/2023', N'PAGO DE INTERESES DE OSVALDO', CAST(17000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:57:09.990' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2212, 1702307804, 4, 154, 103, NULL, 3, 184, N'JORGE CABRERA', N'', N'05/06/2023', N'PAGO A JORGE CABRERA ', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2023-09-26T13:42:24.873' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2213, 1702307804, 3, 167, 100, NULL, 3, 185, N'BENITO REAL TRABAJO', N'', N'05/06/2023', N'REPARACION DE RECTIFICADORA DE SUPERFICIES PLANAS ALEMANA', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T07:33:45.350' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2214, 1702307804, 4, 154, 103, NULL, 3, 186, N'INTERESES CAYETANO', N'', N'06/06/2023', N'INTERESES DE CAYETANO ', CAST(11000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:03:04.457' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2215, 1702307804, 2, 176, 100, NULL, 1, 187, N'TARIMAS', N'', N'06/06/2023', N'SE COMPRARON TARIMAS', CAST(680.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:07:10.903' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2216, 1702307804, 2, 176, 100, NULL, 1, 188, N'GAS MOTO', N'', N'06/06/2023', N'SE LE PUSO GAS A LA MOTO', CAST(280.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:07:38.993' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2217, 1702307804, 3, 167, 100, NULL, 3, 189, N' BENITO REAL', N'', N'06/06/2023', N'DINERO PARA RECTIFICADORA, HONGOS DE STOP Y VOLANTE ', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-09-26T13:49:55.590' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2218, 1702307804, 4, 154, 102, NULL, 1, 190, N'PAGO FINAL VF-4', N'', N'06/06/2023', N'PAGO FINAL VF-4 RAFA DE LA TORRE ', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2023-06-06T13:31:43.743' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2221, 1702307804, 2, 176, 100, NULL, 1, 191, N'TARJETA PARA MARTÍN BBVA', N'', N'07/06/2023', N'DINERO PARA SACAR TARJETA DE MARTÍN ', CAST(2300.00 AS Decimal(18, 2)), CAST(N'2023-06-08T06:33:58.020' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2222, 1702307804, 2, 176, 100, NULL, 1, 192, N'GASTO DE BOLSAS PARA ENVÍO DE TARJETAS ', N'', N'06/06/2023', N'DINERO PARA COMPRAR BOLSAS ANTIESTATICA PARA TARJETAS, SE LE ENTREGÓ A MARIO PEREZ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-26T13:51:04.853' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2223, 1702307804, 3, 167, 100, NULL, 3, 193, N'FABRICACIÓN DE PIEZAS BENITO', N'', N'07/06/2023', N'LE DI DINERO A BENITO PARA LA FABRICACIÓN DE PIEZA DE TORNO COLCHESTER Y TORNO LOGAN ANTICIPO', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T07:34:15.410' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2224, 1702307804, 2, 161, 100, NULL, 1, 194, N'GASTO PERSONAL ALLAN', N'', N'07/06/2023', N'LE DI DINERO ALLAN PARA GASTO PERSONAL ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-06-08T06:41:23.427' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2225, 1702307804, 3, 169, 100, NULL, 3, 195, N'COMPRA DE HAAS VF6', N'VF6 AZUL ', N'09/06/2023', N'COMPRA DE MAQUINARIA ', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2023-06-09T09:59:55.197' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2226, 1702307804, 3, 169, 100, NULL, 3, 196, N'ANTICIPO REPARACION VF6 A BENITO', N'VF6 AZUÑ', N'09/06/2023', N'PRIMER PAGO DE REPARACION DE ', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-06-09T09:59:57.557' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2227, 1702307804, 1, 166, 102, NULL, 1, 197, N'VENTA DE TORNO CNC HWACHEON ', N'V-00016', N'09/06/2023', N'VENTA DE TORNO CNC HWACHEON ', CAST(395000.00 AS Decimal(18, 2)), CAST(N'2023-06-13T08:25:08.183' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2228, 1702307804, 4, 154, 102, NULL, 1, 198, N'PRIMER PAGO DE TORNO CNC HWACHEON', N'V-00016', N'09/06/2023', N'PRIMER PAGO DE TORNO CNC HWACHEON, JULIO MARQUEZ', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-06-13T08:35:05.017' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2229, 1702307804, 4, 154, 102, NULL, 1, 199, N'SEGUNDO PAGO  TORNO CNC HWACHEON ', N'V-00016', N'14/06/2023', N'SEGUNDO PAGO EN EFECTIVO A ALLAN ', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-06-14T10:13:42.230' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2230, 1702307804, 2, 161, 100, NULL, 1, 200, N'VIAJE TEPA', N'GP-0003', N'13/06/2023', N'GASTO PARA COMER ALLAN', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-06-14T10:28:09.490' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2231, 1702307804, 2, 161, 100, NULL, 1, 201, N'ALTAGRACIA GASTOS', N'GP-0004', N'13/06/2023', N'LE DIÓ DINERO PARA GASTOS PERSONALES A SU ESPSOA', CAST(6500.00 AS Decimal(18, 2)), CAST(N'2023-06-14T10:28:47.567' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2232, 1702307804, 2, 161, 100, NULL, 1, 202, N'GASTO PERSONAL ', N'GP-0004', N'14/06/2023', N'GASTO PERSONAL DE ALLAN', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-06-14T10:40:38.217' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2233, 1702307804, 2, 176, 100, NULL, 1, 203, N'PAGO IMSS', N'GB-0001', N'14/06/2023', N'PAGO PENDIENTE DE IMSS DINERO APARTADO ', CAST(2300.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:34:19.017' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2234, 1702307804, 2, 161, 100, NULL, 1, 204, N'DINERO MONTES ', N'PP-OOO1', N'15/06/2023', N'DINERO APARTADO PARA PAGARLE A MONTES LO QUE SE GASTÓ ', CAST(21317.00 AS Decimal(18, 2)), CAST(N'2023-06-15T13:37:31.407' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2235, 1702307804, 2, 161, 100, NULL, 1, 205, N'GASTO PERSONAL MANTENIMIENTO BMW', N'GP-0003', N'13/06/2023', N'MANTENIMIENTO DEL BMW ', CAST(2200.00 AS Decimal(18, 2)), CAST(N'2023-09-27T07:42:30.780' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2236, 1702307804, 2, 176, 100, NULL, 1, 206, N'SAT', N'GB-0004', N'14/06/2023', N'PAGO DE IMPUESTOS, SE GUARDÓ 200 PARA ESO, EN REALIDAD SON 136', CAST(136.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:34:59.313' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2237, 1702307804, 2, 161, 1109, NULL, 1, 207, N'PRESTAMO ALLAN', N'GP-0005', N'13/06/2023', N'PAGO DE PRÉSTAMO QUE LE HIZO SU HERMANO A ALLAN', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-06-14T14:11:38.267' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2238, 1702307804, 3, 152, 1109, NULL, 3, 208, N'PAGO COMISIÓN YADIRA', N'CO-0002', N'13/06/2023', N'PAGO EN TRASFERENCIA DE COMISIÓN POR VENTA DE APILADOR A YADIRA', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-09-26T13:53:53.310' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2239, 1702307804, 2, 161, 1109, NULL, 1, 209, N'PAGO PRESTAMO MONTES', N'PP-0004', N'13/06/2023', N'SE HIZO RETIRO SIN TARJETA PARA PAGARLE LO QUE PRESTÓ MONTES ', CAST(6500.00 AS Decimal(18, 2)), CAST(N'2023-06-14T14:15:23.963' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2240, 1702307804, 4, 154, 102, NULL, 3, 210, N'PAGADO PRESTAMO A PAPÁ DE ALLAN', N'PP-0005', N'21/07/2023', N'EL PAPÁ DE ALLAN PAGÓ EL PRESTAMO QUE ALLAN LE HIZO EL VIERNES 09 DE JUNIO ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:20:07.473' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2241, 1702307804, 3, 167, 100, NULL, 3, 211, N'TRABAJO BENITO ', N'TB-0001', N'13/06/2023', N'SE PAGÓ EL TRABAJO REALIZADO DE TORNO LOGAN, RECTIFICADORA CHEVALIER, RECTIFICADORA ARGENTINA Y FRESADORA POLACA', CAST(7800.00 AS Decimal(18, 2)), CAST(N'2023-09-27T07:40:10.210' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2242, 1702307804, 2, 161, 100, NULL, 1, 212, N'RESTO DEL PAGO A MONTES ', N'PP-0001', N'13/06/2023', N'SE LE PAGO EL RESTO DEL PRÉSTAMO QUE SE LE HIZO A ALLAN CON EL RESTO DE LA DEVOLUCIÓN DEL PAPÁ DE ALLAN', CAST(2700.00 AS Decimal(18, 2)), CAST(N'2023-09-27T08:57:11.113' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2243, 1702307804, 1, 1180, 100, NULL, 3, 213, N'INGRESO DE EFECTIVO ', N'IE-0001', N'15/06/2023', N'INGRESO DE EFECTIVO DE VENTA DE ALLAN Y SU HERMANO', CAST(230000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T12:56:19.647' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2244, 1702307804, 2, 174, 100, NULL, 1, 214, N'DINERO MONTES', N'PP-0001', N'15/06/2023', N'PAGO DEL PRESTAMO DE SU TARJETA KONFIO DE MONTES, MAZDA Y 500 QUE LE DEBIAMOS ', CAST(16000.00 AS Decimal(18, 2)), CAST(N'2023-06-15T13:43:41.450' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2245, 1702307804, 2, 161, 100, NULL, 1, 215, N'HERMANO ALLAN', N'PP-0002', N'15/06/2023', N'PAGO A HERMANO DE ALLAN', CAST(28250.00 AS Decimal(18, 2)), CAST(N'2023-09-27T08:58:24.637' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2246, 1702307804, 2, 1191, 100, NULL, 1, 216, N'GASTO PERSONAL ALLAN', N'GP-0008', N'15/06/2023', N'GASTO PERSONAL DE ALLAN GALVÁN', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-06-15T13:51:13.890' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2247, 1702307804, 4, 154, 102, NULL, 1, 217, N'PAGADO EN SU TOTALIDAD ', N'CP-0001', N'03/07/2023', N'CUENTA PAGADA $40,000 EN EFECTIVO Y $60,000 EN CUENTA DE DAVID CRUZ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-07-03T08:06:50.453' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2248, 1702307804, 2, 176, 100, NULL, 1, 218, N'HERRERO PORTÓN ELECTRICO', N'GB-0001', N'16/06/2023', N'SE INSTALÓ PUERTA PEATONAL ELECTRICA, CONTROL, APP, CONTROLES Y CASA DE ALLAN ', CAST(8500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:41:28.277' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2249, 1702307804, 2, 1222, 100, NULL, 1, 219, N'NOMINAS', N'N-0001', N'16/06/2023', N'PAGO DE NOMINA, SEMANA.
MARTIN, RICHARD, MARIANA.', CAST(6000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T08:22:40.783' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2250, 1702307804, 3, 167, 103, NULL, 3, 220, N'DAVID GONZALEZ ', N'DP-0004', N'31/12/2022', N'DINERO EN EFECTIVO QUE ENTREGÓ ALLAN, PRESTAMO DE DAVID GONZALEZ', CAST(1800000.00 AS Decimal(18, 2)), CAST(N'2023-07-10T07:57:54.137' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2251, 1702307804, 2, 161, 100, NULL, 1, 221, N'COMIDA ALLAN ', N'GP-0006', N'19/06/2023', N'GASTO PERSONAL DE ALLAN GALVÁN PARA IR A DESAYUNAR ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-07-10T07:59:44.327' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2252, 1702307804, 2, 1222, 100, NULL, 1, 222, N'NOMINA ALLAN', N'NO-0008', N'19/06/2023', N'NOMINA DE ALLAN GALVÁN ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T08:23:14.620' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2253, 1702307804, 3, 167, 100, NULL, 3, 223, N'TRABAJO BENITO ', N'TB-0001', N'19/06/2023', N'TRABAJO DE MAQUINARIA PARA BENITO ', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T08:28:17.333' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2254, 1702307804, 4, 154, 103, NULL, 3, 224, N'PAGO PARA CUCO', N'DP-0005', N'19/06/2023', N'SE LE DIÓ DINERO AL PAPÁ DE ALLAN PARA PAGARLE A CUCO ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:38:01.820' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2255, 1702307804, 2, 161, 100, NULL, 1, 225, N'GASTO PERSONAL ALLAN ', N'GP-0009', N'19/06/2023', N'GASTO PERSONAL DE ALLAN ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-07-10T08:42:14.960' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2256, 1702307804, 4, 154, 103, NULL, 3, 226, N'DAVID GONZALEZ PAGO', N'PD-0010', N'10/07/2023', N'PAGO A DAVID GONZALEZ', CAST(162500.00 AS Decimal(18, 2)), CAST(N'2023-07-10T11:20:24.687' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2257, 1702307804, 3, 167, 1109, NULL, 3, 227, N'TARJETA MARIANA ', N'T-0002', N'19/06/2023', N'DINERO QUE SE DEPOSITÓ PARA GASTOS DE BODEGA', CAST(23000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T08:28:35.970' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2258, 1702307804, 2, 161, 100, NULL, 1, 228, N'GASTO PERSONAL ALLAN', N'GP-0004', N'19/06/2023', N'GASTO PERSONAL PARA ALLAN ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-07-10T12:39:05.177' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2259, 1702307804, 3, 167, 100, NULL, 3, 229, N'TRABAJO MARIO', N'TM-0006', N'19/06/2023', N'GASTO DE TRABAJO PARA MAQUINARIA, REALIZADO POR MARIO PEREZ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T08:42:41.020' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2260, 1702307804, 3, 167, 100, NULL, 3, 230, N'RAFA CASTILLO ', N'RF-0001', N'19/06/2023', N'DINERO PARA PINTOR, RAFA ', CAST(2700.00 AS Decimal(18, 2)), CAST(N'2023-09-27T08:42:52.250' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2261, 1702307804, 2, 161, 100, NULL, 1, 231, N'GASTO PERSONAL', N'GP-0011', N'23/06/2023', N'GASTO PERSONAL PARA ALLAN GALVÁN', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:34:47.227' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2262, 1702307804, 2, 176, 100, NULL, 3, 232, N'TRABAJO MARIO ', N'TM-0003', N'23/06/2023', N'DINERO QUE SE LE DIÓ A MARIO PARA TARJETA', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T09:16:44.430' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2263, 1702307804, 2, 176, 100, NULL, 1, 233, N'HERRERO PORTÓN', N'GB-0002', N'23/06/2023', N'DINERO PARA PORTÓN ELECTRICO DE BODEGA', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:00:41.877' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2264, 1702307804, 2, 176, 100, NULL, 1, 234, N'COMPRA DE ACEITE', N'GB-0007', N'23/06/2023', N'SE COMPRÓ ACEITE PARA MÁQUINAS', CAST(1300.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:01:55.827' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2265, 1702307804, 2, 176, 100, NULL, 1, 235, N'GAS MOTO', N'GB-0010', N'23/06/2023', N'COMPRA DE GAS PARA LA MOTO', CAST(260.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:01:19.493' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2266, 1702307804, 2, 176, 100, NULL, 1, 236, N'GAS NISSAN', N'GB-0009', N'23/06/2023', N'DINERO PARA GAS DE CAMIONETA NISSAN ', CAST(1400.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:05:56.750' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2267, 1702307804, 3, 175, 100, NULL, 3, 237, N'BENITO REAL', N'TB-0002', N'23/06/2023', N'TRABAJO DE BENITO REAL', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T09:21:07.670' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2268, 1702307804, 4, 154, 103, NULL, 3, 238, N'INTERESES HERMANO DE BETO', N'IN-0004', N'26/06/2023', N'PAGO DE INTERESES DEL HERMANO DE BETO', CAST(3600.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:26:37.270' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2269, 1702307804, 4, 154, 103, NULL, 3, 239, N'INTERESES DOÑA BERTHA', N'IN-0002', N'26/06/2023', N'INTERESES DE DOÑA BERTHA ', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:30:26.773' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2270, 1702307804, 4, 179, 103, NULL, 3, 240, N'PAGO ASPIRIA', N'', N'14/07/2023', N'LIQUIDADO PRÉSTAMO ASPIRIA ', CAST(83000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T11:03:53.070' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2271, 1702307804, 5, 1212, 102, NULL, 1, 241, N'PRÉSTAMO A PAPÁ ALLAN ', N'P-PAPA', N'10/06/2023', N'PRÉSTAMO A PAPÁ ALLAN FECHA INCIERTA ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T07:36:10.887' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2272, 1702307804, 4, 154, 102, NULL, 3, 242, N'PAGO PRESTAMO A PAPÁ DE ALLAN', N'PAGO', N'13/06/2023', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T07:40:56.567' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2273, 1702307804, 1, 172, 105, NULL, 1, 243, N'VENTA DE SIERRA DOALL', N'F-112', N'13/07/2023', N'SIERRA-CINTA AUTOMATICA DOALL AMERICANA ', CAST(116000.00 AS Decimal(18, 2)), CAST(N'2023-09-29T10:07:13.490' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2274, 1702307804, 1, 178, 105, NULL, 3, 244, N'VENTA DE RECTIFICADORA KENT ', N'F-99', N'26/06/2023', N'VENTA DE RECTIFICADORA DE SUPERFICIE PLANA MARCA KENT 
NO SERIE : 781134 
CLIENTE: HUGO RAMIREZ
', CAST(425000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T13:15:48.737' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2275, 1702307804, 1, 166, 105, NULL, 1, 245, N'VENTA DE TORNO TOS SN-40', N'F-111', N'13/07/2023', N'TORNO TOS SN-40 DIMENSIONES 16 X 1 METRO CHECOSLOVACO.', CAST(162400.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:49:24.040' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2276, 1702307804, 2, 176, 100, NULL, 1, 246, N'PAQUETERÍA ', N'', N'23/06/2023', N'SE EMTREGÓ DINERO PARA PAGAR PAQUETERÍA', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T09:21:30.180' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2277, 1702307804, 1, 166, 105, NULL, 1, 247, N'VENTA TORNO CHECOSLOVACO SN-71', N'F-110', N'12/07/2023', N'VENTA DE TORNO CHECOSLOVACO MODELO: SN-71 28 X 4 METROS.', CAST(962800.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:36:19.140' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2278, 1702307804, 1, 166, 103, NULL, 3, 248, N'VENTA DE TORNO CONVENCIONAL PINACHO ', N'F-P', N'26/06/2023', N'VENTA DE TORNO CONVENCIONAL PINACHO 
NO DE SERIE: 9102 
CLIENTE: KBS TECNOLOGÍA LINEAL ', CAST(225000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:30:39.120' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2279, 1702307804, 2, 161, 100, NULL, 1, 249, N'HERRERO CASA DE ALLAN ', N'GP-0003', N'23/06/2023', N'SE LE PAGÓ AL HERRERO PARA EL PAGO DEL PORTÓN DE LA CASA DE ALLAN ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:37:40.650' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2280, 1702307804, 1, 165, 105, NULL, 1, 250, N'VENTA CENTRO DE MAQUINADO HAAS VF4', N'F-109', N'12/07/2023', N'VENTA DE CENTRO DE MAQUINADO HAAS VF4.
Nº DE SERIE: 1167094', CAST(1218000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:37:58.527' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2281, 1702307804, 1, 178, 102, NULL, 3, 251, N'VENTA DE RECTIFICADORA DE SUPERFICIES PLANAS ', N'F-P', N'26/06/2023', N'VENTA DE RECTIFICADORA DE SUPERFICIES PLANAS 
NO DE SERIE: 537852
CLIENTE: KBS TECNOLOGÍA LINEAL', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:14:33.973' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2282, 1702307804, 2, 176, 100, NULL, 1, 252, N'LIJAS Y FIBRAS', N'GB-0012', N'23/06/2023', N'SE LE DIÓ DINERO A NATALIO PARA QUE COMPRARA FIBRAS Y LIJAS PARA TRABAJR ', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:17:52.883' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2283, 1702307804, 2, 161, 100, NULL, 1, 253, N'GASTO PERSONAL ALLAN', N'GP-0008', N'23/06/2023', N'GASTO PERSONAL ALLAN ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:39:50.923' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2284, 1702307804, 1, 153, 102, NULL, 3, 254, N'VENTA DE PERFILADORA BRIDGEPORT  ', N'F-P', N'26/06/2023', N'VENTA DE PERFILADORA BRIDGEPORT 
NO DE SERIE: 537852
CLIENTE: KBS TECNOLOGÍA LINEAL', CAST(95000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:16:58.907' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2285, 1702307804, 2, 161, 100, NULL, 1, 255, N'PAGO DE TARJETA AMERICAN EXPRESS', N'GP-0009', N'23/06/2023', N'SE LE DIÓ DINERO A RICARDO PARA QUE PAGARA AMERICAN EXPRESS DE ALLAN ', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:41:25.473' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2286, 1702307804, 1, 166, 105, NULL, 1, 256, N'VENTA DE TORNO CNC HAAS HL-4', N'F-095', N'06/06/2023', N'VENTA DE TORNO CNC MARCA: HAAS MODELO: HL-4
Nº DE SERIE: 0689
7 HOLDERS USADOS', CAST(348000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:43:20.197' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2287, 1702307804, 1, 165, 102, NULL, 3, 257, N'VENTA DE CENTRO DE MAQUINADO MORI SEIKI ', N'F-P', N'26/06/2023', N'VENTA DE CENTRO DE MAQUINADO MORI SEIKI MODELO MV-45B
NO SERIE: 1181
CLIENTE: ROGELIO LICEA ', CAST(279310.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:16:04.333' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2288, 1702307804, 2, 161, 100, NULL, 1, 258, N'PAGO DE TARJETA PLATINUM ALTAGRACIA', N'GP-0010', N'23/06/2023', N'SE LE DIÓ EFECTIVO A RICARDO PARA PAGAR TARJETA PLATINUM DE ALTAGRACIA', CAST(27500.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:43:59.700' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2289, 1702307804, 4, 154, 102, NULL, 3, 259, N'PAGO DE EFECTIVO POR LA VENTA DE MORI SEIKI ROGELIO LICEA', N'P-1', N'27/06/2023', N'', CAST(129310.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:24:45.457' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2290, 1702307804, 2, 176, 100, NULL, 1, 260, N'TRAPOS ', N'GB-0009', N'23/06/2023', N'SE DIÓ DINERO PARA PAGAR LOS TRAPOS PARA NATALIO Y MARTIN ', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:18:23.133' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2291, 1702307804, 1, 1186, 105, NULL, 1, 261, N'VENTA DE APILADOR BIG JOE', N'F-097', N'12/06/2023', N'VENTA DE APILADOR BIG JOE.
Nº DE SERIE: 377444', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:45:19.120' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2292, 1702307804, 4, 179, 102, NULL, 3, 262, N'PAGO A LA CUENTA FISCAL POR LA VENTA DE MORI SEIKI ROGELIO LICEA', N'P-02', N'27/06/2023', N'', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:26:16.570' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2293, 1702307804, 3, 152, 100, NULL, 3, 263, N'PAGO A RAFA CASTILLO ', N'GB-0003', N'23/06/2023', N'DINERO QUE SE PAGÓ A RAFA POR PINTURA DE MAQUINARIA', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T09:23:48.667' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2294, 1702307804, 1, 165, 105, NULL, 1, 264, N'VENTA DE CENTRO DE MAQUINADO VF-0', N'F-093', N'12/06/2023', N'VENTA DE CENTRO DE MAQUINADO VF-0 MARCA: HAAS AÑO 2000 CONTROL 2012
Nº DE SERIE: 20494', CAST(278400.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:47:15.920' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2295, 1702307804, 2, 161, 100, NULL, 1, 265, N'GASTO PERSONAL ALLAN ', N'GP-0011', N'23/06/2023', N'GASTOS PERSONALES DE ALLAN GALVÁN ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T11:48:19.423' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2296, 1702307804, 2, 1222, 100, NULL, 1, 266, N'NOMINAS', N'NO-0006', N'23/06/2023', N'PAGO DE DÓMINAS A MARIANA, RICARDO, MARTÍN Y NATALIO ', CAST(8500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T09:24:33.080' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2297, 1702307804, 2, 1222, 100, NULL, 1, 267, N'NOMINA DE ALLAN', N'NO-007', N'23/06/2023', N'NOMINA DE ALLAN ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T09:24:45.160' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2298, 1702307804, 3, 152, 100, NULL, 3, 268, N'BENITO', N'TB-0008', N'23/06/2023', N'PAGO DE BENITO DE TRABAJO ', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T09:24:56.583' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2299, 1702307804, 1, 178, 102, NULL, 1, 269, N'VENTA DE RECTIFICADORA DE SUPERFICIES PLANAS ', N'F-P', N'26/06/2023', N'VENTA DE RECTIFICADORA DE SUPERFICIES PLANAS 
NO DE SERIE: 537852
CLIENTE: KBS TECNOLOGÍA LINEAL
', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:15:13.790' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2300, 1702307804, 1, 165, 102, NULL, 1, 270, N'VENTA DE CENTRO DE MAQUINADO MORI SEIKI ', N'F-P', N'26/06/2023', N'VENTA DE CENTRO DE MAQUINADO MORI SEIKI MODELO MV-45B
NO SERIE: 1181
CLIENTE: ROGELIO LICEA 
', CAST(279310.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:16:38.563' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2301, 1702307804, 1, 153, 102, NULL, 1, 271, N'VENTA DE PERFILADORA BRIDGEPORT', N'F-P', N'26/06/2023', N'VENTA DE PERFILADORA BRIDGEPORT 
NO DE SERIE: 537852
CLIENTE: KBS TECNOLOGÍA LINEAL
  ', CAST(95000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:17:35.323' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2302, 1702307804, 4, 154, 102, NULL, 1, 272, N'PAGO DE EFECTIVO POR LA VENTA DE MORI SEIKI ROGELIO LICEA', N'P-01', N'27/06/2023', N'SE PAGÓ UNA PARTE EN EFECTIVO Y OTRA EN CUENTA FISCAL', CAST(129310.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:26:03.157' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2303, 1702307804, 4, 179, 102, NULL, 1, 273, N'PAGO A LA CUENTA FISCAL POR LA VENTA DE MORI SEIKI ROGELIO LICEA', N'P-02', N'27/06/2023', N'PAGO POR LA DIFERENCIA EN LA CUENTA FISCAL', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:28:10.557' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2304, 1702307804, 3, 1183, 100, NULL, 3, 274, N'COMISIÓN DAVID', N'CO-0002', N'26/06/2023', N'DIENERO QUE SE LE DIÓ A DAVID POR LA VENTA DEL TORNO PINACHO', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T09:26:05.250' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2305, 1702307804, 2, 161, 100, NULL, 1, 275, N'PAGO DE TARJETA DE LIVERPOOL', N'GP-0012', N'26/06/2023', N'GASTO DE TARJETA LIVERPOOL DE ALLAN GALVAN ', CAST(24500.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:31:29.843' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2306, 1702307804, 1, 166, 102, NULL, 1, 276, N'VENTA DE TORNO CONVENCIONAL PINACHO', N'F-P', N'26/06/2023', N'VENTA DE TORNO CONVENCIONAL PINACHO 
NO DE SERIE: 9102 
CLIENTE: KBS TECNOLOGÍA LINEAL 
', CAST(225000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:31:30.357' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2307, 1702307804, 4, 154, 102, NULL, 1, 277, N'PAGO POR VENTA DE PINACHO A KBS', N'P-01', N'26/06/2023', N'PAGO EN EFECTIVO A CUENTA DE PINACHO KBS', CAST(94000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:36:24.477' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2308, 1702307804, 4, 154, 102, NULL, 1, 278, N'PAGO A CUENTA DE LA VENTA DE PINACHO KBS', N'P-002', N'10/07/2023', N'ABONO DOS A CUENTA DE PINACHO', CAST(40000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:38:49.613' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2309, 1702307804, 1, 153, 102, NULL, 1, 279, N'VENTA DE PERFILADORA TITANIUM ', N'NS-214MR1A', N'28/04/2023', N'SE VENDIÓ PERFILADORA EN $140,000.00 SE DIÓ UN ANTICIPO DE $100,000.00
', CAST(140000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:44:31.680' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2310, 1702307804, 4, 154, 102, NULL, 1, 280, N'ANTICIPO POR VENTA DE PERFILADORA TITANIUM ', N'A-01', N'28/04/2023', N'ANTICIPO VENTA DE PERFILADORA TITANIUM ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:45:35.030' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2311, 1702307804, 4, 154, 102, NULL, 1, 281, N'PAGO TOTAL POR VENTA DE PERFILADORA TITANIUM', N'P-01', N'10/07/2023', N'PAGO DEL SALDO TOTAL VENTA DE PERFILADORA TITANIUM 
 ', CAST(40000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:48:09.157' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2312, 1702307804, 4, 154, 102, NULL, 1, 282, N'PAGO TOTAL POR VENTA CHINERIK', N'P-01', N'10/07/2023', N'PAGO DEL SALDO TOTAL', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T12:49:38.613' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2313, 1702307804, 3, 1194, 100, NULL, 3, 283, N'COMPRA DE PERFILADORA BRIDGEPORT MODELO 34157088-0V', N'NS-537852', N'26/06/2023', N'COMPRA DE PERFILADORA DESDE LA CUENTA DE DAVID', CAST(48000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:27:34.393' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2314, 1702307804, 3, 162, 100, NULL, 3, 284, N'COSTO DE TRASLADO PERFILADORA BRIDGEPORT', N'C-002', N'26/06/2023', N'SE PAGO DESDE LA CUENTA DE DAVID', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:27:37.280' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2315, 1702307804, 2, 161, 100, NULL, 1, 285, N'PAGO RZR', N'', N'26/06/2023', N'SE PAGO DESDE LA CUENTA DE DAVID', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T13:12:13.180' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2316, 1702307804, 1, 178, 102, NULL, 1, 286, N' VENTA DE RECTIFICADORA KENT ', N'F-99', N'24/06/2023', N'VENTA DE RECTIFICADORA DE SUPERFICIE PLANA MARCA KENT 
NO SERIE : 781134 
CLIENTE: HUGO RAMIREZ', CAST(425000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T13:16:44.477' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2317, 1702307804, 4, 179, 102, NULL, 1, 287, N'ANTICIPO DE  VENTA DE RECTIFICADORA KENT ', N'A-01', N'26/06/2023', N'', CAST(348000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T13:18:21.953' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2318, 1702307804, 2, 161, 100, NULL, 1, 288, N'GASTO PERSONAL ALLAN SIN REFERENCIA ', N'SR', N'26/06/2023', N'GASTO PERSONAL ALLAN SIN REFERENCIA ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T13:35:16.150' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2319, 1702307804, 3, 1183, 100, NULL, 3, 289, N'COMISION PINACHO A DAVID ', N'', N'26/06/2023', N'COMISIÓN A DAVID POR VENTA DE PINACHO', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T09:52:51.140' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2320, 1702307804, 2, 161, 100, NULL, 1, 290, N'PAGO LIVERPOOL', N'G-SR', N'26/06/2023', N'PARA PAGO DE LA TARJETA LIVERPOOL', CAST(24500.00 AS Decimal(18, 2)), CAST(N'2023-07-21T13:37:28.200' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2321, 1702307804, 2, 161, 100, NULL, 1, 291, N'GASTOS PERSONALES ALLAN SIN REFERENCIA', N'SR', N'26/06/2023', N'ALLAN TOMO 16 MIL SIN REFERENCIA ', CAST(16000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T13:39:46.367' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2322, 1702307804, 2, 161, 100, NULL, 1, 292, N'ALLAN GASTO PERSONAL SIN REFERENCIA', N'SR', N'26/06/2023', N'GASTO PERSONAL ALLAN SIN REFERENCIA ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T13:40:46.300' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2323, 1702307804, 3, 1183, 100, NULL, 3, 293, N'GASTO DE DAVID PARA BENITO TOMADO DE DINERO ALLAN A CUENTA DE COMISIONES', N'', N'26/06/2023', N'DAVID TOMO 3 MIL PESOS PARA ABONAR A BENITO A CUENTA DE SUS COMISIONES ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:02:41.917' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2324, 1702307804, 3, 1195, 100, NULL, 3, 294, N'PAGO A BENITO A CUENTA DE REPARACION PERFILADORA ', N'C-01B', N'26/06/2023', N'SE ABONO A BENITO A CUENTA DE LA REPARACIÓN DE LA PERFILADORA ', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:32:16.760' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2325, 1702307804, 2, 176, 100, NULL, 1, 295, N'MANIOBRAS MAKAKO A DISTINTAS MAQUINAS ', N'G-1', N'26/06/2023', N'MANIOBRAS Y MOVIMIENTOS DE MAQUINAS EN BODEGA  ', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-07-21T13:48:04.910' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2326, 1702307804, 2, 176, 100, NULL, 1, 296, N'ENVÍO DE CONBELLO POR PAQUETERIA POR CONFUSIÓN TORNO FEMCO DURGA 25E ', N'', N'27/06/2023', N'PAGO DE PAQUETERÍA, POR CONFUSIÓN DE CONBELLO EN VENTA DE TORNO FEMCO ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T13:55:14.550' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2327, 1702307804, 4, 154, 103, NULL, 3, 297, N'INTERESES A DAVID GONZALEZ ', N'F-P', N'28/06/2023', N'', CAST(70000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:32:19.803' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2328, 1702307804, 3, 1196, 100, NULL, 3, 298, N'COMISIÓN MARIO PÉREZ POR VENTA DE MORI SEIKI', N'SR', N'28/06/2023', N'PAGO DE COMISIÓN POR VENTA DE MORI SEIKI A MARIO PEREZ 
', CAST(13000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:41:49.860' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2329, 1702307804, 2, 161, 100, NULL, 1, 299, N'PAGO DE TARJETA DE CRÉDITO SIN REFERENCIA', N'S-R', N'28/06/2023', N'SE LE ENTREGARON 22,500 DE LOS CUALES FUERON 20,000 PARA UNA TARJETA DE CRÉDITO DE ALLAN  Y DAVID SE QUEDÓ 2500 PARA SU CAMIONETA SIN REFERENCIA Y SIN ABONO A COMISIONES ', CAST(22500.00 AS Decimal(18, 2)), CAST(N'2023-07-21T14:04:28.577' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2330, 1702307804, 3, 152, 100, NULL, 3, 300, N'REPARACION DE SUPER VF 3 A HÉCTOR CARILLO  ', N'H-01', N'28/06/2023', N'SE LE ABONARON 40 MIL PESOS A CUENTA DE LA REPARACIÓN DE SUPER VF3', CAST(40000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:42:02.997' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2331, 1702307804, 2, 176, 100, NULL, 1, 301, N'PAGO A HERRERO PARA REPARACIÓN DE PORTÓN ', N'', N'28/06/2023', N'PAGO PARA REPARACIÓN DE PORTÓN ', CAST(1300.00 AS Decimal(18, 2)), CAST(N'2023-07-21T14:07:37.443' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2332, 1702307804, 2, 176, 100, NULL, 3, 302, N'RAFAEL CASTILLO PINTURA DE MAQUINARIA SIN REFERENCIA ', N'', N'28/06/2023', N'PAGO POR PINTURA DE MAQUINARIA SIN REFERENCIA ', CAST(600.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:42:26.650' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2333, 1702307804, 2, 1205, 100, NULL, 1, 303, N'INTERESES A SERRANO ', N'', N'28/06/2023', N'PAGO DE INTERESES A SERRANO', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:42:50.707' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2334, 1702307804, 2, 176, 100, NULL, 1, 304, N'PAGO DE SIAPA BODEGA', N'', N'28/06/2023', N'PAGO DE SERVICIOS DE AGUA POTABLE ', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2023-07-21T14:12:15.237' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2335, 1702307804, 2, 161, 100, NULL, 1, 305, N'GASTO PERSONAL ALLAN SIN REFERENCIA ', N'', N'28/06/2023', N'GASTO PERSONAL DE ALLAN SIN REFERENCIA ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-07-21T14:12:50.253' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2336, 1702307804, 3, 152, 100, NULL, 3, 306, N'PAGO A CUENTA DE REPARACION RECTIFICADORA CANARIO A BENITO', N'', N'28/06/2023', N'PAGO A CUENTA DE LA REPARACIÓN DE LA RECTIFICADORA CANARIO A BENITO', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:43:25.803' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2337, 1702307804, 2, 161, 100, NULL, 1, 307, N'GASTOS PERSONALES OSVALDO BARBA ', N'TC-0003', N'28/06/2023', N'TARJETA, INTERESES Y VUELTAS ', CAST(12200.00 AS Decimal(18, 2)), CAST(N'2023-07-24T09:54:23.143' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2338, 1702307804, 2, 176, 100, NULL, 1, 308, N'FIBRAS CHATO ', N'GB-0016', N'03/07/2023', N'DINERO QUE LE DI AL CHATO PARA FIBRAS ', CAST(100.00 AS Decimal(18, 2)), CAST(N'2023-09-27T12:55:44.887' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2339, 1702307804, 3, 1195, 100, NULL, 3, 309, N'CUENTA DE TRABAJO BENITO', N'TB-0006', N'03/07/2023', N'DINERO A CUENTA DE TRABAJO DE BENITO REAL', CAST(11200.00 AS Decimal(18, 2)), CAST(N'2023-09-28T06:52:51.647' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2340, 1702307804, 2, 1205, 100, NULL, 1, 310, N'INTERES CAYETANO ', N'', N'03/07/2023', N'PAGO DE DEUDA A CAYETANO ', CAST(24000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T06:59:29.997' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2341, 1702307804, 3, 1196, 100, NULL, 3, 311, N'COMISIÓN DE YADIRA', N'', N'03/07/2023', N'COMISIÓN DE VENTA A YADIRA ', CAST(13000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T06:59:39.987' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2342, 1702307804, 2, 161, 100, NULL, 1, 312, N'ING ANTONIO ', N'', N'03/07/2023', N'PAGO INGENIERO ANTONIO ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-07-26T10:07:19.047' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2343, 1702307804, 2, 176, 100, NULL, 1, 313, N'CUBETA ', N'', N'03/07/2023', N'COMPRA DE UNA CUBETA PARA ACEITE', CAST(300.00 AS Decimal(18, 2)), CAST(N'2023-09-27T12:57:21.100' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2344, 1702307804, 2, 161, 100, NULL, 1, 314, N'GASTO RZR PERSONAL ', N'', N'28/06/2023', N'PAGO PARA ARREGLAR RZR ', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2023-07-26T10:26:07.630' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2345, 1702307804, 2, 161, 100, NULL, 1, 315, N'DINERO PARA BETO ', N'', N'03/07/2023', N'DINERO QUE ALLAN ', CAST(6000.00 AS Decimal(18, 2)), CAST(N'2023-07-26T11:07:29.993' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2346, 1702307804, 2, 176, 100, NULL, 1, 316, N'CUBETA DE ACEITE', N'', N'03/07/2023', N'COMPRA DE CUBETA DE ACEITE RICARDO ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:42:23.593' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2347, 1702307804, 3, 1195, 100, NULL, 3, 317, N'TRABAJO BENITO ', N'', N'04/07/2023', N'SE LE DIÓ EFECTIVO A BENITO PARA REPARACIÓN/REFACCIONES', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:02:24.810' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2348, 1702307804, 2, 161, 100, NULL, 1, 318, N'COMIDA CHRIS', N'', N'04/07/2023', N'EFECTIVO PARA COMPRAR COMIDA PARA CHRIS', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-07-28T06:22:36.057' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2349, 1702307804, 2, 176, 100, NULL, 1, 319, N'CUBETAS PARA ACEITE ', N'', N'04/07/2023', N'DINERO PAA CUBETAS', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:47:29.377' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2350, 1702307804, 2, 1205, 100, NULL, 1, 320, N'INTERES DAVID GONZALEZ', N'', N'04/07/2023', N'GASTO DE DAVID GONZALEZ, INTERESES.', CAST(51000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:03:28.293' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2351, 1702307804, 2, 161, 100, NULL, 1, 321, N'GASTO PERSONAL ALLAN', N'', N'04/07/2023', N'GASTO PERSONAL A ALLAN GALVÁN', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T06:33:57.710' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2352, 1702307804, 2, 1205, 100, NULL, 1, 322, N'CAYETANO GASTO ', N'', N'04/07/2023', N'DINERO PARA INTERESES DE CAYETANO ', CAST(27000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:48:23.170' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2353, 1702307804, 2, 161, 100, NULL, 1, 323, N'GASTO LIVERPOOL ', N'', N'08/07/2023', N'GASTO DE PAGO DE TARJETA DE ALLAN ', CAST(7000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T07:01:23.640' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2354, 1702307804, 2, 161, 100, NULL, 1, 324, N'PRÉSTAMO ALLAN', N'', N'08/07/2023', N'GASTO DE EFECTIVO DE UN PRÉSTAMO DE ALLAN ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T07:02:45.430' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2355, 1702307804, 2, 176, 100, NULL, 1, 325, N'PAGO DE RENTA', N'', N'08/07/2023', N'RENTA DE BODEGA ', CAST(55000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T07:06:43.653' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2356, 1702307804, 2, 161, 100, NULL, 1, 326, N'GASTO PERSONAL DE ALLAN ', N'', N'08/07/2023', N'GASTO PERSONAL ALLAN ', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T07:11:12.707' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2357, 1702307804, 2, 161, 100, NULL, 1, 327, N'GASTO PERSONAL ALLAN', N'', N'08/07/2023', N'ELECTRA NOVA GASTO PERSONAL DE ALLAN ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-07-28T07:17:50.240' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2358, 1702307804, 2, 161, 100, NULL, 1, 328, N'GASTO PERSONAL ', N'', N'08/07/2023', N'PAGO DE UNA TARJETA DE ALLAN ', CAST(41600.00 AS Decimal(18, 2)), CAST(N'2023-07-28T07:20:15.197' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2359, 1702307804, 2, 161, 100, NULL, 1, 329, N'GASTO PERSONAL ALLAN', N'', N'10/07/2023', N'GASTO PERSONAL ALLAN COMIDA', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T07:20:56.397' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2360, 1702307804, 3, 1195, 100, NULL, 3, 330, N'TRABAJO BENITO', N'', N'10/07/2023', N'TRABAJO DE BENITO ', CAST(7000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:30:39.050' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2361, 1702307804, 2, 161, 100, NULL, 1, 331, N'COMIDA CHRIS', N'', N'10/07/2023', N'GASTO DE COMIDA PARA CHRIS', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-07-28T07:22:34.243' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2362, 1702307804, 2, 1205, 100, NULL, 1, 332, N'GASTO DE INTERESES', N'', N'10/07/2023', N'PAGO DE INTERESES DE ALLAN ', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:23:56.977' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2363, 1702307804, 2, 161, 100, NULL, 1, 333, N'GASTO ALLAN A CARRILLO ', N'', N'10/07/2023', N'PRESTAMO DE CORAZON A CARRILLO ', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T07:52:34.333' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2364, 1702307804, 2, 161, 100, NULL, 1, 334, N'GASTO DE PAGO DE TARJETA ', N'', N'10/07/2023', N'GASTO DE EFECTIVO PRA PAGO DE TARJETA ', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T08:07:39.023' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2365, 1702307804, 2, 161, 100, NULL, 1, 335, N'PRESTAMO DE ALLAN A HERMANO DE FREDDY', N'', N'10/07/2023', N'PRESTAMO PERSONAL DE ALLAN A HERMANO DE FREDDY ', CAST(13000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T08:09:19.090' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2366, 1702307804, 3, 1183, 100, NULL, 3, 336, N'COMISIÓN DAVID ', N'', N'10/07/2023', N'DINERO QUE DAVID AGARRÓ PARA SU CAMIONETA Y SE LE DESCONTÓ DE SUS COMISIONES ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:32:27.103' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2367, 1702307804, 2, 1230, 100, NULL, 1, 337, N'PAGO IMSS ', N'', N'17/07/2023', N'PAGO DE IMSS ', CAST(8300.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:37:34.860' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2368, 1702307804, 2, 176, 100, NULL, 1, 338, N'BASURA', N'', N'17/07/2023', N'DINERO PARA TIRAR LA BASURA DE LA BODGA', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-07-28T09:01:48.900' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2369, 1702307804, 2, 1205, 100, NULL, 1, 339, N'GASTO DAVID GONZALEZ', N'', N'17/07/2023', N'DINERO QUE SE LE DIÓ A DAVID GONZALEZ', CAST(40000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:37:48.957' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2370, 1702307804, 2, 161, 100, NULL, 1, 340, N'GASTO PERSONAL RZR', N'', N'17/07/2023', N'GASTO PERSONAL DEL RZR ALLAN ', CAST(12500.00 AS Decimal(18, 2)), CAST(N'2023-07-28T09:12:12.947' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2371, 1702307804, 2, 176, 100, NULL, 1, 341, N'TARIMAS ', N'', N'17/07/2023', N'gasto para tarimas ', CAST(800.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:43:51.630' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2372, 1702307804, 3, 1195, 100, NULL, 3, 342, N'TRABAJO BENITO ', N'', N'17/07/2023', N'DINERO PARA TRABAJO DE BENITO ', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:38:57.877' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2373, 1702307804, 2, 161, 100, NULL, 1, 343, N'GASTO PERSONAL MAMÁ DE ALLAN', N'', N'17/07/2023', N'DINERO QUE SE LE DIÓ A LA MAMÁ DE ALLAN POR ÓRDENES DE ALLAN ', CAST(3600.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:05:46.610' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2374, 1702307804, 2, 1222, 100, NULL, 1, 344, N'NOMINA MARIANA ', N'', N'17/07/2023', N'NOMINA DE MARIANA ', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:50:59.097' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2375, 1702307804, 3, 1196, 100, NULL, 3, 345, N'COMISIÓN MARIANA', N'', N'17/07/2023', N'RESTO DE LA COMISIÓN POR EL TORNO TOS', CAST(1200.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:39:16.923' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2376, 1702307804, 2, 161, 100, NULL, 1, 346, N'GASTO PERSONAL DE ALLAN ', N'', N'17/07/2023', N'GASTO PERSONAL DE UNOS TENIS DE ALLAN ', CAST(1800.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:18:20.453' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2377, 1702307804, 2, 176, 100, NULL, 1, 347, N'CARATULAS PARA MÁQUINAS HAAS', N'3500', N'17/07/2023', N'COMPRA DE CARATULAS PARA MAQUINARIA HAAS ', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:39:42.140' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2378, 1702307804, 2, 160, 100, NULL, 1, 348, N'SAT', N'', N'17/07/2023', N'PAGO DE IMPUESTOS', CAST(168.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:21:05.423' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2379, 1702307804, 3, 1195, 100, NULL, 3, 349, N'TRABAJO BENITO ', N'', N'18/07/2023', N'DINERO A CUENTA DE TRABAJO DE BENITO ', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:40:35.667' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2380, 1702307804, 3, 1196, 100, NULL, 3, 350, N'COMISIÓN RAMON OROS', N'', N'18/07/2023', N'COMISION A RAMON OROS', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:40:43.470' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2381, 1702307804, 3, 1196, 100, NULL, 3, 351, N'COMISIÓN A BARBOZA', N'', N'18/07/2023', N'COMISIÓN A FRANCISCO BARBOZA ', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:40:56.353' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2382, 1702307804, 2, 161, 100, NULL, 1, 352, N'GASTO PERSONAL DE ALLAN ', N'', N'18/07/2023', N'GASTO PERSONAL DE ALLAN G', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:26:44.177' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2383, 1702307804, 2, 161, 100, NULL, 1, 353, N'RIFA DE ALLAN ', N'', N'18/07/2023', N'RIFA DE ALLAN GALVAN ', CAST(6500.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:27:18.347' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2384, 1702307804, 2, 161, 100, NULL, 1, 354, N'SONIDO DE RZR ', N'', N'18/07/2023', N'GASTO DE SONIDO PARA RZR ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:28:01.760' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2385, 1702307804, 2, 1222, 100, NULL, 1, 355, N'NOMINA RICHARD', N'', N'18/07/2023', N'SE LE DIERON MIL MÁS PORQUE LE PRESTÓ A ALLAN ', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:51:34.793' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2386, 1702307804, 2, 1205, 100, NULL, 1, 356, N'GASTO DE INTERESES DAVID GONZÁLEZ', N'', N'18/07/2023', N'GASTO DE DE INTERESES A DAVID GONZALEZ ', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:41:18.323' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2387, 1702307804, 3, 1183, 100, NULL, 3, 357, N'COMISIÓN DAVID CRUZ', N'', N'15/07/2023', N'COMISIÓN POR VF-4 2019', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:34:05.273' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2388, 1702307804, 3, 1196, 100, NULL, 3, 358, N'COMISIÓN YADIRA ', N'', N'15/07/2023', N'COMISIÓN A YADIRA POR VENTA ', CAST(10500.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:34:18.073' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2389, 1702307804, 2, 161, 105, NULL, 1, 359, N'PRESTAMO ALLAN ', N'', N'15/07/2023', N'PAGO DE UN PRÉSTAMO QUE TIENE ALLAN CON BBVA QUE SE LE CARGA AUTOMÁTICAMENTE ', CAST(1700.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:36:50.637' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2390, 1702307804, 2, 161, 105, NULL, 1, 360, N'PAGO PRESTAMO DE ALLAN ', N'', N'15/07/2023', N'PAGO DE PRESTAMO PERSONAL DE ALLAN ', CAST(1700.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:42:09.530' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2391, 1702307804, 2, 161, 100, NULL, 1, 361, N'PAGO PRESTAMO PERSONAL ALLAN', N'', N'15/07/2023', N'PAGO DE PRESTAMO DE ALLAN QUE SE LE CARGA AUTOMÁTICAMENTE A SU CUENTA BBVA ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:37:14.273' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2392, 1702307804, 2, 161, 105, NULL, 1, 362, N'GASTO DE PAGO DE TARJETA ', N'', N'15/07/2023', N'GASTO DE PAGO DE AMERICAN EXPRESS CON LA CUENTA FISCAL DE ALLAN ', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:46:15.503' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2393, 1702307804, 2, 1205, 100, NULL, 1, 363, N'INTERESES DAVID GONZALEZ', N'', N'02/06/2023', N'PAGO DE INTERESES A DAVID GONZALEZ', CAST(120500.00 AS Decimal(18, 2)), CAST(N'2023-09-26T12:38:56.490' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2394, 1702307804, 2, 161, 100, NULL, 1, 364, N'DINERO PARA PRESTAMO ALTAGRACIA', N'', N'17/07/2023', N'DINERO PARA UN PRESTAMO DE ALLAN GALVÁN ', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-07-28T12:48:18.160' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2395, 1702307804, 4, 154, 103, NULL, 3, 365, N'PAGO PRESTAMO ASPIRIA', N'', N'11/09/2023', N'PAGO DE PRESTAMO A ASPIRIA', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-11T10:58:37.520' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2396, 1702307804, 2, 1205, 100, NULL, 1, 366, N'INTERESES OSVALDO', N'', N'03/06/2023', N'PAGO DE INTERESES OSVALDO', CAST(17000.00 AS Decimal(18, 2)), CAST(N'2023-09-26T13:08:55.843' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2397, 1702307804, 2, 161, 100, NULL, 1, 367, N'INTERESES CAYETANO', N'', N'05/06/2023', N'PAGO DE INTERESES A CAYETANO', CAST(11000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:02:35.680' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2398, 1702307804, 2, 1222, 100, NULL, 1, 368, N'NOMINA MARTIN ', N'', N'21/07/2023', N'DINERO QUE SE LE ADELANTÓ A MARTIN ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:48:32.977' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2399, 1702307804, 2, 1205, 105, NULL, 1, 369, N'PAGO DE INTERESES A HERMANO BETO', N'', N'22/05/2023', N'PAGO DE INTERESES A HERMANO BETO ', CAST(6500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T11:43:26.040' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2400, 1702307804, 2, 1205, 100, NULL, 1, 370, N'PAGO A SERRANO DE INTERESES', N'', N'25/05/2023', N'PAGO DE INTERESES A SERRANO', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:44:35.403' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2401, 1702307804, 2, 176, 100, NULL, 1, 371, N'TARIMAS RICHARD', N'', N'21/07/2023', N'DINERO PARA TARIMAS DE SIERRA CINTA ', CAST(300.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:50:06.843' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2402, 1702307804, 2, 1221, 100, NULL, 1, 372, N'FLETE Y MANIOBRAS MACACO', N'', N'21/07/2023', N'FLETE Y MANIOBRAS MACACO SIERRA-CINTA ', CAST(9000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T07:46:19.563' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2403, 1702307804, 2, 1205, 100, NULL, 1, 373, N'INTERESES HERMANO DE BETO', N'IN-0004', N'26/06/2023', N'PAGO DE INTERESES A HERMANOS DE BETO', CAST(3600.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:35:06.963' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2404, 1702307804, 2, 176, 100, NULL, 1, 374, N'LIJAS Y FIBRAS', N'', N'21/07/2023', N'LIJAS Y FIBRAS PARA EL CHATO', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:57:32.050' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2405, 1702307804, 2, 176, 100, NULL, 1, 375, N'TRAPOS ', N'', N'21/07/2023', N'TRAPOS ', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:57:56.410' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2406, 1702307804, 2, 1205, 100, NULL, 1, 376, N'INTERESES DOÑA BERTHA', N'IN-0002', N'26/06/2023', N'PAGO DE INTERESES A DOÑA BERTHA', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:40:41.547' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2407, 1702307804, 2, 1205, 100, NULL, 1, 377, N'INTERESES A DAVID GONZALEZ', N'F-P', N'28/06/2023', N'PAGO DE INTERESES A DAVID GONZALEZ', CAST(70000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T10:43:44.557' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2408, 1702307804, 2, 176, 100, NULL, 1, 378, N'CARATULAS ', N'', N'21/07/2023', N'CARATULAS SEGUNDO PAGO ', CAST(3700.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:58:29.717' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2409, 1702307804, 4, 154, 100, NULL, 3, 379, N'PAGO PARA CUCO', N'DP-0005', N'02/08/2023', N'SE LE DIÓ DINERO AL PAPÁ DE ALLAN PARA PAGARLE A CUCO', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-08-02T13:33:05.217' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2410, 1702307804, 2, 161, 105, NULL, 1, 380, N'GASTO BOTELLA', N'F-', N'21/07/2023', N'PAGO DE BOTELLA EN EL VIAJE DEL 17 AL 21 DE JULIO', CAST(370.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:47:01.140' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2411, 1702307804, 2, 161, 105, NULL, 1, 381, N'GASTO DE CAFE', N'F-', N'21/07/2023', N'GASTO POR CAFE EN EL VIAJE DEL 17 AL 21 DE JULIO', CAST(85.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:47:51.483' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2412, 1702307804, 2, 161, 105, NULL, 1, 382, N'GASTO EN BURGER KING', N'F-', N'21/07/2023', N'GASTO POR PAGO EN BURGER KING EN EL VIAJE DEL 17 AL 21 DE JULIO', CAST(348.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:50:35.197' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2413, 1702307804, 2, 161, 105, NULL, 1, 383, N'GASTO POR PROPINAS', N'F-', N'21/07/2023', N'GASTO DE PROPINAS EN EL VIAJE DEL 17 AL 21 DE JULIO', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-07-28T13:58:26.187' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2414, 1702307804, 2, 161, 105, NULL, 1, 384, N'GASTO DE CAFE', N'F-', N'21/07/2023', N'GASTO DE CAFE EN EL VIAJE DEL 17 AL 21 DE JULIO', CAST(167.00 AS Decimal(18, 2)), CAST(N'2023-07-28T14:02:32.250' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2415, 1702307804, 5, 1224, 103, NULL, 3, 385, N'NUEVO PRESTAMO DAVID GONZALEZ ', N'P-003', N'04/08/2023', N'SOLICITO UN NUEVO PRESTAMOS JUSTO ANTES DE IR A ESTADOS UNIDOS PARA COMPRA DE MERCANCIA ', CAST(901000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:04:32.847' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2416, 1702307804, 2, 161, 105, NULL, 1, 386, N'GASTO DE SEGURO', N'F-', N'21/07/2023', N'GASTO POR PAGO DE SEGURO EN EL VIAJE DEL 17 AL 21 DE JULIO', CAST(945.00 AS Decimal(18, 2)), CAST(N'2023-07-28T14:03:14.270' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2417, 1702307804, 2, 161, 105, NULL, 1, 387, N'GASTO PERSONAL', N'F-', N'21/07/2023', N'GASTO PERSONAL ALLAN EN EL VIAJE DEL 17 AL 21 DE JULIO', CAST(300.00 AS Decimal(18, 2)), CAST(N'2023-07-28T14:04:17.143' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2418, 1702307804, 2, 161, 105, NULL, 1, 388, N'GASTO POR ESTACIONAMIENTO BMW', N'F-', N'21/07/2023', N'GASTO POR PAGO DE ESTACIONAMIENTO BMW', CAST(1200.00 AS Decimal(18, 2)), CAST(N'2023-07-28T14:05:05.287' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2419, 1702307804, 2, 161, 105, NULL, 1, 389, N'GASTO TACO BELL', N'F-', N'21/07/2023', N'GASTO POR TACO BELL EN EL VIAJE DEL 17 AL 21 DE JULIO', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-07-28T14:06:43.790' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2420, 1702307804, 2, 161, 105, NULL, 1, 390, N'GASTO WALMART ', N'', N'21/07/2023', N'COMPRA DE COSAS PARA ALLAN GALVAN ', CAST(4700.00 AS Decimal(18, 2)), CAST(N'2023-07-31T10:07:20.593' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2421, 1702307804, 2, 161, 105, NULL, 1, 391, N'GASTO GASOLINA', N'', N'21/07/2023', N'COMPRO GASOLINA ALLAN ', CAST(175.00 AS Decimal(18, 2)), CAST(N'2023-07-31T10:07:30.573' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2422, 1702307804, 2, 161, 105, NULL, 1, 392, N'GASTO KFC COMIDA', N'', N'21/07/2023', N'COMPRA DE COMIDA ALLAN GALVAN ', CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-07-31T10:07:41.607' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2423, 1702307804, 2, 161, 105, NULL, 1, 393, N'GASTO PERSONAL ALLAN ROPA ', N'', N'21/07/2023', N'COMPRA DE ROPA, ZAPATOS, PLAYERAS DE ALLAN EN TOTAL ', CAST(162721.00 AS Decimal(18, 2)), CAST(N'2023-07-31T10:06:14.427' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2424, 1702307804, 2, 161, 105, NULL, 1, 394, N'GASTO TERMO ', N'', N'21/07/2023', N'SE COMPRÓ UN TERMO ', CAST(625.00 AS Decimal(18, 2)), CAST(N'2023-07-31T10:07:53.577' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2425, 1702307804, 2, 161, 105, NULL, 1, 395, N'GASTO PARQUE DE DIVERISIONES ', N'', N'21/07/2023', N'GASTO DE PARQUE DE DIVERSIONES CON CHRIS ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-07-31T10:08:41.417' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2426, 1702307804, 2, 161, 105, NULL, 1, 396, N'GASTO DE CONSUVINO ', N'', N'21/07/2023', N'GASTO DE CONSUVINO ', CAST(370.00 AS Decimal(18, 2)), CAST(N'2023-08-02T05:28:25.563' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2427, 1702307804, 2, 161, 105, NULL, 1, 397, N'GASTO DE PARQUE DE DIVERSIONES ', N'', N'21/07/2023', N'LOCKER DE PARQUE DE DIVERSIONES ESTADOS UNIDOS ', CAST(252.00 AS Decimal(18, 2)), CAST(N'2023-08-02T05:28:29.027' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2428, 1702307804, 2, 161, 105, NULL, 1, 398, N'GASTO DE PARQUE DE DIVERSIONES ', N'', N'21/07/2023', N'PAGO DE PARQUE ', CAST(5800.00 AS Decimal(18, 2)), CAST(N'2023-08-02T05:28:32.850' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2429, 1702307804, 2, 161, 105, NULL, 1, 399, N'GASTO PERSONAL ', N'', N'21/07/2023', N'GASTO PERSONAL DE ALLAN ', CAST(842.00 AS Decimal(18, 2)), CAST(N'2023-08-02T05:28:35.277' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2430, 1702307804, 2, 161, 105, NULL, 1, 400, N'GASTO PERSONAL DE ALLAN ', N'', N'21/07/2023', N'GASTO PERSONAL DE ALLAN GALVÁN ', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-08-02T05:28:38.173' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2431, 1702307804, 2, 161, 105, NULL, 1, 401, N'GASTO DE LIVERPOOL ', N'', N'21/07/2023', N'GASTO DE PAGO DE TARJETA LIVERPOOL ', CAST(600.00 AS Decimal(18, 2)), CAST(N'2023-08-02T05:28:40.673' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2432, 1702307804, 2, 161, 105, NULL, 1, 402, N'GASTO DE PAGO EDSON GOLDEN ', N'', N'21/07/2023', N'PAGO QUE REALIZÓ ALLAN GALVÁN ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-08-02T05:28:43.463' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2433, 1702307804, 2, 161, 105, NULL, 1, 403, N'GASTO DE PRESTAMO DE BANCO', N'', N'21/07/2023', N'PAGO DE PRESTAMOS ', CAST(2400.00 AS Decimal(18, 2)), CAST(N'2023-08-02T05:28:45.987' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2434, 1702307804, 2, 176, 100, NULL, 1, 404, N'COMPRA DE ACEITE ', N'', N'24/07/2023', N'COMPRA DE ACEITE PARA MÁQUINA ', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:19:50.920' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2435, 1702307804, 2, 161, 100, NULL, 1, 405, N'GASTO COMIDA DE CHRIS ', N'', N'24/07/2023', N'SE LE COMPRÓ COMIDA Y CENA ESE DÍA A CHRIS,', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-08-02T08:06:14.557' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2436, 1702307804, 2, 161, 100, NULL, 1, 406, N'GASTO PERSONAL ALLAN', N'', N'25/07/2023', N'GASTO PERSONAL ALLAN GALVÁN ', CAST(1800.00 AS Decimal(18, 2)), CAST(N'2023-08-02T11:55:15.540' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2437, 1702307804, 3, 1195, 100, NULL, 3, 407, N'TRABAJO BENITO', N'', N'25/07/2023', N'GASTO DE REPARACIÓN BENITO ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T08:10:05.860' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2438, 1702307804, 3, 1183, 100, NULL, 3, 408, N'COMISIÓN DAVID ', N'', N'25/07/2023', N'PARTE DE COMISÓN DE DAVUD ', CAST(1600.00 AS Decimal(18, 2)), CAST(N'2023-09-28T08:10:15.937' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2439, 1702307804, 4, 154, 103, NULL, 1, 409, N'PAGO DE ADEUDO A CUCO', N'', N'19/06/2023', N'PAGO DEL ADEUDO TOTAL A CUCO', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-08-02T13:34:49.053' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2440, 1702307804, 2, 1221, 106, NULL, 1, 410, N'MACACO ', N'', N'26/07/2023', N'pago en retiros sin tarjeta ', CAST(13000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T08:10:37.763' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2441, 1702307804, 2, 1221, 106, NULL, 1, 411, N'CARRIZO', N'', N'26/07/2023', N'RETIRO SIN TARJETA ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T08:11:01.187' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2442, 1702307804, 3, 1195, 106, NULL, 3, 412, N'TRABAJO BENITO ', N'', N'26/07/2023', N'DINERO DE TRABAJO PARA BENITO ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T08:11:13.453' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2443, 1702307804, 2, 161, 106, NULL, 1, 413, N'GASTOS DE COLIMA ', N'', N'28/07/2023', N'SE SACARON EN EFECTIVO PARA CUBRIR GASTOS DE COLIMA', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-08-03T09:34:01.900' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2444, 1702307804, 2, 161, 106, NULL, 1, 414, N'GASTO RIFA ALLAN', N'', N'28/07/2023', N'PAGO DE UNA RIFA DE ALLAN GALVÁN, SE RETIRÓ EN EFECTIVO Y SE LLEVÓ ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-08-03T09:34:52.023' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2445, 1702307804, 2, 1205, 106, NULL, 1, 415, N'GASTO INTERES SERRANO', N'', N'28/07/2023', N'RETIRO DE TARJETA DE 20,000 PARA PAGO DE INTERESES DE 17,500 Y SE QUEDÓ CON 2,500 DAVID', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T08:11:57.560' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2446, 1702307804, 2, 161, 106, NULL, 1, 416, N'GASTO BOTELLAS ', N'', N'28/07/2023', N'gasto de dos veces que fueron a comprar botellas ', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2023-08-03T12:49:28.473' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2447, 1702307804, 2, 161, 106, NULL, 1, 417, N'GASTO TARJETA DE CRÉDITO ALLAN ', N'', N'28/07/2023', N'GASTO DE TARJETA DE CRÉDITO ALLAN ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-08-03T13:36:18.680' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2448, 1702307804, 2, 161, 1109, NULL, 1, 418, N'GASTO TARJETA DE CRÉDITO', N'', N'28/07/2023', N'GASTO DE TARJETA DE CRÉDITO INVEX', CAST(580.00 AS Decimal(18, 2)), CAST(N'2023-08-03T13:41:02.933' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2449, 1702307804, 4, 154, 103, NULL, 1, 419, N'PAGO TOTAL DE PRESTAMO ', N'', N'20/07/2023', N'PAGO QUE REALIZÓ ALLAN EN DOLARES, CANTIDAD TOTAL EXPUESTA EN LA APP ES EN PESOS MEXICANOS.', CAST(120000.00 AS Decimal(18, 2)), CAST(N'2023-08-04T08:05:26.133' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2450, 1702307804, 4, 154, 103, NULL, 1, 420, N'PAGO FLETE MONTES ', N'', N'04/05/2023', N'', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-08-04T08:15:49.170' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2451, 1702307804, 4, 154, 103, NULL, 1, 421, N'PAGO DE PRÉSTAMO MIGUEL', N'', N'20/07/2023', N'PAGO DE PRESTAMO DE MIGUEL USA, CONVERTIDO A PESOS MEXICANOS LA DEUDA EN LA APP', CAST(130000.00 AS Decimal(18, 2)), CAST(N'2023-08-04T08:18:16.263' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2452, 1702307804, 2, 161, 1109, NULL, 1, 422, N'GASTO TARJETA AMERICAN EXPRESS', N'', N'27/07/2023', N'PAGO DE TARJETA DE ALLAN ', CAST(19371.00 AS Decimal(18, 2)), CAST(N'2023-08-04T08:28:17.830' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2453, 1702307804, 2, 161, 1109, NULL, 1, 423, N'GASTO PAGO DE TARJETA AMERICAN EXPRESS', N'', N'27/07/2023', N'PAGO DE LA TARJETA AMERICAN EXPRESS DE ALTAGRACIA ', CAST(20575.00 AS Decimal(18, 2)), CAST(N'2023-08-04T08:30:18.680' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2454, 1702307804, 3, 167, 1109, NULL, 3, 424, N'REPARACIÓN DE MONTACARGAS', N'', N'31/07/2023', N'GASTOS DE MAQUINARIA. REPARACIÓN DE MONTACARGAS', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T08:13:13.580' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2455, 1702307804, 2, 176, 1109, NULL, 1, 425, N'PAGO SIAPA', N'', N'31/07/2023', N'PAGO DEL RECIBO DEL AGUA ', CAST(5114.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:24:00.650' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2456, 1702307804, 2, 1222, 1109, NULL, 1, 426, N'NOMINAS', N'', N'31/07/2023', N'', CAST(6000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:49:57.127' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2457, 1702307804, 3, 1183, 1109, NULL, 3, 427, N'PAGO DE COMISIÓN ', N'', N'31/07/2023', N'DINERO QUE SE LE PRESTÓ A DAVID, A CUENTA DE SU COMISIÓN ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T08:13:27.737' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2458, 1702307804, 2, 176, 100, NULL, 1, 428, N'PINTURA RAFA CASTILLO ', N'', N'31/07/2023', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:25:23.053' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2459, 1702307804, 2, 161, 100, NULL, 1, 429, N'GASTO DE RZR ALLAN', N'', N'31/07/2023', N'GASTO DE SONIDO DE RZR ', CAST(35000.00 AS Decimal(18, 2)), CAST(N'2023-08-04T09:21:59.583' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2460, 1702307804, 2, 161, 100, NULL, 1, 430, N'COMIDA CHRIS', N'', N'31/07/2023', N'GASTO DE COMIDA CHRIS ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-08-04T09:22:32.020' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2461, 1702307804, 2, 1221, 100, NULL, 1, 431, N'PAGO DE MANIOBRAS MACACO', N'', N'31/07/2023', N'PAGO DE MANIOBRAS MACACO', CAST(13000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T08:14:19.393' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2462, 1702307804, 3, 1181, 100, NULL, 3, 432, N'PAGO DE TRANSPORTE CARGA 2', N'', N'31/07/2023', N'FUERON 40,000 ALLAN DIJO QUE SE LE DIERAN 2,000 DE PROPINA ', CAST(42000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T08:14:57.713' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2463, 1702307804, 2, 176, 100, NULL, 1, 433, N'TRABAJO BENITO ', N'A-00009', N'01/08/2023', N'COMPRA DE CABLE Y RECTIFICADOR DE CORRIENTE Y TERMINALES', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:04:43.800' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2464, 1702307804, 2, 176, 100, NULL, 1, 434, N'FIBRAS Y GUANTES', N'', N'01/08/2023', N'COMPRA DE MATERIAL PARA TRABAJAR ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:04:56.050' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2465, 1702307804, 3, 1183, 100, NULL, 3, 435, N'COMISIÓN DAVID ', N'', N'02/08/2023', N'DINERO QUE TOMÓ RICARDO PARA IR AL HOSPITAL A VISITAR A SU HERMANO, ALLAN PIDIÓ QUE SE DESCONTARA DE LAS COMISIONES DE DAVID ', CAST(600.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:06:14.790' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2466, 1702307804, 2, 176, 100, NULL, 1, 436, N'COMPRA DE SOPORTES ', N'', N'03/08/2023', N'COMPRA QUE REALIZÓ MARIO PEREZ PARA COMPRAR 6 SOPORTES PARA MAQUINARIA HAAS', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:08:02.950' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2467, 1702307804, 2, 176, 100, NULL, 1, 437, N'BROCHAS', N'', N'03/08/2023', N'COMPRA DE BROCHAS PARA TRABAJO ', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:42:57.200' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2468, 1702307804, 3, 1195, 100, NULL, 3, 438, N'TRABAJO BENITO', N'A-00009', N'03/08/2023', N'COMPRA DE TORNILLOS Y PIEDRAS DE ESMERIL PARA TORNO RUSO', CAST(300.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:08:37.290' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2469, 1702307804, 2, 176, 100, NULL, 1, 439, N'COMPRA DE DESENGRASANTE ', N'', N'03/08/2023', N'COMPRA DE DESENGRASANTE PARA MAQUINARIA ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:44:16.187' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2470, 1702307804, 2, 176, 100, NULL, 1, 440, N'COMPRA DE CARETA ', N'', N'03/08/2023', N'COMPRA DE CARETA PARA USO DE SOLDADORA PARA REPARACIÓN DE PIEZAS DE MAQUINARIA ', CAST(300.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:46:14.873' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2471, 1702307804, 1, 1199, 102, NULL, 1, 441, N'TARJETA PROCESO GUILLERMO LIMÓN ', N'', N'04/08/2023', N'DEUDA DE TARJETA PROCESO CON ALLAN ', CAST(81200.00 AS Decimal(18, 2)), CAST(N'2023-09-29T08:50:13.313' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2472, 1702307804, 4, 179, 103, NULL, 3, 442, N'PAGO ASPIRIA ', N'', N'04/08/2023', N'', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-08-04T10:35:28.410' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2473, 1702307804, 1, 172, 105, NULL, 3, 443, N'VENTA DE SIERRA-CINTA DOALL', N'', N'13/07/2023', N'VENTA DE SIERRA CINTA DOALL', CAST(116000.00 AS Decimal(18, 2)), CAST(N'2023-09-29T10:41:02.990' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2474, 1702307804, 2, 161, 100, NULL, 1, 444, N'GASTO PERSONAL DE ALLAN', N'', N'04/08/2023', N'GASTO DE ANTICIPO NUEVO DEPA ALLAN ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-08-04T12:54:23.507' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2475, 1702307804, 2, 161, 100, NULL, 1, 445, N'GASTO PERSONAL DE ALLAN - RIFA ', N'', N'04/08/2023', N'GASTO DE RIFA ALLAN GALVÁN ', CAST(6000.00 AS Decimal(18, 2)), CAST(N'2023-08-04T12:55:10.700' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2476, 1702307804, 3, 1181, 100, NULL, 3, 446, N'FLETE TIJUANA-GDL', N'', N'04/08/2023', N'PAGO DE FLETE TIJUANA A GDL ', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:26:08.910' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2477, 1702307804, 2, 176, 100, NULL, 1, 447, N'COMPRA DE MATERIAL PARA TRABAJAR', N'', N'04/08/2023', N'COMPRA DE MATERIAL PARA LIMPIEZA DE MAQUINARIA ', CAST(100.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:50:32.213' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2478, 1702307804, 3, 162, 100, NULL, 3, 448, N'FLETE SAN EMETERIO Y HERMOSILLO ', N'', N'04/08/2023', N'FLETE Y MORDIDAS DE ALLAN ', CAST(18000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:27:17.550' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2479, 1702307804, 4, 154, 102, NULL, 3, 449, N'ABONO TORNO CNC ', N'F-197', N'04/08/2023', N'', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-08-04T13:17:22.727' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2480, 1702307804, 2, 161, 100, NULL, 1, 450, N'GASTO PERSONAL CELULAR ALLAN', N'', N'04/08/2023', N'PAGO DE CELULAR ALLAN GALVÁN ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-08-04T13:33:18.850' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2481, 1702307804, 3, 155, 100, NULL, 3, 451, N'   DINERO RAFA CASTILLO', N'  A-00004', N'04/08/2023', N'pintura de SL-20 mano de obra ', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:30:17.243' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2482, 1702307804, 3, 155, 100, NULL, 3, 452, N'DINERO RAFA CASTILLO ', N'A-00003', N'04/08/2023', N'DINERO MANO DE OBRA DE CENTRO DE MAQUINADO VF-4 DOBLE PALLET', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:33:57.887' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2483, 1702307804, 2, 1222, 100, NULL, 1, 453, N'NOMINAS', N'', N'04/08/2023', N'PAGO DE NOMINAS ', CAST(12700.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:53:14.530' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2484, 1702307804, 2, 1191, 102, NULL, 1, 454, N'PRESTAMO A RICARDO ', N'', N'04/08/2023', N'SE LE PRESTÓ A RICARDO EFECTIVO ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-08-07T12:54:04.030' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2485, 1702307804, 2, 161, 100, NULL, 1, 455, N'GASTO PERSONAL ALLAN', N'', N'04/08/2023', N'REGALO DE CUMPLEAÑOS MARIANA ', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-08-07T13:13:42.180' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2486, 1702307804, 2, 176, 100, NULL, 1, 456, N'COMPRA FIBRAS', N'', N'04/08/2023', N'GASTO DE COMPRA DE FIBRAS', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:51:47.093' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2487, 1702307804, 3, 1195, 100, NULL, 3, 457, N'PAGO DE TRABAJO BENITO', N'A-00009', N'04/08/2023', N'GASTO DE TRABAJO BENITO TORNO RUSO', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T12:52:38.377' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2488, 1702307804, 2, 1205, 100, NULL, 1, 458, N'GASTO PAGO DE INTERESES', N'', N'04/08/2023', N'PAGO DE INTERESES DE ALLAN A SUSANA', CAST(7000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:52:18.197' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2489, 1702307804, 2, 1209, 100, NULL, 1, 459, N'GASTO VIÁTICOS ', N'', N'04/08/2023', N'REPARACIÓN TORNO ROMI ', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:44:05.173' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2490, 1702307804, 2, 176, 100, NULL, 1, 460, N'GASTO RECOLECTORA DE BASURA', N'', N'04/08/2023', N'GASTOS DE BODEGA RECOLECTORA DE BASURA', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-08-08T11:07:23.390' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2491, 1702307804, 2, 176, 100, NULL, 1, 461, N'GASTO DE BODEGA TRAPEADOR ', N'', N'08/08/2023', N'SE COMPRÓ UN TRAPEADOR ', CAST(100.00 AS Decimal(18, 2)), CAST(N'2023-08-08T12:48:51.953' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2492, 1702307804, 1, 165, 102, NULL, 1, 462, N'VENTA CENTRO DE MAQUINADO FADAL', N'F-117', N'07/08/2023', N'SE VENDIÓ CENTRO DE MAQUINADO MARCA FADAL ', CAST(375000.00 AS Decimal(18, 2)), CAST(N'2023-08-08T12:51:32.017' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2493, 1702307804, 4, 154, 102, NULL, 1, 463, N'PAGO DE CENTRO DE MAQUINADO FADAL 4020', N'F-117', N'07/08/2023', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-08-08T12:52:20.880' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2494, 1702307804, 4, 179, 102, NULL, 1, 464, N'PAGO DE CENTRO DE MAQUINADO', N'F-117', N'07/08/2023', N'CENTRO DE MAQUINADO FADAL 4020 CON FACTURA MÁS IVA 32000', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2023-08-08T13:10:07.773' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2495, 1702307804, 2, 1225, 100, NULL, 1, 465, N'MANIOBRAS', N'', N'07/08/2023', N'MANIOBRAS ', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:46:40.610' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2496, 1702307804, 2, 1221, 100, NULL, 1, 466, N'FLETE PROPINA ', N'', N'07/08/2023', N'PROPINAS', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:47:35.520' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2497, 1702307804, 2, 161, 100, NULL, 1, 467, N'GASTO PERSONAL ALLAN', N'', N'08/08/2023', N'GASTO PERSONAL DE ALLAN', CAST(650.00 AS Decimal(18, 2)), CAST(N'2023-08-08T13:13:56.793' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2498, 1702307804, 2, 176, 100, NULL, 1, 468, N'GASTO DE BODEGA ', N'', N'08/08/2023', N'CENA PARA LOS TRABAJADORES', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-08-08T13:14:39.127' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2499, 1702307804, 2, 161, 100, NULL, 1, 469, N'GASTO DE INTERESES BETO', N'', N'08/08/2023', N'GASTO DE INTERESES BETO', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-08-08T13:15:20.870' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2500, 1702307804, 2, 161, 100, NULL, 1, 470, N'GASTO DE PAGO DE TARJETA ', N'', N'08/08/2023', N'PAGO DE TARJETA HSBC ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-08-08T13:15:59.293' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2501, 1702307804, 2, 176, 100, NULL, 1, 471, N'COMPRA DE FIBRAS', N'', N'08/08/2023', N'SE COMPRÓ CENA ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:11:03.850' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2502, 1702307804, 2, 161, 100, NULL, 1, 472, N'GASTO PERSONAL DE ALLAN ', N'', N'08/08/2023', N'GASTO PERSONAL ALLAN ', CAST(1700.00 AS Decimal(18, 2)), CAST(N'2023-08-08T13:33:18.420' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2503, 1702307804, 2, 161, 105, NULL, 1, 473, N'GASTO DE PAGO DE TARJETA INBURSA', N'', N'08/08/2023', N'SE PAGÓ LA TARJETA DE INBURSA ALLAN GALVÁN ', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-08-09T06:30:38.320' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2504, 1702307804, 2, 161, 105, NULL, 1, 474, N'GASTO DE REPARACIÓN CELULAR ALLAN', N'', N'08/08/2023', N'SE ROMPIÓ SU CELULAR Y LO LLEVÓ A REPARAR', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-08-09T06:38:56.280' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2505, 1702307804, 2, 161, 105, NULL, 1, 475, N'GASTO PAGO DE TARJETA HSBC', N'', N'08/08/2023', N'SE PAGÓ LA TARJETA HSBC ', CAST(6000.00 AS Decimal(18, 2)), CAST(N'2023-08-09T06:50:47.410' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2506, 1702307804, 2, 161, 105, NULL, 1, 476, N'GASTO DE PAGO DE CELULAR ALLAN ', N'', N'08/08/2023', N'ALLAN PAGÓ SU CELULAR ', CAST(1694.00 AS Decimal(18, 2)), CAST(N'2023-08-09T07:02:20.560' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2507, 1702307804, 2, 161, 100, NULL, 1, 477, N'GASTO DE DEPA ALLAN ', N'', N'08/08/2023', N'GASTO DE INVESTIGACIÓN PARA LA AUTORIZACIÓN DEL DEPA DE ALLAN', CAST(1160.00 AS Decimal(18, 2)), CAST(N'2023-08-09T07:31:57.773' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2508, 1702307804, 2, 161, 100, NULL, 1, 478, N'GASTO DE BOTELLA', N'', N'08/08/2023', N'GASTO DE BOTELLA ', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-08-09T07:34:38.100' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2509, 1702307804, 2, 161, 105, NULL, 1, 479, N'GASTO PERSONAL GAS ', N'', N'08/08/2023', N'GASTO E GAS TACOMA DE ALLAN', CAST(1320.00 AS Decimal(18, 2)), CAST(N'2023-08-09T07:59:31.330' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2510, 1702307804, 2, 161, 105, NULL, 1, 480, N'GASTO BOTELLA ', N'', N'08/08/2023', N'COMPRA DE BOTELLA ', CAST(979.00 AS Decimal(18, 2)), CAST(N'2023-08-09T08:11:20.993' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2511, 1702307804, 2, 161, 105, NULL, 1, 481, N'GASTO PERSONAL DE ALLAN ', N'', N'08/08/2023', N'GASTO PERSONAL DE ALLAN ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-08-09T08:13:49.787' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2512, 1702307804, 2, 161, 105, NULL, 1, 482, N'GASTO DE RENTA SAN LORENZO', N'', N'08/08/2023', N'PAGO DE RENTA SAN LORENZO', CAST(20766.00 AS Decimal(18, 2)), CAST(N'2023-08-09T08:18:47.587' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2513, 1702307804, 2, 1222, 105, NULL, 1, 483, N'NOMINA MARTÍN ', N'', N'08/08/2023', N'NOMINA DE MARTÍN ', CAST(2316.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:53:52.127' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2514, 1702307804, 3, 1181, 105, NULL, 3, 484, N'FLETE TIJUANA ', N'', N'08/08/2023', N'FLETE DE TIJUANA ', CAST(23200.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:48:30.300' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2515, 1702307804, 2, 161, 105, NULL, 1, 485, N'GASTO PERSONAL ALLAN ', N'', N'08/08/2023', N'GASTO PERSONAL DE EL CUERNO ALLAN ', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2023-08-09T09:54:14.770' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2516, 1702307804, 2, 1201, 105, NULL, 1, 486, N'NOMINA RUBEN ', N'', N'09/08/2023', N'NOMINA HERMANO DE ALLAN JULIO Y AGOSTO ', CAST(6222.00 AS Decimal(18, 2)), CAST(N'2023-08-09T12:22:17.140' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2517, 1702307804, 1, 165, 102, NULL, 1, 487, N' VENTA DE CENTRO DE MAQUINADO VF3 DOBLE PALLET', N'NO. SERIE 28794', N'28/07/2023', N'VENTA DE CENTRO DE MAQUINADO DOBLE PALLET', CAST(725000.00 AS Decimal(18, 2)), CAST(N'2023-09-29T10:21:57.923' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2518, 1702307804, 4, 180, 102, NULL, 1, 488, N'PAGO DE CENTRO DE MAQUINADO VF3 DOBLE PALLET', N'NO. SERIE 28794', N'01/08/2023', N'PRIMER PAGO DE VF3 ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-08-10T06:59:17.000' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2519, 1702307804, 4, 154, 102, NULL, 1, 489, N'SEGUNDO PAGO DE VF3 DOBLE PALLET', N'NO. SERIE 28794', N'09/08/2023', N'SEGUNDO PAGO DE VF3, TRANSFERENCIA Y SACADO EN EFECTIVO', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-08-10T07:01:50.697' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2520, 1702307804, 4, 179, 102, NULL, 1, 490, N'PRIMER PAGO DE TARJETA PROCESO ', N'F-119', N'08/08/2023', N'PAGO A CUENTA FISCAL ALLAN ', CAST(40000.00 AS Decimal(18, 2)), CAST(N'2023-08-10T07:10:39.863' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2521, 1702307804, 2, 161, 100, NULL, 1, 491, N'PAGO DE TARJETA LIVERPOOL ', N'', N'09/08/2023', N'PAGO DE TARJETA ', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-08-10T13:17:09.920' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2522, 1702307804, 3, 1183, 100, NULL, 3, 492, N'COMISIÓN DAVID CRUZ', N'', N'10/08/2023', N'PAGO DE DOS COMISIONES ', CAST(19000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:00:14.703' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2523, 1702307804, 2, 176, 100, NULL, 1, 493, N'HONORARIOS FREDDY ', N'', N'09/08/2023', N'PAGO DE HONORARIOS DE 1 MES A FREDDY EN EFECTIVO Y 500 DE UN DOCUMENTO A SU MAMÁ ', CAST(15500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:18:32.790' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2524, 1702307804, 2, 176, 100, NULL, 1, 494, N'CARDAS LIJAS Y GAS MOTO', N'', N'10/08/2023', N'SE COMPRARON PARA TRABAJAR ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:24:54.803' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2525, 1702307804, 2, 176, 100, NULL, 1, 495, N'DESENGRASANTE ', N'', N'10/08/2023', N'', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:25:13.007' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2526, 1702307804, 3, 1195, 100, NULL, 3, 496, N'TRABAJO BENITO', N'A-00009', N'09/08/2023', N'SE LE DIÓ EL FINIQUITO DEL TORNO RUSO', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:49:13.093' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2527, 1702307804, 3, 155, 100, NULL, 3, 497, N'RAFAEL CASTILLO', N'', N'09/08/2023', N'TRABAJO DE VF3 Y TORNO RUSO', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:50:58.500' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2528, 1702307804, 3, 167, 100, NULL, 3, 498, N'COMPRA DE LAMINAS', N'', N'09/08/2023', N'GASTO DE LAMINAS PARA VFE', CAST(1200.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:51:50.600' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2529, 1702307804, 2, 176, 100, NULL, 1, 499, N'GASTO GAS NISSAN', N'', N'09/08/2023', N'GASTO DE GAS NISSAN', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:19:47.730' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2530, 1702307804, 2, 1205, 100, NULL, 1, 500, N'INTERESES ATZHIRY ', N'', N'10/08/2023', N'GASTO DE INTERESES DE EFECTIVO ', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:25:52.283' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2531, 1702307804, 5, 1228, 103, NULL, 1, 501, N'PRESTAMO PERSONAL HECTOR CARRILLO ', N'', N'10/08/2023', N'DEUDA PERSONAL CON CARRILLO ', CAST(16200.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:56:11.340' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2532, 1702307804, 4, 154, 103, NULL, 1, 502, N'PAGO A PRESTAMO PERSONAL HECTOR CARRILLO ', N'', N'10/08/2023', N'PAGADO', CAST(16200.00 AS Decimal(18, 2)), CAST(N'2023-08-10T13:56:23.053' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2533, 1702307804, 2, 1205, 100, NULL, 1, 503, N'INTERESES DAVID GONZALEZ', N'', N'10/08/2023', N'PAGO DE INTEREES DAVID GONZALEZ', CAST(62000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:01:12.180' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2534, 1702307804, 1, 1202, 102, NULL, 1, 504, N'VENTA DE VECTOR DRIVE MARCO MARTÍNEZ', N'', N'10/08/2023', N'SE VENDIÓ UN VECTOR DRIVE ', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-08-11T06:40:07.400' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2535, 1702307804, 2, 161, 100, NULL, 1, 505, N'LONA CX3', N'', N'11/08/2023', N'GASTO DE LONA PARA CX3 DE CASA DE ALLAN ', CAST(300.00 AS Decimal(18, 2)), CAST(N'2023-08-11T07:01:33.967' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2536, 1702307804, 5, 1207, 103, NULL, 1, 506, N'PRESTAMO PERSONAL ALLAN ', N'', N'08/08/2023', N'PRESTAMO PERSONAL DE ALLAN GALVÁN ', CAST(36000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:53:43.080' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2537, 1702307804, 4, 154, 102, NULL, 1, 507, N'ABONO PRESTAMO RICHARD', N'', N'11/08/2023', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-08-14T09:27:50.483' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2538, 1702307804, 4, 154, 102, NULL, 1, 508, N'PAGO DE CENTRO DE MAQUINADO VF3 DOBLE PALLET', N'', N'12/08/2023', N'', CAST(70000.00 AS Decimal(18, 2)), CAST(N'2023-08-14T09:44:24.227' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2539, 1702307804, 1, 166, 102, NULL, 1, 509, N'VENTA DE TORNO RUSO ', N'A-00009', N'12/08/2023', N'Venta de torno ', CAST(325000.00 AS Decimal(18, 2)), CAST(N'2023-08-14T09:53:41.793' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2540, 1702307804, 1, 156, 102, NULL, 3, 510, N'VENTA DE CAFE', N'F-002', N'14/08/2023', N'SE LE VENDIÓ AL CLIENTE Y DIO UN ANTICIPO DE 50 MIL PESOS ', CAST(250000.00 AS Decimal(18, 2)), CAST(N'2023-08-14T12:53:15.467' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2541, 1702307804, 4, 154, 102, NULL, 3, 511, N'ANTICIPO DE CAFE ', N'F-002', N'14/08/2023', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-08-14T12:53:17.610' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2542, 1702307804, 4, 1203, 102, NULL, 1, 512, N'PRIMER PAGO TORNO RUSO', N'A-00009', N'16/08/2023', N'PRIMER PAGO TORNO RUSO', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-08-16T07:18:02.020' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2543, 1702307804, 2, 176, 100, NULL, 1, 513, N'PAGO DE SERVICIO DE NISSAN', N'', N'15/08/2023', N'PAGO DE CAMIONETA NISSAN SERVICIO ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-08-16T07:25:03.207' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2544, 1702307804, 3, 1195, 100, NULL, 3, 514, N'TRABAJO BENITO ', N'A-00018', N'15/08/2023', N'REFACCIONES BENITO ', CAST(6100.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:10:05.480' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2545, 1702307804, 2, 161, 100, NULL, 1, 515, N'GASTO BOTELLA', N'', N'13/08/2023', N'BOTELLA CLIENTES', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-08-16T07:56:49.490' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2546, 1702307804, 5, 1229, 102, NULL, 1, 516, N'PRESTAMO NETO ', N'', N'13/08/2023', N'PAGOS ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:08:11.843' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2547, 1702307804, 3, 1195, 100, NULL, 3, 517, N'TRABAJO BENITO ', N'A-00013', N'15/08/2023', N'DINERO PARA REFACCIONES BENITO ', CAST(1900.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:11:02.617' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2548, 1702307804, 2, 176, 100, NULL, 1, 518, N'PAGO RENTA', N'', N'15/08/2023', N'PAGO DE RENTA IRINEO ', CAST(55000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:38:33.613' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2549, 1702307804, 2, 161, 105, NULL, 1, 519, N'GASTO PERSONAL ALLAN COMIDA', N'', N'12/08/2023', N'', CAST(1300.00 AS Decimal(18, 2)), CAST(N'2023-08-17T12:26:00.050' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2550, 1702307804, 2, 161, 105, NULL, 1, 520, N'GASTO PERSONAL BOTELLA', N'', N'12/08/2023', N'', CAST(1043.00 AS Decimal(18, 2)), CAST(N'2023-08-17T12:26:57.613' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2551, 1702307804, 2, 161, 105, NULL, 1, 521, N'GASTO PERSONAL ALLAN', N'', N'12/08/2023', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-08-17T12:35:08.390' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2552, 1702307804, 2, 161, 105, NULL, 1, 522, N'GASTO PERSONAL TACOMA ', N'', N'12/08/2023', N'GASTO PERSONAL DE PAGO DE TACOMA ', CAST(1700.00 AS Decimal(18, 2)), CAST(N'2023-08-17T12:42:00.710' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2553, 1702307804, 2, 161, 105, NULL, 1, 523, N'GASTO PERSONAL ALLAN ', N'', N'12/08/2023', N'GASTO PERSONAL DE ALLAN ', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-08-17T12:56:18.030' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2554, 1702307804, 2, 161, 105, NULL, 1, 524, N'GASTO PERSONAL BOTELLA ', N'', N'12/08/2023', N'GASTO PERSONAL BOTELLA', CAST(1486.00 AS Decimal(18, 2)), CAST(N'2023-08-17T13:03:22.567' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2555, 1702307804, 2, 161, 105, NULL, 1, 525, N'GASTO PERSONAL ALLAN', N'', N'12/08/2023', N'GASTO PERSONAL ALLAN ', CAST(1600.00 AS Decimal(18, 2)), CAST(N'2023-08-17T13:05:08.050' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2556, 1702307804, 2, 161, 105, NULL, 1, 526, N'GASTO PERSONAL ALLAN GOLF', N'', N'12/08/2023', N'GASTO PERSONAL ALLAN DE TORNEO DE GOLF ', CAST(800.00 AS Decimal(18, 2)), CAST(N'2023-08-17T13:27:52.750' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2557, 1702307804, 2, 161, 105, NULL, 1, 527, N'GASTO PERONAL BOTELLA ', N'', N'12/08/2023', N'GASTO PERSONAL ALLAN GALVAN BOTELLA ', CAST(890.00 AS Decimal(18, 2)), CAST(N'2023-08-17T13:30:04.913' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2558, 1702307804, 2, 161, 105, NULL, 1, 528, N'GASTO PERSONAL DE ALLAN', N'', N'12/08/2023', N'TIENDA ', CAST(2600.00 AS Decimal(18, 2)), CAST(N'2023-08-17T13:32:32.577' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2559, 1702307804, 2, 161, 105, NULL, 1, 529, N'GASTO PERSONAL ALLAN COMIDA', N'', N'12/08/2023', N'COMIDA CON FREDDY', CAST(800.00 AS Decimal(18, 2)), CAST(N'2023-08-17T13:55:30.780' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2560, 1702307804, 5, 1204, 103, NULL, 3, 530, N'NUEVO PRESTAMO DANIEL ZEPEDA ', N'', N'22/08/2023', N'ZEPEDA NOS PRESTÓ UNA LANA ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-08-22T10:51:52.897' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2561, 1702307804, 5, 1204, 101, NULL, 3, 531, N'PRESTAMO ZEPEDA', N'P-001', N'22/08/2023', N'LE PRESTAMOS DINERO POR BUENA ONDA ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-08-22T11:04:44.063' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2562, 1702307804, 3, 155, 105, NULL, 3, 532, N'COMPRA DE HOJAS DE PAPEL ', N'P-001', N'22/08/2023', N'COMPRAMOS 100 CAJAS DE HOJAS ', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-08-22T11:26:39.210' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2563, 1702307804, 1, 153, 105, NULL, 3, 533, N'VENTA DE 50 CAJAS DE HOJAS DE PAPEL ', N'V-001', N'22/08/2023', N'', CAST(35000.00 AS Decimal(18, 2)), CAST(N'2023-08-22T11:26:41.093' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2564, 1702307804, 2, 161, 1109, NULL, 1, 534, N'GASTO PERSONAL DE ALLAN ', N'', N'16/08/2023', N'GASTO PERSONAL DE ALLAN', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-08-23T07:27:56.617' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2565, 1702307804, 2, 161, 100, NULL, 1, 535, N'GASTO PERSONAL ALLAN', N'', N'16/08/2023', N'GASTO PERSONAL DE ALLAN RIFA ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-08-23T07:28:37.390' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2566, 1702307804, 2, 161, 1109, NULL, 1, 536, N'GASTO PERSONAL ALLAN DEPA', N'', N'16/08/2023', N'GASTO DE DEPA NUEVO ALLAN', CAST(6700.00 AS Decimal(18, 2)), CAST(N'2023-08-23T07:29:15.623' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2567, 1702307804, 2, 161, 100, NULL, 1, 537, N'GASTO PERSONAL DEPA ALLAN', N'', N'17/08/2023', N'GASTO PERSONAL DE DEPA DE ALLAN ', CAST(6000.00 AS Decimal(18, 2)), CAST(N'2023-08-23T07:29:57.760' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2568, 1702307804, 2, 161, 106, NULL, 1, 538, N'GASTO PERSONAL DE RZR ', N'', N'17/08/2023', N'GASTO PERSONAL DE RZR ALLAN', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-08-23T07:30:51.593' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2569, 1702307804, 2, 161, 106, NULL, 1, 539, N'GASTO PERSONAL ALLAN ', N'', N'17/08/2023', N'GASTO PERSONAL DE ALLAN ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-08-23T07:31:29.140' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2570, 1702307804, 2, 161, 105, NULL, 1, 540, N'GASTO PERSONAL ALLAN COMIDA ', N'', N'17/08/2023', N'GASTO PERSONAL DE COMIDA ALLAN', CAST(1495.00 AS Decimal(18, 2)), CAST(N'2023-08-23T07:32:05.073' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2571, 1702307804, 2, 161, 105, NULL, 1, 541, N'GASTO PERSONAL HERRAMIENTAS', N'', N'18/08/2023', N'GASTO PERSONAL DE HERRAMIENTAS PARA DEPA ', CAST(614.00 AS Decimal(18, 2)), CAST(N'2023-08-23T08:04:26.720' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2572, 1702307804, 2, 161, 105, NULL, 1, 542, N'GASTO PERSONAL ALLAN DEPA', N'', N'18/08/2023', N'GASTO PERSONAL ALLAN SINCHOS DEPA ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-08-23T08:05:04.680' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2573, 1702307804, 2, 161, 105, NULL, 1, 543, N'GASTO PERSONAL ALLAN ', N'', N'18/08/2023', N'GASTO PERSONAL EN FARMACIA GDL ', CAST(1544.00 AS Decimal(18, 2)), CAST(N'2023-08-23T08:05:35.657' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2574, 1702307804, 2, 161, 105, NULL, 1, 544, N'GASTO PERSONAL BOTELLAS ALLAN ', N'', N'18/08/2023', N'GASTO PERSONAL DE BOTELLAS ALLAN ', CAST(1276.00 AS Decimal(18, 2)), CAST(N'2023-08-23T08:06:09.383' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2575, 1702307804, 2, 161, 105, NULL, 1, 545, N'GASTO DE PRESTAMOS ALLAN ', N'', N'18/08/2023', N'PRESTAMOS PERSONALES DE ALLAN CON EL BANCO ', CAST(5100.00 AS Decimal(18, 2)), CAST(N'2023-08-23T08:07:13.750' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2576, 1702307804, 2, 161, 105, NULL, 1, 546, N'GASTO PERSONAL SEGURO ALLAN ', N'', N'18/08/2023', N'GASTO PERSONAL DE COBRO DE UN SEGURO QUE TIENE ALLAN ', CAST(2819.00 AS Decimal(18, 2)), CAST(N'2023-08-23T08:07:58.230' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2577, 1702307804, 2, 176, 100, NULL, 3, 547, N'TRABAJO RAFA CASTILLO ', N'', N'19/08/2023', N'DINERO PARA RAFA CASTILLO DE MAQUINAS ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:17:05.770' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2578, 1702307804, 2, 176, 100, NULL, 1, 548, N'MORENO PINTURAS ', N'', N'19/08/2023', N'GASTO DE PAGO A MORENO PINTURAS ', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:48:50.363' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2579, 1702307804, 2, 176, 100, NULL, 1, 549, N'COMPRA DE MATERIAL BODEGA ', N'', N'23/08/2023', N'COMPRA DE LIJAS, FIBRAS Y TRAMPAS PARA RATONES ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:18:46.713' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2580, 1702307804, 4, 180, 102, NULL, 1, 550, N'PAGO DE TORNO RUSO ', N'A-00009', N'21/08/2023', N'PAGO DE TORNO RUSO, VENTA ', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-08-23T09:59:23.487' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2581, 1702307804, 4, 154, 102, NULL, 1, 551, N'PAGO TORNO HWACHEON ', N'', N'14/08/2023', N'PAGO DE HWACHEON ', CAST(49000.00 AS Decimal(18, 2)), CAST(N'2023-08-23T10:03:28.730' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2582, 1702307804, 4, 1203, 102, NULL, 1, 552, N'PAGADO DRIVE DEUDA POR COBRAR', N'', N'19/08/2023', N'PAGADO ', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-08-23T10:07:16.030' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2583, 1702307804, 2, 161, 1109, NULL, 1, 553, N'GASTO PERSONAL BMW ALLAN ', N'', N'18/08/2023', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-08-23T10:09:00.580' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2584, 1702307804, 2, 161, 1109, NULL, 3, 554, N'GASTO DE IMPUESTOS FABRE ', N'', N'18/08/2023', N'GASTO DE IMPUESTOS A FABRE ', CAST(21228.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:15:32.327' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2585, 1702307804, 2, 161, 1109, NULL, 1, 555, N'GASTO PERSONA ALLAN DEPA ', N'', N'18/08/2023', N'PAGO TAG ALLAN ', CAST(1160.00 AS Decimal(18, 2)), CAST(N'2023-08-23T10:17:45.187' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2586, 1702307804, 2, 1230, 1109, NULL, 1, 556, N'PAGO DE IMSS ', N'', N'17/08/2023', N'PAGO DE IMSS', CAST(2225.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:13:47.680' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2587, 1702307804, 2, 161, 106, NULL, 1, 557, N'GASTO PERSONAL DEPA ALLAN ', N'', N'18/08/2023', N'GASTO PERSONAL DE DEPA DE ALLAN ', CAST(9000.00 AS Decimal(18, 2)), CAST(N'2023-08-23T10:29:48.940' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2588, 1702307804, 2, 161, 106, NULL, 1, 558, N'GASTO PERSONAL DEPA ALLAN ', N'', N'18/08/2023', N'GASTO PERSONAL DEPA ALLA N', CAST(9000.00 AS Decimal(18, 2)), CAST(N'2023-08-23T10:30:24.187' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2589, 1702307804, 5, 1204, 103, NULL, 3, 559, N'NUEVO PRÉSTAMO ZEPEDA', N'P001', N'24/08/2023', N'ALLAN PIDIO UN NUEVO PRESTAMO PARA COMPRAR MERCANCIA ', CAST(250000.00 AS Decimal(18, 2)), CAST(N'2023-08-24T12:52:02.457' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2590, 1702307804, 5, 1204, 103, NULL, 3, 560, N'PRESTAMO ZEPDA ', N'P001', N'24/08/2023', N'SE PIDIO PARA MERCANCIA ', CAST(250000.00 AS Decimal(18, 2)), CAST(N'2023-08-24T13:27:30.823' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2591, 1702307804, 1, 166, 106, NULL, 3, 561, N'VENTA DE TORNO CONVENCIONAL RUSO ', N'V-003', N'24/08/2023', N'VENTA DEL TORNO CONVENCIONAL ', CAST(377000.00 AS Decimal(18, 2)), CAST(N'2023-08-24T14:01:36.857' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2592, 1702307804, 2, 161, 106, NULL, 3, 562, N'GASTOS PERSONALES DE VALLARTAZO ', N'', N'24/08/2023', N'SE FUERON DE FIESTA ', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-08-24T14:01:40.050' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2593, 1702307804, 3, 175, 100, NULL, 3, 563, N'COSTO TOTAL DEL MES DE AGOSTO ', N'', N'24/08/2023', N'Costo total del mes de agosto ', CAST(223000.00 AS Decimal(18, 2)), CAST(N'2023-08-24T14:01:43.300' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2594, 1702307804, 4, 179, 102, NULL, 1, 564, N'PAGO TORNO RUSO  ', N'A-00009', N'28/08/2023', N'PAGO DE TORNO RUSO A CUENTA FISCAL ALLAN ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-08-28T13:48:10.607' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2595, 1702307804, 4, 179, 102, NULL, 1, 565, N'PAGO DE TORNO RUSO', N'', N'24/08/2023', N'PAGO DE TORNO RUSO', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-08-28T13:52:34.113' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2596, 1702307804, 4, 179, 102, NULL, 1, 566, N'PAGO DE RECTIFICADORA KENT ', N'', N'28/08/2023', N'PAGO DE RECTIFICADORA KENT ', CAST(62500.00 AS Decimal(18, 2)), CAST(N'2023-08-28T13:54:30.313' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2597, 1702307804, 2, 176, 1109, NULL, 1, 567, N'PAGO DE LUZ', N'', N'25/08/2023', N'PAGO DE LUZ DE BODEGA ', CAST(5840.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:20:34.897' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2598, 1702307804, 2, 176, 1109, NULL, 1, 568, N'PAGO DE LUZ OFICINAS', N'', N'25/08/2023', N'', CAST(1434.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:20:51.147' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2599, 1702307804, 2, 1222, 1109, NULL, 1, 569, N'NOMINAS ', N'', N'25/08/2023', N'PAGO DE NÓMINAS ', CAST(7000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:55:31.163' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2600, 1702307804, 2, 161, 1109, NULL, 1, 570, N'GASTO PERSONAL ALLAN TELEFONO ', N'', N'25/08/2023', N'', CAST(1180.00 AS Decimal(18, 2)), CAST(N'2023-08-29T10:30:17.490' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2601, 1702307804, 2, 176, 1109, NULL, 1, 571, N'  GASTO GAS NISSAN', N'', N'25/08/2023', N'gasto de gasolina ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-08-29T10:39:29.177' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2602, 1702307804, 2, 161, 1109, NULL, 1, 572, N'GASTO PERSONAL RIFA ALLAN ', N'', N'25/08/2023', N'HASTO PERSONAL DE LA RIFA DE ALLAN ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-08-29T10:47:41.257' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2603, 1702307804, 2, 161, 1109, NULL, 1, 573, N'GASTO PERSONAL DE ALLAN RAÚL ', N'', N'26/08/2023', N'GASTO PERSONAL DE ALLAN DE DINERO PARA RAÚL ', CAST(5500.00 AS Decimal(18, 2)), CAST(N'2023-08-29T10:49:19.397' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2604, 1702307804, 2, 1205, 1109, NULL, 1, 574, N'PAGO DE INTERESES DAVID GONZALEZ ', N'', N'26/08/2023', N'INTERESES DAVID GONZALEZ ', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2023-08-29T10:52:51.113' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2605, 1702307804, 2, 161, 1109, NULL, 1, 575, N'PAGO DE PRESTAMO A DAVID CRUZ DE CORA', N'', N'26/08/2023', N'PAGO DE UN DINERO QUE DAVID LE PRESTÓ A ALLAN DE CORAZÓN DICE ÉL ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-08-29T11:15:00.063' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2606, 1702307804, 2, 1220, 1109, NULL, 1, 576, N'GASTO TELMEX BODEGA', N'', N'26/08/2023', N'', CAST(659.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:20:57.130' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2607, 1702307804, 2, 161, 1109, NULL, 1, 577, N'GASTO PERSONAL ALLAN ', N'', N'26/08/2023', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-08-29T11:30:21.260' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2608, 1702307804, 2, 1205, 106, NULL, 1, 578, N'INTERRES DOÑA BERTHA ', N'', N'26/08/2023', N'GASTO DE INTERESES DE DOÑA BERTHA ', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2023-08-29T12:24:46.177' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2609, 1702307804, 2, 161, 106, NULL, 1, 579, N'GASTO PERSONAL PAGO DE TARJETA ', N'', N'26/08/2023', N'GASTO DE PAGO DE TARJETA PLATINUM ALTAGRACIA', CAST(15500.00 AS Decimal(18, 2)), CAST(N'2023-08-29T12:25:33.780' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2610, 1702307804, 5, 1206, 100, NULL, 1, 580, N'PRESTAMO OSVALDO BARBA', N'', N'26/08/2023', N'PRESTAMO QUE PIDIÓ ALLAN A SU PRIMO', CAST(17500.00 AS Decimal(18, 2)), CAST(N'2023-08-29T12:27:23.863' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2611, 1702307804, 2, 1205, 100, NULL, 1, 581, N'PAGO DE INTERESES SERRANO', N'', N'26/08/2023', N'PAGO DE INTERESES CON EL PRÉSTAMO DE OSVALDO ', CAST(17500.00 AS Decimal(18, 2)), CAST(N'2023-08-29T13:11:23.643' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2612, 1702307804, 2, 161, 105, NULL, 1, 582, N'GASTO PERSONAL DEL VALLARTAZO ALLAN ', N'', N'26/08/2023', N'DINERO QUE SE GASTÓ ALLAN EN COSAS PERSONALES ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-08-29T13:13:26.957' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2613, 1702307804, 5, 1207, 105, NULL, 1, 583, N'PRESTAMO RUBEN GALVAN ', N'', N'26/08/2023', N'DINERO QUE LE PRESTÓ EL HERMANO DE ALLAN A ALLAN ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-08-29T13:15:26.133' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2614, 1702307804, 5, 1208, 100, NULL, 1, 584, N'PRESTAMO GUSTAVO ', N'', N'25/08/2023', N'PRESTAMO QUE ALLAN LE PIDIÓ A GUSTAVO ', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-08-30T07:37:27.573' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2615, 1702307804, 2, 161, 100, NULL, 1, 585, N' GASTO PERSONAL DE PAGO DE TARJETA', N'', N'25/08/2023', N'GASTO PERSONAL DE ALLAN PAGO DE TARJETA LIVERPOOL ALTAGRACIA ', CAST(16700.00 AS Decimal(18, 2)), CAST(N'2023-08-30T09:36:58.240' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2616, 1702307804, 2, 161, 100, NULL, 1, 586, N'GASTO PERSONAL VALLARTAZO ', N'', N'25/08/2023', N'GASTO PERSONAL ALLAN EN VALLARTA ', CAST(8300.00 AS Decimal(18, 2)), CAST(N'2023-08-30T09:37:29.913' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2617, 1702307804, 2, 1205, 100, NULL, 1, 587, N'INTERES OSVALDO ', N'', N'11/08/2023', N'', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2023-08-31T10:31:02.360' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2618, 1702307804, 2, 1205, 100, NULL, 1, 588, N'INTERESES PADRINO DE ALLAN ', N'', N'11/08/2023', N'', CAST(24000.00 AS Decimal(18, 2)), CAST(N'2023-08-31T10:31:29.023' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2619, 1702307804, 4, 154, 103, NULL, 3, 589, N'PAGO PRESTAMO CHIQUIS', N'', N'11/08/2023', N'PRESTAMO PERSONAL DE ALLAN ', CAST(36000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T10:29:23.863' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2620, 1702307804, 2, 1222, 100, NULL, 1, 590, N'NOMINAS ', N'', N'11/08/2023', N'PAGO DE NOMINAS ', CAST(10500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:54:44.323' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2621, 1702307804, 2, 176, 100, NULL, 1, 591, N'RAFA CASTILLO ', N'', N'11/08/2023', N'GASTO  PINTURA ', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:26:37.880' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2622, 1702307804, 2, 161, 1109, NULL, 1, 592, N'GASTO PERSONAL ALLAN ALTAGRACIA', N'', N'11/08/2023', N'', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-08-31T11:19:19.720' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2623, 1702307804, 3, 167, 100, NULL, 3, 593, N'HECTOR CARRILLO ', N'', N'21/08/2023', N'A CUENTA DE TRABAJO ', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:17:42.410' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2624, 1702307804, 2, 161, 100, NULL, 1, 594, N'GASTO PERSONAL PARA ALLAN ', N'', N'21/08/2023', N'GASTO PARA EL DEPA DE ALLAN QUE OCUPÓ RICARDO ', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-08-31T11:23:05.123' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2625, 1702307804, 3, 1195, 100, NULL, 3, 595, N'TRABAJO BENITO ', N'A-00009', N'21/08/2023', N'A CUENTA DE TORNO RUSO ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:17:57.797' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2626, 1702307804, 2, 1205, 105, NULL, 1, 596, N'INTERESES FABRE ', N'', N'21/08/2023', N'', CAST(7400.00 AS Decimal(18, 2)), CAST(N'2023-08-31T11:25:43.673' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2627, 1702307804, 2, 1205, 100, NULL, 1, 597, N'INTERES OSVALDO BARBA', N'', N'31/08/2023', N'', CAST(22500.00 AS Decimal(18, 2)), CAST(N'2023-08-31T12:15:49.233' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2628, 1702307804, 2, 161, 100, NULL, 1, 598, N'GASTO PERSONAL ALLAN ', N'', N'31/08/2023', N'DINERO DE CORAZÓN PARA OSVALDO ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-08-31T12:16:42.643' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2629, 1702307804, 2, 161, 100, NULL, 1, 599, N'GASTO PERSONAL ALLAN CELULAR OSVALDO ', N'', N'31/08/2023', N'GASTO DE UN CELULAR DE OSVALDO ', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2023-08-31T12:17:54.003' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2630, 1702307804, 3, 1195, 100, NULL, 3, 600, N'TRABAJO BENITO REPARACIÓN ', N'A-00009', N'31/08/2023', N'', CAST(4500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:22:44.140' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2631, 1702307804, 2, 176, 100, NULL, 1, 601, N'LONA MAQUINAS ', N'', N'31/08/2023', N'LONA PARA MAQUINAS ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T14:26:25.370' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2632, 1702307804, 2, 1231, 100, NULL, 1, 602, N'GASTO GAS MOTO ', N'', N'31/08/2023', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:24:10.373' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2633, 1702307804, 2, 1231, 100, NULL, 1, 603, N'GAS NISSAN ', N'', N'31/08/2023', N'GASTO DE GAS PARA NISSA', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:24:27.970' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2634, 1702307804, 2, 161, 106, NULL, 1, 604, N'BETO CASILLAS ', N'', N'30/08/2023', N'DEPOSITO A BETO ', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2023-09-01T07:34:23.060' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2635, 1702307804, 2, 161, 106, NULL, 1, 605, N'GASTO PERSONAL DE ALLAN ', N'', N'30/08/2023', N'SIN CONTEXTO ', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-01T07:34:49.877' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2636, 1702307804, 2, 161, 106, NULL, 1, 606, N'GASTO PERSONAL RZR ALLAN ', N'', N'31/08/2023', N'PAGO DE RZR ALLAN ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-09-01T07:35:34.633' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2637, 1702307804, 2, 161, 106, NULL, 1, 607, N'GASTO PERSONAL ALLAN RT', N'', N'31/08/2023', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-01T07:35:55.473' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2638, 1702307804, 2, 161, 106, NULL, 1, 608, N'GASTO PERSONAL COMIDA ALLAN ', N'', N'31/08/2023', N'', CAST(1433.00 AS Decimal(18, 2)), CAST(N'2023-09-01T07:36:25.453' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2639, 1702307804, 1, 165, 105, NULL, 1, 609, N'INGRESO DE RENTA DE MAQUINA FADAL 6030', N'', N'24/08/2023', N'RENTA DE CENTRO DE MAQUINADO FADAL 6030 ', CAST(34800.00 AS Decimal(18, 2)), CAST(N'2023-09-01T07:54:12.023' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2640, 1702307804, 1, 1236, 105, NULL, 1, 610, N'INGRESO DE FADAL 6030 RENTA ', N'', N'24/08/2023', N'PAGO DE ADELANTO DE LA RENTA DEL FADAL ', CAST(34800.00 AS Decimal(18, 2)), CAST(N'2023-10-05T12:30:53.120' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2641, 1702307804, 1, 165, 102, NULL, 1, 611, N'VENTA DE CENTRO DE MAQUINADO VF3 ', N'A-00005', N'24/08/2023', N'VENTA DE CENTRO DE MAQUINADO VF3 AÑO 1995', CAST(445000.00 AS Decimal(18, 2)), CAST(N'2023-09-01T07:59:14.717' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2642, 1702307804, 4, 180, 102, NULL, 1, 612, N'TERCER PAGO DE CENTRO DE MAQUINADO VF3', N'A-00005', N'30/08/2023', N'PAGO DE CENTRO DE MAQUINADO VF3 ', CAST(250000.00 AS Decimal(18, 2)), CAST(N'2023-09-01T08:01:25.727' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2643, 1702307804, 4, 154, 102, NULL, 1, 613, N'PRIMER PAGO DE CENTRO DE MAQUINADO VF3 ', N'', N'24/08/2023', N'PRIMER PAGO DE VF3 ', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-09-01T08:06:01.430' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2644, 1702307804, 4, 154, 102, NULL, 1, 614, N'SEGUNDO PAGO DE CENTRO DE MAQUINADO VF3', N'A-00005', N'25/08/2023', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-09-01T08:14:12.037' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2645, 1702307804, 4, 154, 102, NULL, 1, 615, N'PAGADO PRESTAMO RICHARD ', N'', N'18/08/2023', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-01T08:16:22.563' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2646, 1702307804, 2, 1223, 100, NULL, 1, 616, N'HONORARIOS AUDITORÍA FREDDY ', N'', N'31/08/2023', N'HONORARIOS A FREDDY DE AUDITORÍA ', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:24:44.163' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2647, 1702307804, 2, 161, 100, NULL, 1, 617, N'GASTO PERSONAL ALLAN ', N'', N'31/08/2023', N'', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-01T08:26:01.707' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2648, 1702307804, 2, 1209, 100, NULL, 1, 618, N'GASTO DE VUELOS INVEX CARRILLO ', N'', N'30/08/2023', N'', CAST(16500.00 AS Decimal(18, 2)), CAST(N'2023-09-01T08:27:15.590' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2649, 1702307804, 2, 161, 106, NULL, 1, 619, N'GASTO PERSONAL ALLAN CUPRA Y PRESTAMO ', N'', N'01/09/2023', N'GASTO PERSONAL PAGO DE CUPRA Y PRESTAMO ', CAST(14500.00 AS Decimal(18, 2)), CAST(N'2023-09-01T09:16:50.987' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2650, 1702307804, 2, 161, 100, NULL, 1, 620, N'GASTO PERSONAL CELULAR DE ALLAN ', N'', N'01/09/2023', N'', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-01T10:48:08.580' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2651, 1702307804, 2, 161, 100, NULL, 1, 621, N'GASTO PERSONAL RIFA ALLAN ', N'', N'01/09/2023', N'GASTO PERSONAL DE RIFA DE ALLAN ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-01T11:06:41.750' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2652, 1702307804, 2, 176, 100, NULL, 1, 622, N'ASIENTO MONTACARGAS', N'', N'01/09/2023', N'', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T12:31:25.047' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2653, 1702307804, 2, 161, 106, NULL, 1, 623, N'GASTO PERSONAL ALLAN TACOMA ', N'', N'01/09/2023', N'GASTO PERSONAL DE ALLAN PAGO DE TACOMA ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-09-01T12:40:28.000' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2654, 1702307804, 1, 1210, 102, NULL, 3, 624, N'VENTA DE MONTACARGAS NISSAN ', N'A-00019', N'02/09/2023', N'VENTA DE MONTACARGAS NISSAN, SE HIZO UN CAMBIO ', CAST(130000.00 AS Decimal(18, 2)), CAST(N'2023-09-04T06:55:57.973' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2655, 1702307804, 1, 1210, 102, NULL, 1, 625, N'VENTA DE MONTACARGAS NISSAN ', N'A-00019', N'30/08/2023', N'VENTA DE MONTACARGAS NISSAN, SE VENDIÓ POR 130,000 PROBABLE INTERCAMBIO DE MAQUINARIA ', CAST(130000.00 AS Decimal(18, 2)), CAST(N'2023-09-04T06:57:16.647' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2656, 1702307804, 4, 154, 102, NULL, 1, 626, N'PAGO DE MONTACARGAS NISSAN ', N'A-00019', N'02/09/2023', N'', CAST(40000.00 AS Decimal(18, 2)), CAST(N'2023-09-04T07:02:54.027' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2657, 1702307804, 2, 161, 100, NULL, 1, 627, N'GASTO PERSONAL DE ALLAN AIRPODS ', N'', N'01/09/2023', N'GASTO PERSONAL DE ALLAN ', CAST(6500.00 AS Decimal(18, 2)), CAST(N'2023-09-04T07:12:26.780' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2658, 1702307804, 2, 1205, 100, NULL, 1, 628, N'INTERES DAVID GONZALEZ ', N'', N'01/09/2023', N'', CAST(64000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T11:57:17.930' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2659, 1702307804, 2, 1222, 100, NULL, 1, 629, N'Nominas ', N'', N'01/09/2023', N'pago de nominas y 1000 de comisión de Mariana', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:30:17.867' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2660, 1702307804, 3, 1196, 100, NULL, 3, 630, N'COMISIÓN YADIRA ', N'', N'01/09/2023', N'', CAST(6000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:31:40.097' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2661, 1702307804, 3, 1195, 100, NULL, 3, 631, N'TRABAJO BENITO ', N'', N'01/09/2023', N'REPARACIÓN DE TORNO RUSO A-00009', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:31:49.080' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2662, 1702307804, 3, 152, 100, NULL, 3, 632, N'PAGO A CUENTA DE TRABAJO CARRILLO ', N'', N'02/09/2023', N'PAGO A CUENTA DE TRABAJO HECTOR CARRILLO ', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:32:30.040' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2663, 1702307804, 2, 1205, 100, NULL, 1, 633, N'INTERESES ALFREDO AVILA ', N'', N'02/09/2023', N'PAGO DE INTERES PADRINO DE ALLAN ', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2023-09-04T07:31:06.720' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2664, 1702307804, 2, 1205, 100, NULL, 1, 634, N'INTERES OSVALDO BARBA ', N'', N'02/09/2023', N'', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2023-09-04T11:19:44.323' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2665, 1702307804, 3, 167, 100, NULL, 3, 635, N'TRABAJO MARIO PEREZ ', N'', N'02/09/2023', N'5 REFLECTORES Y TARJETA I/O', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:33:35.997' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2666, 1702307804, 2, 176, 100, NULL, 1, 636, N'GUARDAPOLVOS Y TORNILLOS ', N'', N'04/09/2023', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:03:57.363' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2667, 1702307804, 2, 1205, 100, NULL, 1, 637, N'INTERES ING ANTONIO ', N'', N'04/09/2023', N'INTERES DE TOBY ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-09-04T11:42:41.880' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2668, 1702307804, 5, 1211, 1109, NULL, 1, 638, N'PRESTAMO BETO ', N'', N'02/09/2023', N'EL PRESTAMO FUE DE 100 Y EN LA TARJETA DE MARIANA DEPOSITARON 77', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-09-05T11:12:37.893' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2669, 1702307804, 5, 1212, 1109, NULL, 3, 639, N'PRESTAMO PARA LIQUIDAR TARJETAS', N'', N'04/09/2023', N'PRESTAMO PERSONAL PARA ALLAN PARA PAGAR TARJETAS', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T16:58:32.817' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2670, 1702307804, 2, 161, 1109, NULL, 1, 640, N'GASTO PERSONAL ESCUELA CHRIS', N'', N'02/09/2023', N'', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-09-05T13:39:22.440' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2671, 1702307804, 3, 1195, 1109, NULL, 3, 641, N'TRABAJO BENITO ', N'', N'02/09/2023', N'', CAST(5800.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:33:47.390' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2672, 1702307804, 2, 1205, 1109, NULL, 1, 642, N'INTERES LUIS ', N'', N'02/09/2023', N'', CAST(6200.00 AS Decimal(18, 2)), CAST(N'2023-09-06T09:29:51.280' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2673, 1702307804, 2, 161, 1109, NULL, 1, 643, N'GASTO PERSONAL GOLF ALLAN. ', N'', N'05/09/2023', N'', CAST(7633.00 AS Decimal(18, 2)), CAST(N'2023-09-06T09:30:22.567' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2674, 1702307804, 2, 161, 1109, NULL, 1, 644, N'GASTO PERSONAL TARJETA INVEX ', N'', N'05/09/2023', N'', CAST(25126.00 AS Decimal(18, 2)), CAST(N'2023-09-06T09:31:54.223' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2675, 1702307804, 2, 176, 1109, NULL, 1, 645, N'PAGO APP UPNIFY ', N'', N'05/09/2023', N'', CAST(3076.00 AS Decimal(18, 2)), CAST(N'2023-09-06T10:11:17.147' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2676, 1702307804, 2, 176, 100, NULL, 1, 646, N'GAS NISSAN', N'', N'06/09/2023', N'', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-09-06T10:33:55.623' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2677, 1702307804, 3, 1196, 1109, NULL, 3, 647, N'COMISIÓN YADIRA ', N'', N'06/09/2023', N'', CAST(5700.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:34:10.467' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2678, 1702307804, 2, 161, 1109, NULL, 1, 648, N'GASTO PERSONAL ALLAN ', N'', N'06/09/2023', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-06T10:34:52.207' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2692, 1702307804, 4, 154, 102, 0, 1, 649, N'PAGO DEL CENTRO DE MAQUINADO DOBLE PALLET ', N'', N'12/09/2023', N'PAGO A CUENTA DE DAVID EL CUAL SE RETIRÓ Y ENTREGÓ EN EFECTIVO, DAVID SE QUEDÓ CON 50 A CUENTA DE SU COMISIÓN ', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2023-09-12T08:22:36.910' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2693, 1702307804, 2, 176, 100, 0, 1, 650, N'PAGO DE RENTA ', N'', N'11/09/2023', N'PAGO DE RENTA DE BODEGA IRINEO ', CAST(55000.00 AS Decimal(18, 2)), CAST(N'2023-09-12T08:25:53.480' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2694, 1702307804, 2, 1205, 100, 0, 1, 651, N'INTERES SUSANA', N'', N'11/09/2023', N'PAGO DE INTERESES SUSANA ', CAST(7500.00 AS Decimal(18, 2)), CAST(N'2023-09-12T08:40:25.430' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2698, 1702307804, 2, 161, 100, 0, 1, 652, N'GASTO PERSONAL DE ALLAN ', N'', N'09/09/2023', N'', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2023-09-12T13:15:04.753' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2699, 1702307804, 2, 1222, 100, 0, 1, 653, N'NOMINAS ', N'', N'08/09/2023', N'', CAST(7000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:34:42.497' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2700, 1702307804, 2, 161, 100, 0, 1, 654, N'GASTO PERSONAL GAS ALLAN ', N'', N'09/09/2023', N'', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2023-09-12T13:23:05.437' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2701, 1702307804, 2, 161, 100, 0, 1, 655, N'GASTO PERSONAL ALLAN ', N'', N'09/09/2023', N'', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-09-12T13:24:22.147' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2702, 1702307804, 2, 161, 100, 0, 1, 656, N'GASTO PERSONAL ALLAN COMIDA', N'', N'11/09/2023', N'', CAST(3544.00 AS Decimal(18, 2)), CAST(N'2023-09-12T14:05:05.783' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2703, 1702307804, 2, 161, 100, 0, 1, 657, N'DINERO PARA PRIMO DE ALLAN ', N'', N'09/09/2023', N'', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2023-09-13T07:02:35.320' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2704, 1702307804, 2, 161, 100, 0, 1, 658, N'GASTO PERSONAL DINERO RICARDO ', N'', N'09/09/2023', N'DINERO QUE ALLAN LE PRESTÓ A RICARDO ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-09-13T07:12:58.637' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2705, 1702307804, 1, 153, 102, 0, 1, 659, N'VENTA DE PERFILADORA ACRAMILL ', N'', N'09/09/2023', N'VENTE DE PERFILADORA ACRAMILL ', CAST(85000.00 AS Decimal(18, 2)), CAST(N'2023-09-13T07:18:47.453' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2706, 1702307804, 4, 1203, 102, 0, 1, 660, N'PRIMER PAGO DE PERFILADORA ACRAMILL ', N'', N'09/09/2023', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-13T07:19:31.450' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2707, 1702307804, 2, 161, 105, 0, 1, 661, N'GASTO PERSONAL GAS BMW ', N'', N'11/09/2023', N'', CAST(1068.00 AS Decimal(18, 2)), CAST(N'2023-09-13T09:30:14.850' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2708, 1702307804, 2, 161, 105, 0, 1, 662, N'GASTO PERSONAL COMIDA ALLAN ', N'', N'11/09/2023', N'', CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-09-13T09:30:46.540' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2709, 1702307804, 2, 161, 105, 0, 1, 663, N'GASTO PERSONAL ALLAN STARBUCK ', N'', N'11/09/2023', N'', CAST(127.00 AS Decimal(18, 2)), CAST(N'2023-09-13T10:54:41.460' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2710, 1702307804, 2, 161, 105, 0, 1, 664, N'GASTO PERSONAL ALLAN OXXO ', N'', N'11/09/2023', N'', CAST(149.00 AS Decimal(18, 2)), CAST(N'2023-09-13T11:01:43.363' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2711, 1702307804, 2, 161, 105, 0, 1, 665, N'GASTO PERSONAL ALLAN SAMS ', N'', N'11/09/2023', N'', CAST(664.00 AS Decimal(18, 2)), CAST(N'2023-09-13T11:38:12.293' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2712, 1702307804, 2, 161, 105, 0, 1, 666, N' GASTO PERSONAL ALLAN ', N'', N'11/09/2023', N'', CAST(1200.00 AS Decimal(18, 2)), CAST(N'2023-09-13T11:41:11.493' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2713, 1702307804, 2, 161, 105, 0, 1, 667, N'GASTO PERSONAL ALLAN ', N'', N'12/09/2023', N'', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-09-13T11:45:31.340' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2714, 1702307804, 2, 161, 105, 0, 1, 668, N'GASTO PERSONAL ALLAN SEGURO RZR', N'', N'12/09/2023', N'', CAST(2600.00 AS Decimal(18, 2)), CAST(N'2023-09-13T11:50:09.213' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2715, 1702307804, 2, 161, 105, 0, 1, 669, N'GASTO PERSONAL ALLAN BOTELLA ', N'', N'12/09/2023', N'', CAST(2700.00 AS Decimal(18, 2)), CAST(N'2023-09-13T11:54:13.300' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2716, 1702307804, 2, 161, 105, 0, 1, 670, N'GASTO PERSONAL ALLAN BOTELLA ', N'', N'12/09/2023', N'', CAST(1800.00 AS Decimal(18, 2)), CAST(N'2023-09-13T11:55:18.763' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2717, 1702307804, 2, 1205, 105, 0, 1, 671, N'INTERES FABRE ', N'', N'12/09/2023', N'', CAST(1100.00 AS Decimal(18, 2)), CAST(N'2023-09-13T12:00:37.227' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2718, 1702307804, 2, 1205, 100, 0, 1, 672, N'INTERES CABRERA ', N'', N'11/09/2023', N'', CAST(135000.00 AS Decimal(18, 2)), CAST(N'2023-09-13T12:14:43.603' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2719, 1702307804, 2, 161, 1109, 0, 1, 673, N'GASTO PERSONAL ALLAN PAGO TARJETA ', N'', N'11/09/2023', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-13T12:29:51.383' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2720, 1702307804, 2, 1191, 103, 0, 3, 674, N'SERRANO FAKE ', N'', N'31/12/2022', N'', CAST(397000.00 AS Decimal(18, 2)), CAST(N'2023-09-14T08:10:16.450' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2721, 1702307804, 5, 1211, 103, 1109, 3, 675, N'BETO CASILLAS', N'', N'04/09/2023', N'', CAST(400000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T16:55:22.607' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2722, 1702307804, 2, 161, 100, 0, 1, 676, N'GASTO PERSONAL ALLAN ', N'', N'12/09/2023', N'', CAST(800.00 AS Decimal(18, 2)), CAST(N'2023-09-14T13:42:37.473' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2723, 1702307804, 5, 1211, 103, 106, 3, 677, N'PRESTAMO BETO ', N'', N'15/09/2023', N'PRESTAMO QUE PIDIÓ ALLAN ', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:07:41.050' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2724, 1702307804, 2, 161, 100, 0, 1, 678, N'GASTO PERSONAL ALLAN ALTAGRACIA ', N'', N'15/09/2023', N'', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-09-18T08:29:05.427' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2725, 1702307804, 2, 1205, 100, 0, 1, 679, N'INTERES DAVID GONZALEZ', N'', N'15/09/2023', N'', CAST(64000.00 AS Decimal(18, 2)), CAST(N'2023-09-18T10:45:46.013' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2726, 1702307804, 2, 161, 106, 0, 1, 680, N'GASTO PRESTAMOS DEL BANCO PERSONAL ', N'', N'15/09/2023', N'', CAST(3700.00 AS Decimal(18, 2)), CAST(N'2023-09-18T10:55:34.540' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2727, 1702307804, 2, 161, 106, 0, 1, 681, N'GASTO PERSONAL ALLAN BMW', N'', N'15/09/2023', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-21T13:52:26.803' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2728, 1702307804, 2, 161, 106, 0, 1, 682, N'GASTO PERSONAL DEPA DE ALLAN ', N'', N'15/09/2023', N'', CAST(34000.00 AS Decimal(18, 2)), CAST(N'2023-09-18T12:38:34.397' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2729, 1702307804, 2, 161, 100, 0, 1, 683, N'INTERES TOBY ', N'', N'15/09/2023', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-09-18T12:39:23.533' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2730, 1702307804, 2, 1222, 100, 0, 1, 684, N'NOMINA ALLAN ', N'', N'15/09/2023', N'', CAST(7000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:36:34.097' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2731, 1702307804, 2, 161, 100, 0, 1, 685, N'GASTO PERSONAL DE ALLAN ', N'', N'15/09/2023', N'ME VA A REGRESAR 5,000 EL LUNES. 

(NO LOS REGRESÓ)', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-18T12:51:54.187' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2732, 1702307804, 4, 179, 102, 0, 1, 686, N'PAGO PINACHO ', N'', N'19/09/2023', N'PAGO EN CUENTA FISCAL, IVA INCLUIDO ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-09-19T12:37:49.563' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2733, 1702307804, 1, 178, 102, 0, 3, 687, N'VENTA DE RECTIFICADORA MARCA TOYOTA ', N'F-0021', N'20/09/2023', N'EL CLIENTE PIDIÓ UN CRÉDITO DEL 50 % PAGADERO A UN MES ', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2023-09-20T10:30:16.047' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2734, 1702307804, 4, 154, 102, 0, 3, 688, N'ANTICIPO DEL 50 %', N'F-001', N'20/09/2023', N'', CAST(250000.00 AS Decimal(18, 2)), CAST(N'2023-09-20T10:30:18.020' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2735, 1702307804, 3, 152, 100, 0, 3, 689, N'COMPRA DE RECTIFICADORA ', N'F-001', N'20/09/2023', N'', CAST(400000.00 AS Decimal(18, 2)), CAST(N'2023-09-20T10:30:20.853' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2736, 1702307804, 5, 1216, 103, 100, 3, 690, N'PRESTAMO PERSONAL ALTAGRACIA', N'', N'20/09/2023', N'', CAST(58000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:05:28.030' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2737, 1702307804, 4, 154, 102, 0, 1, 691, N'PAGO HWACHEON ', N'', N'21/09/2023', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-09-21T11:40:33.350' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2738, 1702307804, 2, 161, 100, 0, 1, 692, N'GASTO PERSONAL ALLAN ', N'', N'21/09/2023', N'PAGO DE UN PRESTAMO PERSONAL ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-21T13:52:55.567' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2739, 1702307804, 2, 161, 100, 0, 1, 693, N'GASTO PERSONAL ALLAN TARJETA AMEX', N'', N'21/09/2023', N'LIQUIDÓ TARJETA AMERICAN EXPRESS, EL SEGURO QUE COBRARON ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-09-21T13:57:02.677' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2740, 1702307804, 4, 154, 103, 0, 1, 694, N'PAGO PRÉSTAMO CHIQUIS', N'', N'11/08/2023', N'', CAST(36000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T10:30:14.180' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2741, 1702307804, 2, 161, 106, 0, 1, 695, N'GASTO PERSONAL ALLAN BMW (PAGO DE MENSUALIDAD)', N'', N'18/05/2023', N'PAGO DE MENSUALIDAD DE BMW', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T10:46:02.790' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2742, 1702307804, 2, 161, 103, 0, 3, 696, N'BMW', N'', N'31/12/2022', N'', CAST(350000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T10:48:16.630' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2743, 1702307804, 4, 179, 103, 0, 1, 697, N'LIQUIDADO PRÉSTAMO ASPIRIA ', N'', N'14/07/2023', N'', CAST(83000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T11:05:52.880' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2744, 1702307804, 5, 1224, 102, 100, 3, 698, N'ADELANTO COMISION VF3 A DAVID ', N'', N'22/09/2023', N'SE LE ADELANTO A DAVID POR LA VENTA DE VF396', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:43:58.963' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2745, 1702307804, 4, 154, 102, 0, 3, 699, N'PAGO DE DEDUDA POR ADELANTO DE VF3', N'', N'22/09/2023', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:44:03.927' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2746, 1702307804, 5, 1224, 103, 100, 1, 700, N'COMISIONES PENDIENTES DAVID ', N'', N'22/09/2023', N'A CUENTA DE VARIAS VENTAS ', CAST(56450.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:37:18.830' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2747, 1702307804, 4, 154, 103, 0, 3, 701, N'PAGO DE COMISIONES PENDIENTES DAVID ', N'', N'22/09/2023', N'', CAST(46450.00 AS Decimal(18, 2)), CAST(N'2023-09-22T13:53:40.060' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2748, 1702307804, 1, 165, 102, 0, 1, 702, N'VENTA DE CENTRO DE MAQ. VF3 AÑO 2000', N'A-00007', N'23/09/2023', N'VENTA DE CENTRO DE MAQUINADO VF3 AÑO 2000, VENDIDA POR DAVID EL DÍA SÁBADO', CAST(525000.00 AS Decimal(18, 2)), CAST(N'2023-09-25T13:19:02.910' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2749, 1702307804, 4, 154, 102, 0, 1, 703, N'ABONO DE CENTRO DE MAQ. VF3 AÑO 2000', N'A-00007', N'23/09/2023', N'PRIMER PAGO DE CENTRO DE MAQUINADO VF3 ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-25T13:21:09.147' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2750, 1702307804, 2, 1205, 100, 0, 1, 704, N'INTERESES CABRERA ', N'', N'05/06/2023', N'', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2023-09-26T13:42:55.320' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2751, 1702307804, 4, 154, 102, 0, 1, 705, N'PAGADO PRESTAMO QUE SE LE HIZO A PAPÁ DE ALLAN ', N'', N'13/06/2023', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T07:41:31.527' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2752, 1702307804, 4, 154, 102, 0, 1, 706, N'PAGO DE CENTRO DE MAQ. AÑO 2000', N'A-00007', N'26/09/2023', N'PAGO EN EFECTIVO DE CENTRO DE MAQUINADO ', CAST(390000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T09:32:58.427' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2753, 1702307804, 4, 154, 102, 0, 1, 707, N'PAGO DE PERFILADORA ACRAMILL', N'', N'27/09/2023', N'PAGO EN EFECTIVO ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T09:36:10.360' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2754, 1702307804, 5, 1226, 103, 100, 3, 708, N'PRÉSTAMO JORGE LLANOS ', N'', N'07/08/2023', N'DEBE ALLAN 26,000 DÓLARES ', CAST(459940.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:13:37.733' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2755, 1702307804, 5, 1227, 103, 100, 3, 709, N'PRÉSTAMO MIGUEL MOVER TOTOTLÁN ', N'', N'07/08/2023', N'LE DEBE ALLAN 25,000', CAST(442250.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:13:40.067' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2756, 1702307804, 2, 1205, 100, 0, 1, 710, N'INTERESES SRA. BERTHA ', N'', N'26/09/2023', N'PAGO DE INTERESES A LA SEÑORA BERTHA ', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:56:24.077' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2757, 1702307804, 2, 161, 100, 0, 1, 711, N'GASTO PERSONAL DE ALLAN COMIDA ', N'', N'26/09/2023', N'SE FUE A COMER CON CARRILLO Y SE GASTÓ 4,000
SE QUEDÓ CON 2,000', CAST(6000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T13:59:17.377' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2758, 1702307804, 2, 161, 100, 0, 1, 712, N'GASTO PERSONAL ALLAN TACOMA ', N'', N'26/09/2023', N'PAGÓ EL ARREGLO DE LA TACOMA PORQUE SE BRISEA CON LAS PINTURAS ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:00:13.190' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2759, 1702307804, 2, 161, 100, 0, 1, 713, N'GASTO PERSONAL DE ALLAN ALTAGRACIA', N'', N'27/09/2023', N'GASTO DE SEMANAS QUE LE DEBÍA ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:01:11.077' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2760, 1702307804, 2, 176, 100, 0, 1, 714, N'HONORARIOS FREDDY ', N'', N'27/09/2023', N'PAGO DE HONORARIOS DE AUDITORIA ALLAN ', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:10:34.153' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2761, 1702307804, 4, 154, 103, 0, 1, 715, N'PAGO DE COMISIÓN A DAVID ', N'', N'26/09/2023', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:12:23.457' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2762, 1702307804, 2, 161, 100, 0, 1, 716, N'GASTO PERSONAL ALLAN RIFA ', N'', N'27/09/2023', N'GASTO DE RIFA EN LA QUE ESTÁ ALLAN ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-09-27T14:24:52.730' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2763, 1702307804, 4, 180, 102, 0, 1, 717, N'PAGO DE CENTRO DE MAQUINADO VF3 DOBLE PALLET', N'', N'02/08/2023', N'DEPOSITO A TARJETA DE DAVID ', CAST(80000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T13:33:57.107' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2764, 1702307804, 4, 180, 102, 0, 1, 718, N'PAGO DE CENTRO DE MAQUINADO VF3 DOBLE PALLET ', N'', N'23/08/2023', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T13:36:52.377' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2765, 1702307804, 4, 180, 102, 0, 1, 719, N'PAGO DE CENTRO DE MAQUINADO VF3 DOBLE PALLET ', N'', N'27/09/2023', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-09-28T13:41:54.427' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2766, 1702307804, 4, 179, 102, 0, 1, 720, N'PAGO DE TARJETA PROCESO GUILLERMO LIMÓN ', N'', N'29/09/2023', N'ULTIMO PAGO DE TARJETA PROCESO ', CAST(41200.00 AS Decimal(18, 2)), CAST(N'2023-09-29T08:53:21.580' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2767, 1702307804, 1, 1233, 102, 0, 1, 721, N'VENTA DE INYECTORA DE PLÁSTICOS ', N'', N'28/09/2023', N'ALLAN ACORDÓ CON EL CLIENTE QUE SE PAGARÁ MÁS TARDAR EL 26 DE DICIEMBRE 
LE  DIÓ UN COMPRESOR TAMBIÉN EL CLIENTE ', CAST(130000.00 AS Decimal(18, 2)), CAST(N'2023-10-12T12:12:31.020' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2768, 1702307804, 3, 1234, 100, 0, 1, 722, N'COSTO TOTAL DEL MES DE SEPTIEMBRE', N'C-009', N'30/09/2023', N'SE REGISTRA EL TOTAL DEL COSTO DEL MES DE SEPTIEMBRE
PERFILADORA ACRA
INYECTORA DE PLASTICOS POTENZA
CENTRO DE MAQUINADO VF3
TORNO CNC HARDINGE 
', CAST(619682.00 AS Decimal(18, 2)), CAST(N'2023-10-02T09:01:35.003' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2769, 1702307804, 1, 166, 102, 0, 1, 723, N'VENTA DE TORNO CNC HARDINGE ', N'', N'30/09/2023', N'VENTA DE TORNO CNC HARDINGE, SÁBADO 30 DE SEPTIEMBRE ', CAST(265000.00 AS Decimal(18, 2)), CAST(N'2023-10-02T08:55:01.733' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2770, 1702307804, 4, 154, 102, 0, 1, 724, N'PAGO DE TORNO CNC HARDINGE ', N'', N'30/09/2023', N'PRIMER PAGO RECIBIDO POR DAVID, ALLAN SE LO LLEVÓ A ESTADOS UNIDOS EN DOLARES ', CAST(125000.00 AS Decimal(18, 2)), CAST(N'2023-10-02T08:56:26.333' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2771, 1702307804, 4, 180, 102, 0, 1, 725, N'PAGO DE CENTRO DE MAQ. VF3 DOBLE PALLET ', N'', N'30/09/2023', N'', CAST(90000.00 AS Decimal(18, 2)), CAST(N'2023-10-02T10:35:46.627' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2772, 1702307804, 2, 1222, 106, 0, 1, 726, N'NOMINAS ', N'', N'30/09/2023', N'', CAST(7000.00 AS Decimal(18, 2)), CAST(N'2023-10-02T10:46:07.300' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2773, 1702307804, 4, 180, 102, 0, 1, 727, N'PAGO DE CENTRO DE MAQUINADO DOBLE PALLET', N'', N'02/10/2023', N'PAGO QUE ESTÁ EN LA TARJETA DE DAVID, PENDIENTE CHWECAR GASTOS ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-10-02T12:25:12.047' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2774, 1702307804, 5, 1217, 103, 106, 1, 728, N'PRÉSTAMO NUEVO DE SERRANO ', N'DP-00009', N'30/09/2023', N'PRESTAMO NUEVO QUE PIDIÓ ALLAN PARA IRSE A ESTADOS UNIDOS, ESTÁ EN LA TARJETA DE DAVID ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-10-03T08:30:47.760' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2775, 1702307804, 4, 180, 103, 0, 1, 729, N'ABONO A COMISIONES DE DAVID CRUZ ', N'', N'30/09/2023', N'', CAST(23500.00 AS Decimal(18, 2)), CAST(N'2023-10-03T11:10:44.400' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2776, 1702307804, 4, 157, 102, 0, 1, 730, N'PAGO DE TORNO PINACHO ', N'', N'02/10/2023', N'PAGADO EN CUENTA FISCAL CON IVA INCLUIDO', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-10-03T11:50:00.747' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2777, 1702307804, 2, 161, 100, 0, 1, 731, N'GASTO PERSONAL DE ALLAN ', N'', N'01/10/2023', N'GASTO PERSONAL DE ALLAN', CAST(5500.00 AS Decimal(18, 2)), CAST(N'2023-10-03T13:09:31.237' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2778, 1702307804, 2, 161, 100, 0, 1, 732, N'GASTO PERSONAL ALLAN RZR ', N'', N'30/09/2023', N'GASTO PERSONAL DE ALLAN DE RZR ', CAST(9500.00 AS Decimal(18, 2)), CAST(N'2023-10-04T08:54:54.527' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2779, 1702307804, 2, 161, 106, 0, 1, 733, N'GASTO PERSONAL ALLAN CUPRA ', N'', N'02/10/2023', N'GASTO PERSONAL DE ALLAN, PAGO DE CUPRA ', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-10-04T09:29:05.200' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2780, 1702307804, 2, 1205, 106, 0, 1, 734, N'INTERESES BETO CASILLAS ', N'', N'30/09/2023', N'PAGO DE INTERESES A BETO CASILLAS ', CAST(14000.00 AS Decimal(18, 2)), CAST(N'2023-10-04T09:30:40.030' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2781, 1702307804, 2, 176, 100, 0, 1, 735, N'GASTO DE TARJETA MOCON A MARIO PEREZ ', N'', N'30/09/2023', N'PAGO DE UNA REPARACIÓN DE UNA TARJETA ', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-10-04T09:35:33.760' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2782, 1702307804, 2, 161, 106, 0, 1, 736, N'GASTO PERSONAL DE ALLAN CHINO BARBA ', N'', N'30/09/2023', N'NI IDEA DE QUIEN SEA CHINO BARBA, PENDIENTE INVESTIGAR SI ES GASTO PERSONAL ', CAST(5600.00 AS Decimal(18, 2)), CAST(N'2023-10-04T10:06:46.237' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2783, 1702307804, 2, 161, 100, 0, 1, 737, N'GASTO PERSONAL DE ALLAN RIFA ', N'', N'04/10/2023', N'GASTO PERSONAL DE LA RIFA DE ALLAN ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-10-04T10:34:04.100' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2784, 1702307804, 2, 1231, 100, 0, 1, 738, N'GASTO DE GASOLINA A NISSAN', N'', N'04/10/2023', N'GASTO PARA GASOLINA NISSAN ', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2023-10-04T10:35:07.763' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2785, 1702307804, 3, 1234, 100, 0, 1, 739, N'COSTO TOTAL DEL MES DE JUNIO ', N'C-006', N'30/06/2023', N'SE REGISTRA EL TOTAL DEL COSTO DEL MES DE JUNIO 
RECTIFICADORA	 KENT
RECTIFICADORA	 MANUAL
CENTRO DE MAQUINADO 	 MORI SEIKI 
APILADOR  DESCONOCIDO
TORNO CNC  HWACHEON 
TORNO CNC  HAAS HL-4
TORNO CONVENCIONAL PINACHO 
PERFILADORA 	BRIDGEPORT 
CENTRO DE MAQUINADO	HAAS VF0 
', CAST(1241381.00 AS Decimal(18, 2)), CAST(N'2023-10-04T11:39:56.950' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2786, 1702307804, 2, 1205, 100, 0, 1, 740, N'INTERESES DAVID GONZALEZ ', N'', N'04/10/2023', N'EFECTIVO PARA INTERESES DE DAVID GONZALEZ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-10-04T11:48:38.347' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2787, 1702307804, 2, 176, 100, 0, 1, 741, N'GASTO DE CAJAS PARA GUARDAR REFACCIONES ', N'', N'05/10/2023', N'BENITO PIDIÓ CAJAS DE PLÁSTICO PARA GUARDAR REFACCIONES ', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-10-05T08:59:59.837' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2788, 1702307804, 2, 176, 100, 0, 1, 742, N'GASTO DE DIESEL ', N'', N'05/10/2023', N'COMPRA DE DIESEL PARA PONERLO AL MONTACARGAS Y MOVER UNAS MÁQUINAS', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-10-05T09:33:39.177' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2789, 1702307804, 3, 1234, 100, 0, 1, 743, N'COSTO TOTAL DEL MES DE ENERO', N'C-001', N'31/01/2023', N'SE REGISTRAL EL TOTAL DEL COSTO DEL MES DE ENERO 
CENTRO DE MAQUINADO VF4
TORNO CNC MORI SEIKI 
PERFILADORA BRIDGEPORT 
TORNO CNC FEMCO  ', CAST(631897.00 AS Decimal(18, 2)), CAST(N'2023-10-06T09:10:34.813' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2790, 1702307804, 3, 1234, 100, 0, 1, 744, N'COSTO TOTAL DEL MES DE FEBRERO ', N'C-002', N'28/02/2023', N'SE REGISTRA EL COSTO TOTAL DEL MES DE FEBRERO 
CENTRO DE MAQUINADO VF1 
CENTRO DE MAQUINADO MINI VF2 
CENTRO DE MAQUINADO VF3 
TORNO CONVENCIONAL LOGAN 
TORNO CONVENCIONAL CLARK 
TORNO CNC FEMCO 
SIERRA-CINTA HYD-MECH 
CENTRO DE MAQUINADO TAKUMI 
TORNO CNC ST-30 
CENTRO DE MAQUINADO SUPER VF3 ', CAST(2083131.00 AS Decimal(18, 2)), CAST(N'2023-10-06T09:11:02.330' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2791, 1702307804, 3, 1234, 100, 0, 1, 745, N'COSTO TOTAL DEL MES DE MARZO', N'C-003', N'31/03/2023', N'SE REGISTRA EL COSTO TOTAL DEL MES DE MARZO 
CENTRO DE MAQUINADO VF4 
TORNO CONVENCIONAL COLCHESTER 
PERFILADORA GORTON ', CAST(451108.00 AS Decimal(18, 2)), CAST(N'2023-10-06T08:32:31.650' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2792, 1702307804, 3, 1234, 100, 0, 1, 746, N'COSTO TOTAL DEL MES DE ABRIL ', N'C-004', N'30/04/2023', N'SE REGISTRA EL COSTO TOTAL DEL MES DE ABRIL 
PERFILADORA TITANIUM 
TORNO CNC FEMCO 
CEPILLO DE CODO AMERICANO 
TORNO CONVENCIONAL 14X40 ', CAST(312429.00 AS Decimal(18, 2)), CAST(N'2023-10-06T08:35:55.787' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2793, 1702307804, 3, 1234, 100, 0, 1, 747, N'COSTO TOTAL DEL MES DE MAYO ', N'C-005', N'31/05/2023', N'SE REGISTRA EL COSTO TOTAL DEL MES DE MAYO 
FRESADORA CHINERIK 
PERFILADORA BRIDGEPORT 
PERFILADORA SHIKUOKA 
CENTRO DE MAQUINADO VF4 
PERFILADORA BRIDGEPORT 
PERFILADORA TREE
PERFILADORA BRIDGEPORT 
RECTIFICADORA KENT 
TORNO CONVENCIONAL ROMI 
TORNO CONVENCIONAL DMTG 
TORNO CONVENCIONAL TB32120-C ', CAST(1066444.00 AS Decimal(18, 2)), CAST(N'2023-10-06T08:41:02.207' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2794, 1702307804, 3, 1234, 100, 0, 1, 748, N'COSTO TOTAL DEL MES DE JULIO', N'C-007', N'31/07/2023', N'SE REGISTRA EL COSTO TOTAL DEL MES DE JULIO 
CENTRO DE MAQUINADO VF4 2019
CENTRO DE MAQUINADO VF3 DOBLE PALLET
SIERRA-CINTA DOALL
TORNO TOS SN-40 
TORNO CHECOSLOVACO SN-71', CAST(1816908.00 AS Decimal(18, 2)), CAST(N'2023-10-06T08:46:19.350' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2795, 1702307804, 3, 1234, 100, 0, 1, 749, N'COSTO TOTAL DEL MES DE AGOSTO ', N'C-008', N'31/08/2023', N'SE REGISTRA EL COSTO TOTAL DEL MES DE AGOSTO 
CENTRO DE MAQUINADO FADAL 4020 
CENTRO DE MAQUINADO HAAS VF3 1995
MONTACARGAS NISSAN 
TORNO CONVENCIONAL RUSO ', CAST(629086.00 AS Decimal(18, 2)), CAST(N'2023-10-06T08:49:22.113' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2796, 1702307804, 2, 1222, 100, 0, 1, 750, N'GASTO NÓMINAS ', N'', N'06/10/2023', N'PAGO DE NÓMINAS, MARIANA Y RICARDO ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-10-09T07:36:09.980' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2797, 1702307804, 2, 161, 100, 0, 1, 751, N'GASTO PERSONAL PAGO DE TARJETA ', N'', N'09/10/2023', N'LIQUIDÓ LA TARJETA LIVERPOOL ALLAN GALVÁN ', CAST(23500.00 AS Decimal(18, 2)), CAST(N'2023-10-10T08:48:59.517' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2798, 1702307804, 2, 161, 100, 0, 1, 752, N'GASTO PERSONAL PAGO DE RENTA CASA ALLAN ', N'', N'09/10/2023', N'GASTO PERSONAL PAGO DE SAN ESTEBAN ALLAN ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-10-10T08:54:49.200' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2799, 1702307804, 4, 154, 102, 0, 1, 753, N'PAGO DE TORNO CNC HWACHEON ', N'', N'09/10/2023', N'PAGO DE TORNO CNC HWACHEON, ENTREGADO A ALLAN GALVAN ', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-10-10T09:29:36.100' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2800, 1702307804, 2, 1205, 100, 0, 1, 754, N'GASTO DE INTERES SUSANA ', N'', N'09/10/2023', N'PAGO DE INTERESES SUSANA ', CAST(7500.00 AS Decimal(18, 2)), CAST(N'2023-10-10T09:31:05.663' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2801, 1702307804, 2, 160, 100, 0, 1, 755, N'GASTO DE ISN DEL MES DE OCTUBRE ', N'', N'09/10/2023', N'PAGO DE IMPUESTO SOBRE NOMINA DE OCTUMBRE ', CAST(600.00 AS Decimal(18, 2)), CAST(N'2023-10-10T10:00:50.637' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2802, 1702307804, 2, 1205, 100, 0, 1, 756, N'GASTO INTERESES DAVID GONZALES ', N'', N'09/10/2023', N'PAGO DE UNOS INTERESES QUE DEBE ALLAN GALVÁN, FUERON 10,000 Y 2,000 DE LOS INTERES DE DAVID CRUZ, PENDIENTE    ', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2023-10-10T10:30:17.257' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2803, 1702307804, 4, 154, 103, 0, 3, 757, N'PAGADO PRESTAMO DE JORGE LLANOS (DÓLARES)', N'', N'04/10/2023', N'PAGADO PRESTAMO DE DÓLARES ', CAST(459940.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:10:00.620' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2804, 1702307804, 5, 1226, 103, 100, 3, 758, N'PRESTAMO JORGE LLANOS NUEVO', N'', N'04/10/2023', N'LE PAGAMOS A JORGE LLANOS PERO NOS HIZO UN NUEVO PRESTAMO DE 15,000 DLS ', CAST(267600.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:09:58.457' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2805, 1702307804, 5, 1237, 103, 100, 3, 759, N'NUEVO PRESTAMO DAVID GONZALES ', N'', N'04/10/2023', N'NUEVO PRESTAMO A DAVID GONZALES, ', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:09:50.500' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2806, 1702307804, 4, 154, 103, 0, 3, 760, N'PAGADO PRESTAMO MIGUEL MOVER ', N'', N'04/10/2023', N'PAGADO EL PRESTAMO A MIGUEL MOVER TOTOTLÁN ', CAST(442250.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:09:56.130' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2807, 1702307804, 4, 154, 103, 0, 1, 761, N'PAGO DE PARTE DE COMISIÓN DAVID ', N'', N'07/10/2023', N'PAGO EN EFECTIVO, DAVID TOMÓ EL DINERO ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-10-11T13:01:36.067' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2808, 1702307804, 4, 1203, 103, 0, 1, 762, N'PAGO DE COMISIONES PENDIENTES A DAVID ', N'', N'09/10/2023', N'PAGO DE COMISIONES PENDIENTES A DAVID, FUE POR TRANSFERENCIA, TARJETA DE MARIANA ', CAST(4500.00 AS Decimal(18, 2)), CAST(N'2023-10-11T13:04:36.343' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2809, 1702307804, 4, 180, 103, 0, 1, 763, N'PAGO DE COMISIONES PENDIENTES DAVID ', N'', N'10/10/2023', N'SE LE ENTREGÓ ESTE DINERO PARA QUE PAGARA LA RENTA DE SU CASA COMENTÓ ALLAN ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-10-11T13:06:50.313' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2810, 1702307804, 1, 153, 105, 0, 1, 764, N'VENTA DE PERFILADORA SUPERMAX', N'A-00012', N'04/10/2023', N'VENTA DE PERDILADORA SUPERMAX, EL PAGO SE REALIZÓ EN DOS PARTES, EN LA CUENTA FISCAL UNA POR LA MAQUINA Y OTRA POR SERVICIO ', CAST(85000.00 AS Decimal(18, 2)), CAST(N'2023-10-12T11:57:08.820' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2811, 1702307804, 4, 180, 102, 0, 1, 765, N'PAGO DE CENTRO DE MAQUINADO VF3 DOBLE PALLET', N'', N'06/10/2023', N'Y SE LOS GASTÓ ALLAN EN ESTADOS UNIDOS AFIRMA Y CONFIRMA ÉL ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-10-12T13:30:50.653' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2812, 1702307804, 5, 1207, 103, 100, 1, 766, N'PRESTAMO HERMANO DE ALLAN ', N'', N'13/10/2023', N'PRESTAMO PERSONAL QUE PIDIÓ ALLAN ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-10-16T08:35:42.653' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2813, 1702307804, 2, 1222, 106, 0, 1, 767, N'NÓMINAS ', N'', N'13/10/2023', N'NOMINAS DE LA SEMANA ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-10-16T08:37:27.710' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2814, 1702307804, 5, 1212, 102, 100, 1, 768, N'PRÉSTAMO A PAPÁ DE ALLAN', N'', N'13/10/2023', N'PRESTAMO QUE ALLAN LE HIZO A SU PAPÁ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-10-16T08:58:25.547' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2816, 1702307804, 4, 180, 102, 0, 1, 769, N'PAGO DE TORNO CNC HARDINGE ', N'', N'16/10/2023', N'', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-10-20T11:05:44.103' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2817, 1702307804, 4, 180, 102, 0, 1, 770, N'PAGO DE VF3 AÑO 1995', N'A-00005', N'16/10/2023', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-10-20T11:22:49.550' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2818, 1702307804, 4, 180, 103, 0, 1, 771, N'PAGO DE COMISIONES DAVID ', N'', N'12/10/2023', N'PAGADO CON RESTOS QUE SE HA QUEDADO DAVID, AÚN SE LE DEBEN MA', CAST(8450.00 AS Decimal(18, 2)), CAST(N'2023-10-20T13:02:59.843' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2819, 1702307804, 1, 165, 105, 0, 1, 772, N'PAGO DE RENTA DE CENTRO DE MAQUINADO FADAL 6030', N'', N'18/10/2023', N'PAGO DE RENTA DE SEPTIEMBRE ', CAST(34800.00 AS Decimal(18, 2)), CAST(N'2023-10-24T08:41:23.677' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2820, 1702307804, 2, 1192, 100, 0, 1, 773, N'INTERÉS ING ANTONIO ', N'', N'18/10/2023', N'', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-10-24T09:28:18.047' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2821, 1702307804, 2, 161, 106, 0, 1, 774, N'GASTO PERSONAL DE ALLAN DEPARTAMENTO ', N'', N'18/10/2023', N'', CAST(34000.00 AS Decimal(18, 2)), CAST(N'2023-10-24T09:32:13.263' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2822, 1702307804, 5, 1211, 103, 1109, 3, 775, N'PRESTAMO BETO ', N'', N'23/10/2023', N'PRESTAMO QUE ALLAN LE PIDIÓ A BETO, SE DEPOSITO A LA TARJETA DE MARIANA', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2024-02-08T16:14:32.553' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2823, 1702307804, 5, 1239, 103, 100, 3, 776, N'PRESTAMO CHRISTIAN ', N'', N'23/10/2023', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:03:54.660' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2824, 1702307804, 5, 1216, 103, 100, 3, 777, N'PRESTAMO ALTAGRACIA', N'', N'23/10/2023', N'', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:03:52.773' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2825, 1702307804, 5, 1211, 103, 100, 3, 778, N'PRESTAMO BETO ', N'', N'23/10/2023', N'PRESTAMO EN EFECTIVO', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2024-02-08T16:14:37.797' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2826, 1702307804, 5, 1241, 103, 100, 3, 779, N'PRESTAMO TIO GUSTAVO ', N'', N'23/10/2023', N'', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:03:40.213' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2827, 1702307804, 5, 1224, 103, 105, 3, 780, N'PRESTAMO DAVID CRUZ', N'', N'23/10/2023', N'', CAST(11000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:03:43.353' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2828, 1702307804, 5, 1228, 103, 1109, 3, 781, N'PRESTAMO CARRILLO', N'', N'30/10/2023', N'PRESTAMO A TARJETA DE MARIANA', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2024-02-08T12:26:14.030' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2829, 1702307804, 5, 1208, 103, 106, 3, 782, N'PRESTAMO DE TIO GUSTAVO ', N'', N'30/10/2023', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:00:46.450' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2830, 1702307804, 5, 1242, 103, 100, 3, 783, N'PRESTAMO VALDIVIA', N'', N'30/10/2023', N'', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:00:49.407' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2831, 1702307804, 1, 166, 105, 0, 1, 784, N'VENTA DE TORNO CNC SL-20', N'NO. 15', N'01/11/2023', N'SE VENDIÓ POR 295,000 ', CAST(342200.00 AS Decimal(18, 2)), CAST(N'2023-11-03T11:38:34.280' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2832, 1702307804, 3, 1234, 100, 0, 1, 785, N'COSTO TOTAL DEL MES DE OCTUBRE ', N'C-010', N'31/10/2023', N'SE REGISTRA EL TOTAL DEL COSTO DEL MES DE OCTUBRE 
PERFILADORA SUPERMAX ', CAST(41120.91 AS Decimal(18, 2)), CAST(N'2023-11-03T11:50:23.200' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2880, 1702307804, 4, 1203, 102, 0, 1, 786, N'PAGO DE PERFILADORA ACRAMILL  ', N'', N'06/11/2023', N'PAGO EN TARJETA DE MARIANA', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-11-06T13:40:39.900' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2881, 1702307804, 4, 1203, 102, 0, 1, 787, N'PAGO DE PERFILADORA ACRAMILL ', N'', N'17/10/2023', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-11-06T14:44:04.267' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2882, 1702307804, 2, 161, 100, 0, 1, 788, N'GASTO PERSONAL ALLAN RENTA ', N'', N'04/11/2023', N'PAGO RENTA DE SU CASA', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-11-06T17:34:20.353' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2883, 1702307804, 2, 161, 100, 0, 1, 789, N'GASTO PERSONAL DE ALLAN ', N'', N'04/11/2023', N'NO ME DIJO EN QUE SE LO GASTÓ, SOLO GASTO PERSONAL', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-11-06T17:35:34.837' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2884, 1702307804, 1, 178, 106, 0, 1, 790, N'VENTA DE RECTIFICADORA HIDROMATIC', N'NO. 61', N'04/11/2023', N'VENTA DE RECTIFICADORA HIDROMATIC, DINERO DEPOSITADO A TARJETA DE DAVID', CAST(95000.00 AS Decimal(18, 2)), CAST(N'2023-11-06T17:46:07.753' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2885, 1702307804, 4, 154, 103, 0, 1, 791, N'PAGO DE PRESTAMO VALDIVIA ', N'', N'04/11/2023', N'PAGADO POR ALLAN EN EFECTIVO ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-11-07T10:51:58.167' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2886, 1702307804, 2, 1222, 100, 0, 1, 792, N'PAGO DE NOMINAS ', N'', N'03/11/2023', N'PAGO DE NOMINAS A NATALIO, RICARDO Y MARIANA + 2,500 A MARIANA POR SL-20 ', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2023-11-07T10:53:39.127' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2887, 1702307804, 2, 1251, 100, 0, 1, 793, N'GASTO FACTURA FABRE ', N'', N'03/11/2023', N'COMPRA DE FACTURA PARA RETIRO EN EFECTIVO ', CAST(11600.00 AS Decimal(18, 2)), CAST(N'2023-11-07T11:08:09.900' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2888, 1702307804, 2, 1205, 100, 0, 1, 794, N'INTERESES ALFREDO AVILA ', N'', N'04/11/2023', N'PAGO DE INTERESES ALFREDO AVILA ', CAST(19500.00 AS Decimal(18, 2)), CAST(N'2023-11-07T11:09:43.703' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2889, 1702307804, 2, 161, 100, 0, 1, 795, N'GASTO PERSONAL DE ALLAN / ALTAGRACIA ', N'', N'04/11/2023', N'GASTO PERSONAL DE ALLAN, DINERO PARA ALTAGRACIA ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-11-07T11:10:52.810' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2890, 1702307804, 2, 1205, 100, 0, 1, 796, N'PAGO DE INTERESES DAVID GONZALES ', N'', N'04/11/2023', N'PAGO DE INTERESES 48,000 EFECTIVO Y 4,000 TRASFERENCIA ', CAST(52000.00 AS Decimal(18, 2)), CAST(N'2023-11-07T11:11:36.840' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2891, 1702307804, 2, 161, 100, 0, 1, 797, N'GASTO PERSONAL DE ALLAN LAVADORA ', N'', N'04/11/2023', N'GASTO DE ARREGLO DE LAVADORA DE ALLAN ', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-11-07T11:12:17.343' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2892, 1702307804, 2, 161, 105, 0, 1, 798, N'GASTO PERSONAL DE ALLAN GASOLIAN ', N'', N'04/11/2023', N'GASOLINA PARA LA CUPRA ', CAST(982.00 AS Decimal(18, 2)), CAST(N'2023-11-07T11:12:56.017' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2893, 1702307804, 2, 161, 105, 0, 1, 799, N'GASTO PERSONAL DE ALLAN COMIDA ', N'', N'04/11/2023', N'SE FUE A COMER ALLAN ', CAST(2056.00 AS Decimal(18, 2)), CAST(N'2023-11-07T11:16:32.080' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2894, 1702307804, 2, 161, 105, 0, 1, 800, N'GASTO PERSONAL DE ALLAN BOTELLA', N'', N'04/11/2023', N'GASTO PERSONAL DE UNA BOTELLA', CAST(320.00 AS Decimal(18, 2)), CAST(N'2023-11-07T11:15:49.667' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2895, 1702307804, 2, 161, 105, 0, 1, 801, N'GASTO PERSONAL DE ALLAN BOLICHE ', N'', N'04/11/2023', N'GASTO PERSONAL DE ALLAN FUE AL BOLICHE CON CHRIS ', CAST(720.00 AS Decimal(18, 2)), CAST(N'2023-11-07T11:16:22.017' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2896, 1702307804, 2, 161, 105, 0, 1, 802, N'GASTO PERSONAL DE ALLAN COMIDA ', N'', N'04/11/2023', N'GASTO PERSONAL DE COMIDA ', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-11-07T11:17:04.160' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2900, 1702307804, 2, 1205, 100, 0, 1, 803, N'PAGO DE INTERESES OSVALDO ', N'', N'04/11/2023', N'PAGO DE INTERESES A OSVALDO', CAST(8500.00 AS Decimal(18, 2)), CAST(N'2023-11-07T13:29:44.553' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2907, 1702307804, 6, 1250, 105, 100, 3, 804, N'TRANSFERENCIA ENTRE CUENTAS ', N'MOVIMIENTO A CAJA ', N'07/11/2023', N'SACAMOS DINERO DE LA CUENTA ', CAST(1000000.00 AS Decimal(18, 2)), CAST(N'2023-11-07T17:52:48.733' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2908, 1702307804, 2, 161, 100, 0, 1, 805, N'GASTO PERSONAL ALLAN COMIDA ', N'', N'07/11/2023', N'', CAST(619.00 AS Decimal(18, 2)), CAST(N'2023-11-07T18:04:36.583' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2910, 1702307804, 1, 166, 106, 0, 1, 806, N'VENTA DE TORNO AMERICAN MACHINE TOOLS ', N'NO. 004', N'15/11/2023', N'VENTA DE TORNO CONVENCIONAL AMERICAN MACHINE TOOLS ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-11-15T13:35:04.043' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2911, 1702307804, 1, 153, 102, 100, 1, 807, N'VENTA DE PERFILADORA BRIDGEPORT ', N'NO. 41 ', N'15/11/2023', N'VENTA DE PERFILADORA BRIDGEPORT, FALTAN 20,000 POR DAR PERO NO PUEDO PONERLO EN DEUDA POR COBRAR ', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-12-01T16:56:09.167' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2912, 1702307804, 2, 1205, 100, 0, 1, 808, N'PAGO DE PRESTAMO AMISTOSO DAVID GONZALES ', N'', N'14/11/2023', N'PAGO DE UN PRÉSTAMO AMISTOSO ', CAST(110000.00 AS Decimal(18, 2)), CAST(N'2023-11-22T16:44:42.543' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2913, 1702307804, 2, 1223, 105, 0, 1, 809, N'GASTO BLACK CONTADORES ', N'', N'17/11/2023', N'PAGO DE BLACK CONTADORES ', CAST(1800.00 AS Decimal(18, 2)), CAST(N'2023-11-24T12:30:29.143' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2914, 1702307804, 5, 1207, 102, 105, 1, 810, N'PRESTAMO A HERMANO DE ALLAN ', N'', N'20/11/2023', N'PRESTAMO A HERMANO DE ALLAN ', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-11-24T12:31:17.490' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2915, 1702307804, 2, 161, 105, 0, 1, 811, N'GASTO PERSONAL DE ALLAN ', N'', N'20/11/2023', N'GASTO PERSONAL SIN CONCEPTO ESPECIFICO ', CAST(500.00 AS Decimal(18, 2)), CAST(N'2023-11-24T12:34:05.367' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2916, 1702307804, 2, 1205, 100, 0, 1, 812, N'GASTO DE INTERESES ALFREDO AVILA', N'', N'25/11/2023', N'PAGO DE INTERESES ', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-11-27T13:53:54.910' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2917, 1702307804, 1, 165, 100, 0, 1, 813, N'VENTA DE CENTRO DE MAQUINADO VF2 ', N'', N'21/11/2023', N'VENTA DE CENTRO DE MAQUINADO VF2 ', CAST(340000.00 AS Decimal(18, 2)), CAST(N'2023-11-28T16:04:00.037' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2918, 1702307804, 1, 165, 100, 0, 1, 814, N'CENTRO DE MAQUINADO HAAS MINI MILL ', N'NO. 74', N'21/11/2023', N'', CAST(375000.00 AS Decimal(18, 2)), CAST(N'2023-11-28T16:15:02.560' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2919, 1702307804, 1, 165, 103, 0, 1, 815, N'CENTRO DE MAQUINADO VF3 AÑO 1997', N'NO. 71', N'16/11/2023', N'VENTA DE CM VF3 AÑO 1997', CAST(450000.00 AS Decimal(18, 2)), CAST(N'2023-12-01T17:56:33.617' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2920, 1702307804, 5, 1287, 103, 105, 1, 816, N'PRESTAMO KONFIO ', N'', N'21/11/2023', N'PRESTAMO KONFIO ', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2023-11-28T16:44:46.863' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2921, 1702307804, 1, 165, 102, 0, 3, 817, N'VENTA DE CENTRO DE MAQUINADO VF3 96', N'NO. 44', N'28/11/2023', N'', CAST(460000.00 AS Decimal(18, 2)), CAST(N'2024-02-27T16:28:07.280' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2922, 1702307804, 4, 180, 102, 0, 1, 818, N'PAGO DE VF3 AÑO 1995', N'', N'02/11/2023', N'', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2023-11-29T16:18:28.760' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2923, 1702307804, 2, 161, 105, 0, 1, 819, N'GASTO DE PRESTAMO DE TARJETA ', N'', N'16/11/2023', N'UN GASTO PERSONAL DE ALLAN ', CAST(2818.00 AS Decimal(18, 2)), CAST(N'2023-11-30T13:06:34.043' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2924, 1702307804, 2, 161, 105, 0, 1, 820, N'GASTO DE PRESTAMO DE ALLAN ', N'', N'16/11/2023', N'GASTO DE UN PRESTAMO EN LA CUENTA DE ALLAN QUE SE CARGAN AUTOMATICAMENTE ', CAST(1627.00 AS Decimal(18, 2)), CAST(N'2023-11-30T13:09:35.903' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2925, 1702307804, 2, 161, 105, 0, 1, 821, N'GASTO DE PRESTAMO PERSONAL BBVA DE ALLAN ', N'', N'16/11/2023', N'GASTO DE PRESTAMO PERSONAL QUE SE CARGA AUTOMATICAMENTE ', CAST(1643.00 AS Decimal(18, 2)), CAST(N'2023-11-30T13:10:25.910' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2926, 1702307804, 2, 1223, 105, 0, 1, 822, N'GASTO DE HONORARIOS A FREDDY ', N'', N'16/11/2023', N'GASTO DE HONORARIOS QUE LE DEBEMOS A FREDDY, AUN FALTAN 15,000', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-11-30T13:11:13.400' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2927, 1702307804, 2, 161, 105, 0, 1, 823, N'GASTO PERSONAL DE COMIDA ', N'', N'17/11/2023', N'PAGO DE COMIDA PARA MANIOBRISTAS ', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:10:58.357' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2928, 1702307804, 2, 161, 105, 0, 1, 824, N'GASTO PERSONAL DE ALLAN RZR Q', N'', N'17/11/2023', N'GASTO PERSONAL DE RZR ', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:11:31.040' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2929, 1702307804, 2, 1205, 105, 0, 1, 825, N'GASTO DE INTERESES LUIS ', N'', N'17/11/2023', N'HERMANO DE BETO ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:13:28.880' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2930, 1702307804, 2, 161, 105, 0, 1, 826, N'GASTO DE PRESTAMO ALTAGRACIA ', N'', N'18/11/2023', N'PAGO DE UN PRESTAMO PERSONAL DE ALTAGRACIA ', CAST(9500.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:14:33.200' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2931, 1702307804, 2, 161, 105, 0, 1, 827, N'GASTO PERSONAL DE COMIDA ', N'', N'19/11/2023', N'', CAST(1892.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:15:22.937' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2932, 1702307804, 2, 161, 105, 0, 1, 828, N'GASTO PERSONAL BOTELLAS ', N'', N'19/11/2023', N'', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:15:59.913' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2933, 1702307804, 2, 1205, 105, 0, 1, 829, N'GASTO DE INTERES DOÑA BERTHA', N'', N'19/11/2023', N'GASTO DE INTERES ', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:16:57.993' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2934, 1702307804, 2, 161, 105, 0, 1, 830, N'GASTO PERSONAL DE ALLAN ', N'', N'20/11/2023', N'GOGLES ', CAST(781.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:17:41.860' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2935, 1702307804, 2, 161, 105, 0, 1, 831, N'GASTO PERSONAL DE BOTELLAS', N'', N'20/11/2023', N'', CAST(685.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:21:10.613' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2936, 1702307804, 2, 161, 105, 0, 1, 832, N'GASTO PERSONAL GAS RZR ', N'', N'20/11/2023', N'', CAST(630.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:21:32.213' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2937, 1702307804, 2, 161, 105, 0, 1, 833, N'GASTO PERSONAL DE GAS TACOMA ', N'', N'20/11/2023', N'', CAST(2249.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:23:26.383' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2938, 1702307804, 2, 161, 105, 0, 1, 834, N'GASTO PERSONAL COMIDA ALLAN ', N'', N'20/11/2023', N'UN DESYUNO ', CAST(800.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:23:51.280' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2939, 1702307804, 2, 161, 105, 0, 1, 835, N'GASTO PERSONAL COMIDA ALLAN ', N'', N'20/11/2023', N'', CAST(2300.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:24:53.423' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2940, 1702307804, 2, 161, 105, 0, 1, 836, N'GASTO PERSONAL GOLF ALLAN ', N'', N'20/11/2023', N'PAGO DE GOLF ', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:25:28.120' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2941, 1702307804, 2, 161, 105, 0, 1, 837, N'GASTO PEROSNAL DE ALLAN BMW ', N'', N'20/11/2023', N'', CAST(11600.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:25:51.297' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2942, 1702307804, 2, 161, 105, 0, 1, 838, N'GASTO PERSONAL GAS BMW ', N'', N'23/11/2023', N'', CAST(1395.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:27:09.323' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2943, 1702307804, 2, 161, 105, 0, 1, 839, N'GASTO PERSONAL COMIDA ALLAN ', N'', N'23/11/2023', N'SE COMPRÓ UN SUBWAY ', CAST(106.00 AS Decimal(18, 2)), CAST(N'2023-11-30T14:27:41.033' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2944, 1702307804, 2, 176, 105, 0, 1, 840, N'GASTO DE COMISIÓN POR APERTURA DE PRESTAMO ', N'', N'20/11/2023', N'GASTO DE COMISIÓN POR APERTURA, PENDIENTE INVESTIGAR SI LOS DEJO EN ', CAST(12500.00 AS Decimal(18, 2)), CAST(N'2023-11-30T15:37:56.727' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2945, 1702307804, 4, 180, 102, 0, 1, 841, N'PAGADO VF3 1995', N'', N'30/11/2023', N'SE LOS QUEDÓ DAVID, ES EL SOBREPRECIO ', CAST(45000.00 AS Decimal(18, 2)), CAST(N'2023-11-30T15:44:15.400' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2946, 1702307804, 2, 161, 105, 0, 1, 842, N'GASTO DE STARBUCKS', N'', N'23/11/2023', N'', CAST(200.00 AS Decimal(18, 2)), CAST(N'2023-11-30T17:07:23.487' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2947, 1702307804, 2, 161, 105, 0, 1, 843, N'GASTO DE SEGURO GNP ALLAN ', N'', N'23/11/2023', N'', CAST(2439.00 AS Decimal(18, 2)), CAST(N'2023-11-30T18:14:49.063' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2948, 1702307804, 2, 161, 105, 0, 1, 844, N'GASTO PERSONAL DE ALLAN ', N'', N'23/11/2023', N'NO ME DIJO DE QUE SOLO GASTO PERSONAL ', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-11-30T18:15:18.863' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2949, 1702307804, 2, 1205, 105, 0, 1, 845, N'GASTO DE INTERSES CAYETANO ', N'', N'23/11/2023', N'', CAST(22420.00 AS Decimal(18, 2)), CAST(N'2023-12-01T11:05:01.220' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2950, 1702307804, 4, 179, 103, 0, 1, 846, N'PAGO DE DEUDA POR PAGAR CHRISTIAN CHRISTIAN', N'', N'23/11/2023', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-12-01T11:11:15.073' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2951, 1702307804, 2, 176, 100, 0, 1, 847, N'GASTO DE RENTA NOVIEMBRE ', N'', N'10/11/2023', N'', CAST(55000.00 AS Decimal(18, 2)), CAST(N'2023-12-01T14:53:41.060' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2952, 1702307804, 4, 154, 102, 0, 3, 848, N'PAGO DE PERFILADORA BRIDGEPORT', N'NO.44', N'15/11/2023', N'', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-12-01T17:25:18.790' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2953, 1702307804, 4, 180, 102, 0, 1, 849, N'PAGO DE PERFILADORA BRIDGEPORT ', N'NO.41', N'15/11/2023', N'', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-12-01T17:35:24.470' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2954, 1702307804, 3, 1234, 100, 0, 1, 850, N'COSTO TOTAL DEL MES DE NOVIEMBRE', N'C-011', N'30/11/2023', N'SE REGISTRA EL TOTAL DEL COSTO DEL MES DE NOVIEMBRE 
TORNO CNC SL20 
RECTIFICADORA HIDROMATIC 
TORNO AMERICAN MACHINE TOOLS
PERFILADORA BRIDGEPORT 
CENTRON DE MAQUINADO VF2
CENTRO DE MAQUINADO MINI MILL 
CENTRO DE MAQUINADO VF3 AÑO 1997 
CENTRO DE MAQUINADO VF3 AÑO 1996 ', CAST(1281267.97 AS Decimal(18, 2)), CAST(N'2024-01-04T11:09:45.450' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2955, 1702307804, 2, 161, 100, 0, 1, 851, N'GASTO PERSONAL DE ALLAN AUTOS ', N'', N'01/12/2023', N'GASTO DE TACOMA, CUPRA Y NISSAN ', CAST(44000.00 AS Decimal(18, 2)), CAST(N'2023-12-04T11:21:01.953' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2956, 1702307804, 2, 161, 100, 0, 1, 852, N'GASTO PAGO DE PRESTAMO ALTAGRACIA ', N'', N'01/12/2023', N'PAGO DE PRESTAMO PERSONA CON ALTAGRACIA ', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2023-12-04T11:22:07.890' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2957, 1702307804, 2, 1205, 100, 0, 1, 853, N'GASTO DE INTERESES BETO ', N'', N'01/12/2023', N'GASTO DE PAGO DE INTERESES BETO ', CAST(16000.00 AS Decimal(18, 2)), CAST(N'2023-12-04T11:22:53.770' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2958, 1702307804, 2, 1205, 100, 0, 1, 854, N'GASTO DE INTERESES TOBY ', N'', N'02/12/2023', N'PAGO DE INTERESES TOBY', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-12-04T11:23:47.887' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2959, 1702307804, 2, 1205, 100, 0, 1, 855, N'GASTO DE INTERESES SUSANA', N'', N'02/12/2023', N'PAGO DE INTERESES DE SUSANA ', CAST(7500.00 AS Decimal(18, 2)), CAST(N'2023-12-04T11:24:33.207' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2960, 1702307804, 2, 1205, 100, 0, 1, 856, N'GASTO DE INTERES ALFREDO AVILA ', N'', N'02/12/2023', N'GASTO DE ADELANTO DE INTERESES ALFREDO AVILA ', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-12-04T11:25:17.533' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2961, 1702307804, 2, 1288, 100, 0, 1, 857, N'GASTO DE PAGO DE TARJETA OSVALDO ', N'', N'02/12/2023', N'PAGO DE TARJETA DE CREDITO OSVALDO ', CAST(5500.00 AS Decimal(18, 2)), CAST(N'2023-12-04T11:26:56.187' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2962, 1702307804, 2, 176, 100, 0, 1, 858, N'PAGO DE RENTA IRINEO PAZ', N'', N'01/12/2023', N'PAGO DE RENTA MES DE DICIEMBRE ', CAST(55000.00 AS Decimal(18, 2)), CAST(N'2023-12-04T12:28:10.303' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2963, 1702307804, 2, 176, 100, 0, 1, 859, N'GASTO PLAYERAS MAQALLAN ', N'', N'02/12/2023', N'', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-12-04T13:56:18.230' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2964, 1702307804, 2, 176, 100, 0, 1, 860, N'GASTO DE BODEGA TAPA DE CALLE', N'', N'02/12/2023', N'', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-12-04T14:19:06.007' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2965, 1702307804, 2, 176, 100, 0, 1, 861, N'GASTO DE BODEGA COMPRA DE GRASA ', N'', N'04/12/2023', N'GASTO DE BODEGA, SE COMPRÓ GRASA ', CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-12-04T17:52:30.373' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2966, 1702307804, 1, 1289, 105, 0, 1, 862, N'VENTA DE MANDRINADORA TOS', N'NO.  47', N'05/12/2023', N'SE VENDIÓ ', CAST(464000.00 AS Decimal(18, 2)), CAST(N'2023-12-05T16:03:15.210' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2967, 1702307804, 2, 176, 100, 0, 1, 863, N'GASTO DE TRAPOS PARA LIMPIEZA DE MAQUINAS ', N'', N'05/12/2023', N'', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2023-12-05T16:06:23.120' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2968, 1702307804, 4, 154, 103, 0, 1, 864, N'PAGO DE PRESTAMO HERMANO DE ALLAN ', N'', N'27/10/2023', N'', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-12-05T16:28:00.227' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2969, 1702307804, 2, 176, 100, 0, 1, 865, N'GASTO DE BODEGA ', N'', N'05/12/2023', N'', CAST(300.00 AS Decimal(18, 2)), CAST(N'2023-12-05T18:02:39.137' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2970, 1702307804, 2, 161, 100, 0, 1, 866, N'GASTO PERSONAL DE ALLAN REPARACIÓN BMW', N'', N'05/12/2023', N'DICE QUE ME LOS VA A REGRESAR YA QUE LOS TOMAMOS DE LA CAJA CHICA', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2023-12-05T18:04:36.780' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2971, 1702307804, 2, 176, 100, 0, 1, 867, N'GASTO DE BODEGA CAJAS', N'', N'06/12/2023', N'CAJAS PARA LAS TARJETAS ', CAST(300.00 AS Decimal(18, 2)), CAST(N'2023-12-06T15:52:41.873' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2972, 1702307804, 2, 176, 100, 0, 1, 868, N'GASTO DE BODEGA AEROSOL PARA ACRILICOS ', N'', N'06/12/2023', N'', CAST(100.00 AS Decimal(18, 2)), CAST(N'2023-12-06T15:53:42.487' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2973, 1702307804, 2, 176, 100, 0, 1, 869, N'GASTO DE BODEGA TORNILLOS ', N'', N'06/12/2023', N'GASTO DE BODEGA TORNILLOS ', CAST(100.00 AS Decimal(18, 2)), CAST(N'2023-12-06T15:54:14.350' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2974, 1702307804, 2, 161, 100, 0, 1, 870, N'GASTO DE PRESTAMO A ALLAN PARA GASTO PERSONAL', N'', N'05/12/2023', N'PAGO DE TARJETA CITY BANAMEX', CAST(45500.00 AS Decimal(18, 2)), CAST(N'2023-12-06T16:18:30.947' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2975, 1702307804, 1, 166, 100, 0, 1, 871, N'VENTA DE TORNO CONVENCIONAL LEBLOND REGAL', N'NO. 05', N'07/12/2023', N'VENTA DE ALLAN', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-12-08T11:40:30.053' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2976, 1702307804, 1, 166, 100, 0, 1, 872, N' VENTA DE TORNO CONVENCIONAL MACHINISTS ', N'NO. 58', N'07/12/2023', N'VENTA ALLAN ', CAST(65000.00 AS Decimal(18, 2)), CAST(N'2023-12-08T11:40:20.223' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2977, 1702307804, 2, 1205, 100, 0, 1, 873, N'GASTO DE INTERESES ATRASADOS DAVID GONZALEZ ', N'', N'08/12/2023', N'', CAST(320000.00 AS Decimal(18, 2)), CAST(N'2023-12-08T16:44:51.337' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2978, 1702307804, 2, 1222, 100, 0, 1, 874, N'NÓMINAS ', N'', N'08/12/2023', N'NOMINAS Y AGUINALDO DEL CHATO', CAST(17500.00 AS Decimal(18, 2)), CAST(N'2023-12-14T16:31:19.570' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2979, 1702307804, 1, 165, 106, 0, 1, 875, N'VENTA DE CENTRO DE MAQUINADO VFOE ', N'NO. 72', N'09/12/2023', N'VENTA DE DAVID, VFOE', CAST(350000.00 AS Decimal(18, 2)), CAST(N'2023-12-14T16:58:28.780' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2980, 1702307804, 4, 154, 102, 0, 1, 876, N'PAGO DE PERFILADORA ACRAMILL', N'', N'06/11/2023', N'', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-12-14T17:02:03.933' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2981, 1702307804, 4, 1203, 102, 0, 1, 877, N'PAGO DE PERFILADORA ACRAMILL', N'', N'13/12/2023', N'', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-12-14T17:49:11.730' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2982, 1702307804, 4, 179, 102, 0, 1, 878, N'PAGO DE VENTA DE RECTIFICADORA DE SUPERFICIES PLANAS', N'', N'13/12/2023', N'PAGO DE RECTIFICADORA JUNTO CON PINACHO ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-12-15T11:56:10.620' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2983, 1702307804, 4, 179, 102, 0, 1, 879, N'PAGO DE PERFILADORA BRIDGEPORT', N'', N'02/10/2023', N'', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-12-15T12:30:55.797' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2984, 1702307804, 4, 157, 102, 0, 1, 880, N'PAGO DE PERFILADORA BRIDGEPORT', N'', N'19/10/2023', N'', CAST(65000.00 AS Decimal(18, 2)), CAST(N'2023-12-15T12:32:48.217' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2985, 1702307804, 4, 179, 102, 0, 1, 881, N'PAGO DE TORNO CONVENCIONAL PINACHO', N'', N'27/11/2023', N'', CAST(11000.00 AS Decimal(18, 2)), CAST(N'2023-12-15T12:35:26.510' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2986, 1702307804, 4, 154, 102, 0, 1, 882, N'PAGO DE TORNO RUSO ', N'A-0019', N'30/08/2023', N'', CAST(85000.00 AS Decimal(18, 2)), CAST(N'2023-12-18T15:57:36.123' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2987, 1702307804, 4, 157, 102, 0, 1, 883, N'PAGO DE PRESTAM HERMANO DE ALLAN', N'', N'28/11/2023', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2023-12-18T16:16:48.303' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2988, 1702307804, 4, 180, 102, 0, 1, 884, N'PAGO DE PERFILADORA BRIDGEPORT ', N'NO. 41', N'24/11/2023', N'', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-12-18T16:20:11.870' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2989, 1702307804, 4, 180, 102, 0, 1, 885, N'PAGO DE CENTRO DE MAQUINADO FADAL', N'', N'26/11/2023', N'', CAST(125000.00 AS Decimal(18, 2)), CAST(N'2023-12-18T16:34:18.637' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2990, 1702307804, 4, 154, 102, 0, 1, 886, N'PAGO DE MONTACARGAS NISSAN', N'', N'26/11/2023', N'SE DIO OTRA MAQ A CAMBIO ', CAST(90000.00 AS Decimal(18, 2)), CAST(N'2023-12-18T16:36:16.033' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2991, 1702307804, 4, 1203, 102, 0, 3, 887, N'PAGO DE TORNO HARDINGE ', N'', N'18/12/2023', N'', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-12-18T16:46:52.240' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2992, 1702307804, 4, 1203, 102, 0, 1, 888, N'PAGO DE TORNO HARDINGE ', N'', N'09/12/2023', N'', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-12-18T16:47:54.467' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2993, 1702307804, 4, 179, 103, 0, 1, 889, N'PAGADO PRESTAMO DAVID CRUZ', N'', N'20/10/2023', N'', CAST(11000.00 AS Decimal(18, 2)), CAST(N'2023-12-18T17:08:52.897' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2994, 1702307804, 2, 1223, 105, 0, 1, 890, N'HONORARIOS BLACK CONTADORES ', N'', N'15/12/2023', N'', CAST(1800.00 AS Decimal(18, 2)), CAST(N'2023-12-20T10:04:14.730' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2995, 1702307804, 2, 176, 105, 0, 1, 891, N'GASTO DE MATERIAL OFICINA', N'', N'15/12/2023', N'', CAST(2087.00 AS Decimal(18, 2)), CAST(N'2023-12-20T10:05:04.193' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2996, 1702307804, 2, 161, 105, 0, 1, 892, N'GASTO DE GAS CUPRA ', N'', N'15/12/2023', N'', CAST(1172.00 AS Decimal(18, 2)), CAST(N'2023-12-20T10:30:59.760' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2997, 1702307804, 5, 1229, 102, 100, 1, 893, N'PRESTAMO BRENDA ', N'', N'19/12/2023', N'PRESTAMO A ESPOSA DE NETO ', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2023-12-20T11:52:04.587' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2998, 1702307804, 4, 154, 102, 0, 1, 894, N'PAGO DE PRESTAMO DE PAPÁ DE ALLAN ', N'', N'16/10/2023', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-12-20T12:21:27.240' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (2999, 1702307804, 4, 154, 103, 0, 1, 895, N'PAGO A SERRANO PRESTAMO NUEVO ', N'', N'30/09/2023', N'', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2023-12-20T12:33:13.257' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3000, 1702307804, 1, 166, 105, 0, 1, 896, N'VENTA DE TORNO FEMCO ', N'NO. 27 ', N'17/12/2023', N'SE VENDIÓ EN 270,000 + IVA ', CAST(313200.00 AS Decimal(18, 2)), CAST(N'2023-12-20T12:55:58.353' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3001, 1702307804, 1, 153, 105, 0, 1, 897, N'VENTA DE PERFILADORA SYSTEM M3X', N'NO. 78', N'17/12/2023', N'SE VENDIÓ EN 190,000 + IVA ', CAST(220400.00 AS Decimal(18, 2)), CAST(N'2023-12-20T12:57:00.213' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3002, 1702307804, 1, 1290, 105, 0, 1, 898, N'VENTA DE DNC ', N'', N'17/12/2023', N'11,000 CADA UNO SE VENDIERON 2 AL MISMO CLIENTE ', CAST(25520.00 AS Decimal(18, 2)), CAST(N'2023-12-20T12:58:02.667' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3003, 1702307804, 1, 172, 106, 0, 1, 899, N'VENTA DE SIERRA-CINTA AMADA ', N'NO. 56 ', N'20/12/2023', N'', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2023-12-20T13:11:15.227' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3004, 1702307804, 1, 165, 102, 0, 1, 900, N'VENTA DE CENTRO DE MAQUINADO VFE', N'NO. 29', N'20/12/2023', N'SE VENDIÓ EN 335,000 SE TOMARÁ EN CUENTA UN TORNO POR 135,000
DARÁ 200,000 EN TRANSFERENCIAS', CAST(335000.00 AS Decimal(18, 2)), CAST(N'2023-12-20T13:13:16.280' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3005, 1702307804, 2, 161, 1109, 0, 1, 901, N'PAGO DE COMIDA POSADA ', N'', N'15/12/2023', N'', CAST(9060.00 AS Decimal(18, 2)), CAST(N'2023-12-20T13:18:57.763' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3006, 1702307804, 2, 161, 1109, 0, 1, 902, N'PAGO DE APP CLIENTES ALLAN ', N'', N'16/12/2023', N'PAGO DE UPNIFY', CAST(3077.00 AS Decimal(18, 2)), CAST(N'2023-12-20T13:20:01.070' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3007, 1702307804, 2, 176, 1109, 0, 1, 903, N'PAGO DE APP BLACK CONTADORES ', N'', N'15/12/2023', N'', CAST(300.00 AS Decimal(18, 2)), CAST(N'2023-12-20T13:20:28.900' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3008, 1702307804, 2, 1205, 1109, 0, 1, 904, N'PAGO DE INTERÉS DAVID GONZALEZ ', N'', N'15/12/2023', N'AL PARECER SON DE DAVID ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-12-20T13:21:59.957' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3009, 1702307804, 2, 1222, 1109, 0, 1, 905, N'NOMINAS Y AGUINALDO ', N'', N'15/12/2023', N'PAGO DE NOMINAS: 5,000
PAGO DE AGUINALDOS: 10,000', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2023-12-20T13:27:08.863' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3010, 1702307804, 2, 1230, 100, 0, 1, 906, N'PAGO DE IMSS', N'', N'18/12/2023', N'', CAST(2200.00 AS Decimal(18, 2)), CAST(N'2023-12-20T13:32:14.160' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3011, 1702307804, 2, 176, 100, 0, 1, 907, N'PAGO DE LUZ MAQALLAN', N'', N'20/12/2023', N'', CAST(6600.00 AS Decimal(18, 2)), CAST(N'2023-12-20T13:32:50.383' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3012, 1702307804, 2, 1232, 100, 0, 1, 908, N'GASTO GAS NISSAN', N'', N'18/12/2023', N'', CAST(1400.00 AS Decimal(18, 2)), CAST(N'2023-12-20T13:33:32.367' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3013, 1702307804, 2, 1222, 100, 0, 1, 909, N'PAGO DE NOMINA ALLAN ', N'', N'18/12/2023', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-12-20T14:10:27.520' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3014, 1702307804, 2, 176, 100, 0, 1, 910, N'GASTO DE RACKS ', N'', N'16/12/2023', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2023-12-20T14:13:32.123' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3015, 1702307804, 2, 176, 100, 0, 1, 911, N'GASTO DE RACKS ', N'', N'19/12/2023', N'', CAST(7400.00 AS Decimal(18, 2)), CAST(N'2023-12-20T14:14:39.937' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3016, 1702307804, 2, 161, 105, 0, 1, 912, N'PAGO DE PRESTAMO ALLAN ', N'', N'19/12/2023', N'', CAST(1605.00 AS Decimal(18, 2)), CAST(N'2023-12-20T15:24:11.663' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3017, 1702307804, 2, 161, 105, 0, 1, 913, N'PAGO DE PRESTAMO ALLAN ', N'', N'19/12/2023', N'', CAST(1605.00 AS Decimal(18, 2)), CAST(N'2023-12-20T15:26:34.580' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3018, 1702307804, 2, 161, 105, 0, 1, 914, N'PAGO DE PRESTAMO ALLAN ', N'', N'18/12/2023', N'', CAST(2785.00 AS Decimal(18, 2)), CAST(N'2023-12-20T15:28:28.787' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3019, 1702307804, 2, 161, 105, 0, 1, 915, N'GASTO PERSONAL ALLAN BMW ', N'', N'18/12/2023', N'', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2023-12-20T15:31:54.573' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3020, 1702307804, 1, 165, 102, 0, 1, 916, N'VENTA DE CENTRO DE MAQUINADO VF3 AÑO 2005', N'NO. 70', N'21/12/2023', N'', CAST(725000.00 AS Decimal(18, 2)), CAST(N'2023-12-21T16:32:36.840' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3021, 1702307804, 1, 1291, 102, 0, 1, 917, N'VENTA EROSIONADORA DE PENETRACIÓN ', N'NO. 37', N'19/12/2023', N'SE PAGA EN FEBRERO ', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2023-12-21T17:59:16.880' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (3999, 1702307804, 4, 154, 102, 0, 1, 918, N'  PAGO DE PERFILADORA ACRAMILL ', N'', N'03/01/2024', N'', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2024-01-03T14:10:37.853' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4000, 1702307804, 4, 179, 102, 0, 1, 919, N'PAGO DE CENTRO DE MAQUINADO VF3 2005', N'NO. 70', N'22/12/2023', N'', CAST(490000.00 AS Decimal(18, 2)), CAST(N'2024-01-04T09:33:00.600' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4001, 1702307804, 4, 179, 102, 0, 1, 920, N'PAGO DE CENTRO DE MAQUINADO VF3 2005', N'NO. 70', N'23/12/2023', N'', CAST(60000.00 AS Decimal(18, 2)), CAST(N'2024-01-04T09:34:40.477' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4002, 1702307804, 1, 165, 105, 0, 1, 921, N'VENTA DE CENTRO DE MAQUINADO FADAL 904-1 (3016)', N'', N'23/12/2023', N'', CAST(238960.00 AS Decimal(18, 2)), CAST(N'2024-01-04T09:36:08.023' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4003, 1702307804, 3, 1234, 100, 0, 1, 922, N'COSTO TOTAL DEL MES DE DICIEMBRE', N'C-012', N'31/12/2023', N'SE REGISTRA EL TOTAL DEL COSTO DEL MES DE DICIEMBRE
MANDRINADORA
TORNO LEBLOND 
TORNO MACHINIST 
CM VFOE 
TORNO CNC FEMCO 
PERFILADROA SYSTEM M3X 
REFACCIÓN DNC
SIERRA-CINTA AMADA
CM VFE
CM VF3 2005 
EROSIONADORA DE PENETRACIÓN 
CM FADAL 904-1', CAST(1300938.69 AS Decimal(18, 2)), CAST(N'2024-01-04T11:13:13.113' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4004, 1702307804, 4, 154, 102, 0, 3, 923, N'PAGO DE CENTRO DE MAQUINADO VF3 AÑO 2000', N'', N'04/01/2024', N'', CAST(125000.00 AS Decimal(18, 2)), CAST(N'2024-01-04T12:28:40.517' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4005, 1702307804, 4, 154, 102, 0, 1, 924, N'PAGO DE CENTRO DE MAQUINADO AÑO 2000', N'', N'28/12/2023', N'', CAST(125000.00 AS Decimal(18, 2)), CAST(N'2024-01-04T12:29:31.850' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4006, 1702307804, 4, 154, 102, 0, 1, 925, N'PAGO DE INYECTORA DE PLÁSTICO', N'', N'28/12/2023', N'', CAST(75000.00 AS Decimal(18, 2)), CAST(N'2024-01-04T13:01:32.957' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4007, 1702307804, 4, 179, 102, 0, 1, 926, N'PAGO DE TORNO CNC HWACHEON ', N'', N'02/01/2024', N'', CAST(70000.00 AS Decimal(18, 2)), CAST(N'2024-01-04T13:05:46.457' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4008, 1702307804, 2, 1223, 105, 0, 1, 927, N'HONORARIOS BLACK CONTADORES ', N'', N'04/01/2024', N'', CAST(1800.00 AS Decimal(18, 2)), CAST(N'2024-01-04T17:14:37.887' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4009, 1702307804, 2, 161, 105, 0, 1, 928, N'GASTO DE TACOMA ', N'', N'01/01/2024', N'', CAST(22323.00 AS Decimal(18, 2)), CAST(N'2024-01-04T17:26:00.837' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4010, 1702307804, 2, 161, 105, 0, 1, 929, N'GASTO PERSONAL DE ALLAN COMIDA ', N'', N'02/01/2024', N'', CAST(532.00 AS Decimal(18, 2)), CAST(N'2024-01-08T16:35:35.357' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4011, 1702307804, 2, 161, 105, 0, 1, 930, N'GASTO PERSONAL DE PRESTAMOS BBVA ALLAN ', N'', N'04/01/2024', N'1614
1614 
2797 ', CAST(6025.00 AS Decimal(18, 2)), CAST(N'2024-01-08T17:39:16.027' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4012, 1702307804, 4, 154, 103, 0, 1, 931, N'PAGO DE DEUDA A SUSANA ', N'', N'09/01/2024', N'DEUDA PAGADA ', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2024-01-09T13:14:55.603' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4013, 1702307804, 2, 1205, 100, 0, 1, 932, N'GASTO DE INTERÉS SUSANA ', N'', N'09/01/2024', N'', CAST(7500.00 AS Decimal(18, 2)), CAST(N'2024-01-09T13:45:41.770' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4014, 1702307804, 4, 154, 103, 0, 1, 933, N'PAGO DE DEUDA SERRANO ', N'', N'22/01/2024', N'PAGADA LA DEUDA DE SERRANO ', CAST(350000.00 AS Decimal(18, 2)), CAST(N'2024-01-24T11:39:31.823' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4015, 1702307804, 4, 154, 103, 0, 1, 934, N'PAGO DE DEUDA JORGE LLANOS ', N'', N'01/01/2024', N'PAGO DE DÓLARES JORGE LLANOS ', CAST(267600.00 AS Decimal(18, 2)), CAST(N'2024-01-24T11:42:29.600' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4016, 1702307804, 2, 176, 100, 0, 1, 935, N'GASTO DE RENTA IRINEO PAZ', N'', N'01/01/2024', N'', CAST(55000.00 AS Decimal(18, 2)), CAST(N'2024-01-24T11:51:39.957' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4017, 1702307804, 2, 161, 105, 0, 1, 936, N'GASTO DE SEGURO DINAMICO TARJETA ALLAN ', N'', N'01/01/2024', N'', CAST(192.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:08:29.717' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4018, 1702307804, 2, 161, 105, 0, 1, 937, N'GASTO PERSONAL DE ALLAN COMIDA ', N'', N'01/01/2024', N'', CAST(2288.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:11:16.097' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4019, 1702307804, 2, 161, 105, 0, 1, 938, N'GASTO PERSONAL DE ALLAN BOILER ', N'', N'04/01/2024', N'', CAST(3499.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:11:57.727' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4020, 1702307804, 2, 161, 105, 0, 1, 939, N'GASTO PERSONAL DE ALLAN MEDICAMENTO', N'', N'04/01/2024', N'', CAST(917.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:13:25.450' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4021, 1702307804, 2, 161, 105, 0, 1, 940, N'GASTO PERSONAL DE ALLAN COMIDA ', N'', N'04/01/2024', N'GASTO PERSONAL DE ALLAN SUSHI ', CAST(716.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:14:24.493' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4022, 1702307804, 2, 1231, 105, 0, 1, 941, N'GASTO PERSONAL DE ALLAN GASOLINA ', N'', N'04/01/2024', N'BMW 1143
CUPRA 1039', CAST(2182.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:15:23.870' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4023, 1702307804, 2, 161, 105, 0, 1, 942, N'GASTO PERSONAL ALLAN TACOMA ', N'', N'04/01/2024', N'LOJACK TACOMA |', CAST(4897.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:16:25.983' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4024, 1702307804, 2, 176, 100, 0, 1, 943, N'GASTO PROPINA PARA GÜERO (TRABAJADOR DE ALLAN)', N'', N'06/01/2024', N'', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:17:52.650' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4025, 1702307804, 2, 161, 100, 0, 1, 944, N'GASTO PERSONAL DE ALLAN BMW', N'', N'06/01/2024', N'', CAST(15560.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:24:36.530' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4026, 1702307804, 2, 176, 100, 0, 1, 945, N'GASTO DE BODEGA CAMISA BENITO ', N'', N'06/01/2024', N'', CAST(1500.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:29:01.770' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4027, 1702307804, 2, 176, 100, 0, 1, 946, N'GASTO DE BODEGA PAGO A MORENO PINTURAS ', N'', N'08/01/2024', N'', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:31:28.367' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4028, 1702307804, 2, 176, 100, 0, 1, 947, N'GASTO DE BODEGA ARREGLO DE PORTÓN ', N'', N'08/01/2024', N'', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:32:24.567' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4029, 1702307804, 2, 176, 100, 0, 1, 948, N'GASTO DE BODEGA PAGO DE BOMBA ', N'', N'08/01/2024', N'', CAST(1800.00 AS Decimal(18, 2)), CAST(N'2024-01-24T12:42:27.117' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4030, 1702307804, 2, 1205, 100, 0, 1, 949, N'GASTO DE INTERÉS DAVID GONZALEZ', N'', N'04/01/2024', N'PAGO DE INTERES DAVID GONZALEZ ', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2024-01-24T13:07:37.817' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4031, 1702307804, 2, 176, 100, 0, 1, 950, N'GASTO DE ARCHIVEROS OFICINA ', N'', N'04/01/2024', N'', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2024-01-24T13:08:25.453' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4032, 1702307804, 2, 1205, 100, 0, 1, 951, N'GASTO DE INTERÉS OSVALDO ', N'', N'04/01/2024', N'', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2024-01-24T13:09:00.993' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4033, 1702307804, 2, 176, 100, 0, 1, 952, N'GASTO DE ARREGLO FACHADA RAMIRO ', N'', N'04/01/2024', N'', CAST(550.00 AS Decimal(18, 2)), CAST(N'2024-01-24T13:11:52.540' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4034, 1702307804, 2, 176, 100, 0, 1, 953, N'GASTO DE GUANTES CHATO ', N'', N'04/01/2024', N'', CAST(59.00 AS Decimal(18, 2)), CAST(N'2024-01-24T13:12:23.433' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4035, 1702307804, 2, 176, 100, 0, 1, 954, N'GASTO DE CUBETAS Y PILA ', N'', N'04/01/2024', N'', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2024-01-24T13:13:04.137' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4036, 1702307804, 2, 1222, 100, 0, 1, 955, N'NOMINAS  PRIMER SEMANA ', N'', N'05/01/2024', N'', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2024-01-24T13:19:52.547' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4037, 1702307804, 2, 176, 100, 0, 1, 956, N'GASTO DE BODEGA CINTAS Y DISCOS ', N'', N'05/01/2024', N'', CAST(182.00 AS Decimal(18, 2)), CAST(N'2024-01-24T13:22:41.723' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4038, 1702307804, 2, 176, 100, 0, 1, 957, N'GASTO DE BODEGA PINOL ', N'', N'08/01/2024', N'', CAST(18.00 AS Decimal(18, 2)), CAST(N'2024-01-24T13:23:08.960' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4039, 1702307804, 2, 176, 100, 0, 1, 958, N'GASTO DE BODEGA RECOGIDA DE BASURA ', N'', N'08/01/2024', N'', CAST(100.00 AS Decimal(18, 2)), CAST(N'2024-01-24T13:23:55.350' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4040, 1702307804, 2, 161, 1109, 0, 1, 959, N'GASTO PERSONAL DE ALLAN PRESTAMO YADIRA ', N'', N'08/01/2024', N'', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2024-01-24T13:29:31.413' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4041, 1702307804, 2, 1205, 100, 0, 1, 960, N'PAGO DE INTERÉS SERRANO ', N'', N'22/01/2024', N'', CAST(17500.00 AS Decimal(18, 2)), CAST(N'2024-01-24T15:50:13.683' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4042, 1702307804, 2, 161, 100, 0, 1, 961, N'GASTO PERSONAL ALLAN ALTAGRACIA ', N'', N'11/01/2024', N'', CAST(7000.00 AS Decimal(18, 2)), CAST(N'2024-01-24T16:05:20.263' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4043, 1702307804, 2, 176, 100, 0, 1, 962, N'GASTO DE  MUEBLE PARA OFICINA ', N'', N'11/01/2024', N'', CAST(3500.00 AS Decimal(18, 2)), CAST(N'2024-01-24T16:30:48.183' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4044, 1702307804, 2, 176, 100, 0, 1, 963, N'GASTO DE BODEGA TORNILLO Y GAS ', N'', N'11/01/2024', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2024-01-24T16:31:19.010' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4045, 1702307804, 2, 160, 100, 0, 1, 964, N'GASTO DE PAGO IS N ', N'', N'11/01/2024', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2024-01-24T16:35:25.503' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4046, 1702307804, 2, 1230, 100, 0, 1, 965, N'GASTO DE PAGO DE IMSS ', N'', N'11/01/2024', N'', CAST(5500.00 AS Decimal(18, 2)), CAST(N'2024-01-24T16:36:45.850' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4047, 1702307804, 2, 1222, 100, 0, 1, 966, N'NOMINAS ', N'', N'12/01/2024', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2024-01-24T16:37:15.737' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4048, 1702307804, 2, 176, 105, 0, 1, 967, N'GASTO DE BODEGA ROSCA ', N'', N'15/01/2024', N'', CAST(305.00 AS Decimal(18, 2)), CAST(N'2024-01-24T17:10:27.657' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4049, 1702307804, 2, 176, 105, 0, 1, 968, N'GASTO DE BODEGA TUBOS ', N'', N'15/01/2024', N'', CAST(1300.00 AS Decimal(18, 2)), CAST(N'2024-01-24T17:36:32.163' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4050, 1702307804, 2, 176, 105, 0, 1, 969, N'GASTO DE BODEGA ADT ', N'', N'17/01/2024', N'', CAST(2482.00 AS Decimal(18, 2)), CAST(N'2024-01-24T17:47:32.830' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4051, 1702307804, 2, 176, 105, 0, 1, 970, N'GASTO DE BODEGA OFICINA', N'', N'17/01/2024', N'', CAST(800.00 AS Decimal(18, 2)), CAST(N'2024-01-24T17:50:26.150' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4052, 1702307804, 1, 153, 100, 0, 1, 971, N'VENTA DE PERFILADORA SOUTH BEND ', N'NO. 40', N'23/01/2024', N'', CAST(38000.00 AS Decimal(18, 2)), CAST(N'2024-01-25T15:27:10.010' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4053, 1702307804, 1, 166, 102, 0, 1, 972, N'VENTA DE TORNO CNC SL-20 ', N'NO. 32', N'13/01/2024', N'', CAST(300000.00 AS Decimal(18, 2)), CAST(N'2024-01-31T17:26:05.157' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4054, 1702307804, 1, 165, 100, 0, 1, 973, N'VENTA DE CENTRO DE MAQUINADO FADAL 4020', N'NO. 68', N'22/01/2024', N'MITAD FACTURA, MITAD EFECTIVO ', CAST(249500.00 AS Decimal(18, 2)), CAST(N'2024-01-25T15:35:04.427' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4055, 1702307804, 2, 1205, 100, 0, 1, 974, N'INTERES DE OSVALDO BARBA ', N'', N'15/01/2024', N'', CAST(18500.00 AS Decimal(18, 2)), CAST(N'2024-01-31T10:30:37.250' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4056, 1702307804, 2, 1222, 100, 0, 1, 975, N'PAGO DE NOMINA ALLAN ', N'', N'15/01/2024', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2024-01-31T10:31:12.890' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4057, 1702307804, 1, 1180, 100, 0, 1, 976, N'VENTA DE COMPRESOR TOLEDO ', N'NO. 80', N'26/01/2024', N'', CAST(14000.00 AS Decimal(18, 2)), CAST(N'2024-01-31T17:12:56.730' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4058, 1702307804, 4, 154, 102, 0, 1, 977, N'PAGO DE TORNO SL-20 ', N'', N'13/01/2024', N'', CAST(280000.00 AS Decimal(18, 2)), CAST(N'2024-01-31T17:26:47.750' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4059, 1702307804, 4, 154, 102, 0, 1, 978, N'PAGO DE TORNO HARDNINGE ', N'', N'06/02/2024', N'', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2024-02-06T12:44:20.850' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4060, 1702307804, 4, 154, 103, 0, 1, 979, N'PAGO A CAPITAL JORGE CABRERA ', N'', N'19/01/2024', N'', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2024-02-07T12:26:57.210' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4061, 1702307804, 2, 1191, 103, 0, 3, 980, N'ALTAGRACIA ', N'', N'31/12/2022', N'', CAST(400000.00 AS Decimal(18, 2)), CAST(N'2024-02-08T16:44:55.140' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4062, 1702307804, 2, 1191, 103, 0, 3, 981, N'EDITAR', N'', N'31/12/2022', N'', CAST(400000.00 AS Decimal(18, 2)), CAST(N'2024-02-20T11:46:30.450' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4063, 1702307804, 2, 152, 103, 0, 3, 982, N'GUSTAVO BARBA ', N'', N'31/12/2022', N'', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2024-02-08T17:21:16.830' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4064, 1702307804, 2, 1191, 103, 0, 3, 983, N'EDITAR', N'', N'31/12/2022', N'', CAST(551000.00 AS Decimal(18, 2)), CAST(N'2024-02-08T17:24:50.303' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4065, 1702307804, 2, 161, 103, 0, 3, 984, N'PRESTAMO KONFÍO ', N'', N'31/12/2022', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2024-02-09T13:27:07.503' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4066, 1702307804, 5, 2290, 102, 100, 1, 985, N'PRESTAMO ENRIQUE LOPEZ', N'', N'09/02/2024', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2024-02-09T13:29:11.233' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4067, 1702307804, 3, 1234, 100, 0, 1, 986, N'COSTO TOTAL DEL MES DE ENERO 2024', N'C-001-2024', N'31/01/2024', N'PERFILADORA SOUTH BEND
TORNO CNC SL-20
CENTRO DE MAQUINADO FADAL 4020
COMPRESOR TOLEDO ', CAST(361387.00 AS Decimal(18, 2)), CAST(N'2024-02-12T16:28:50.677' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4068, 1702307804, 4, 154, 103, 0, 1, 987, N'PAGO KONFÍO ', N'', N'01/01/2023', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2024-02-15T17:21:22.097' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4069, 1702307804, 4, 154, 103, 0, 1, 988, N'PAGO DE PRESTAMO ', N'', N'18/07/2023', N'', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2024-02-15T17:41:51.580' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4070, 1702307804, 4, 154, 103, 0, 3, 989, N'PAGOS ALTAGRACIA', N'', N'01/01/2023', N'', CAST(58000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:59:41.480' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4071, 1702307804, 5, 1237, 103, 0, 3, 990, N'PRESTAMO DAVID GONZALEZ ', N'', N'12/02/2024', N'', CAST(850000.00 AS Decimal(18, 2)), CAST(N'2024-02-20T13:26:25.897' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4072, 1702307804, 5, 2292, 103, 0, 1, 991, N'PRESTAMO CÉSAR RUBIO', N'', N'20/02/2024', N'', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2024-02-20T15:00:10.763' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4073, 1702307804, 5, 2293, 103, 100, 3, 992, N'PRESTAMO FABRE ', N'', N'12/02/2024', N'PRESTAMO QUE VA A REGRESAR PRONTAMENTE ALLAN ', CAST(55000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:02:52.457' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4074, 1702307804, 5, 2294, 103, 0, 3, 993, N'PRESTAMO GRINGO ', N'', N'16/02/2024', N'13,500 DOLARES X 17.10', CAST(25500.00 AS Decimal(18, 2)), CAST(N'2024-02-20T17:23:12.950' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4075, 1702307804, 5, 2294, 103, 100, 3, 994, N'PRESTAMO MIGUEL USA', N'', N'16/02/2024', N'11,500 + 4,000 + 25,000 X 17.10', CAST(692550.00 AS Decimal(18, 2)), CAST(N'2024-09-06T17:01:46.253' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4076, 1702307804, 2, 1191, 103, 0, 3, 995, N'???', N'', N'31/12/2022', N'', CAST(520150.00 AS Decimal(18, 2)), CAST(N'2024-02-20T17:49:21.190' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4077, 1702307804, 4, 1203, 102, 0, 1, 996, N'PAGO DE EROSIONADORA DE PENETRACIÓN ', N'P-2024', N'22/02/2024', N'', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2024-02-22T12:29:15.967' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4078, 1702307804, 2, 176, 100, 0, 1, 997, N'PAGO DE LUZ ', N'', N'21/02/2024', N'', CAST(6800.00 AS Decimal(18, 2)), CAST(N'2024-02-22T13:38:43.517' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4079, 1702307804, 1, 165, 102, 0, 1, 998, N'VENTA DE CENTRO DE MAQUINADO VF3 AÑO 1996', N'NO. 44', N'28/11/2023', N'', CAST(460000.00 AS Decimal(18, 2)), CAST(N'2024-02-27T16:29:08.243' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4080, 1702307804, 4, 154, 102, 0, 1, 999, N'PAGO DE CENTRO DE MAQUINADO VF3 1996', N'', N'01/12/2023', N'', CAST(350000.00 AS Decimal(18, 2)), CAST(N'2024-02-27T16:30:28.977' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4081, 1702307804, 4, 154, 102, 0, 1, 1000, N'PAGO DE CENTRO DE MAQUINADO VF3 1996', N'', N'27/02/2024', N'', CAST(90000.00 AS Decimal(18, 2)), CAST(N'2024-02-27T16:32:20.647' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4082, 1702307804, 1, 165, 102, 0, 1, 1001, N'VENTA DE CENTRO DE MAQUINADO VF4 DE BRAZO', N'', N'02/02/2024', N'', CAST(550000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T10:14:23.750' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4083, 1702307804, 1, 165, 102, 0, 1, 1002, N'VENTA DE CENTRO DE MAQUINADO VIPER ', N'', N'08/02/2024', N'EN 3 MESES 200,000', CAST(700000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T10:21:13.770' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4084, 1702307804, 1, 165, 102, 0, 1, 1003, N'VENTA DE CENTRO DE MAQUINADO VF6 ', N'', N'19/02/2024', N'', CAST(775000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T10:51:39.467' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4085, 1702307804, 1, 165, 102, 0, 1, 1004, N'VENTA DE TORNO CNC FEMCO WNCL 35/70B', N'', N'19/02/2024', N'', CAST(600000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T10:57:10.877' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4086, 1702307804, 1, 165, 102, 0, 1, 1005, N'VENTA DE CENTRO DE MAQUINADO VF1 ', N'', N'26/02/2024', N'', CAST(300000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T10:57:54.033' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4087, 1702307804, 4, 154, 102, 0, 1, 1006, N'PAGO DE CENTRO DE MAQUINADO VF4 DE BRAZO', N'', N'03/02/2024', N'DEBEN EL IVA DE 260000', CAST(300000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T11:38:02.113' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4088, 1702307804, 4, 154, 102, 0, 1, 1007, N'PAGO DE CENTRO DE MAQUINADO VIPER ', N'', N'09/02/2024', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T11:40:31.813' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4089, 1702307804, 2, 1191, 103, 0, 3, 1008, N'DAVID GONZALEZ NUEVA DEUDA', N'', N'31/12/2022', N'', CAST(1100000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T12:15:36.007' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4090, 1702307804, 4, 154, 102, 0, 1, 1009, N'PAGO DE CENTRO DE MAQUINADO VF6 ', N'', N'20/02/2024', N'', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T14:15:32.517' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4091, 1702307804, 4, 154, 102, 0, 1, 1010, N'PAGO DE TORNO CNC FEMCO WNCL 35/70B', N'', N'20/02/2024', N'', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T14:17:29.557' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4092, 1702307804, 4, 154, 102, 0, 1, 1011, N'PAGO DE CENTRO DE MAQUINADO VFE', N'', N'22/12/2023', N'', CAST(305000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T17:33:39.610' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4093, 1702307804, 4, 154, 102, 0, 1, 1012, N'PAGO DE CENTRO DE MAQUINADO VFE', N'', N'01/01/2024', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T17:36:01.237' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4094, 1702307804, 4, 154, 102, 0, 1, 1013, N'PAGO DE CENTRO DE MAQUINADO VFE', N'', N'28/02/2024', N'', CAST(20000.00 AS Decimal(18, 2)), CAST(N'2024-02-28T17:40:04.127' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (4095, 1702307804, 3, 1234, 100, 0, 1, 1014, N'COSTO TOTAL DEL MES DE FEBERO 2024', N'C-002-2024', N'29/02/2024', N'COSTO TOTAL DEL MES DE FEBRERO 2024
CENTRO DE MAQUINADO HAAS VF6
TORNO CNC FEMCO WNLC 
CENTRO DE MAQUINADO VF4
CENTRO DE MAQUINADO VF1
CENTRO DE MAQUINADO VIPER ', CAST(1751601.93 AS Decimal(18, 2)), CAST(N'2024-04-10T16:54:07.750' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5014, 1702307804, 2, 1205, 100, 0, 1, 1015, N'INTERESES DE CABRERA ', N'', N'13/03/2024', N'', CAST(135000.00 AS Decimal(18, 2)), CAST(N'2024-03-13T12:22:32.940' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5015, 1702307804, 2, 161, 100, 0, 1, 1016, N'GASTO PERSONAL DE ALLAN ', N'', N'13/03/2024', N'CHIVO ALTAGRACIA ', CAST(7000.00 AS Decimal(18, 2)), CAST(N'2024-03-13T12:30:38.873' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5016, 1702307804, 2, 176, 100, 0, 1, 1017, N'GASTO DE UNIFORMES ', N'', N'13/03/2024', N'CAMISAS PARA MARIANA ', CAST(580.00 AS Decimal(18, 2)), CAST(N'2024-03-13T14:08:56.103' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5017, 1702307804, 2, 176, 100, 0, 1, 1018, N'GASTO DE UNIFORMES ALLAN GALVAN ', N'', N'13/03/2024', N'', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2024-03-13T14:20:49.423' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5018, 1702307804, 2, 176, 100, 0, 1, 1019, N'PAGO DE RENTA DE BODEGA ', N'', N'01/03/2024', N'', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2024-03-13T14:23:31.830' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5019, 1702307804, 2, 176, 100, 0, 1, 1020, N'GASTO DE INTERÉS TOBY ', N'', N'13/03/2024', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2024-03-13T14:33:41.360' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5020, 1702307804, 2, 159, 100, 0, 1, 1021, N'GASTO DE LIVERPOOL ALLAN', N'', N'13/03/2024', N'', CAST(12015.00 AS Decimal(18, 2)), CAST(N'2024-03-13T14:41:48.320' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5021, 1702307804, 2, 161, 106, 0, 1, 1022, N'GASTO PERSNAL DE ALLAN ', N'', N'13/03/2024', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2024-03-13T16:20:15.223' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5022, 1702307804, 2, 161, 106, 0, 1, 1023, N'GASTO PERSONAL DE ALLAN GALVÁN ', N'', N'13/03/2024', N'', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2024-03-13T16:22:11.087' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5023, 1702307804, 2, 161, 105, 0, 1, 1024, N'GASTO PERSONAL DE ALLAN ', N'', N'13/03/2024', N'APARTADO TACOMA ', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2024-03-13T16:29:25.700' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5024, 1702307804, 2, 161, 105, 0, 1, 1025, N'GASTO PERSONAL DE ALLAN ', N'', N'13/03/2024', N'', CAST(2139.00 AS Decimal(18, 2)), CAST(N'2024-03-13T17:16:46.013' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5025, 1702307804, 2, 161, 105, 0, 1, 1026, N'GASTO PERSONAL DE ALLAN GALVAN ', N'', N'13/03/2024', N'BOTELLA ', CAST(672.00 AS Decimal(18, 2)), CAST(N'2024-03-13T17:30:18.690' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5026, 1702307804, 2, 161, 105, 0, 1, 1027, N'GASTO PERSONAL DE ALLAN ', N'', N'13/03/2024', N'MCDONALS', CAST(112.00 AS Decimal(18, 2)), CAST(N'2024-03-13T17:34:25.033' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5027, 1702307804, 2, 161, 105, 0, 1, 1028, N'GASTO PERSONAL DE ALLAN CUPRA ', N'', N'13/03/2024', N'GASOLINA CUPRA ', CAST(1200.00 AS Decimal(18, 2)), CAST(N'2024-03-13T17:37:42.993' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5028, 1702307804, 2, 161, 105, 0, 1, 1029, N'GASTO PERSONAL DE ALLAN ', N'', N'13/03/2024', N'BIRRIA', CAST(214.00 AS Decimal(18, 2)), CAST(N'2024-03-13T17:39:32.770' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5029, 1702307804, 2, 161, 105, 0, 1, 1030, N'GASTO PERSONAL DE ALLAN ', N'', N'13/03/2024', N'SUSHI ', CAST(608.00 AS Decimal(18, 2)), CAST(N'2024-03-13T17:39:57.807' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5030, 1702307804, 2, 161, 105, 0, 1, 1031, N'GASTO PERSONAL DE ALLAN ', N'', N'13/03/2024', N'POLLO PEPE ', CAST(671.00 AS Decimal(18, 2)), CAST(N'2024-03-13T17:40:36.343' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (5031, 1702307804, 2, 161, 105, 0, 1, 1032, N'GASTO PERSONAL DE ALLAN ', N'', N'13/03/2024', N'OXXO ', CAST(200.00 AS Decimal(18, 2)), CAST(N'2024-03-13T17:41:13.717' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6014, 1702307804, 1, 1210, 100, 0, 1, 1033, N'VENTA DE MONTACARGAS HYSTER CHICO', N'NO. 66', N'05/03/2024', N'', CAST(90000.00 AS Decimal(18, 2)), CAST(N'2024-04-03T13:33:38.133' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6015, 1702307804, 1, 156, 105, 0, 1, 1034, N'VENTA DE FRESADORA JAFD JAROCIN ', N'NO. 01', N'14/03/2024', N'', CAST(108000.00 AS Decimal(18, 2)), CAST(N'2024-04-03T13:36:45.867' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6016, 1702307804, 1, 153, 100, 0, 1, 1035, N'VENTA DE PERFILADORA HARD FORD ', N'NO. 43', N'14/03/2024', N'', CAST(42000.00 AS Decimal(18, 2)), CAST(N'2024-04-03T13:38:41.660' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6017, 1702307804, 1, 165, 100, 0, 1, 1036, N'VENTA DE CENTRO DE MAQUINADO FADAL 4020', N'NO. 52', N'12/03/2024', N'', CAST(285000.00 AS Decimal(18, 2)), CAST(N'2024-04-03T13:54:54.070' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6018, 1702307804, 1, 165, 100, 0, 1, 1037, N'VENTA DE CENTRO DE MAQUINADO VF2', N'NO. 92', N'06/03/2024', N'', CAST(425000.00 AS Decimal(18, 2)), CAST(N'2024-04-04T10:44:27.363' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6019, 1702307804, 1, 166, 100, 0, 1, 1038, N'VENTA DE TORNO SL-20', N'NO. 54', N'06/03/2024', N'', CAST(350000.00 AS Decimal(18, 2)), CAST(N'2024-04-04T10:45:42.687' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6020, 1702307804, 1, 166, 100, 0, 1, 1039, N'VENTA DE TORNO CNC GT20', N'NO. 69', N'26/03/2024', N'', CAST(435000.00 AS Decimal(18, 2)), CAST(N'2024-04-04T11:13:07.817' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6021, 1702307804, 1, 178, 100, 0, 1, 1040, N'VENTA DE RECTIFICADORA HECKER ', N'NO. 49', N'26/03/2024', N'', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2024-04-04T11:12:44.940' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6022, 1702307804, 3, 1234, 100, 0, 1, 1041, N'COSTO TOTAL DEL MES DE MARZO 2024', N'C-003-2024', N'31/03/2024', N'COSTO TOTAL DEL MES DE MARZO 2024 
MONTACARGAS HYSTER
FRESADORA 
PERFILADORA 
CM FADAL 4020 
TORNO CNC SL-20 
CM VF2 
TORNO CNC GT20 
RECTIFICADORA HECKER ', CAST(1070522.64 AS Decimal(18, 2)), CAST(N'2024-04-04T12:48:00.830' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6023, 1702307804, 2, 1222, 100, 0, 1, 1042, N'GASTO DE NOMINA ALLAN ', N'', N'01/04/2024', N'', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2024-04-05T10:00:48.657' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6024, 1702307804, 2, 1222, 100, 0, 1, 1043, N'GASTO NOMINA ALLAN GALVAN ', N'', N'05/04/2024', N'', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2024-04-08T12:26:18.683' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6025, 1702307804, 2, 1222, 100, 0, 1, 1044, N'GASTO DE NOMINAS ABRIL ', N'', N'05/04/2024', N'$3,000 CHATO
$2,500 MARIANA ', CAST(5500.00 AS Decimal(18, 2)), CAST(N'2024-04-08T12:29:27.527' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6026, 1702307804, 1, 165, 102, 0, 1, 1045, N'VENTA DE CENTRO DE MAQUINADO SVF4', N'NO. 77', N'01/04/2024', N'SE DIÓ UNA PARTE EN CUENTA FISCAL Y SE COBRARÁ EL IVA Y ADEMÁS SE VENDIÓ UN DNS EN 11,000
TOTAL A COBRARLE AL SEÑOR 56,000 DE IVA 
655,500.00 + 52,000.00  = 707,500', CAST(707500.00 AS Decimal(18, 2)), CAST(N'2024-04-08T14:46:25.130' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6027, 1702307804, 4, 154, 102, 0, 1, 1046, N'PRIMER PAGO DE CENTRO DE MAQUINADO SVF4 ', N'', N'01/04/2024', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2024-04-08T14:44:59.953' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6028, 1702307804, 4, 1203, 102, 0, 1, 1047, N'PAGO DE TORNO CNC HARDINGE ', N'', N'08/04/2024', N'', CAST(75000.00 AS Decimal(18, 2)), CAST(N'2024-04-08T18:32:54.623' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6029, 1702307804, 2, 1191, 104, 0, 1, 1048, N'GASTO DE RENTA ABRIL ', N'', N'02/04/2024', N'', CAST(55000.00 AS Decimal(18, 2)), CAST(N'2024-04-15T10:50:07.133' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6030, 1702307804, 1, 165, 100, 0, 1, 1049, N'VENTA DE CENTRO DE MAQUINADO VF3 ', N'NO. 83', N'15/04/2024', N'DAVID CHRISTIAN FERNANDEZ ', CAST(415000.00 AS Decimal(18, 2)), CAST(N'2024-04-19T15:19:16.517' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6031, 1702307804, 1, 166, 100, 0, 1, 1050, N'VENTA DE TORNO SL-20 2002', N'NO. 28', N'18/04/2024', N'JAIME BRAVO ', CAST(375000.00 AS Decimal(18, 2)), CAST(N'2024-04-19T15:23:51.083' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6032, 1702307804, 1, 3290, 102, 0, 1, 1051, N'VENTA DE SERVO-BAR HAAS ', N'NO.60', N'18/04/2024', N'JAIME BRAVO ', CAST(75000.00 AS Decimal(18, 2)), CAST(N'2024-04-19T15:27:25.767' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6033, 1702307804, 4, 179, 102, 0, 1, 1052, N'PAGO DE SERVO-BAR ', N'NO. 60', N'18/04/2024', N'', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2024-04-19T15:28:06.233' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6034, 1702307804, 1, 153, 102, 0, 3, 1053, N'VENTA DE PERFILADORA BRIDGEPORT CNC ', N'NO. 57', N'19/04/2024', N'EDGAR FRANCISCO DÍAZ CASTAÑEDA ', CAST(110200.00 AS Decimal(18, 2)), CAST(N'2024-04-19T18:15:57.103' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6035, 1702307804, 1, 153, 102, 0, 1, 1054, N'VENTA DE PERFILADOR BRIDGEPORT CNC ', N'', N'18/04/2024', N'EDGAR FRANCISCO DÍAZ CASTAÑEDA ', CAST(100200.00 AS Decimal(18, 2)), CAST(N'2024-04-19T18:33:27.357' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6036, 1702307804, 4, 179, 102, 0, 1, 1055, N'PAGO DE PERFILADORA BRIDGEPORT CNC', N'', N'18/04/2024', N'', CAST(80000.00 AS Decimal(18, 2)), CAST(N'2024-04-19T18:34:12.130' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6037, 1702307804, 1, 165, 100, 0, 1, 1056, N'VENTA DE CENTRO DE MAQUINADO VF3 ', N'NO. 82', N'18/04/2024', N'JOSÉ REYES ', CAST(425000.00 AS Decimal(18, 2)), CAST(N'2024-04-30T11:24:57.253' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6038, 1702307804, 1, 165, 100, 0, 1, 1057, N'VENTA DE CENTRO DE MAQUINADO VF4 ', N'NO. 35', N'18/04/2024', N'MANUEL OCHOA ', CAST(450000.00 AS Decimal(18, 2)), CAST(N'2024-04-30T11:43:03.960' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6039, 1702307804, 3, 1234, 100, 0, 1, 1058, N'COSTO TOTAL DEL MES DE ABRIL 2024', N'C-004-2024', N'30/04/2024', N'COSTO TOTAL DEL MES DE ABRIL 2024
CM SUPER VF4
CM VF3
TORNO CNC SL-20 2002
SERVOBAR HAAS
PERFILADORA BRIDGEPORT 
CM VF3
CM VF4', CAST(1987540.00 AS Decimal(18, 2)), CAST(N'2024-05-01T18:44:47.893' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6040, 1702307804, 1, 165, 100, 0, 1, 1059, N'VENTA DE CENTRO DE MAQUINADO VFOE ', N'', N'01/05/2024', N'150,000 CUENTA FISCAL 
105,000 CUENTA DAVID 
100,000 ALTAGRACIA 
10,000 ANTICIPO ', CAST(365000.00 AS Decimal(18, 2)), CAST(N'2024-05-01T18:56:33.453' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6041, 1702307804, 2, 176, 105, 0, 1, 1060, N'COMPRA DE HERRAMIENTA PARA BODEGA ', N'', N'09/05/2024', N'', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2024-05-13T11:16:53.053' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6042, 1702307804, 1, 156, 100, 0, 1, 1061, N'VENTA DE FRESADORA LAGUN', N'NO. 61', N'13/05/2024', N'', CAST(65000.00 AS Decimal(18, 2)), CAST(N'2024-05-14T12:13:51.210' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6043, 1702307804, 2, 1191, 100, 0, 1, 1062, N'PAGO DE ARREGLO SIAPA', N'', N'09/05/2024', N'', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2024-05-21T12:25:06.027' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6044, 1702307804, 2, 176, 100, 0, 1, 1063, N'GASTO DE FIBRAS ', N'', N'06/05/2024', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2024-05-21T12:53:40.590' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6045, 1702307804, 2, 176, 100, 0, 1, 1064, N'GASTO DE BASURA ', N'', N'06/05/2024', N'', CAST(100.00 AS Decimal(18, 2)), CAST(N'2024-05-21T12:59:32.413' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6046, 1702307804, 2, 176, 100, 0, 1, 1065, N'GASTO DE GASOLINA NISSAN ', N'', N'08/05/2024', N'', CAST(2000.00 AS Decimal(18, 2)), CAST(N'2024-05-21T13:04:42.793' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6047, 1702307804, 2, 1222, 100, 0, 1, 1066, N'GASTO DE NOMINA ', N'', N'03/05/2024', N'', CAST(8000.00 AS Decimal(18, 2)), CAST(N'2024-05-21T13:11:14.623' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6048, 1702307804, 2, 176, 100, 0, 1, 1067, N'GASTO DE CAÑERÍA ', N'', N'03/05/2024', N'', CAST(400.00 AS Decimal(18, 2)), CAST(N'2024-05-21T13:25:55.177' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6053, 1702307804, 1, 165, 100, 0, 1, 1068, N'VENTA DE CENTRO DE MAQUINADO VF4 ', N'', N'24/05/2024', N'', CAST(400000.00 AS Decimal(18, 2)), CAST(N'2024-05-29T13:31:19.710' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6054, 1702307804, 2, 1223, 1109, 0, 1, 1069, N'GASTO DE CRM ', N'', N'28/05/2024', N'', CAST(3365.00 AS Decimal(18, 2)), CAST(N'2024-05-29T14:24:37.243' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6055, 1702307804, 2, 1205, 1109, 0, 1, 1070, N'GASTO DE INTERES Y ABONO A CAPITAL BERTHA ', N'', N'28/05/2024', N'', CAST(24000.00 AS Decimal(18, 2)), CAST(N'2024-05-29T14:59:26.107' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6056, 1702307804, 3, 1234, 100, 0, 1, 1071, N'COSTO TOTAL DEL MES DE MAYO 2024 ', N'C-005-2024', N'31/05/2024', N'COSTO TOTAL DEL MES DE MAYO 2024 
FRESADORA LAGUN 
CENTRO DE MAQUINADO VFOE 
CENTRO DE MAQUINADO VF4 1998 (VF3)
VENTA DE TARJETA ', CAST(480053.07 AS Decimal(18, 2)), CAST(N'2024-06-03T18:43:20.370' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6057, 1702307804, 1, 166, 102, 0, 1, 1072, N'VENTA DE TORNO CNC MAZAK ', N'NO. 112', N'07/06/2024', N'', CAST(550000.00 AS Decimal(18, 2)), CAST(N'2024-06-18T12:53:10.033' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6058, 1702307804, 1, 165, 105, 0, 1, 1073, N'VENTA DE CENTRO DE MAQUINADO VF6 1995', N'NO. 23', N'07/06/2024', N'', CAST(725000.00 AS Decimal(18, 2)), CAST(N'2024-06-18T14:56:34.627' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6059, 1702307804, 1, 153, 100, 0, 1, 1074, N'VENTA DE PERFILADORA BRIDGEPORT ', N'NO. 42 ', N'07/06/2024', N'', CAST(87000.00 AS Decimal(18, 2)), CAST(N'2024-06-18T16:49:27.217' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6060, 1702307804, 1, 166, 105, 0, 1, 1075, N'VENTA DE TORNO CNC HL-2', N'', N'07/06/2024', N'A CAMBIO DEL OKUMA ', CAST(124200.00 AS Decimal(18, 2)), CAST(N'2024-06-18T16:50:49.880' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6061, 1702307804, 1, 165, 102, 0, 1, 1076, N'VENTA DE CENTRO DE MAQUINADO VF4 ', N'', N'07/06/2024', N'', CAST(975000.00 AS Decimal(18, 2)), CAST(N'2024-06-18T18:10:17.460' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6062, 1702307804, 1, 165, 102, 0, 1, 1077, N'VENTA DE CENTRO DE MAQUINADO MORI SEIKI MV-JUNIOR ', N'NO. 120', N'03/06/2024', N'', CAST(522000.00 AS Decimal(18, 2)), CAST(N'2024-06-18T18:51:38.933' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6063, 1702307804, 4, 154, 102, 0, 1, 1078, N'PAGO DE CENTRO DE MAQUINADO VIPER ', N'', N'10/06/2024', N'', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2024-06-18T18:55:06.820' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6064, 1702307804, 2, 1205, 106, 0, 1, 1079, N'PAGO A ING ANTONIO ', N'', N'03/06/2024', N'', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2024-06-24T14:03:09.020' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6065, 1702307804, 2, 1205, 106, 0, 1, 1080, N'INTERES CAYETANO ', N'', N'03/06/2024', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2024-06-24T14:56:33.150' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6066, 1702307804, 2, 159, 104, 0, 1, 1081, N'PAGO DE TARJETA INVEX ', N'', N'07/06/2024', N'', CAST(13700.00 AS Decimal(18, 2)), CAST(N'2024-06-24T16:18:24.263' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6067, 1702307804, 2, 159, 104, 0, 1, 1082, N'PAGO TARJETA HSBC ', N'', N'07/06/2024', N'', CAST(19316.00 AS Decimal(18, 2)), CAST(N'2024-06-24T16:19:36.733' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6068, 1702307804, 4, 154, 103, 0, 1, 1083, N'PAGO A CAPITAL DAVID GONZALEZ ', N'', N'20/06/2024', N'', CAST(1000000.00 AS Decimal(18, 2)), CAST(N'2024-06-24T17:18:53.493' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6069, 1702307804, 5, 1212, 102, 100, 1, 1084, N'PRESTAMO PAPÁ DE ALLAN ', N'', N'20/06/2024', N'', CAST(15000.00 AS Decimal(18, 2)), CAST(N'2024-06-24T18:00:01.420' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6070, 1702307804, 6, 1252, 1132, 1132, 1, 1085, N'COMPRA DE DÓLARES ', N'', N'20/06/2024', N'', CAST(300000.00 AS Decimal(18, 2)), CAST(N'2024-06-24T18:22:38.193' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6071, 1702307804, 1, 165, 100, 0, 1, 1086, N'VENTA DE CENTRO DE MAQUINADO VF3 ', N'NO. 106', N'25/06/2024', N'', CAST(400000.00 AS Decimal(18, 2)), CAST(N'2024-06-25T12:18:42.150' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6072, 1702307804, 1, 165, 100, 0, 1, 1087, N'VENTA DE CENTRO DE MAQUINADO VF1 ', N'NO. 87', N'20/06/2024', N'235,000 MÁS IVA 
100,000 EN EFECTIVO', CAST(335000.00 AS Decimal(18, 2)), CAST(N'2024-06-25T13:43:28.277' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6073, 1702307804, 1, 166, 100, 0, 1, 1088, N'VENTA DE TORNO CNC HITACHI SEIKI 4NE-II', N'', N'25/06/2024', N'', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2024-07-02T10:59:24.457' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6074, 1702307804, 3, 1234, 100, 0, 1, 1089, N'COSTO TOTAL DEL MES DE JUNIO 2024', N'C-006-2024', N'30/06/2024', N'COSTO TOTAL DEL MES DE JUNIO 2024 
TORNO CNC HITACHI SEIKI 
CENTRO DE MAQUINADO VF6 
TORNO CNC HL2 
PERFILADORA BRIDGEPORT 
CENTRO DE MAQUINADO VF1 
CENTRO DE MAQUINADO VF4 
CENTRO DE MAQUINADO VF3 (VF4)
CENTRO DE MAQUINADO VF2 
TORNO CNC MAZAK OTN-250 ', CAST(1624811.73 AS Decimal(18, 2)), CAST(N'2024-07-02T11:19:43.230' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6075, 1702307804, 2, 161, 105, 0, 1, 1090, N'PAGO DE MAZDA JUNIO 2024 ', N'', N'01/07/2024', N'', CAST(14662.00 AS Decimal(18, 2)), CAST(N'2024-07-05T14:00:00.223' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6076, 1702307804, 2, 159, 105, 0, 1, 1091, N'PAGO DE PRESTAMO ', N'', N'01/07/2024', N'', CAST(5476.00 AS Decimal(18, 2)), CAST(N'2024-07-05T14:57:29.950' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6077, 1702307804, 2, 159, 105, 0, 1, 1092, N'PAGO DE PRESTAMO ', N'', N'01/07/2024', N'', CAST(2476.00 AS Decimal(18, 2)), CAST(N'2024-07-05T14:59:33.450' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6078, 1702307804, 2, 159, 105, 0, 3, 1093, N'PAGO DE PRESTAMOS ', N'', N'01/07/2024', N'', CAST(2476.00 AS Decimal(18, 2)), CAST(N'2024-07-05T15:56:46.233' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6079, 1702307804, 2, 161, 105, 0, 1, 1094, N'GASTO PERSOLAN DE ALLAN ', N'', N'02/07/2024', N'', CAST(4000.00 AS Decimal(18, 2)), CAST(N'2024-07-05T15:58:41.523' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6080, 1702307804, 2, 159, 105, 0, 1, 1095, N'PAGO DE PRESTAMO BANCO ', N'', N'01/07/2024', N'', CAST(5183.00 AS Decimal(18, 2)), CAST(N'2024-07-05T15:59:37.467' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6081, 1702307804, 2, 159, 105, 0, 1, 1096, N'PAGO DE PRESTAMO ALLAN ', N'', N'01/07/2024', N'', CAST(1636.00 AS Decimal(18, 2)), CAST(N'2024-07-05T16:54:00.013' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6082, 1702307804, 2, 159, 105, 0, 1, 1097, N'PAGO DE PRESTAMO ALLAN ', N'', N'01/07/2024', N'', CAST(1637.00 AS Decimal(18, 2)), CAST(N'2024-07-05T17:27:33.210' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6083, 1702307804, 2, 176, 105, 0, 1, 1098, N'GASTO DE DISCOS PARA CORTADORA ', N'', N'01/07/2024', N'', CAST(420.00 AS Decimal(18, 2)), CAST(N'2024-07-05T17:28:15.097' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6084, 1702307804, 2, 1232, 105, 0, 1, 1099, N'PAGO DE GAS TACOMA ', N'', N'01/07/2024', N'', CAST(1602.00 AS Decimal(18, 2)), CAST(N'2024-07-05T18:08:30.170' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6085, 1702307804, 1, 165, 102, 0, 1, 1100, N'VENTA DE CENTRO DE MAQUINADO SUPERMAX REBEL ', N'NO. 13', N'12/07/2024', N'', CAST(250000.00 AS Decimal(18, 2)), CAST(N'2024-08-22T18:39:51.150' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6086, 1702307804, 4, 154, 102, 0, 1, 1101, N'PAGO DE CENTRO DE MAQUINADO SUPERMAX', N'NO. 13', N'12/07/2024', N'', CAST(225000.00 AS Decimal(18, 2)), CAST(N'2024-08-22T18:46:42.200' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6087, 1702307804, 1, 1180, 102, 0, 1, 1102, N'VENTA DE CENTRO DE MAQUINADO VF3 ', N'NO. 128', N'19/07/2024', N'', CAST(450000.00 AS Decimal(18, 2)), CAST(N'2024-08-23T15:10:59.060' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6088, 1702307804, 4, 154, 102, 0, 1, 1103, N'PAGO DE CENTRO DE MAQUINADO VF3', N'NO. 128 ', N'19/07/2024', N'', CAST(250000.00 AS Decimal(18, 2)), CAST(N'2024-08-26T14:18:18.110' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6089, 1702307804, 3, 1234, 100, 0, 1, 1104, N'COSTO TOTAL DEL MES DE JULIO 2024', N'CO-007-2024', N'31/07/2024', N'COSTO TOTAL DEL MES DE JULIO 2024
CENTRO DE MAQUINADO SUPERMAX
CENTRO DE MAQUINADO VF3 1997', CAST(551287.54 AS Decimal(18, 2)), CAST(N'2024-08-28T18:08:11.023' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6090, 1702307804, 3, 1234, 100, 0, 1, 1105, N'COSTO TOTAL DEL MES DE AGOSTO 2024', N'CO-008-2024', N'28/08/2024', N'COSTO TOTAL DEL MES DE AGOSTO 
CENTRO DE MAQUINADO VF3 1993
TORNO CNC PUMA 200 LC
CENTRO DE MAQUINADO VF1 
TORNO CONVENCIONAL ROMI ', CAST(875542.87 AS Decimal(18, 2)), CAST(N'2024-08-28T18:29:41.270' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6091, 1702307804, 1, 153, 100, 0, 1, 1106, N'VENTA DE PERFILADORA TRAH ', N'', N'01/08/2024', N'', CAST(195000.00 AS Decimal(18, 2)), CAST(N'2024-08-28T18:43:09.930' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6092, 1702307804, 1, 165, 100, 0, 1, 1107, N'VENTA DE CENTRO DE MAQUINADO VF3 1993', N'', N'07/08/2024', N'', CAST(435000.00 AS Decimal(18, 2)), CAST(N'2024-08-28T18:51:19.950' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6093, 1702307804, 1, 166, 100, 0, 1, 1108, N'VENTA DE TORNO CNC PUMA 200 LC', N'', N'16/08/2024', N'', CAST(415000.00 AS Decimal(18, 2)), CAST(N'2024-08-28T18:53:12.080' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6094, 1702307804, 1, 165, 100, 0, 1, 1109, N'VENTA DE CENTRO DE MAQUINADO VF1 ', N'', N'16/08/2024', N'', CAST(310000.00 AS Decimal(18, 2)), CAST(N'2024-08-28T18:53:50.700' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6095, 1702307804, 1, 166, 100, 0, 1, 1110, N'VENTA DE TORNO CONVENCIONAL ROMI ', N'', N'21/08/2024', N'', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2024-08-28T18:54:32.887' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6096, 1702307804, 1, 3291, 105, 0, 1, 1111, N'VENTA DE CUARTO EJE ', N'', N'02/09/2024', N'SE VENDIÓ EN 150,000 MÁS IVA', CAST(174000.00 AS Decimal(18, 2)), CAST(N'2024-09-03T13:47:17.853' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6097, 1702307804, 1, 1199, 102, 0, 1, 1112, N'TARJETA VENDIDA', N'', N'31/12/2022', N'', CAST(35000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T17:55:13.177' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6098, 1702307804, 1, 166, 102, 0, 1, 1113, N'VENTA DE HL2 ', N'', N'31/12/2022', N'', CAST(75000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T17:55:33.357' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6099, 1702307804, 1, 165, 102, 0, 1, 1114, N'VENTA DE VF3 MONTAÑO ', N'', N'31/12/2022', N'', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T17:55:59.053' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6100, 1702307804, 1, 165, 102, 0, 1, 1115, N'VENTA DE VF4 2007', N'', N'31/12/2022', N'', CAST(285000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T17:56:27.417' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6101, 1702307804, 1, 165, 102, 0, 1, 1116, N'VENTA DESAMA CENTRO DE MAQUINADO ', N'', N'31/12/2022', N'', CAST(25000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T17:57:15.537' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6102, 1702307804, 1, 165, 102, 0, 1, 1117, N'VENTA DE VF1 ', N'', N'31/12/2022', N'', CAST(100000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T17:57:28.857' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6103, 1702307804, 2, 1192, 103, 0, 3, 1118, N'BETO CASILLAS ', N'', N'31/12/2022', N'', CAST(300000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:17:06.380' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6104, 1702307804, 2, 1192, 103, 0, 3, 1119, N'SANTANDER OSVALDO BARBA', N'', N'31/12/2022', N'', CAST(1000000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:18:22.813' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6105, 1702307804, 2, 152, 103, 0, 3, 1120, N'ALTAGRACIA BANCO BBVA', N'', N'31/12/2022', N'', CAST(600000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:18:45.063' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6106, 1702307804, 2, 1191, 103, 0, 1, 1121, N'BENITO REAL ', N'', N'31/12/2022', N'', CAST(65000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:19:06.477' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6107, 1702307804, 2, 1191, 103, 0, 1, 1122, N'HERMANA DE ALTAGRACIA ', N'', N'31/12/2022', N'', CAST(130000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:20:17.837' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6108, 1702307804, 2, 1192, 103, 0, 1, 1123, N'MIGUEL USA TOTOTLÁN', N'', N'31/12/2022', N'', CAST(52850.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:20:54.707' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6109, 1702307804, 2, 1192, 103, 0, 1, 1124, N'NELSON USA ', N'', N'31/12/2022', N'', CAST(6000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:21:17.643' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6110, 1702307804, 2, 1192, 103, 0, 3, 1125, N'XX', N'', N'31/12/2022', N'', CAST(102500.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:21:54.717' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6111, 1702307804, 2, 1191, 103, 0, 3, 1126, N'ALLAN BANCO BBVA', N'', N'31/12/2022', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:23:22.457' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6112, 1702307804, 2, 1192, 103, 0, 3, 1127, N'ING ANTONIO (TOBY)', N'', N'31/12/2022', N'', CAST(110000.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:24:37.857' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6113, 1702307804, 2, 1191, 103, 0, 3, 1128, N'ALTAGRACIA 2 ', N'', N'31/12/2022', N'', CAST(192500.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:25:26.490' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6114, 1702307804, 2, 1192, 103, 0, 3, 1129, N'XX', N'', N'31/12/2022', N'', CAST(102500.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:25:40.593' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6115, 1702307804, 2, 1191, 103, 0, 3, 1130, N'SSS', N'', N'31/12/2022', N'', CAST(25500.00 AS Decimal(18, 2)), CAST(N'2024-09-05T18:49:46.413' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6116, 1702307804, 2, 1192, 103, 0, 1, 1131, N'DAVID GONZALEZ 1', N'', N'31/12/2022', N'', CAST(1100000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:07:45.507' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6117, 1702307804, 2, 1192, 103, 0, 1, 1132, N'BETO CASILLAS ', N'', N'31/12/2022', N'', CAST(300000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:08:12.690' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6118, 1702307804, 2, 1192, 103, 0, 1, 1133, N'ING ANTONIO (TOBY)', N'', N'31/12/2022', N'', CAST(1000000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:08:41.840' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6119, 1702307804, 2, 1192, 103, 0, 1, 1134, N'ALFREDO AVILA ', N'', N'31/12/2022', N'', CAST(750000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:09:19.287' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6120, 1702307804, 2, 1191, 103, 0, 1, 1135, N'JORGE CABERA ', N'', N'31/12/2022', N'', CAST(1500000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:10:01.867' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6121, 1702307804, 2, 1191, 103, 0, 1, 1136, N'CAYETANO ', N'', N'31/12/2022', N'', CAST(700000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:10:29.347' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6122, 1702307804, 2, 1191, 103, 0, 1, 1137, N'GUSTAVO BARBA ', N'', N'31/12/2022', N'', CAST(200000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:10:59.057' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6123, 1702307804, 2, 1191, 103, 0, 1, 1138, N'BERTHA ', N'', N'31/12/2022', N'', CAST(160000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:11:18.530' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6124, 1702307804, 2, 1191, 103, 0, 1, 1139, N'DAVID GONZALEZ 2 ', N'', N'31/12/2022', N'', CAST(600000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:11:49.773' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6125, 1702307804, 2, 1191, 103, 0, 1, 1140, N'DAVID GONZALEZ 3 ', N'', N'31/12/2022', N'', CAST(1800000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:12:11.647' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6126, 1702307804, 2, 1191, 103, 0, 1, 1141, N'PRESTAMO KONFÍO', N'', N'31/12/2022', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:12:42.677' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6127, 1702307804, 2, 1192, 103, 0, 1, 1142, N'PRESTAMO ALTAGRACIA ', N'', N'31/12/2022', N'', CAST(400000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:13:02.663' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6128, 1702307804, 2, 1191, 103, 0, 1, 1143, N'ALLAN BANCO BBVA ', N'', N'31/12/2022', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:13:28.863' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6129, 1702307804, 2, 1191, 103, 0, 1, 1144, N'DAVID BANCO BBVA', N'', N'31/12/2022', N'', CAST(90000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:14:05.800' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6130, 1702307804, 2, 1192, 103, 0, 1, 1145, N'SANTANDER OSVALDO ', N'', N'31/12/2022', N'', CAST(1000000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:14:40.643' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6131, 1702307804, 2, 1192, 103, 0, 1, 1146, N'ALTAGRACIA BANCO BBVA ', N'', N'31/12/2022', N'', CAST(600000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:15:03.687' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6132, 1702307804, 2, 1191, 103, 0, 1, 1147, N'JAIME USA ', N'', N'31/12/2022', N'', CAST(25500.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:15:29.230' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6133, 1702307804, 2, 1191, 103, 0, 1, 1148, N'ALTAGRACIA 2 ', N'', N'31/12/2022', N'', CAST(192500.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:16:01.230' AS DateTime), N'allan@maqallan.com')
GO
INSERT [dbo].[MtoCat_RegistroDiario] ([RegistroID], [EmpresaTransID], [ClasificacionID], [SubClasificacionID], [CuentaID], [SubCuentaID], [EstatusID], [FolioInterno], [Descripcion], [Referencia], [FechaRegistro], [Observaciones], [Importe], [CreadoEl], [CreadoPor]) VALUES (6134, 1702307804, 2, 1191, 103, 0, 1, 1149, N'ING ANTONIO (TOBY) 2', N'', N'31/12/2022', N'', CAST(110000.00 AS Decimal(18, 2)), CAST(N'2024-09-06T12:16:35.850' AS DateTime), N'allan@maqallan.com')
GO
SET IDENTITY_INSERT [dbo].[MtoCat_RegistroDiario] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_SaldosInicialesEmpresa] ON 
GO
INSERT [dbo].[MtoCat_SaldosInicialesEmpresa] ([SaldoInicialID], [EmpresaTransID], [Efectivo], [Bancos], [DeudasCobrar], [ActivoFijo], [DeudasPagar], [CapitalInicial], [CapitalFinal], [CreadoPor], [CreadoEl], [ModificadoPor], [ModificadoEl]) VALUES (19, 1702307804, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(720000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(12607850.00 AS Decimal(18, 2)), CAST(-11887850.00 AS Decimal(18, 2)), CAST(-11887850.00 AS Decimal(18, 2)), N'Sistema', CAST(N'2023-05-17T12:39:11.050' AS DateTime), N'allan@maqallan.com', CAST(N'2024-09-05T18:50:17.463' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MtoCat_SaldosInicialesEmpresa] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_TipoCuentas] ON 
GO
INSERT [dbo].[MtoCat_TipoCuentas] ([TipoCuentaID], [Descripcion]) VALUES (1, N'Efectivo')
GO
INSERT [dbo].[MtoCat_TipoCuentas] ([TipoCuentaID], [Descripcion]) VALUES (2, N'Banco(s)')
GO
INSERT [dbo].[MtoCat_TipoCuentas] ([TipoCuentaID], [Descripcion]) VALUES (3, N'Cuentas por cobrar')
GO
INSERT [dbo].[MtoCat_TipoCuentas] ([TipoCuentaID], [Descripcion]) VALUES (4, N'Cuentas por pagar ')
GO
SET IDENTITY_INSERT [dbo].[MtoCat_TipoCuentas] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_TipoMembresias] ON 
GO
INSERT [dbo].[MtoCat_TipoMembresias] ([TipoMembresiaID], [Descripcion], [EsSugerido], [CreadoEl], [CreadoPor]) VALUES (1, N'Gratuita', 0, CAST(N'2021-03-04T08:00:24.267' AS DateTime), N'Sistemas')
GO
INSERT [dbo].[MtoCat_TipoMembresias] ([TipoMembresiaID], [Descripcion], [EsSugerido], [CreadoEl], [CreadoPor]) VALUES (2, N'MicroEmpresa', 0, CAST(N'2021-03-04T08:00:30.217' AS DateTime), N'Sistemas')
GO
INSERT [dbo].[MtoCat_TipoMembresias] ([TipoMembresiaID], [Descripcion], [EsSugerido], [CreadoEl], [CreadoPor]) VALUES (3, N'Negocio', 1, CAST(N'2021-03-04T08:01:11.730' AS DateTime), N'Sistemas')
GO
INSERT [dbo].[MtoCat_TipoMembresias] ([TipoMembresiaID], [Descripcion], [EsSugerido], [CreadoEl], [CreadoPor]) VALUES (4, N'Empresarial', 0, CAST(N'2021-03-04T08:01:17.757' AS DateTime), N'Sistemas')
GO
SET IDENTITY_INSERT [dbo].[MtoCat_TipoMembresias] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Usuarios] ON 
GO
INSERT [dbo].[MtoCat_Usuarios] ([UsuarioID], [EmpresaTransID], [EsActivo], [NombreUsuario], [CorreoUsuario], [Contrasena], [CreadoPor], [CreadoEl]) VALUES (19, 1702307804, 1, N'Allan Enrique Giovanni Galván Barba ', N'allan@maqallan.com', N'$2b$10$F0AeoDpi8aOZ8Rx18uF08ursS8Is3pkwEpduXFa2n.KeoHyL6l0X2', N'allan@maqallan.com', CAST(N'2023-05-17T12:39:11.067' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MtoCat_Usuarios] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoTra_Cobranza] ON 
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (210, 1702307804, 2271, 0, 1, CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (213, 1702307804, 2300, 0, 1, CAST(279310.00 AS Decimal(18, 2)), CAST(279310.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (212, 1702307804, 2299, 0, 1, CAST(30000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (216, 1702307804, 2309, 0, 1, CAST(140000.00 AS Decimal(18, 2)), CAST(140000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (224, 1702307804, 2534, 0, 1, CAST(50000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (225, 1702307804, 2536, 0, 0, CAST(36000.00 AS Decimal(18, 2)), CAST(36000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (226, 1702307804, 2539, 0, 1, CAST(325000.00 AS Decimal(18, 2)), CAST(325000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (233, 1702307804, 2641, 0, 1, CAST(445000.00 AS Decimal(18, 2)), CAST(445000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (234, 1702307804, 2655, 0, 1, CAST(130000.00 AS Decimal(18, 2)), CAST(130000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (197, 1702307804, 1117, 0, 1, CAST(900000.00 AS Decimal(18, 2)), CAST(900000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2333, 1702307804, 6116, 1, 0, CAST(1100000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1100000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (179, 1702307804, 1051, 1, 0, CAST(120000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(120000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2334, 1702307804, 6117, 1, 0, CAST(300000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(300000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (1308, 1702307804, 4066, 0, 1, CAST(5000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2335, 1702307804, 6118, 1, 0, CAST(1000000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2336, 1702307804, 6119, 1, 0, CAST(750000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(750000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (187, 1702307804, 1059, 1, 0, CAST(78000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(78000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (188, 1702307804, 1060, 1, 0, CAST(78000.00 AS Decimal(18, 2)), CAST(130000.00 AS Decimal(18, 2)), CAST(78000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (200, 1702307804, 1140, 0, 1, CAST(460000.00 AS Decimal(18, 2)), CAST(460000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (201, 1702307804, 1143, 0, 1, CAST(45000.00 AS Decimal(18, 2)), CAST(45000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (203, 1702307804, 1152, 0, 1, CAST(481400.00 AS Decimal(18, 2)), CAST(481400.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (249, 1702307804, 2705, 0, 1, CAST(85000.00 AS Decimal(18, 2)), CAST(85000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (205, 1702307804, 2157, 1, 0, CAST(350000.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), CAST(350000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (208, 1702307804, 2227, 0, 1, CAST(395000.00 AS Decimal(18, 2)), CAST(319000.00 AS Decimal(18, 2)), CAST(76000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (258, 1702307804, 2748, 0, 1, CAST(525000.00 AS Decimal(18, 2)), CAST(525000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (263, 1702307804, 2774, 0, 0, CAST(100000.00 AS Decimal(18, 2)), CAST(100000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (267, 1702307804, 2814, 0, 1, CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (1310, 1702307804, 4072, 1, 0, CAST(200000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (301, 1702307804, 2997, 0, 1, CAST(20000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (303, 1702307804, 3020, 0, 1, CAST(725000.00 AS Decimal(18, 2)), CAST(550000.00 AS Decimal(18, 2)), CAST(175000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (304, 1702307804, 3021, 0, 1, CAST(30000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (1302, 1702307804, 4053, 0, 1, CAST(300000.00 AS Decimal(18, 2)), CAST(280000.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2337, 1702307804, 6120, 1, 0, CAST(1500000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1500000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (1318, 1702307804, 4084, 0, 1, CAST(775000.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)), CAST(575000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (1319, 1702307804, 4085, 0, 1, CAST(600000.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)), CAST(400000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (1320, 1702307804, 4086, 0, 1, CAST(300000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(300000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2339, 1702307804, 6122, 1, 0, CAST(200000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2302, 1702307804, 6026, 0, 1, CAST(707500.00 AS Decimal(18, 2)), CAST(500000.00 AS Decimal(18, 2)), CAST(207500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2303, 1702307804, 6032, 0, 1, CAST(75000.00 AS Decimal(18, 2)), CAST(25000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2304, 1702307804, 6035, 0, 1, CAST(100200.00 AS Decimal(18, 2)), CAST(80000.00 AS Decimal(18, 2)), CAST(20200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2308, 1702307804, 6057, 0, 1, CAST(550000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(550000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2310, 1702307804, 6062, 0, 1, CAST(522000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(522000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2311, 1702307804, 6069, 0, 1, CAST(15000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2313, 1702307804, 6087, 0, 1, CAST(450000.00 AS Decimal(18, 2)), CAST(250000.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2315, 1702307804, 6098, 1, 1, CAST(75000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(75000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2317, 1702307804, 6100, 1, 1, CAST(285000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(285000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2340, 1702307804, 6123, 1, 0, CAST(160000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(160000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2323, 1702307804, 6106, 1, 0, CAST(65000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(65000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2324, 1702307804, 6107, 1, 0, CAST(130000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(130000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2325, 1702307804, 6108, 1, 0, CAST(52850.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(52850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2326, 1702307804, 6109, 1, 0, CAST(6000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(6000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2341, 1702307804, 6124, 1, 0, CAST(600000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(600000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2342, 1702307804, 6125, 1, 0, CAST(1800000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1800000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2344, 1702307804, 6127, 1, 0, CAST(400000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(400000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2350, 1702307804, 6133, 1, 0, CAST(192500.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(192500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2351, 1702307804, 6134, 1, 0, CAST(110000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(110000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (261, 1702307804, 2767, 0, 1, CAST(130000.00 AS Decimal(18, 2)), CAST(75000.00 AS Decimal(18, 2)), CAST(55000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (193, 1702307804, 1073, 0, 0, CAST(15000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (299, 1702307804, 2914, 0, 1, CAST(50000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (300, 1702307804, 2920, 0, 0, CAST(500000.00 AS Decimal(18, 2)), CAST(500000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2312, 1702307804, 6085, 0, 1, CAST(250000.00 AS Decimal(18, 2)), CAST(225000.00 AS Decimal(18, 2)), CAST(25000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2319, 1702307804, 6102, 1, 1, CAST(100000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(100000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (202, 1702307804, 1147, 0, 1, CAST(255000.00 AS Decimal(18, 2)), CAST(255000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (214, 1702307804, 2301, 0, 1, CAST(95000.00 AS Decimal(18, 2)), CAST(95000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (1316, 1702307804, 4082, 0, 1, CAST(550000.00 AS Decimal(18, 2)), CAST(300000.00 AS Decimal(18, 2)), CAST(250000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (228, 1702307804, 2546, 0, 1, CAST(3000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (302, 1702307804, 3004, 0, 1, CAST(335000.00 AS Decimal(18, 2)), CAST(335000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (1317, 1702307804, 4083, 0, 1, CAST(700000.00 AS Decimal(18, 2)), CAST(650000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2316, 1702307804, 6099, 1, 1, CAST(200000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2318, 1702307804, 6101, 1, 1, CAST(25000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(25000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2348, 1702307804, 6131, 1, 0, CAST(600000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(600000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (266, 1702307804, 2812, 0, 0, CAST(30000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (221, 1702307804, 2492, 0, 1, CAST(375000.00 AS Decimal(18, 2)), CAST(375000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2338, 1702307804, 6121, 1, 0, CAST(700000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(700000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (215, 1702307804, 2306, 0, 1, CAST(225000.00 AS Decimal(18, 2)), CAST(225000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (298, 1702307804, 2911, 0, 1, CAST(50000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (217, 1702307804, 2316, 0, 1, CAST(425000.00 AS Decimal(18, 2)), CAST(410500.00 AS Decimal(18, 2)), CAST(14500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (219, 1702307804, 2471, 0, 1, CAST(81200.00 AS Decimal(18, 2)), CAST(81200.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (220, 1702307804, 2484, 0, 1, CAST(1000.00 AS Decimal(18, 2)), CAST(1000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (222, 1702307804, 2517, 0, 1, CAST(725000.00 AS Decimal(18, 2)), CAST(710000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (223, 1702307804, 2531, 0, 0, CAST(16200.00 AS Decimal(18, 2)), CAST(16200.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (262, 1702307804, 2769, 0, 1, CAST(265000.00 AS Decimal(18, 2)), CAST(265000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2343, 1702307804, 6126, 1, 0, CAST(500000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(500000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (1315, 1702307804, 4079, 0, 1, CAST(460000.00 AS Decimal(18, 2)), CAST(440000.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (257, 1702307804, 2746, 0, 0, CAST(56450.00 AS Decimal(18, 2)), CAST(56450.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2309, 1702307804, 6061, 0, 1, CAST(975000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(975000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2314, 1702307804, 6097, 1, 1, CAST(35000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(35000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2345, 1702307804, 6128, 1, 0, CAST(500000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(500000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2346, 1702307804, 6129, 1, 0, CAST(90000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2347, 1702307804, 6130, 1, 0, CAST(1000000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[MtoTra_Cobranza] ([CxCID], [EmpresaTransID], [RegistroID], [EsCobranzaInicial], [EsCxC], [Total], [Abono], [Saldo]) VALUES (2349, 1702307804, 6132, 1, 0, CAST(25500.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(25500.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[MtoTra_Cobranza] OFF
GO
INSERT [dbo].[MtoTra_EmpresaReportesMensual] ([EmpresaTransID], [NoReportesRestantes], [Mes]) VALUES (1702307804, 99, 11)
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (1, N'Acceso con un usuario')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (1, N'Un mes de acceso a la plataforma para llevar tus registros día a día')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (2, N'Acceso con un usuario')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (2, N'Reportes solo en plataforma')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (2, N'Descarga un reporte mensual en formato Excel')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (3, N'Acceso con dos usuarios')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (3, N'Reportes solo en plataforma')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (3, N'Descarga de reportes ilimitados al mes en formato Excel')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (4, N'Acceso con tres usuarios')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (4, N'Reportes solo en plataforma')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (4, N'Descarga de reportes ilimitados al mes en formato Excel')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (4, N'Posibilidad de adquirir más usuarios')
GO
INSERT [dbo].[MtoTra_MembresiaCaracteristicas] ([MembresiaID], [Caracteristica]) VALUES (4, N'Acceso a módulo de canción empresarial')
GO
SET IDENTITY_INSERT [dbo].[MtoTra_PagoMembresias] ON 
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (32, 1740059224, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2023-05-17T12:39:11.140' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (34, 201319402, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2023-06-23T14:02:54.707' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (35, 958288237, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2023-07-28T05:51:31.560' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (36, 1569227723, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2023-09-06T08:53:24.577' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (37, 537099039, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2023-10-06T12:12:15.983' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (41, 432619116, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2023-11-07T10:58:42.900' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (42, 38790577, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2023-12-14T16:16:39.517' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (43, 790903627, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2024-01-18T11:49:17.587' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (44, 529916668, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2024-02-21T12:10:15.227' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (1043, 368249433, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2024-04-03T10:45:27.663' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (1044, 641070013, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2024-05-06T18:12:30.317' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (1046, 936614358, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2024-06-18T11:35:58.437' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (1047, 1151442698, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2024-07-22T10:44:10.100' AS DateTime))
GO
INSERT [dbo].[MtoTra_PagoMembresias] ([PagoID], [TransactioID], [EmpresaID], [MembresiaID], [Pago], [NoCuenta], [CreadoPor], [CreadoEl]) VALUES (1048, 850652071, 1702307804, 4, CAST(300.00 AS Decimal(18, 2)), N'Me', N'allan@maqallan.com', CAST(N'2024-08-22T13:34:38.160' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MtoTra_PagoMembresias] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoTra_Pagos] ON 
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (156, 181, 104, 1075, CAST(3000.00 AS Decimal(18, 2)), CAST(147000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-19T10:19:09.997' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (158, 197, 100, 1118, CAST(500000.00 AS Decimal(18, 2)), CAST(400000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-24T11:59:33.010' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (159, 197, 100, 1119, CAST(100000.00 AS Decimal(18, 2)), CAST(300000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-24T12:01:35.970' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (160, 197, 100, 1120, CAST(100000.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-24T12:03:30.640' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (163, 200, 100, 1142, CAST(160000.00 AS Decimal(18, 2)), CAST(300000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-25T13:43:14.757' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (164, 201, 100, 1144, CAST(25000.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-26T07:28:40.803' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (165, 200, 100, 1145, CAST(150000.00 AS Decimal(18, 2)), CAST(150000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-26T07:30:12.233' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (166, 202, 100, 1148, CAST(10000.00 AS Decimal(18, 2)), CAST(245000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-26T07:58:27.457' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (167, 203, 105, 1153, CAST(5800.00 AS Decimal(18, 2)), CAST(475600.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-26T09:46:33.280' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (168, 202, 100, 1154, CAST(200000.00 AS Decimal(18, 2)), CAST(45000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-26T13:04:04.457' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (169, 197, 106, 1155, CAST(100000.00 AS Decimal(18, 2)), CAST(100000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-29T09:33:22.383' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (170, 202, 106, 1160, CAST(45000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-29T11:51:56.047' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1169, 204, 100, 2158, CAST(316000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-31T06:28:09.533' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1170, 205, 100, 2159, CAST(20000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-31T07:16:46.300' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1172, 203, 105, 2165, CAST(475600.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-05-31T10:08:22.397' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1179, 200, 100, 2218, CAST(150000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-06-06T13:31:43.920' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1180, 208, 100, 2228, CAST(50000.00 AS Decimal(18, 2)), CAST(345000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-06-13T08:35:05.177' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1181, 208, 100, 2229, CAST(50000.00 AS Decimal(18, 2)), CAST(295000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-06-14T10:13:42.417' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1182, 197, 100, 2247, CAST(100000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-07-03T08:06:50.653' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1191, 213, 100, 2302, CAST(129310.00 AS Decimal(18, 2)), CAST(150000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-07-21T12:26:03.383' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1192, 213, 105, 2303, CAST(150000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-07-21T12:28:10.780' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1193, 215, 100, 2307, CAST(94000.00 AS Decimal(18, 2)), CAST(131000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-07-21T12:36:24.700' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1194, 215, 100, 2308, CAST(40000.00 AS Decimal(18, 2)), CAST(91000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-07-21T12:38:49.840' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1195, 216, 100, 2310, CAST(100000.00 AS Decimal(18, 2)), CAST(40000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-07-21T12:45:35.283' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1196, 216, 100, 2311, CAST(40000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-07-21T12:48:09.410' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1197, 201, 100, 2312, CAST(20000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-07-21T12:49:38.840' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1198, 217, 105, 2317, CAST(348000.00 AS Decimal(18, 2)), CAST(77000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-07-21T13:18:34.277' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1200, 177, 100, 2439, CAST(100000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-02T13:34:49.247' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1201, 189, 100, 2449, CAST(120000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-04T08:05:26.357' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1202, 193, 100, 2450, CAST(15000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-04T08:15:49.493' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1203, 188, 100, 2451, CAST(130000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-04T08:18:16.593' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1206, 221, 100, 2493, CAST(50000.00 AS Decimal(18, 2)), CAST(325000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-08T12:52:21.243' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1207, 221, 105, 2494, CAST(200000.00 AS Decimal(18, 2)), CAST(125000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-08T13:10:08.110' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1208, 222, 101, 2518, CAST(30000.00 AS Decimal(18, 2)), CAST(695000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-10T06:59:17.273' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1209, 222, 100, 2519, CAST(100000.00 AS Decimal(18, 2)), CAST(595000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-10T07:01:50.970' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1210, 219, 105, 2520, CAST(40000.00 AS Decimal(18, 2)), CAST(25000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-10T07:10:40.123' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1211, 223, 100, 2532, CAST(16200.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-10T13:56:23.337' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1212, 220, 100, 2537, CAST(500.00 AS Decimal(18, 2)), CAST(500.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-14T09:27:50.780' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1213, 222, 100, 2538, CAST(70000.00 AS Decimal(18, 2)), CAST(525000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-14T09:44:24.483' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1215, 226, 1109, 2542, CAST(25000.00 AS Decimal(18, 2)), CAST(300000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-16T07:18:02.520' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1216, 226, 106, 2580, CAST(15000.00 AS Decimal(18, 2)), CAST(285000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-23T09:59:23.677' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1217, 208, 100, 2581, CAST(49000.00 AS Decimal(18, 2)), CAST(246000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-23T10:03:28.907' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1218, 224, 1109, 2582, CAST(50000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-23T10:07:16.313' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1219, 226, 105, 2594, CAST(100000.00 AS Decimal(18, 2)), CAST(185000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-28T13:48:10.807' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1220, 226, 105, 2595, CAST(100000.00 AS Decimal(18, 2)), CAST(85000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-28T13:52:34.307' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1221, 217, 105, 2596, CAST(62500.00 AS Decimal(18, 2)), CAST(14500.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-08-28T13:54:30.543' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1222, 233, 106, 2642, CAST(250000.00 AS Decimal(18, 2)), CAST(195000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-01T08:01:25.973' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1223, 233, 100, 2643, CAST(25000.00 AS Decimal(18, 2)), CAST(170000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-01T08:06:01.647' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1224, 233, 100, 2644, CAST(50000.00 AS Decimal(18, 2)), CAST(120000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-01T08:14:12.250' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1225, 220, 100, 2645, CAST(500.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-01T08:16:22.803' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1226, 234, 100, 2656, CAST(40000.00 AS Decimal(18, 2)), CAST(90000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-04T07:02:54.273' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1227, 222, 100, 2692, CAST(150000.00 AS Decimal(18, 2)), CAST(375000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-12T08:22:37.170' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1228, 249, 1109, 2706, CAST(10000.00 AS Decimal(18, 2)), CAST(75000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-13T07:19:31.730' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1229, 215, 105, 2732, CAST(30000.00 AS Decimal(18, 2)), CAST(61000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-19T12:37:49.843' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1231, 208, 100, 2737, CAST(50000.00 AS Decimal(18, 2)), CAST(196000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-21T11:40:33.900' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1232, 225, 100, 2740, CAST(36000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-22T10:30:14.443' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1233, 180, 105, 2743, CAST(83000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-22T11:05:53.057' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1236, 258, 100, 2749, CAST(10000.00 AS Decimal(18, 2)), CAST(515000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-25T13:21:09.397' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1237, 210, 100, 2751, CAST(10000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-27T07:41:31.697' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1238, 258, 100, 2752, CAST(390000.00 AS Decimal(18, 2)), CAST(125000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-27T09:32:58.620' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1239, 249, 100, 2753, CAST(10000.00 AS Decimal(18, 2)), CAST(65000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-27T09:36:10.530' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1240, 257, 100, 2761, CAST(10000.00 AS Decimal(18, 2)), CAST(46450.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-27T14:12:23.717' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1241, 222, 106, 2763, CAST(80000.00 AS Decimal(18, 2)), CAST(295000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-28T13:33:57.283' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1242, 222, 106, 2764, CAST(10000.00 AS Decimal(18, 2)), CAST(285000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-28T13:36:52.597' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1243, 222, 106, 2765, CAST(50000.00 AS Decimal(18, 2)), CAST(235000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-28T13:41:54.617' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1244, 219, 105, 2766, CAST(41200.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-09-29T08:53:21.763' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1245, 262, 100, 2770, CAST(125000.00 AS Decimal(18, 2)), CAST(140000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-02T08:56:26.540' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1246, 222, 106, 2771, CAST(90000.00 AS Decimal(18, 2)), CAST(145000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-02T10:35:46.813' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1247, 222, 106, 2773, CAST(100000.00 AS Decimal(18, 2)), CAST(45000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-02T12:25:12.270' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1248, 257, 106, 2775, CAST(23500.00 AS Decimal(18, 2)), CAST(22950.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-03T11:10:44.603' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1249, 215, 105, 2776, CAST(50000.00 AS Decimal(18, 2)), CAST(11000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-03T11:50:00.923' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1250, 208, 100, 2799, CAST(50000.00 AS Decimal(18, 2)), CAST(146000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-10T09:29:36.287' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1253, 257, 100, 2807, CAST(5000.00 AS Decimal(18, 2)), CAST(17950.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-11T13:01:36.293' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1254, 257, 1109, 2808, CAST(4500.00 AS Decimal(18, 2)), CAST(13450.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-11T13:04:36.543' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1255, 257, 106, 2809, CAST(5000.00 AS Decimal(18, 2)), CAST(8450.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-11T13:06:50.590' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1256, 222, 106, 2811, CAST(30000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-12T13:30:50.863' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1257, 262, 106, 2816, CAST(25000.00 AS Decimal(18, 2)), CAST(115000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-20T11:05:44.340' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1258, 233, 100, 2817, CAST(50000.00 AS Decimal(18, 2)), CAST(70000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-20T11:22:49.827' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1259, 257, 106, 2818, CAST(8450.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-10-20T13:03:00.083' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1275, 249, 1109, 2880, CAST(15000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-11-06T13:40:40.077' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1276, 249, 1109, 2881, CAST(5000.00 AS Decimal(18, 2)), CAST(45000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-11-06T14:44:04.473' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1277, 276, 100, 2885, CAST(30000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-11-07T10:51:58.410' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1278, 233, 106, 2922, CAST(25000.00 AS Decimal(18, 2)), CAST(45000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-11-29T16:18:28.950' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1279, 233, 106, 2945, CAST(45000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-11-30T15:44:15.600' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1280, 269, 105, 2950, CAST(50000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-01T11:11:15.390' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1282, 298, 106, 2953, CAST(30000.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-01T17:35:24.773' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1283, 266, 100, 2968, CAST(30000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-05T16:28:00.430' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1284, 249, 1109, 2980, CAST(15000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-14T17:02:04.553' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1285, 249, 1109, 2981, CAST(15000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-14T17:49:12.000' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1286, 212, 105, 2982, CAST(30000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-15T11:56:10.907' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1287, 214, 105, 2983, CAST(30000.00 AS Decimal(18, 2)), CAST(65000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-15T12:30:56.000' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1288, 214, 105, 2984, CAST(65000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-15T12:32:48.423' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1289, 215, 105, 2985, CAST(11000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-15T12:35:26.710' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1290, 226, 100, 2986, CAST(85000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-18T15:57:36.330' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1291, 299, 105, 2987, CAST(50000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-18T16:16:48.480' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1292, 298, 106, 2988, CAST(20000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-18T16:20:12.060' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1293, 221, 106, 2989, CAST(125000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-18T16:34:18.857' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1294, 234, 100, 2990, CAST(90000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-18T16:36:16.343' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1296, 262, 1109, 2992, CAST(20000.00 AS Decimal(18, 2)), CAST(95000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-18T16:47:54.810' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1297, 273, 105, 2993, CAST(11000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-18T17:08:53.103' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1298, 267, 100, 2998, CAST(5000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-20T12:21:27.500' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (1299, 263, 100, 2999, CAST(100000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2023-12-20T12:33:13.557' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2298, 249, 100, 3999, CAST(15000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-01-03T14:10:38.047' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2299, 303, 105, 4000, CAST(490000.00 AS Decimal(18, 2)), CAST(235000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-01-04T09:33:00.783' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2300, 303, 105, 4001, CAST(60000.00 AS Decimal(18, 2)), CAST(175000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-01-04T09:34:40.660' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2302, 258, 100, 4005, CAST(125000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-01-04T12:29:32.037' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2303, 261, 100, 4006, CAST(75000.00 AS Decimal(18, 2)), CAST(55000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-01-04T13:01:33.143' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2304, 208, 105, 4007, CAST(70000.00 AS Decimal(18, 2)), CAST(76000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-01-04T13:05:46.637' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2305, 173, 100, 4012, CAST(150000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-01-09T13:14:55.817' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2306, 169, 100, 4014, CAST(350000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-01-24T11:39:32.053' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2307, 264, 100, 4015, CAST(267600.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-01-24T11:42:29.903' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2308, 1302, 100, 4058, CAST(280000.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-01-31T17:26:47.933' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2309, 262, 100, 4059, CAST(20000.00 AS Decimal(18, 2)), CAST(75000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-06T12:44:21.043' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2310, 175, 100, 4060, CAST(200000.00 AS Decimal(18, 2)), CAST(1500000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-07T12:26:57.390' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2311, 300, 100, 4068, CAST(500000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-15T17:21:22.300' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2312, 1303, 100, 4069, CAST(150000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-15T17:41:51.740' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2314, 304, 100, 4077, CAST(30000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-22T12:29:16.167' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2315, 1315, 100, 4080, CAST(350000.00 AS Decimal(18, 2)), CAST(110000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-27T16:30:29.213' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2316, 1315, 100, 4081, CAST(90000.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-27T16:32:20.840' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2317, 1316, 100, 4087, CAST(300000.00 AS Decimal(18, 2)), CAST(250000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-28T11:38:02.303' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2318, 1317, 100, 4088, CAST(500000.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-28T11:40:32.017' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2319, 1318, 100, 4090, CAST(200000.00 AS Decimal(18, 2)), CAST(575000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-28T14:15:32.710' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2320, 1319, 100, 4091, CAST(200000.00 AS Decimal(18, 2)), CAST(400000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-28T14:17:29.760' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2321, 302, 100, 4092, CAST(305000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-28T17:33:39.787' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2322, 302, 100, 4093, CAST(10000.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-28T17:36:01.417' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (2323, 302, 100, 4094, CAST(20000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-02-28T17:40:04.293' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (3306, 2302, 100, 6027, CAST(500000.00 AS Decimal(18, 2)), CAST(207500.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-04-08T14:45:00.257' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (3307, 262, 1109, 6028, CAST(75000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-04-08T18:32:54.850' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (3308, 2303, 105, 6033, CAST(25000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-04-19T15:28:06.527' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (3309, 2304, 105, 6036, CAST(80000.00 AS Decimal(18, 2)), CAST(20200.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-04-19T18:34:12.423' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (3311, 1317, 100, 6063, CAST(150000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-06-18T18:55:07.007' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (3312, 163, 100, 6068, CAST(1000000.00 AS Decimal(18, 2)), CAST(1320000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-06-24T17:18:53.690' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (3313, 2312, 100, 6086, CAST(225000.00 AS Decimal(18, 2)), CAST(25000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-08-22T18:46:42.400' AS DateTime))
GO
INSERT [dbo].[MtoTra_Pagos] ([PagoID], [CxCID], [TipoCuentaPagoID], [RegistroID], [Abono], [Saldo], [CreadoPor], [CreadoEl]) VALUES (3314, 2313, 100, 6088, CAST(250000.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)), N'allan@maqallan.com', CAST(N'2024-08-26T14:18:18.300' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MtoTra_Pagos] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoTra_SubClasificaciones] ON 
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (152, 1702307804, 3, 1, N'Maquinaria Industrial')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (153, 1702307804, 1, 1, N'Perfiladoras ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (154, 1702307804, 4, 1, N'EFECTIVO ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (155, 1702307804, 3, 1, N'PINTURA ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (156, 1702307804, 1, 1, N'FRESADORA ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (157, 1702307804, 4, 1, N'CUENTA ALLAN ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (158, 1702307804, 3, 1, N'PAGOS MENSUALES ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (159, 1702307804, 2, 1, N'PAGOS MENSUALES')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (160, 1702307804, 2, 1, N'IMPUESTOS SAT')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (161, 1702307804, 2, 1, N'GASTOS PERSONALES ALLAN ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (162, 1702307804, 3, 1, N'FLETES ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (163, 1702307804, 4, 1, N'ALTAGRACIA ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (164, 1702307804, 1, 1, N'VENTILADOR INDUSTRIAL')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (165, 1702307804, 1, 1, N'CENTRO DE MAQUINADO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (166, 1702307804, 1, 1, N'TORNO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (167, 1702307804, 3, 1, N'GASTOS VARIOS DE MAQUINARIA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (168, 1702307804, 2, 1, N'PRESTAMOS A PERSONAL')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (172, 1702307804, 1, 1, N'SIERRA-CINTA ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (173, 1702307804, 1, 1, N'CEPILLO DE CODO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (174, 1702307804, 2, 1, N'DEVOLUCIÓN')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (175, 1702307804, 3, 1, N'GASTOS DE BODEGA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (176, 1702307804, 2, 1, N'GASTOS VARIOS DE BODEGA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (177, 1702307804, 2, 1, N'SERVICIOS ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (178, 1702307804, 1, 1, N'RECTIFICADORA ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (179, 1702307804, 4, 1, N'CUENTA FISCAL ALLAN ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (180, 1702307804, 4, 1, N'TARJETA DAVID ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1180, 1702307804, 1, 1, N'EFECTIVO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1181, 1702307804, 3, 1, N'FLETES')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1182, 1702307804, 3, 1, N'NOMINAS')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1183, 1702307804, 3, 1, N'COMISIONES DAVID')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1186, 1702307804, 1, 1, N'APILADOR')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1187, 1702307804, 1, 1, N'PRESTAMOS PERSONALES')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1188, 1702307804, 2, 1, N'TARJETA INVEX CRÉDITO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1189, 1702307804, 2, 1, N'TARJETA HSBC CRÉDITO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1190, 1702307804, 2, 1, N'TARJETA BBVA CREDITO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1191, 1702307804, 2, 1, N'EFECTIVO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1192, 1702307804, 2, 1, N'EFECTIVO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1193, 1702307804, 3, 1, N'PERFILADORA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1194, 1702307804, 3, 1, N'PERFILADORA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1195, 1702307804, 3, 1, N'REPARACIONES BENITO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1196, 1702307804, 3, 1, N'COMISIONES VARIAS ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1198, 1702307804, 4, 1, N'TARJETAS PROCESO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1199, 1702307804, 1, 1, N'TARJETA PROCESO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1200, 1702307804, 3, 1, N'VIÁTICOS ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1201, 1702307804, 2, 1, N'NOMINA RUBEN')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1202, 1702307804, 1, 1, N'VECTOR DRIVE ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1203, 1702307804, 4, 1, N'TARJETA MARIANA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1205, 1702307804, 2, 1, N'INTERESES ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1206, 1702307804, 5, 1, N'PRESTAMO OSVALDO BARBA|')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1207, 1702307804, 5, 1, N'PRESTAMO RUBEN GALVAN')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1208, 1702307804, 5, 1, N'PRESTAMO GUSTAVO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1209, 1702307804, 2, 1, N'VIÁTICOS ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1210, 1702307804, 1, 1, N'MONTACARGAS')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1211, 1702307804, 5, 1, N'PRESTAMO BETO ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1212, 1702307804, 5, 1, N'PRESTAMO PERSONAL')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1216, 1702307804, 5, 1, N'PRESTAMO ALTAGRACIA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1217, 1702307804, 5, 1, N'PRÉSTAMO SERRANO ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1218, 1702307804, 5, 1, N'PRÉSTAMO SRA. BERTHA ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1219, 1702307804, 5, 1, N'PRÉSTAMOS JAIME GRINGO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1220, 1702307804, 2, 1, N'TELÉFONO E INTERNET')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1221, 1702307804, 2, 1, N'FLETES')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1222, 1702307804, 2, 1, N'NÓMINAS ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1223, 1702307804, 2, 1, N'HONORARIOS ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1224, 1702307804, 5, 1, N'PRESTAMO DAVID ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1225, 1702307804, 2, 1, N'MANIOBRAS')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1226, 1702307804, 5, 1, N'PRÉSTAMO JORGE LLANOS')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1227, 1702307804, 5, 1, N'PRÉSTAMO MIGUEL MOVER ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1228, 1702307804, 5, 1, N'PRESTAMO CARRILLO ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1229, 1702307804, 5, 1, N'PRESTAMOS NETO ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1230, 1702307804, 2, 1, N'IMSS')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1231, 1702307804, 2, 1, N'GASOLINA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1232, 1702307804, 2, 1, N'GASOLINA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1233, 1702307804, 1, 1, N'INYECTORA DE PLÁSTICOS')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1234, 1702307804, 3, 1, N'COSTO TOTAL DEL MES')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1235, 1702307804, 3, 1, N'RENTA DE CENTRO DE MAQUINADO ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1236, 1702307804, 1, 1, N'RENTA DE CENTRO DE MAQUINADO ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1237, 1702307804, 5, 1, N'PRESTAMO DAVID GONZALES')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1239, 1702307804, 5, 1, N'PRESTAMO CHRISTIAN')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1240, 1702307804, 5, 1, N'TIO GUSTAVO ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1241, 1702307804, 5, 1, N'PRESTAMO TIO GUSTAVO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1242, 1702307804, 5, 1, N'PRESTAMO VALDIVIA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1250, 1702307804, 6, 1, N'CUENTA FISCAL ALLAN')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1251, 1702307804, 2, 1, N'FACTURA ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1252, 1702307804, 6, 1, N'EFECTIVO ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1285, 1702307804, 3, 1, N'PERFILADORA ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1286, 1702307804, 5, 1, N'PERFILADORA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1287, 1702307804, 5, 1, N'PRESTAMO FINANCIERA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1288, 1702307804, 2, 1, N'TARJETAS DE CREDITO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1289, 1702307804, 1, 1, N'MANDRINADORA ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1290, 1702307804, 1, 1, N'REFACCIONES')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (1291, 1702307804, 1, 1, N'EROSIONADORA ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (2290, 1702307804, 5, 1, N'PRESTAMO ENRIQUE LOPEZ ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (2291, 1702307804, 5, 1, N'PRESTAMO BANCO')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (2292, 1702307804, 5, 1, N'PRESTAMO CESAR ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (2293, 1702307804, 5, 1, N'PRESTAMO FABRE ')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (2294, 1702307804, 5, 1, N'PRESTAMO USA')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (3290, 1702307804, 1, 1, N'ALIMENTADOR')
GO
INSERT [dbo].[MtoTra_SubClasificaciones] ([ConceptoID], [EmpresaTransID], [ClasificacionID], [EsActivo], [Concepto]) VALUES (3291, 1702307804, 1, 1, N'CUARTO EJE')
GO
SET IDENTITY_INSERT [dbo].[MtoTra_SubClasificaciones] OFF
GO
SET IDENTITY_INSERT [dbo].[MtoTra_UsuariosToken] ON 
GO
INSERT [dbo].[MtoTra_UsuariosToken] ([TokenID], [UsuarioID], [Token], [CreadoEl]) VALUES (6540, 19, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJja2VjayI6dHJ1ZSwidXNlcm5hbWUiOiJhbGxhbkBtYXFhbGxhbi5jb20iLCJwYXNzd29yZCI6IiQyYiQxMCRGMEFlb0RwaThhT1o4UngxOHVGMDh1cnNTOElzM3Brd0VwZHVYRmEybi5LZW9IeUw2bDBYMiIsImlhdCI6MTczMDg0NzE5N30.i2C4OuDvJeKy9A5ug2jYYD__9OMy5YV3-Yupsi_vrds', CAST(N'2024-11-05T16:53:17.517' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MtoTra_UsuariosToken] OFF
GO
ALTER TABLE [dbo].[MtoCat_Estatus] ADD  CONSTRAINT [DF_MtoCat_Estatus_CreadoEl]  DEFAULT (getdate()) FOR [CreadoEl]
GO
ALTER TABLE [dbo].[MtoCat_Membresias] ADD  CONSTRAINT [DF_MtoCat_Membresias_CreadoEl]  DEFAULT (getdate()) FOR [CreadoEl]
GO
ALTER TABLE [dbo].[MtoCat_TipoMembresias] ADD  CONSTRAINT [DF_MtoCat_TipoMembresias_CreadoEl]  DEFAULT (getdate()) FOR [CreadoEl]
GO
ALTER TABLE [dbo].[MtoTra_EmpresaReportesMensual] ADD  CONSTRAINT [DF_MtoTra_EmpresaReportesMensual_NoReportesRestantes]  DEFAULT ((0)) FOR [NoReportesRestantes]
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_BalanceGeneralEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 21/08/2021
-- Description:	Procedimiento almacenado que recupera el balance general de la empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_BalanceGeneralEmpresaRecuperar]--1695082770
	@EmpresaTransID int
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
   	declare @efectivo decimal(18,2) = 0 
	declare @bancos decimal(18,2) = 0 
	declare @cxc decimal (18,2) = 0 
	declare @activoFijo decimal(18,2) = 0
	declare @cxp decimal(18,2) = 0
	declare @capitalInicial decimal(18,2) = 0
	declare @utilidad decimal(18,2) = 0

	declare @efectivoInicial decimal (18,2) = 0 
	declare @bancoInicial decimal (18,2) = 0 
	declare @cxcInicial decimal (18,2) = 0 
	declare @cxpInicial decimal (18,2) = 0 
	declare @capitalFinal decimal (18,2) = 0 

	declare @totalIngreso decimal(18,2) = 0
	declare @totalCompraefectivo decimal(18,2) = 0
	declare @totalComprabanco decimal(18,2) = 0
	declare @totalGastoefectivo decimal(18,2) = 0
	declare @totalGastobanco decimal(18,2) = 0
	declare @pagoClienteEfectivo decimal(18,2) = 0
	declare @pagoClienteBanco decimal(18,2) = 0
	declare @pagoProveedorEfectivo decimal(18,2) = 0
	declare @pagoProveedorBanco decimal(18,2) = 0

	declare @cxcCobranza decimal(18,2) = 0 
	declare @cxpCobranza decimal(18,2) = 0 

	declare @prestamosPorCobrar decimal(18,2) = 0
	declare @prestamosPorCobrarEnEfectivo decimal (18,2) = 0

	declare @efectivoPorPagar decimal(18,2)= 0 
	declare @efectivoPorPagarBancos decimal(18,2) = 0

	declare @efectivoPorCobrarPrestamo decimal(18,2) = 0
	declare @bancoPorCobrarPrestamo decimal(18,2) = 0

	declare @efectivoPorPagarPrestamo decimal(18,2) = 0
	declare @bancoPorPagarPrestamo decimal(18,2) = 0

	declare @transferEfectivo decimal(18,2) = 0
	declare @transferBanco decimal(18,2) = 0

	select @efectivoInicial = Efectivo,
		   @bancoInicial = Bancos,
		   @cxcInicial = DeudasCobrar,
		   @cxpInicial = DeudasPagar,
		   @capitalFinal = CapitalFinal
	from MtoCat_SaldosInicialesEmpresa
	where EmpresaTransID = @EmpresaTransID

	set @cxcCobranza = (
							select isnull((sum(r.Importe)) ,0)
							from MtoCat_RegistroDiario r with (nolock) 
							join MtoTra_Cobranza c with (nolock) on c.RegistroID = r.RegistroID
							where r.EmpresaTransID = @EmpresaTransID
							and c.EsCobranzaInicial = 1
							and c.EsCxC = 1
						)
	
	set @cxpCobranza = (
							select isnull((sum(r.Importe)) ,0)
							from MtoCat_RegistroDiario r with (nolock) 
							join MtoTra_Cobranza c with (nolock) on c.RegistroID = r.RegistroID
							where r.EmpresaTransID = @EmpresaTransID
							and c.EsCobranzaInicial = 1
							and c.EsCxC = 0
						) 

	set @efectivo =  (
						select isnull((sum(r.Importe)) ,0) Efectivo
						from MtoCat_RegistroDiario r with (nolock)
						left join MtoCat_TipoCuentas t with (nolock) on t.TipoCuentaID = 1
						left join MtoCat_Cuentas c with (nolock) on r.CuentaID = c.CuentaID
						where r.ClasificacionID not in (3,2,6)
						and r.EstatusID  != 3
						and c.TipoCuentaID = t.TipoCuentaID
						and r.EmpresaTransID = @EmpresaTransID
					 ) 

	set @prestamosPorCobrar = (
				select isnull((sum(r.Importe)) ,0) Efectivo
				from MtoCat_RegistroDiario r with (nolock)
				left join MtoCat_Cuentas c with (nolock) on r.CuentaID = c.CuentaID
				where r.ClasificacionID = 4
				and r.EstatusID  != 3
				and c.TipoCuentaID in (2)
				and r.EmpresaTransID = @EmpresaTransID	
		)

		set @prestamosPorCobrarEnEfectivo = (
				select isnull((sum(r.Importe)) ,0) Efectivo
				from MtoCat_RegistroDiario r with (nolock)
				left join MtoCat_Cuentas c with (nolock) on r.CuentaID = c.CuentaID
				where r.ClasificacionID = 4
				and r.EstatusID  != 3
				and c.TipoCuentaID in (1,3)
				and r.EmpresaTransID = @EmpresaTransID	
		)

		set @efectivoPorPagar = (
						select isnull((sum(r.Importe)) ,0) Efectivo
						from MtoCat_RegistroDiario r with (nolock)
						left join MtoCat_Cuentas c with (nolock) on r.CuentaID = c.CuentaID
						where r.ClasificacionID not in (3,2,6)
						and r.EstatusID  != 3
						and c.TipoCuentaID in (1,4)
						and r.EmpresaTransID = @EmpresaTransID		
		)

		set @efectivoPorPagarBancos = (
						select isnull((sum(r.Importe)) ,0) Efectivo
						from MtoCat_RegistroDiario r with (nolock)
						left join MtoCat_Cuentas c with (nolock) on r.CuentaID = c.CuentaID
						where r.ClasificacionID not in (3,2,6)
						and r.EstatusID  != 3
						and c.TipoCuentaID in (1,3)
						and r.EmpresaTransID = @EmpresaTransID
		)

	set @bancos =  (
						select isnull((sum(r.Importe)) ,0) Bancos
						from MtoCat_RegistroDiario r with (nolock)
						left join MtoCat_Cuentas c with (nolock) on c.CuentaID = r.CuentaID
						left join MtoCat_TipoCuentas t with (nolock) on t.TipoCuentaID = 2
						where r.EstatusID  != 3
						and c.TipoCuentaID = t.TipoCuentaID
						and r.ClasificacionID not in (3,2,6)
						and r.EmpresaTransID = @EmpresaTransID
					 ) 

	    set @cxc = ( 
						select isnull(sum(r.Importe) ,0) DeudasCobrar
						from MtoCat_RegistroDiario r with (nolock)
						left join MtoCat_Cuentas c with (nolock) on c.CuentaID = r.CuentaID
						left join MtoCat_TipoCuentas t with (nolock) on  t.TipoCuentaID = 3
						left join MtoTra_Cobranza cb with (nolock) on cb.EsCobranzaInicial = 0
						where r.EmpresaTransID = @EmpresaTransID
						and r.ClasificacionID in (1)
						and r.EstatusID  != 3
						and c.TipoCuentaID = t.TipoCuentaID
						and r.RegistroID = cb.RegistroID
					 )

		set @activoFijo = (
						select ActivoFijo
						from MtoCat_SaldosInicialesEmpresa
						where EmpresaTransID = @EmpresaTransID
					  )
	
		set @cxp =  (
						select isnull(sum(r.Importe) ,0) DeudasPagar
						from MtoCat_RegistroDiario r with (nolock)
						left join MtoCat_Cuentas c with (nolock) on c.CuentaID = r.CuentaID
						left join MtoCat_TipoCuentas t with (nolock) on  t.TipoCuentaID = 4
						left join MtoTra_Cobranza cb with (nolock) on cb.EsCobranzaInicial = 0
						where r.EmpresaTransID = @EmpresaTransID
						and r.EstatusID  != 3
						and c.TipoCuentaID = t.TipoCuentaID
						and r.ClasificacionID in (2,3)
						and r.RegistroID = cb.RegistroID
				) 

		set @capitalInicial = (
							select CapitalInicial
							from MtoCat_SaldosInicialesEmpresa
							where EmpresaTransID = @EmpresaTransID
					      )

		set @cxpInicial = (
						select DeudasPagar
						from MtoCat_SaldosInicialesEmpresa
						where EmpresaTransID = @EmpresaTransID
					  )

		set @cxcInicial = (
						select DeudasCobrar
						from MtoCat_SaldosInicialesEmpresa
						where EmpresaTransID = @EmpresaTransID
					)

		set @totalIngreso = (
								select isnull(sum(r.Importe),0)
								from MtoCat_RegistroDiario r with (nolock)
								left join MtoCat_Cuentas c with (nolock) on c.CuentaID = r.CuentaID
								where r.EmpresaTransID = @EmpresaTransID
								and r.ClasificacionID = 1
								--and c.TipoCuentaID in (1,2)
								and r.EstatusID  != 3
							)

		set @totalGastoefectivo = ( select isnull(sum(r.Importe),0)
							  from MtoCat_RegistroDiario r with (nolock)
							  join MtoCat_Cuentas c with (nolock) on c.CuentaID = r.CuentaID
							  join MtoCat_TipoCuentas t with (nolock) on c.TipoCuentaID = t.TipoCuentaID
							  where r.EmpresaTransID = @EmpresaTransID
							  and r.ClasificacionID = 2
							  and t.TipoCuentaID = 1
							  and r.EstatusID  != 3
							)

		set @totalGastobanco = ( select isnull(sum(r.Importe),0)
							  from MtoCat_RegistroDiario r with (nolock)
							  join MtoCat_Cuentas c with (nolock) on c.CuentaID = r.CuentaID
							  join MtoCat_TipoCuentas t with (nolock) on c.TipoCuentaID = t.TipoCuentaID
							  where r.EmpresaTransID = @EmpresaTransID
							  and r.ClasificacionID = 2
							  and t.TipoCuentaID = 2
							  and r.EstatusID  != 3
							)


		set @totalCompraefectivo = ( select isnull(sum(r.Importe),0)
							  from MtoCat_RegistroDiario r with (nolock)
							  join MtoCat_Cuentas c with (nolock) on c.CuentaID = r.CuentaID
							  join MtoCat_TipoCuentas t with (nolock) on c.TipoCuentaID = t.TipoCuentaID
							  where r.EmpresaTransID = @EmpresaTransID
							  and r.ClasificacionID = 3
							  and t.TipoCuentaID = 1
							  and r.EstatusID  != 3
							)

		set @totalComprabanco = ( select isnull(sum(r.Importe),0)
							  from MtoCat_RegistroDiario r with (nolock)
							  join MtoCat_Cuentas c with (nolock) on c.CuentaID = r.CuentaID
							  join MtoCat_TipoCuentas t with (nolock) on c.TipoCuentaID = t.TipoCuentaID
							  where r.EmpresaTransID = @EmpresaTransID
							  and r.ClasificacionID = 3
							  and t.TipoCuentaID = 2
							  and r.EstatusID  != 3
							)

		set @pagoClienteEfectivo = (  
										  select isnull(sum(p.Abono),0)
										  from MtoTra_Pagos p with (nolock)
										  join MtoTra_Cobranza c with (nolock) on c.EmpresaTransID = @EmpresaTransID
										  join MtoCat_Cuentas ct with (nolock) on ct.CuentaID = p.TipoCuentaPagoID 
										  where p.CxCID = c.CxCID
										  and ct.TipoCuentaID = 1
										  and c.EsCxC = 1
										  
							)

		set @pagoClienteBanco = (  
										  select isnull(sum(p.Abono),0)
										  from MtoTra_Pagos p with (nolock)
										  join MtoTra_Cobranza c with (nolock) on c.EmpresaTransID = @EmpresaTransID
										  join MtoCat_Cuentas ct with (nolock) on ct.CuentaID = p.TipoCuentaPagoID 
										  where p.CxCID = c.CxCID
										  and ct.TipoCuentaID = 2
										  and c.EsCxC = 1
							     )

		set @pagoProveedorEfectivo = (  
										  select isnull(sum(p.Abono),0)
										  from MtoTra_Pagos p with (nolock)
										  join MtoTra_Cobranza c with (nolock) on c.EmpresaTransID = @EmpresaTransID
										  join MtoCat_Cuentas ct with (nolock) on ct.CuentaID = p.TipoCuentaPagoID 
										  where p.CxCID = c.CxCID
										  and ct.TipoCuentaID = 1
										  and c.EsCxC = 0
										  
							)

		set @pagoProveedorBanco = (  
										  select isnull(sum(p.Abono),0)
										  from MtoTra_Pagos p with (nolock)
										  join MtoTra_Cobranza c with (nolock) on c.EmpresaTransID = @EmpresaTransID
										  join MtoCat_Cuentas ct with (nolock) on ct.CuentaID = p.TipoCuentaPagoID 
										  where p.CxCID = c.CxCID
										  and ct.TipoCuentaID = 2
										  and c.EsCxC = 0
							     )

		set @efectivoPorCobrarPrestamo = (
											select isnull((sum(r.Importe)) ,0) Efectivo
											from MtoCat_RegistroDiario r with (nolock)
											left join MtoCat_Cuentas c with (nolock) on r.CuentaID = c.CuentaID
											where r.ClasificacionID = 5
											and r.EstatusID  != 3
											and c.TipoCuentaID in (3)
											and r.SubCuentaID = (select CuentaID 
																 from MtoCat_Cuentas 
																 where CuentaID = r.SubCuentaID and 
																 TipoCuentaID = 1 and 
																 EmpresaTransID = @EmpresaTransID)
											and r.EmpresaTransID  =   @EmpresaTransID
										 )

		set @bancoPorCobrarPrestamo = (
											select isnull((sum(r.Importe)) ,0) Efectivo
											from MtoCat_RegistroDiario r with (nolock)
											left join MtoCat_Cuentas c with (nolock) on r.CuentaID = c.CuentaID
											where r.ClasificacionID = 5
											and r.EstatusID  != 3
											and c.TipoCuentaID in (3)
											and r.SubCuentaID = (select CuentaID 
																 from MtoCat_Cuentas 
																 where CuentaID = r.SubCuentaID and 
																 TipoCuentaID = 2 and 
																 EmpresaTransID = @EmpresaTransID)
											and r.EmpresaTransID  =   @EmpresaTransID
										)

		set @efectivoPorPagarPrestamo = (
											select isnull((sum(r.Importe)) ,0) Efectivo
											from MtoCat_RegistroDiario r with (nolock)
											left join MtoCat_Cuentas c with (nolock) on r.CuentaID = c.CuentaID
											where r.ClasificacionID = 5
											and r.EstatusID  != 3
											and c.TipoCuentaID in (4)
											and r.SubCuentaID = (select CuentaID 
																 from MtoCat_Cuentas 
																 where CuentaID = r.SubCuentaID and 
																 TipoCuentaID = 1 and 
																 EmpresaTransID = @EmpresaTransID)
											and r.EmpresaTransID  =   @EmpresaTransID
										 )

		set @bancoPorPagarPrestamo = (
											select isnull((sum(r.Importe)) ,0) Efectivo
											from MtoCat_RegistroDiario r with (nolock)
											left join MtoCat_Cuentas c with (nolock) on r.CuentaID = c.CuentaID
											where r.ClasificacionID = 5
											and r.EstatusID  != 3
											and c.TipoCuentaID in (4)
											and r.SubCuentaID = (select CuentaID 
																 from MtoCat_Cuentas 
																 where CuentaID = r.SubCuentaID and 
																 TipoCuentaID = 2 and 
																 EmpresaTransID = @EmpresaTransID)
											and r.EmpresaTransID  =   @EmpresaTransID
										)

		set @transferEfectivo = (
											select isnull((sum(r.Importe)) ,0) Efectivo
											from MtoCat_RegistroDiario r with (nolock)
											left join MtoCat_Cuentas c with (nolock) on r.CuentaID = c.CuentaID
											where r.ClasificacionID = 6
											and r.EstatusID  != 3
											and c.TipoCuentaID in (1)
											and r.SubCuentaID = (select CuentaID 
																 from MtoCat_Cuentas 
																 where CuentaID = r.SubCuentaID and 
																 TipoCuentaID = 2 and 
																 EmpresaTransID = @EmpresaTransID)
											and r.EmpresaTransID  =   @EmpresaTransID
										 )

		set @transferBanco = (
											select isnull((sum(r.Importe)) ,0) Efectivo
											from MtoCat_RegistroDiario r with (nolock)
											left join MtoCat_Cuentas c with (nolock) on r.CuentaID = c.CuentaID
											where r.ClasificacionID = 6
											and r.EstatusID  != 3
											and c.TipoCuentaID in (2)
											and r.SubCuentaID = (select CuentaID 
																 from MtoCat_Cuentas 
																 where CuentaID = r.SubCuentaID and 
																 TipoCuentaID = 1 and 
																 EmpresaTransID = @EmpresaTransID)
											and r.EmpresaTransID  =   @EmpresaTransID
										 )


	declare @totalIngresoUtilidad decimal(18,2) = ( select isnull(sum(r.Importe),0)
							  from MtoCat_RegistroDiario r with (nolock)
							  where r.EmpresaTransID = @EmpresaTransID
							  and r.ClasificacionID = 1
							  and r.EstatusID  != 3
							)

		declare @totalGastoUtilidad decimal(18,2) = ( select isnull(sum(r.Importe),0)
							  from MtoCat_RegistroDiario r with (nolock)
							  where r.EmpresaTransID = @EmpresaTransID
							  and r.ClasificacionID = 2
							  --and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103)
							  and r.EstatusID  != 3
							)

		declare @totalCompraUtilidad decimal(18,2) = ( select isnull(sum(r.Importe),0)
							  from MtoCat_RegistroDiario r with (nolock)
							  where r.EmpresaTransID = @EmpresaTransID
							  and r.ClasificacionID = 3
							 --and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103) 
							  and r.EstatusID  != 3
							)

	  declare @UtilidaPerdida decimal(18,2) = convert(decimal(18,2), isnull((round((@totalIngreso - @totalCompraUtilidad - @totalGastoUtilidad),2,0)),0))
	--declare @UtilidaPerdida decimal(18,2) = ((((isnull(@totalIngreso + @cxc,0) - (isnull((@totalCompraefectivo + @totalComprabanco),0)) - isnull((@totalGastobanco + @totalGastoefectivo),0)))) - (ISNULL(@cxp + @efectivo ,0)))

	--activos---
	declare @totalEfectivo decimal(18,2) = (ISNULL(@efectivo,0) + ISNULL(@efectivoInicial,0) + ISNULL(@prestamosPorCobrarEnEfectivo,0) + ISNULL(@efectivoPorPagarPrestamo,0) + ISNULL(@transferBanco,0) - ISNULL(@totalGastoefectivo,0) - ISNULL(@totalCompraefectivo,0) - ISNULL(@efectivoPorCobrarPrestamo,0) - ISNULL(@transferEfectivo,0) - ISNULL(@pagoProveedorEfectivo,0)) 
	declare @totalBancos decimal(18,2) = (ISNULL(@bancos,0) + ISNULL(@bancoInicial,0) + ISNULL(@transferEfectivo,0)  +   ISNULL(@bancoPorPagarPrestamo,0) - ISNULL(@totalGastobanco,0) - ISNULL(@totalComprabanco,0) - ISNULL(@bancoPorCobrarPrestamo,0) - ISNULL(@transferBanco,0) - ISNULL(@pagoProveedorBanco,0))
	declare @totalCirculante decimal(18,2) =  (ISNULL(@totalEfectivo,0) + (ISNULL(@totalBancos, 0)))
	declare @totalDeudasCobrar decimal(18,2) = ((ISNULL(@cxc,0) + ISNULL(@cxcInicial,0) + ISNULL(@efectivoPorCobrarPrestamo,0) + ISNULL(@bancoPorCobrarPrestamo,0) ) - (ISNULL(@prestamosPorCobrarEnEfectivo,0) + ISNULL(@prestamosPorCobrar,0)) )
	declare @totalNoCirculante decimal(18,2) = (ISNULL(@totalDeudasCobrar,0) + ISNULL(@activoFijo,0))
	declare @totalActivo decimal (18,2) = (ISNULL(@totalCirculante,0) + ISNULL(@TotalNoCirculante,0))

	--pasivos----
	declare @totalDeudasPagar decimal(18,2) = (ISNULL(@cxpInicial,0) + ISNULL(@cxp,0) + isnull(@efectivoPorPagarPrestamo,0) + isnull(@bancoPorPagarPrestamo,0) - ISNULL(@pagoProveedorEfectivo,0) - ISNULL(@pagoProveedorBanco,0))

	select @totalEfectivo Efectivo,
			--	(isnull(@efectivo + @efectivoInicial + @efectivoPorPagar - @prestamosPorCobrar, 0) - isnull(@totalCompraefectivo,0) - isnull(@totalGastoefectivo, 0) + ISNULL(@pagoClienteEfectivo,0) - ISNULL(@pagoProveedorEfectivo,0) - ISNULL(@efectivoPorPagarBancos,0))  Efectivo, 
		   --(isnull(@bancos + @efectivoPorPagarBancos,0) + isnull(@bancoInicial,0) - isnull(@totalComprabanco,0) - isnull(@totalGastobanco,0) + ISNULL(@pagoClienteBanco,0) - ISNULL(@pagoProveedorBanco,0) ) Bancos, 
		   @totalBancos Bancos,
		   @totalCirculante TotalCirculante,
		   @totalDeudasCobrar DeudasCobrar,
		   @totalActivo TotalActivo,
		   --(isnull((@efectivo + @efectivoPorPagar + @bancos + @bancoInicial + @efectivoInicial - @prestamosPorCobrar - @totalCompraefectivo -@totalComprabanco -@totalGastoefectivo - @totalGastobanco),0) + isnull(@pagoClienteBanco + @pagoClienteEfectivo,0) - ISNULL(@pagoProveedorEfectivo,0) - ISNULL(@pagoProveedorBanco,0)) TotalCirculante,
		   --((isnull(@cxc,0) + isnull(@cxcInicial,0) + isnull(@prestamosPorCobrar,0) - isnull(@pagoClienteEfectivo + @pagoClienteBanco, 0))) DeudasCobrar,
		   isnull(@activoFijo,0) ActivoFijo,
		   @totalNoCirculante TotalNoCirculante,
		   @totalDeudasPagar DeudasPagar,
		   --((isnull((@efectivo + @efectivoPorPagar + @bancos + @bancoInicial + @efectivoInicial - @prestamosPorCobrar - @totalCompraefectivo -@totalComprabanco -@totalGastoefectivo - @totalGastobanco),0) + isnull(@pagoClienteBanco + @pagoClienteEfectivo,0) - ISNULL(@pagoProveedorEfectivo,0) - ISNULL(@pagoProveedorBanco,0)) + isnull((@cxc + @activoFijo + @cxcInicial + @prestamosPorCobrar - isnull(@pagoClienteBanco + @pagoClienteEfectivo,0)),0))  TotalActivo,
		   --((isnull(@cxpInicial + @cxp + @efectivoPorPagar, 0) - isnull(@pagoProveedorBanco + @pagoProveedorEfectivo,0))) DeudasPagar,
		   isnull(@cxp,0) TotalPasivo,
		   (isnull(@capitalInicial,0)) CapitalInicial,
		   @UtilidaPerdida UtilidadPerdida, 
		   ISNULL(@capitalInicial + @UtilidaPerdida,0) CapitalFinal,
		   ISNULL(@UtilidaPerdida + @capitalInicial + @totalDeudasPagar, 0) TotalPasivoMasCapital

		   --select @capitalInicial, @UtilidaPerdida, @cxp, @cxpInicial
	

	select 'true' success, 'Balance general recuperado exitosamente' message, @EmpresaTransID EmpresaTransID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CatalogoActividadesGirosRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 05/04/2021
-- Description:	Procedimiento almacenado que recupera los sub-giros de la empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CatalogoActividadesGirosRecuperar] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select esg.ActividadID,
		   esg.SubGiroID,
		   esg.NombreActividad
	from MtoCat_EmpresaActividadesSubGiro esg with (nolock)
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CatalogoGirosRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 05/04/2021
-- Description:	Procedimiento almacenado que recupera las membresias activas de las cuentas
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CatalogoGirosRecuperar] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select g.GiroID,
		   g.NombreGiro
	from MtoCat_EmpresaGiros g with (nolock)
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CatalogoMembresiasRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 05/04/2021
-- Description:	Procedimiento almacenado que recupera las membresias activas de las cuentas
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CatalogoMembresiasRecuperar] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @membresias varchar(MAX) 

	set @membresias = (
							select distinct m.MembresiaID, 
								   m.PrecioMes,
								   m.PrecioAnual, 
								   m.NoUsuarios,
								   TipoMembresia.Descripcion,
								   TipoMembresia.EsSugerido,
								   Caracteristicas.Caracteristica
							from MtoCat_Membresias m with (nolock)
							join MtoCat_Estatus e with (nolock) on e.EstatusID = m.EstatusID
							join MtoTra_MembresiaCaracteristicas Caracteristicas with (nolock) on Caracteristicas.MembresiaID = m.MembresiaID
							join MtoCat_TipoMembresias TipoMembresia with (nolock) on TipoMembresia.TipoMembresiaID = m.TipoMembresiaID
							where e.EstatusID = 1
							for json auto
						)

	select convert(varchar(max), @membresias) Membresias
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CatalogoSubGirosRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 05/04/2021
-- Description:	Procedimiento almacenado que recupera los sub-giros de la empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CatalogoSubGirosRecuperar] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select sg.SubGiroID,
		   sg.GiroID,
		   sg.NombreSubGiro
	from MtoCat_EmpresaSubGiros sg with (nolock)
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CerrarSesion]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 07/07/2021
-- Description:	Procedimiento almacenado para cerrar la sesión en plataforma
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CerrarSesion]
	@Token varchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	delete from MtoTra_UsuariosToken
	where Token = @Token

	select 'true' success, 'Se elimino el token correctamente' message
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_ClasificacionesRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 20/04/2021
-- Description:	Procedimiento almacenado para recuperar las clasificaciones
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_ClasificacionesRecuperar] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select ClasificacionID,
		   Clasificacion
	from MtoCat_Clasificaciones

	select 'true' success, 'Clasificaciones recuperadas correctamente' message

	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CobranzaEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 19/08/2021
-- Description:	Procedimiento almacenado para recuperar las cuentas por cobrar
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CobranzaEmpresaRecuperar]--577255844,3
	@EmpresaTransID int,
	@TipoCuentaID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if @TipoCuentaID = 3
	begin
		select c.CxCID,
			   c.RegistroID,
			   r.FolioInterno Folio,
			   r.Descripcion,
			   c.Total,
			   c.Abono,
			   c.Saldo,
			   r.FechaRegistro,
			   concat(ABS(DATEDIFF(DAY, (convert(datetime, r.FechaRegistro, 103)), (select getdate()))), ' días') diasAtraso
		from MtoTra_Cobranza c with (nolock)
		join MtoCat_Cuentas ct with (nolock) on c.EmpresaTransID = ct.EmpresaTransID
		join MtoCat_RegistroDiario r with (nolock) on r.RegistroID = c.RegistroID
		where c.EmpresaTransID = @EmpresaTransID
		and ct.TipoCuentaID = 3
		and r.CuentaID = ct.CuentaID
		and r.EstatusID != 3
		and c.Saldo > 0
		order by c.RegistroID asc
	end

	else

	begin
		select c.CxCID,
			   c.RegistroID,
			   r.FolioInterno Folio,
			   r.Descripcion,
			   c.Total,
			   c.Abono,
			   c.Saldo,
			   r.FechaRegistro,
			   concat(ABS(DATEDIFF(DAY, (convert(datetime, r.FechaRegistro, 103)), (select getdate()))), ' días') diasAtraso
		from MtoTra_Cobranza c with (nolock)
		join MtoCat_Cuentas ct with (nolock) on c.EmpresaTransID = ct.EmpresaTransID
		join MtoCat_RegistroDiario r with (nolock) on r.RegistroID = c.RegistroID
		where c.EmpresaTransID = @EmpresaTransID
		and ct.TipoCuentaID = 4
		and r.CuentaID = ct.CuentaID
		and r.EstatusID != 3
		and c.Saldo > 0 
	end


	select 'true' success, 'Registro recuperado correctamente' message

	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CobranzaPorFechaEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 01/06/2023
-- Description:	Procedimiento almacenado para recuperar las cuentas por cobrar por fecha
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CobranzaPorFechaEmpresaRecuperar]--577255844,3
	@EmpresaTransID int,
	@TipoCuentaID int,
	@FechaInicio varchar(15),
	@FechaFin varchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if @TipoCuentaID = 3
	begin
		select c.CxCID,
			   c.RegistroID,
			   r.FolioInterno Folio,
			   r.Descripcion,
			   c.Total,
			   c.Abono,
			   c.Saldo,
			   r.FechaRegistro,
			   concat(ABS(DATEDIFF(DAY, (convert(datetime, r.FechaRegistro, 103)), (select getdate()))), ' días') diasAtraso
		from MtoTra_Cobranza c with (nolock)
		join MtoCat_Cuentas ct with (nolock) on c.EmpresaTransID = ct.EmpresaTransID
		join MtoCat_RegistroDiario r with (nolock) on r.RegistroID = c.RegistroID
		where c.EmpresaTransID = @EmpresaTransID
		and ct.TipoCuentaID = 3
		and r.CuentaID = ct.CuentaID
		and r.EstatusID != 3
		and c.Saldo > 0
		and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103)
		order by c.RegistroID asc
	end

	else

	begin
		select c.CxCID,
			   c.RegistroID,
			   r.FolioInterno Folio,
			   r.Descripcion,
			   c.Total,
			   c.Abono,
			   c.Saldo,
			   r.FechaRegistro,
			   concat(ABS(DATEDIFF(DAY, (convert(datetime, r.FechaRegistro, 103)), (select getdate()))), ' días') diasAtraso
		from MtoTra_Cobranza c with (nolock)
		join MtoCat_Cuentas ct with (nolock) on c.EmpresaTransID = ct.EmpresaTransID
		join MtoCat_RegistroDiario r with (nolock) on r.RegistroID = c.RegistroID
		where c.EmpresaTransID = @EmpresaTransID
		and ct.TipoCuentaID = 4
		and r.CuentaID = ct.CuentaID
		and r.EstatusID != 3
		and c.Saldo > 0 
		and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103)
	end


	select 'true' success, 'Registro recuperado correctamente' message

	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CobranzaSaldosInicialesRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 16/09/2021
-- Description:	Procedimiento almacenado para recuperar la cobranza de saldos iniciales de la empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CobranzaSaldosInicialesRecuperar]--'1299704628'
	@EmpresaTransID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @CxCInicial decimal(18,2) = 0
	declare @CxPInicial decimal(18,2) = 0
	declare @CxCSaldosIniciales decimal(18,2) = 0
	declare @CxPSaldosIniciales decimal(18,2) = 0

	set @CxCInicial = (
						select isnull(sum(c.Total),0) Total
						from MtoTra_Cobranza c with (nolock)
						where c.EmpresaTransID = @EmpresaTransID
						and c.EsCobranzaInicial = 1
						and c.EsCxC = 1
					  )

	    set @CxPInicial = (
						select isnull(sum(c.Total),0) Total
						from MtoTra_Cobranza c with (nolock)
						where c.EmpresaTransID = @EmpresaTransID
						and c.EsCobranzaInicial = 1
						and c.EsCxC = 0
					  )

	set @CxCSaldosIniciales = (
						select isnull(sum(s.DeudasCobrar),0) Total
						from MtoCat_SaldosInicialesEmpresa s with (nolock)
						where s.EmpresaTransID = @EmpresaTransID
					  )

	set @CxPSaldosIniciales = (
						select isnull(sum(s.DeudasPagar),0) Total
						from MtoCat_SaldosInicialesEmpresa s with (nolock)
						where s.EmpresaTransID = @EmpresaTransID
					  )

	
	select 'true' success, 'Cobranza de la empresa recuperada correctamente' message, (@CxCSaldosIniciales - @CxCInicial) cxcinicial, (@CxPSaldosIniciales - @CxPInicial) cxpinicial

	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_ConceptoRegistroDiarioAgregar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 09/08/2021
-- Description:	Procedimiento almacenado para agregar un concepto de egreso, compra, gasto
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_ConceptoRegistroDiarioAgregar] 
	@EmpresaTransID int,
	@TipoRegistroID int, 
	@Concepto varchar(300)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	insert into MtoTra_ConceptosRegistrosDiarios
	values
	(
		@EmpresaTransID,
		@TipoRegistroID,
		@Concepto
	)
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_ContrasenaUsuarioActualizar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 01/09/2021
-- Description:	Procedimiento almacenado para modificar la contraseña de un usuario
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_ContrasenaUsuarioActualizar] 
	@CorreoUsuario varchar(100),
	@Contrasena varchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		begin try
			begin transaction;
				update MtoCat_Usuarios
				set   Contrasena = @Contrasena
				where CorreoUsuario =@CorreoUsuario
						
			commit transaction;
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_ContrasenaUsuarioRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 27/08/2021
-- Description:	Procedimiento almacenado para recuperar el correo y generar contraseña temporal
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_ContrasenaUsuarioRecuperar]
	@CorreoUsuario varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if (
		    select COUNT(*)
			from MtoCat_Usuarios
			where CorreoUsuario = @CorreoUsuario
	   ) > 0
	begin
		
		declare @Contrasena int = (select ROUND(((9999999 - 1) * RAND()), 0))
		declare @legalNamePerson varchar(100) = (select NombreUsuario
			from MtoCat_Usuarios
			where CorreoUsuario = @CorreoUsuario)

		select 'true' success, 'Se ha enviado un correo electrónico con la información para la recuperación de la contraseña. Favor de ingresar y cambiar la contraseña temporal a una que sea fácil de recordar.' message, @Contrasena contrasenaTemporal, @legalNamePerson legalNamePerson
	
	end

	else
	begin
		select 'false' success, 'El correo especificado no esta registrado. Favor de verificar la información.' message
	end

	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CuentaBancoEmpresaAgregar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 13/07/2021
-- Description:	Procedimiento almacenado para agregar una cuenta a la empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CuentaBancoEmpresaAgregar] 
	@EmpresaTransID int,
	@TipoCuentaID int,
	@DescripcionCuenta varchar(500),
	@CorreoElectronico varchar(100),
	@EsActivo bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		begin try
			begin transaction;
				insert into MtoCat_Cuentas 
				values
				(
					@EmpresaTransID,
					@TipoCuentaID,
					@EsActivo,
					@DescripcionCuenta,		
					1,
					@CorreoElectronico,
					dbo.Func_GetDate(),
					@CorreoElectronico,
					dbo.Func_GetDate()
				)
						
				select 'true' success, 'Cuenta registrada correctamente' message

			commit transaction;
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CuentaBancoEmpresaEditar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 13/07/2021
-- Description:	Procedimiento almacenado para modificar una cuenta a la empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CuentaBancoEmpresaEditar] 
	@CuentaID int,
	@DescripcionCuenta varchar(500),
	@CorreoElectronico varchar(100),
	@TipoCuentaID int,
	@EsActivo bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		begin try
			begin transaction;
				update MtoCat_Cuentas
				set Descripcion = @DescripcionCuenta,
					EsActivo = @EsActivo,
					TipoCuentaID = @TipoCuentaID,
					ModificadoPor = @CorreoElectronico,
					ModifcadoEl = dbo.Func_GetDate()
				where CuentaID = @CuentaID
						
				select 'true' success, 'Cuenta modificada correctamente' message

			commit transaction;
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CuentaEmpresaEliminar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 13/07/2021
-- Description:	Procedimiento almacenado para eliminar una cuenta
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CuentaEmpresaEliminar] 
	@CuentaID int,
	@EmpresaTransID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		begin try
			begin transaction;

				declare @existeRegistros int = (select count(*) from MtoCat_RegistroDiario where EmpresaTransID = @EmpresaTransID and CuentaID = @CuentaID and EstatusID != 3)
				
				if(@existeRegistros = 0)
				begin
					delete from MtoCat_Cuentas
					where CuentaID = @CuentaID
						
					select 'true' success, 'Registro eliminado correctamente' message
				end

				else
				begin
					select 'false' success, 'No se puede eliminar la cuenta. Presenta movimientos.' message
				end
			commit transaction;
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CuentaEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 20/04/2021
-- Description:	Procedimiento almacenado para la cuenta en especifico de una empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CuentaEmpresaRecuperar] 
	@CuentaID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select 'true' success,
		   Descripcion,
		   EsActivo,
		   TipoCuentaID,
		   'Cuenta de la empresa recuperada correctamente' message
	from MtoCat_Cuentas
	where CuentaID = @CuentaID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CuentasBancoEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 20/04/2021
-- Description:	Procedimiento almacenado para recuperar las cuentas de la empresa de bancos
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CuentasBancoEmpresaRecuperar]--577255844
	@EmpresaTransID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--select CuentaID,
	--	EsActivo,
	--	Descripcion,
	--	EsCuentaEmpresa,
	--	TipoCuentaID
	--from MtoCat_Cuentas
	--where EmpresaTransID = @EmpresaTransID
	--	and TipoCuentaID = 2
	--order by TipoCuentaID asc

	select distinct c.CuentaID,
		c.EsActivo,
		c.Descripcion,
		c.EsCuentaEmpresa,
		c.TipoCuentaID,
		( isnull((SUM(r.Importe)),0) -  ( select isnull((SUM(Importe)),0) from MtoCat_RegistroDiario where EmpresaTransID = 577255844 and CuentaID = c.CuentaID and ClasificacionID in (2,3)  )   )  Saldo
	from MtoCat_Cuentas c
	join MtoCat_RegistroDiario r with (nolock) on r.EmpresaTransID = c.EmpresaTransID
	where c.EmpresaTransID = 577255844
	and r.CuentaID = c.CuentaID
	and c.TipoCuentaID = 2
	and r.ClasificacionID = 1
	group by c.CuentaID, c.EsActivo, c.Descripcion, c.EsCuentaEmpresa, c.TipoCuentaID
	order by c.TipoCuentaID asc

	
	select 'true' success, 'Cuentas de la empresa recuperadas correctamente' message, @EmpresaTransID EmpresaTransID

END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CuentasEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 20/04/2021
-- Description:	Procedimiento almacenado para recuperar las cuentas de la empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CuentasEmpresaRecuperar]
	@EmpresaTransID int,
	@MostrarInactivos bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if @MostrarInactivos = 1 
	begin	
		select CuentaID,
		   EsActivo,
		   Descripcion,
		   EsCuentaEmpresa,
		   TipoCuentaID
		from MtoCat_Cuentas
		where EmpresaTransID = @EmpresaTransID
		order by TipoCuentaID asc
	end

	else

	begin
		select CuentaID,
		   EsActivo,
		   Descripcion,
		   EsCuentaEmpresa,
		   TipoCuentaID
		from MtoCat_Cuentas
		where EmpresaTransID = @EmpresaTransID
		and EsActivo = 1
		order by TipoCuentaID asc
	end
	
	select 'true' success, 'Cuentas de la empresa recuperadas correctamente' message, @EmpresaTransID EmpresaTransID

END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CxCSaldoInicialEmpresaEditar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 25/09/2021
-- Description:	Procedimiento almacenado para modificar un cxc o cxp
--              en saldos iniciales
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CxCSaldoInicialEmpresaEditar]--113
	@RegistroID int,
	@Total decimal(18,2) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	update MtoTra_Cobranza
	set Total = @Total,
	    Saldo = @Total
	where RegistroID = @RegistroID

	update MtoCat_RegistroDiario 
	set Importe = @Total
	where RegistroID = @RegistroID

	select 'true' success, 'Registro modificado correctamente' message
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CxCSaldoInicialEmpresaEliminar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 25/09/2021
-- Description:	Procedimiento almacenado para eliminar un cxc o cxp
--              en saldos iniciales
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CxCSaldoInicialEmpresaEliminar]--113
	@RegistroID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	delete 
	from MtoTra_Cobranza 
	where RegistroID = @RegistroID

	update MtoCat_RegistroDiario
	set EstatusID = 3 
	where RegistroID = @RegistroID

	select 'true' success, 'Registro eliminado correctamente' message
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_CxCSaldoInicialEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 25/09/2021
-- Description:	Procedimiento almacenado para recuperar las cuentar por 
--              cobrar en saldos iniciales
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_CxCSaldoInicialEmpresaRecuperar]--2140358316, '01/01/2021','25/09/2021',11
	@EmpresaTransID int,
	@EsCxC bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select r.RegistroID,
	   r.FolioInterno Folio,
	   r.Descripcion,
	   c.Total, 
	   c.Abono,
	   c.Saldo
	from MtoTra_Cobranza c with (nolock)  
	join MtoCat_RegistroDiario r with (nolock) on c.RegistroID = r.RegistroID
	where c.EmpresaTransID = @EmpresaTransID
	and c.EsCobranzaInicial = 1
	and c.EsCxC = @EsCxC

	select 'true' success, 'Registros diarios recuperados correctamentes' message

	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_IniciarSesionRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 07/07/2021
-- Description:	Procedimiento almacenado para iniciar sesión en plataforma
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_IniciarSesionRecuperar]
	@CorreoUsuario varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @EmpresaTransID int
	declare @MensajeUsuario varchar(MAX) = 'Usuario correcto'

	if(	select COUNT(*) 
		from MtoCat_Usuarios u with (nolock)
		where CorreoUsuario = @CorreoUsuario) >= 1
	begin		

		if(	select u.EsActivo
			from MtoCat_Usuarios u with (nolock)
			where CorreoUsuario = @CorreoUsuario
		  ) = 1
		begin

			if(
				select count(*)
				from MtoCat_Empresas e
				join MtoCat_Usuarios u with (nolock) on e.EmpresaTransID = u.EmpresaTransID
				where u.CorreoUsuario = @CorreoUsuario
				and e.FechaVencimiento >= dbo.Func_GetDate()
			) = 0
			begin
		
				set @EmpresaTransID = (
										 select EmpresaTransID 
										 from MtoCat_Usuarios
										 where CorreoUsuario = @CorreoUsuario
									  )
		
				update MtoCat_Empresas
				set EsActivo = 0 
				where EmpresaTransID = @EmpresaTransID

				set @MensajeUsuario = 'Tu membresia ha vencido. Se han desactivado todas las funcionalidades. Favor de actualizar tu membresia en el menu perfil'

			end

			if (
				  select COUNT(CorreoUsuario)
				  from MtoCat_Usuarios 
				  where CorreoUsuario = @CorreoUsuario
				) = 1
			begin

				delete from MtoTra_UsuariosToken
				where UsuarioID = (select UsuarioID from MtoCat_Usuarios where CorreoUsuario = @CorreoUsuario)

				select 'true' success,
						@MensajeUsuario 'message',
						e.EmpresaTransID,
						e.CustomerConektaID,
						m.MembresiaID,
						u.UsuarioID,
						u.Contrasena,
						e.AnioOperacion,
						e.NombreEmpresa,
						u.NombreUsuario,
						e.EsActivo EmpresaActiva,
						(case 
							when e.MembresiaID > 2 then '1'
							else '0'
						 end) AltaDeUsuarios,
						 m.NoUsuarios
				from MtoCat_Empresas e with (nolock) 
				join MtoCat_Usuarios u with (nolock) on e.EmpresaTransID = u.EmpresaTransID
				join MtoCat_Membresias m with (nolock) on m.MembresiaID =e.MembresiaID 
				where u.CorreoUsuario = @CorreoUsuario 
			end

			else 

			begin
				select 'false' success, 'El correo del usuario no es válido. Favor de crear una cuenta' message
			end	
		end 

		else

		begin
			select 'false' success, 'Usuario con estatus no activo. Favor de crear una cuenta' message
		end
	end

	else

		begin
			select 'false' success, 'El correo del usuario no es válido. Favor de crear una cuenta' message
	end

END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_MembresiaEmpresaEditar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 12/04/2021
-- Description:	Procedimiento almacenado para actualizar la membresia del usuario
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_MembresiaEmpresaEditar] 
	@EmpresaTransID int, 
	@MembresiaID int,
	@Periodo varchar(10),
	@Pago decimal(18,2),
	@CorreoUsuario varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		begin try
				
			update MtoCat_Empresas
			set MembresiaID = @MembresiaID,
			    Periodo = @Periodo,
				EsActivo = 1
			where EmpresaTransID = @EmpresaTransID

			execute Usp_API_UsuarioMembresiaPagoAgregar @EmpresaTransID, @MembresiaID, @Pago, @Periodo, @CorreoUsuario

			select 'true' success, 'Pago generado correctamente. Gracias por su preferencia' message, @EmpresaTransID EmpresaTransID

		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
		end catch;
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_PagoCobranzaAgregar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 19/08/2021
-- Description:	Procedimiento almacenado agregar el pago de cobranza de una empresa con un
--              registro en especifico
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_PagoCobranzaAgregar]--9, 400, 'rjuarez@isysc.net', 3400.00,1
	@CxCID int,
	@Abono decimal(18,2),
	@CreadoPor varchar(50),
	@Total decimal(18,2),
	@TipoPagoCuentaID int,
	@RegistroID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		

		begin try
			begin transaction;
				
				declare @totalAbono decimal(18,2) = 0 
				select  @totalAbono = isnull(sum(Abono),0)
				from MtoTra_Pagos
				where CxCID = @CxCID

				set @totalAbono = @totalAbono + @Abono

				insert into MtoTra_Pagos
				values
				(
					@CxCID,
					@TipoPagoCuentaID,
					@RegistroID,
					@Abono,
					(@Total - @totalAbono),
					@CreadoPor,
					dbo.Func_GetDate()
				)

				update MtoTra_Cobranza
				set Abono = (Abono + @Abono),
					Saldo = (@Total - @totalAbono)
				where CxCID = @CxCID
				
				select 'true' success, 'Registro creado correctamente' message

			commit transaction;
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_PerfilUsuarioEditar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 07/07/2021
-- Description:	Procedimiento almacenado para editar la información de la cuenta de perfil
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_PerfilUsuarioEditar]
	@EmpresaTransID int,
	@RepresentanteLegal varchar(200),
	@NombreEmpresa varchar(200),
	@Contrasena varchar(100),
	@Telefono varchar(15),
	@GiroID int, 
	@SubGiroID int,
	@ActividadID int,
	@OtroGiroEmpresa varchar(100),
	@CorreoUsuario varchar(100),
	@OtraActividad varchar(100),
	@AnioOperacion varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	begin try
			begin transaction
				
				update MtoCat_Empresas
				set GiroID = @GiroID,
					SubGiroID = @SubGiroID,
					ActividadGiroID = @ActividadID,
					NombreEmpresa = @NombreEmpresa,
					Telefono = @Telefono,
					OtraActividad = @OtraActividad,
					AnioOperacion = @AnioOperacion,
					ModificadoPor = @CorreoUsuario,
					ModificadoEl = dbo.Func_GetDate()
				where EmpresaTransID = @EmpresaTransID

				update MtoCat_Usuarios 
				set NombreUsuario = @RepresentanteLegal,
					Contrasena = @Contrasena 
				where EmpresaTransID = @EmpresaTransID
				
				select 'true' success, 'Perfil de usuario modificado correctamente' message, @EmpresaTransID EmpresaTransID

			commit transaction
	end try

	begin catch
		select 'false' success, ERROR_MESSAGE() as message
		rollback transaction;
	end catch;
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_PerfilUsuarioRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 07/07/2021
-- Description:	Procedimiento almacenado que recupera la información del perfil de usuario
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_PerfilUsuarioRecuperar]
	@EmpresaTransID int,
	@UsuarioID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select u.NombreUsuario RepresentanteLegal,
		   u.CorreoUsuario,
		   u.Contrasena,
		   e.NombreEmpresa,
		   e.Telefono,
		   format(e.FechaActivacion, 'dd/MM/yyyy') FechaActivacion,
		   format(e.FechaVencimiento, 'dd/MM/yyyy') FechaVencimiento,
		   (case
				when e.Periodo = 'Me' then 'Mensual'
				else 'Anual'
		   end)  as PeriodoVigente,
		   (case
				when e.Periodo = 'Me' then m.PrecioMes
				else m.PrecioAnual
		   end)  as PrecioVigente,
		   eg.GiroID,
		   esg.SubGiroID,
		   asg.ActividadID,
		   oge.OtrosID,
		   m.MembresiaID,
		   e.AnioOperacion,
		   e.OtraActividad,
		   se.CapitalFinal
	from MtoCat_Usuarios u with (nolock) 
	join MtoCat_Empresas e with (nolock) on u.EmpresaTransID = e.EmpresaTransID
	join MtoCat_Membresias m with (nolock) on e.MembresiaID = m.MembresiaID
	left join MtoCat_EmpresaGiros eg with (nolock) on eg.GiroID = e.GiroID
	left join MtoCat_EmpresaSubGiros esg with (nolock) on esg.SubGiroID = e.SubGiroID
	left join MtoCat_EmpresaActividadesSubGiro asg with (nolock) on asg.ActividadID = e.ActividadGiroID
	left join MtoCat_OtrosGirosEmpresa oge with (nolock) on oge.EmpresaTransID = e.EmpresaTransID
	left join MtoCat_SaldosInicialesEmpresa se with (nolock) on se.EmpresaTransID = e.EmpresaTransID
	where u.EmpresaTransID = @EmpresaTransID
	and u.UsuarioID = @UsuarioID

	exec Usp_API_CatalogoMembresiasRecuperar
	exec Usp_API_CatalogoGirosRecuperar
	exec Usp_API_CatalogoSubGirosRecuperar
	exec Usp_API_CatalogoActividadesGirosRecuperar

	select 'true' success, 'Perfil de usuario obtenido correctamente' message, @EmpresaTransID EmpresaTransID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_PorcentajeAvanceEmpresa]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 13/07/2021
-- Description:	Procedimiento almacenado para recuperar el porcentaje de pefil del usuario
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_PorcentajeAvanceEmpresa]--252310765
	@EmpresaTransID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		begin try
			begin transaction;

			declare @existeRegistrosSubclasificaciones int = 0
			declare @existeRegistrosSaldoInicial int = 0 
			declare @existePerfilCompleto int = 0 
			declare @porcentajeAvance int = 100

			set @existeRegistrosSubclasificaciones = (
															select count(*) 
															from MtoTra_SubClasificaciones
															where EmpresaTransID = @EmpresaTransID
													  )

			
			set @existeRegistrosSaldoInicial = (
														select CapitalFinal
														from MtoCat_SaldosInicialesEmpresa
														where EmpresaTransID = @EmpresaTransID
			)

			set @existePerfilCompleto = (
														select (GiroID + SubGiroID + ActividadGiroID) 
														from MtoCat_Empresas
														where EmpresaTransID = @EmpresaTransID
			)

			if @existePerfilCompleto = 0
				set @porcentajeAvance = @porcentajeAvance - 25
			
			if @existeRegistrosSaldoInicial = 0
				set @porcentajeAvance = @porcentajeAvance - 25

			if @existeRegistrosSubclasificaciones = 0
				set @porcentajeAvance = @porcentajeAvance - 25

			
			if(@porcentajeAvance < 100)
				select 'false' success, 'Para una mayor experiencia, se recomienda completar al 100% tu perfil, considerando lo siguientes puntos: ' message, @porcentajeAvance PorcentajeAvance
			else 
				select 'true' success, 'Perfil completado correctamente' message, @porcentajeAvance PorcentajeAvance
			

			commit transaction;
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_RegistroDiarioAgregar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 12/04/2021
-- Description:	Procedimiento almacenado para agregar usuario inicial
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_RegistroDiarioAgregar] 
	@EmpresaTransID int,
	@Descripcion varchar(500),
	@FechaRegistro varchar(15),
	@Referencia nvarchar(100),
	@ClasificacionID int, 
	@SubClasificacionID int,
	@CuentaID int,
	@SubCuentaID int,
	@TipoPagoCuenta int,
	@EsCxC int,
	@Observaciones varchar(400), 
	@Importe decimal(18,2),
	@CreadoPor varchar(50),
	@EsCobranzaInicial bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		begin try
			begin transaction;
				declare @FolioInterno int
				set @FolioInterno = (	
										select count(*) 
										from MtoCat_RegistroDiario
										where EmpresaTransID = @EmpresaTransID
									) + 1

				insert into MtoCat_RegistroDiario 
				values
				(
					@EmpresaTransID,
					@ClasificacionID,
					@SubClasificacionID,
					@CuentaID,
					@SubCuentaID,
					1,
					@FolioInterno,
					@Descripcion,
					@Referencia,
					@FechaRegistro,
					@Observaciones,
					@Importe,
					dbo.Func_GetDate(),
					@CreadoPor
				)

				declare @folioID int = SCOPE_IDENTITY()
				declare @tipoCuentaID int 

				set @tipoCuentaID = (
							select TipoCuentaID
							from MtoCat_Cuentas 
							where CuentaID = @CuentaID
						)

                
				if(@tipoCuentaID = 3 or @tipoCuentaID = 4)
					if(@ClasificacionID != 4)
					begin
						insert into MtoTra_Cobranza
						values
						(
							@EmpresaTransID,
							@FolioID,
							@EsCobranzaInicial,
							@EsCxC,
							@Importe,
							0,
							@Importe
						)
					end

				--exec Usp_API_BalacenGeneralEmpresaEditar @EmpresaTransID, @CuentaID, @Importe, @folioID,  @TipoPagoCuenta, @ClasificacionID
				
				select 'true' success, 'Registro creado correctamente' message, @folioID FolioID

			commit transaction;
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_RegistroDiarioEditar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 13/07/2021
-- Description:	Procedimiento almacenado para editar la información del registro diario
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_RegistroDiarioEditar] 
	@FolioID int,
	@Descripcion varchar(500),
	@FechaRegistro varchar(15),
	@Referencia nvarchar(100),
	@ClasificacionID int, 
	@SubClasificacionID int,
	@CuentaID int, 
	@Observaciones varchar(400), 
	@Importe decimal(18,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		begin try
			begin transaction;
				update MtoCat_RegistroDiario 
				set ClasificacionID =  @ClasificacionID,
					SubClasificacionID = @SubClasificacionID,
					CuentaID = @CuentaID,
					Descripcion = @Descripcion,
					Referencia = @Referencia,
					FechaRegistro = @FechaRegistro,
					Observaciones = @Observaciones,
					Importe = @Importe,
					CreadoEl = dbo.Func_GetDate()
				where RegistroID = @FolioID

				declare @tipoCuenta int = 0 

				set @tipoCuenta = (
									select TipoCuentaID
									from MtoCat_Cuentas
									where CuentaID = @CuentaID 
									and EmpresaTransID = (
															select EmpresaTransID 
															from MtoCat_RegistroDiario 
															where RegistroID = @FolioID
														 )
								  )

				--cuenta por pagar o cobrar
				if @tipoCuenta = 3 or @tipoCuenta = 4
				begin
					
					update MtoTra_Cobranza
					set Total = @Importe,
						Saldo = @Importe - Abono
					where RegistroID = @FolioID

				end
						
				select 'true' success, 'Registro modificado correctamente' message

			commit transaction;
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_RegistroDiarioEliminar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 13/07/2021
-- Description:	Procedimiento almacenado para editar la información del registro diario
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_RegistroDiarioEliminar] 
	@FolioID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		begin try
			begin transaction;
				
				declare @ClasificacionID int = 0 
				declare @CxCID int = 0
				declare @Abono decimal(18,2) = 0.00
				declare @ExisteCobranza int = 0 
				
				update MtoCat_RegistroDiario 
				set EstatusID = 3, 
					CreadoEl = dbo.Func_GetDate()
				where RegistroID = @FolioID
						
				set @ClasificacionID = (select ClasificacionID from MtoCat_RegistroDiario where RegistroID = @FolioID)

				if (@ClasificacionID = 4) --es un registro pago
				begin
					select @CxCID = CxCID,
					       @Abono = Abono
					from MtoTra_Pagos
					where RegistroID = @FolioID

					update MtoTra_Cobranza
					set Abono = Abono - @Abono,
						Saldo = Saldo + @Abono
					where CxCID = @CxCID

					delete from MtoTra_Pagos
					where RegistroID = @FolioID
				end

				set @ExisteCobranza = (
										 select COUNT(*) 
										 from MtoTra_Cobranza
										 where RegistroID = @FolioID
									  )

				if @ExisteCobranza > 0
				begin
					delete from MtoTra_Cobranza where RegistroID = @FolioID
				end
							
				select 'true' success, 'Registro eliminado correctamente' message

			commit transaction;
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_RegistroDiarioEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 20/04/2021
-- Description:	Procedimiento almacenado para recuperar el registro diario de una empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_RegistroDiarioEmpresaRecuperar] 
	@FolioID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select Descripcion, 
		   FechaRegistro,
		   Referencia,
		   ClasificacionID,
		   SubClasificacionID,
		   CuentaID,
		   SubCuentaID,
		   Observaciones, 
		   Importe
	from MtoCat_RegistroDiario with (nolock)
	where RegistroID = @FolioID

	select 'true' success, 'Registro recuperado correctamente' message

	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_RegistrosDiarioEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 20/04/2021
-- Description:	Procedimiento almacenado para recuperar los registros diarios de las empresas
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_RegistrosDiarioEmpresaRecuperar]--761232029,'01/10/2021','31/10/2021',0
	@EmpresaTransID int,
	@FechaInicio varchar(15),
	@FechaFin varchar(15),
	@CuentaID int = 0 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if @CuentaID = 0 
	begin
		select distinct r.RegistroID FolioID,
			   r.FolioInterno Folio,
			   concat(c.Clasificacion, ' | ', sc.Concepto) Clasificacion,
			   c.ClasificacionID,
			   ct.CuentaID,
			   ct.Descripcion,
			   r.Descripcion DescripcionMovimiento,
			   r.FechaRegistro,
			   r.Referencia,
			   r.Observaciones,
			   r.Importe
		from MtoCat_RegistroDiario r with (nolock) 
		join MtoCat_Clasificaciones c with (nolock) on c.ClasificacionID = r.ClasificacionID
		join MtoCat_Cuentas ct with (nolock) on ct.CuentaID = r.CuentaID
		left join MtoTra_SubClasificaciones sc with (nolock) on sc.ConceptoID = r.SubClasificacionID
		--left join MtoTra_Cobranza cb with (nolock) on cb.EsCobranzaInicial = 0
		where r.EmpresaTransID = @EmpresaTransID 
		and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103)
		and sc.ClasificacionID = r.ClasificacionID
		and r.EstatusID != 3
		--and r.RegistroID = cb.RegistroID
		order by r.FechaRegistro asc, r.RegistroID asc
	end

	else
	begin
		select distinct r.RegistroID FolioID,
			   r.FolioInterno Folio,
			   concat(c.Clasificacion, ' | ', sc.Concepto) Clasificacion,
			   c.ClasificacionID,
			   ct.CuentaID,
			   ct.Descripcion,
			   r.Descripcion DescripcionMovimiento,
			   r.FechaRegistro,
			   r.Referencia,
			   r.Observaciones,
			   r.Importe
		from MtoCat_RegistroDiario r with (nolock) 
		join MtoCat_Clasificaciones c with (nolock) on c.ClasificacionID = r.ClasificacionID
		join MtoCat_Cuentas ct with (nolock) on ct.CuentaID = r.CuentaID
		left join MtoTra_SubClasificaciones sc with (nolock) on sc.ConceptoID = r.SubClasificacionID
		--left join MtoTra_Cobranza cb with (nolock) on cb.EsCobranzaInicial = 0
		where r.EmpresaTransID = @EmpresaTransID 
		and r.FechaRegistro between @FechaInicio and @FechaFin
		and sc.ClasificacionID = r.ClasificacionID
		and r.EstatusID != 3
		--and r.RegistroID = cb.RegistroID
		and r.CuentaID = @CuentaID
		order by r.FechaRegistro asc, r.RegistroID asc
	end

	select 'true' success, 'Registros diarios recuperados correctamentes' message

	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_RegistrosDiarioPorParametrosEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 15/07/2021
-- Description:	Procedimiento almacenado para recuperar los registros de la empresa por fecha
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_RegistrosDiarioPorParametrosEmpresaRecuperar]--599683687,0,0,'09/07/2021','29/09/2021'
	@EmpresaTransID int,
	@ClasificacionID int,
	@SubClasificacionID int,
	@FechaInicio varchar(15),
	@FechaFin varchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @totalIngreso decimal(18,2) = 0
	declare @totalCompra decimal(18,2) = 0
	declare @totalGasto decimal(18,2) = 0
	declare @totalMovimiento decimal(18,2) = 0 

	if @ClasificacionID <= 0
	begin
		select r.RegistroID FolioID,
			   r.FolioInterno Folio,
			   c.Clasificacion,
			   c.ClasificacionID,
			   r.SubClasificacionID,
			   ct.CuentaID,
			   ct.Descripcion,
			  concat(r.Descripcion, ' | ', sc.Concepto) DescripcionMovimiento,
			   r.FechaRegistro,
			   r.Referencia,
			   r.Observaciones,
			   r.Importe
			from MtoCat_RegistroDiario r with (nolock) 
			left join MtoCat_Clasificaciones c with (nolock) on c.ClasificacionID = r.ClasificacionID
			left join MtoCat_Cuentas ct with (nolock) on ct.CuentaID = r.CuentaID
			left join MtoTra_SubClasificaciones sc with (nolock) on r.SubClasificacionID = sc.ConceptoID
			--left join MtoTra_Cobranza cb with (nolock) on cb.EsCobranzaInicial = 0 
			where r.EmpresaTransID = @EmpresaTransID
			and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103)
			and r.ClasificacionID != 4
			and r.EstatusID  != 3
			order by r.RegistroID
			--and r.RegistroID = cb.RegistroID

		set @totalIngreso = ( select isnull(sum(r.Importe),0)
							  from MtoCat_RegistroDiario r with (nolock)
							  where r.EmpresaTransID = @EmpresaTransID
							  and r.ClasificacionID = 1
							  and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103)
							  and r.EstatusID  != 3
							)

		set @totalGasto = ( select isnull(sum(r.Importe),0)
							  from MtoCat_RegistroDiario r with (nolock)
							  where r.EmpresaTransID = @EmpresaTransID
							  and r.ClasificacionID = 2
							  and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103)
							  and r.EstatusID  != 3
							)

		set @totalCompra = ( select isnull(sum(r.Importe),0)
							  from MtoCat_RegistroDiario r with (nolock)
							  where r.EmpresaTransID = @EmpresaTransID
							  and r.ClasificacionID = 3
							 and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103) 
							  and r.EstatusID  != 3
							)
		select convert(decimal(18,2), isnull(@totalIngreso,0)) TotalIngreso, 
			   convert(decimal(18,2), isnull(@totalGasto,0)) TotalGasto, 
			   convert(decimal(18,2), isnull(@totalCompra,0)) TotalCompra,
			   (case 
				when @totalIngreso <= 0.00 then 0.00
				else convert(decimal(18,2), isnull((round((100 - ((@totalCompra * 100) / @totalIngreso)),2,0)),0))
				end) MargenUtilidadCosto,
			   (case 
			    when @totalIngreso <= 0.00 then 0.00
				else convert(decimal(18,2), isnull((round((100 - ((@totalCompra + @totalGasto) * 100) / @totalIngreso),2,0)),0))
				end) MargenUtilidadGasto,
			   convert(decimal(18,2), isnull((round((@totalIngreso - @totalCompra - @totalGasto),2,0)),0)) UtilidadNeta
	end

	else

	begin
		
		if @SubClasificacionID = 0 
		begin
			select r.RegistroID FolioID,
			   r.FolioInterno Folio,
			   c.Clasificacion,
			   c.ClasificacionID,
			   r.SubClasificacionID,
			   ct.CuentaID,
			   ct.Descripcion,
			  concat(r.Descripcion, ' | ', sc.Concepto) DescripcionMovimiento,
			   r.FechaRegistro,
			   r.Referencia,
			   r.Observaciones,
			   r.Importe
			from MtoCat_RegistroDiario r with (nolock) 
			left join MtoCat_Clasificaciones c with (nolock) on c.ClasificacionID = r.ClasificacionID
			left join MtoCat_Cuentas ct with (nolock) on ct.CuentaID = r.CuentaID
			left join MtoTra_SubClasificaciones sc with (nolock) on r.SubClasificacionID = sc.ConceptoID
			--left join MtoTra_Cobranza cb with (nolock) on cb.EsCobranzaInicial = 0 
			where r.EmpresaTransID = @EmpresaTransID
			and r.ClasificacionID = @ClasificacionID
			and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103)
			--and r.RegistroID = cb.RegistroID
			and r.EstatusID  != 3
			order by r.RegistroID
		end

		else
		begin
			select r.RegistroID FolioID,
			   r.FolioInterno Folio,
			   c.Clasificacion,
			   c.ClasificacionID,
			   r.SubClasificacionID,
			   ct.CuentaID,
			   ct.Descripcion,
			  concat(r.Descripcion, ' | ', sc.Concepto) DescripcionMovimiento,
			   r.FechaRegistro,
			   r.Referencia,
			   r.Observaciones,
			   r.Importe
			from MtoCat_RegistroDiario r with (nolock) 
			left join MtoCat_Clasificaciones c with (nolock) on c.ClasificacionID = r.ClasificacionID
			left join MtoCat_Cuentas ct with (nolock) on ct.CuentaID = r.CuentaID
			left join MtoTra_SubClasificaciones sc with (nolock) on r.SubClasificacionID = sc.ConceptoID
			--left join MtoTra_Cobranza cb with (nolock) on cb.EsCobranzaInicial = 0 
			where r.EmpresaTransID = @EmpresaTransID
			and r.ClasificacionID = @ClasificacionID
			and r.SubClasificacionID = @SubClasificacionID
			and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103)
			and r.EstatusID  != 3
			order by r.RegistroID
			--and r.RegistroID = cb.RegistroID
		end

		if @SubClasificacionID = 0
		begin
			set @totalMovimiento = ( select isnull(sum(r.Importe),0)
								  from MtoCat_RegistroDiario r with (nolock)
								  where r.EmpresaTransID = @EmpresaTransID
								  and r.ClasificacionID = @ClasificacionID
								  and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103)
								  and r.EstatusID  != 3
								)
		
		end

		else
		begin
			set @totalMovimiento = ( select isnull(sum(r.Importe),0)
								  from MtoCat_RegistroDiario r with (nolock)
								  where r.EmpresaTransID = @EmpresaTransID
								  and r.ClasificacionID = @ClasificacionID
								  and r.SubClasificacionID = @SubClasificacionID
								  and convert(datetime, r.FechaRegistro, 103) between convert(datetime, @FechaInicio, 103) and convert(datetime, @FechaFin,103)
								  and r.EstatusID  != 3
								)
		end

		select convert(decimal(18,2), isnull(@totalMovimiento,0)) TotalMovimiento

	end

	select 'true' success, 'Registros diarios recuperados correctamente' message

END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_ReportesMesEmpresaActualizar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 23/08/2021
-- Description:	Procedimiento almacenado para actualizar los numeros de reportes mensuales por mes
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_ReportesMesEmpresaActualizar]--519833785
	@EmpresaTransID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @NoReportes int
	declare @MesUltimaAsignacion int

	set @MesUltimaAsignacion = (
									select Mes
									from MtoTra_EmpresaReportesMensual
									where EmpresaTransID = @EmpresaTransID
							   )
	if(@MesUltimaAsignacion = (SELECT DATEPART(MONTH, GETDATE())))
	begin
		update MtoTra_EmpresaReportesMensual
		set NoReportesRestantes = (NoReportesRestantes - 1)
		where EmpresaTransID = @EmpresaTransID
	end

	else
		
	begin 
		update MtoTra_EmpresaReportesMensual
		set NoReportesRestantes = (
									select NoReportes 
									from MtoCat_Membresias m with (nolock) 
									join MtoCat_Empresas e with (nolock) on e.MembresiaID = m.MembresiaID
									where e.EmpresaTransID = @EmpresaTransID
								  ),
		Mes = (SELECT DATEPART(MONTH, GETDATE()))
		where EmpresaTransID = @EmpresaTransID
	end

	select 'true' success, 'Numero de reporte actualizado correctamente' message
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_ReportesMesEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 23/08/2021
-- Description:	Procedimiento almacenado para recuperar los numeros de reportes mensuales por mes
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_ReportesMesEmpresaRecuperar]--519833785
	@EmpresaTransID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if ( 
		select NoReportesRestantes NoReportes
		from MtoTra_EmpresaReportesMensual
		where EmpresaTransID = @EmpresaTransID
	    ) > 0
	begin
		select NoReportesRestantes NoReportes
		from MtoTra_EmpresaReportesMensual
		where EmpresaTransID = @EmpresaTransID

		select 'true' success, 'Número de reportes recuperados exitosamente' message
	end

	else
	
	begin
		select 0 NoReportes 
		
		select 'false' success, 'Se han agotado tus descargas para los reportes del mes' message
	end
	

	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_SaldoInicialEmpresaActualizar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 21/08/2021
-- Description:	Procedimiento almacenado que actualiza los saldos iniciales de una empresa. 
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_SaldoInicialEmpresaActualizar]
	@EmpresaTransID int,
	@Efectivo decimal (18,2),
	@Bancos decimal(18,2),
	@DeudasCobrar decimal(18,2),
	@ActivoFijo decimal(18,2),
	@DeudasPagar decimal(18,2),
	@CapitalInicial decimal(18,2),
	@CapitalFinal decimal(18,2),
	@CorreoUsuario varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    update MtoCat_SaldosInicialesEmpresa
	set Efectivo = @Efectivo,
		Bancos = @Bancos,
		DeudasCobrar = @DeudasCobrar,
		ActivoFijo = @ActivoFijo,
		DeudasPagar = @DeudasPagar,
		CapitalInicial = @CapitalInicial,
		CapitalFinal = @CapitalFinal,
		ModificadoPor = @CorreoUsuario,
		ModificadoEl = dbo.Func_GetDate()
	where EmpresaTransID = @EmpresaTransID

	if @CapitalFinal = 0 
	begin
		delete from MtoTra_Cobranza
		where EmpresaTransID = @EmpresaTransID
		and EsCobranzaInicial = 1
	end

	select 'true' success, 'Saldos iniciales actualizados correctamente' message, @EmpresaTransID EmpresaTransID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_SaldoInicialEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 21/08/2021
-- Description:	Procedimiento almacenado que recupera saldos iniciales de la empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_SaldoInicialEmpresaRecuperar]--519833785
	@EmpresaTransID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select Efectivo Efectivo,
		   Bancos,
		   DeudasCobrar,
		   ActivoFijo,
		   DeudasPagar,
		   CapitalInicial
	from MtoCat_SaldosInicialesEmpresa with (nolock)
	where EmpresaTransID = @EmpresaTransID

	select 'true' success, 'Saldos iniciales recuperados exitosamente' message, @EmpresaTransID EmpresaTransID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_SubClasificacionAgregar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 09/08/2021
-- Description:	Procedimiento almacenado para agregar un concepto de egreso, compra, gasto
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_SubClasificacionAgregar] 
	@EmpresaTransID int,
	@ClasificacionID int, 
	@Concepto varchar(300),
	@EsActivo bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	insert into MtoTra_SubClasificaciones
	values
	(
		@EmpresaTransID,
		@ClasificacionID,
		@EsActivo,
		@Concepto
	)

	select 'true' success, 'SubClasificacion agregada correctamente' message
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_SubClasificacionEditar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 09/08/2021
-- Description:	Procedimiento almacenado para agregar un concepto de egreso, compra, gasto
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_SubClasificacionEditar] 
	@ConceptoID int,
	@Concepto varchar(300),
	@ClasificacionID int,
	@EsActivo bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	update MtoTra_SubClasificaciones
	set Concepto = @Concepto,
		ClasificacionID = @ClasificacionID,
		EsActivo = @EsActivo 
	where ConceptoID = @ConceptoID
	
	select 'true' success, 'Subclasificacion modificada correctamente' message
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_SubclasificacionEmpresaEliminar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 13/07/2021
-- Description:	Procedimiento almacenado para eliminar una cuenta
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_SubclasificacionEmpresaEliminar] 
	@SubclasificacionID int,
	@EmpresaTransID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		begin try
			begin transaction;

				declare @existeRegistros int = (select count(*) from MtoCat_RegistroDiario where EmpresaTransID = @EmpresaTransID and SubClasificacionID = @SubclasificacionID and EstatusID in (1,2))
				
				if(@existeRegistros = 0)
				begin
					delete from MtoTra_SubClasificaciones
					where ConceptoID = @SubclasificacionID
						
					select 'true' success, 'Registro eliminado correctamente' message
				end

				else
				begin
					select 'false' success, 'No se puede eliminar la subclasificación. Presenta movimientos.' message
				end
			commit transaction;
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_SubClasificacionRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 09/08/2021
-- Description:	Procedimiento almacenado para agregar un concepto de egreso, compra, gasto
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_SubClasificacionRecuperar]--577255844,0
	@EmpresaTransID int,
	@MostrarInactivos bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if @MostrarInactivos = 1 
	begin
		select sb.ConceptoID,
			   sb.Concepto,
			   c.Clasificacion,
			   c.ClasificacionID, 
			   sb.EsActivo
		from MtoTra_SubClasificaciones sb with(nolock) 
		join MtoCat_Clasificaciones c with(nolock) on sb.ClasificacionID = c.ClasificacionID
		where sb.EmpresaTransID = @EmpresaTransID
	end
	else
	begin
		select sb.ConceptoID,
			   sb.Concepto,
			   c.Clasificacion,
			   c.ClasificacionID, 
			   sb.EsActivo
		from MtoTra_SubClasificaciones sb with(nolock) 
		join MtoCat_Clasificaciones c with(nolock) on sb.ClasificacionID = c.ClasificacionID
		where sb.EmpresaTransID = @EmpresaTransID
		and sb.EsActivo = 1
		order by c.ClasificacionID asc, sb.Concepto asc
	end

	select 'true' success, 'SubClasificaciones recuperadas correctamente' message
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_TipoCuentaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 21/08/2021
-- Description:	Procedimiento almacenado para recuperar el tipo de cuenta
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_TipoCuentaRecuperar] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select TipoCuentaID,
		   Descripcion
	from MtoCat_TipoCuentas with (nolock)
	where TipoCuentaID in (1,2)

	select 'true' success, 'Tipos de cuenta recuperadas correctamente' message

	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_UsuarioEmpresaAgregar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 12/04/2021
-- Description:	Procedimiento almacenado para agregar usuario inicial
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_UsuarioEmpresaAgregar] 
	@NombreUsuario varchar(200),
	@CorreoUsuario varchar(200),
	@Contrasena varchar(200),
	@EmpresaTransID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	insert into MtoCat_Usuarios 
	values 
	(
		@EmpresaTransID,
		1,
		@NombreUsuario,
		@CorreoUsuario,
		@Contrasena,
		@CorreoUsuario,
		dbo.Func_GetDate()
	)
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_UsuarioEmpresaDisponibleAgregar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 12/04/2021
-- Description:	Procedimiento almacenado para agregar usuario inicial
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_UsuarioEmpresaDisponibleAgregar] 
	@EmpresaTransID int,
	@NombreUsuario varchar(200),
	@CorreoUsuario varchar(200),
	@Contrasena varchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @ExisteUsuario int

	set @ExisteUsuario = ( 
							select COUNT(CorreoUsuario) 
							from MtoCat_Usuarios with (nolock) 
							where CorreoUsuario = @CorreoUsuario
						 )

	if @ExisteUsuario = 0
	begin
		begin try
			begin transaction; 
				insert into MtoCat_Usuarios 
				values 
				(
					@EmpresaTransID,
					1,
					@NombreUsuario,
					@CorreoUsuario,
					@Contrasena,
					@CorreoUsuario,
					dbo.Func_GetDate()
				)

			commit transaction;

			select 'true' success, 'Usuario agregado correctamente' message
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch;

	end

	else
	
	begin
		select 'false' success, 'El correo que intenta registrar, ya existe. Favor de verificar la información' message
	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_UsuarioEmpresaDisponibleEditar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 12/04/2021
-- Description:	Procedimiento almacenado para editar usuario
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_UsuarioEmpresaDisponibleEditar] 
	@UsuarioID int,
	@NombreUsuario varchar(200),
	@Contrasena varchar(200),
	@EsActivo bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
		begin try
			begin transaction; 
				update MtoCat_Usuarios 
				set NombreUsuario = @NombreUsuario,
					Contrasena = @Contrasena,
					EsActivo = @EsActivo
				where UsuarioID = @UsuarioID

			commit transaction;

			select 'true' success, 'Usuario modificado correctamente' message
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch;
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_UsuarioEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 15/07/2021
-- Description:	Procedimiento almacenado para recueprar la info de un usuario de una empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_UsuarioEmpresaRecuperar]
	@UsuarioID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select u.UsuarioID,
		   u.NombreUsuario,
		   u.Contrasena,
		   u.CorreoUsuario,
		   u.EsActivo
	from MtoCat_Usuarios u
	where u.UsuarioID = @UsuarioID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_UsuarioMembresiaPagoAgregar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 14/04/2021
-- Description:	Procedimiento almacenado para crear, activar y registrar el pago de la
--              membresia
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_UsuarioMembresiaPagoAgregar]
	@EmpresaTransID int,
	@MembresiaID int,
	@Pago decimal(18,2),
	@NoCuenta varchar(5),
	@CorreoUsuario varchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @TransaccionID int = 0
	declare @FechaVencimientoMembresia varchar(40)
	declare @TipoPlan varchar(40)
	declare @FechaActivacion varchar(40)
	declare @diasVencimiento int
	declare @NombreUsuario varchar(100)

    begin try
		begin transaction;

			set @TransaccionID = (select abs(checksum(newid())))

			insert into MtoTra_PagoMembresias
			values
			(
				@TransaccionID,
				@EmpresaTransID,
				@MembresiaID,
				@Pago,
				@NoCuenta,
				@CorreoUsuario,
				dbo.Func_GetDate()
			)
			
			if (@NoCuenta = 'Me' or @NoCuenta = 'FREE')
			begin
				set @diasVencimiento = 30
			end
			else
			begin
				set @diasVencimiento = 365
			end
			
			set @TipoPlan = (
								select tm.Descripcion 
								from MtoCat_Membresias m with(nolock) 
								left join MtoCat_TipoMembresias tm with(nolock) on m.TipoMembresiaID = tm.TipoMembresiaID
								left join MtoCat_Empresas e with(nolock) on e.MembresiaID = m.MembresiaID
								where  e.EmpresaTransID = @EmpresaTransID
							)

			set @NombreUsuario = (
								select e.NombreEmpresa 
								from MtoCat_Membresias m with(nolock) 
								left join MtoCat_TipoMembresias tm with(nolock) on m.TipoMembresiaID = tm.TipoMembresiaID
								left join MtoCat_Empresas e with(nolock) on e.MembresiaID = m.MembresiaID
								where  e.EmpresaTransID = @EmpresaTransID
							)

			set @FechaActivacion = (select FORMAT(dbo.Func_GetDate(), 'dd/MM/yyyy'))

			update MtoCat_Empresas
			set FechaVencimiento = (select DATEADD(day, @diasVencimiento, dbo.Func_GetDate()))
			where EmpresaTransID = @EmpresaTransID

			declare @NoReportesCuenta int = 0 

			set @NoReportesCuenta = (select NoReportes from MtoCat_Membresias where MembresiaID = @MembresiaID) 
			
			update MtoTra_EmpresaReportesMensual
			set NoReportesRestantes = @NoReportesCuenta
			where EmpresaTransID = @EmpresaTransID

			set @FechaVencimientoMembresia = (select FORMAT((DATEADD(day, @diasVencimiento, dbo.Func_GetDate())), 'dd/MM/yyyy'))

			select 'true' success, 'Pago registrado correctamente...' message, @NombreUsuario NombreUsuario, @FechaVencimientoMembresia fechaVencimiento, @TipoPlan tipoPlan, @FechaActivacion fechaActivacion

		commit transaction;
	end try

	begin catch
		select 'false' success, ERROR_MESSAGE() as message
		rollback transaction;
	end catch;
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_UsuarioRegistroAgregar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 12/04/2021
-- Description:	Procedimiento almacenado para agregar usuario inicial
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_UsuarioRegistroAgregar] 
	@NombreUsuario varchar(200),
	@CorreoUsuario varchar(200),
	@Contrasena varchar(200), 
	@NombreEmpresa varchar(1000),
	@MembresiaID int,
	@Periodo varchar(2),
	@Telefono varchar(15),
	@AnioOperacion varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @ExisteUsuario bit
	declare @EsMembresiaGratuita bit
	declare @EmpresaID int
	declare @EmpresaTransID int = 0

	set @ExisteUsuario = ( 
							select COUNT(CorreoUsuario) 
						    from MtoCat_Usuarios with (nolock) 
						    where CorreoUsuario = @CorreoUsuario
						 )

	if @ExisteUsuario = 0
	begin
		begin try
			begin transaction;
				
				set @EmpresaTransID = (select abs(checksum(newid())))

				insert into MtoCat_Empresas 
				values
				(	
					@EmpresaTransID,
					@MembresiaID,
					0,
					0,
					0,
					'',
					'',
					1,
					@Periodo,
					@NombreEmpresa,
					@Telefono,
					dbo.Func_GetDate(),
					null,
					@AnioOperacion,
					@CorreoUsuario,
					dbo.Func_GetDate(),
					@CorreoUsuario,
					dbo.Func_GetDate()
				)

				-- descripciones de cuentas iniciales para la empresa 
				-- cuando se registra desde el portal
				insert into MtoCat_Cuentas 
				values
				(
					@EmpresaTransID,
					1,
					1,
					'Efectivo',		
					0,
					'Sistema',
					dbo.Func_GetDate(),
					'Sistema',
					dbo.Func_GetDate()
				)

				insert into MtoCat_Cuentas 
				values
				(
					@EmpresaTransID,
					2,
					1,
					'Banco 1',		
					0,
					'Sistema',
					dbo.Func_GetDate(),
					'Sistema',
					dbo.Func_GetDate()
				)

				insert into MtoCat_Cuentas 
				values
				(
					@EmpresaTransID,
					3,
					1,
					'Deudas por cobrar',		
					0,
					'Sistema',
					dbo.Func_GetDate(),
					'Sistema',
					dbo.Func_GetDate()
				)

				insert into MtoCat_Cuentas 
				values
				(
					@EmpresaTransID,
					4,
					1,
					'Deudas por pagar',		
					0,
					'Sistema',
					dbo.Func_GetDate(),
					'Sistema',
					dbo.Func_GetDate()
				)
				--------------------


				----Agregar saldos iniciales en 0
				insert into MtoCat_SaldosInicialesEmpresa
				values
				(
					@EmpresaTransID,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					'Sistema',
					dbo.Func_GetDate(),
					'Sistema',
					dbo.Func_GetDate()
				)

				----Agregar saldos iniciales en balance general
				insert into MtoCat_BalanceGeneralEmpresa
				values
				(
					@EmpresaTransID,
					0,
					0,
					0,
					0,
					0,
					0,
					'Sistema',
					dbo.Func_GetDate(),
					'Sistema',
					dbo.Func_GetDate()
				)

				execute Usp_API_UsuarioEmpresaAgregar @NombreUsuario, @CorreoUsuario, @Contrasena, @EmpresaTransID
				
				declare @NoReportes int = 0

				set @NoReportes = (select NoReportes 
									from MtoCat_Membresias m with (nolock) 
									join MtoCat_Empresas e with (nolock) on e.MembresiaID = m.MembresiaID
									where e.EmpresaTransID = @EmpresaTransID)

				--- agregar contador para reportes del mes 
				insert into MtoTra_EmpresaReportesMensual
				values
				(
					@EmpresaTransID,
					@NoReportes,
					(SELECT DATEPART(MONTH, GETDATE()))
				)

				select 'true' success,
					'Gracias por tu registro. Se ha creado satisfactoriamente tu cuenta en Black Administrativo' message,
					@EmpresaTransID empresaTransID,
					m.MembresiaID,
					u.UsuarioID,
					u.Contrasena,
					e.NombreEmpresa,
					u.NombreUsuario,
					e.EsActivo EmpresaActiva,
					(case 
						when e.MembresiaID > 2 then '1'
						else '0'
					 end) AltaDeUsuarios,
					 m.NoUsuarios
			from MtoCat_Empresas e with (nolock) 
			join MtoCat_Usuarios u with (nolock) on e.EmpresaTransID = u.EmpresaTransID
			join MtoCat_Membresias m with (nolock) on m.MembresiaID =e.MembresiaID 
			where u.EmpresaTransID = @EmpresaTransID 

			commit transaction;
		end try

		begin catch
			select 'false' success, ERROR_MESSAGE() as message
			rollback transaction;
		end catch;
	end

	else
	begin
		select 'false' success, 'El correo que intenta registrar, ya existe. Favor de verificar la información' message
	end
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_UsuariosEmpresaRecuperar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 15/07/2021
-- Description:	Procedimiento almacenado para recueprar los usuario de la empresa
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_UsuariosEmpresaRecuperar]
	@EmpresaTransID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select u.UsuarioID,
		   u.NombreUsuario,
		   u.CorreoUsuario,
		   u.EsActivo,
		   convert(varchar(20), u.CreadoEl, 103) FechaRegistro,
		   CONCAT('Tu membresia solo te permite registrar ', m.NoUsuarios, ' usuario a tu cuenta') UsuariosDisponibleMensaje,
		   (
				select (m.NoUsuarios - count(*)) 
				from MtoCat_Usuarios where EmpresaTransID = @EmpresaTransID
		   ) UsuariosDisponibles
	from MtoCat_Usuarios u with (nolock)
	join MtoCat_Empresas e with (nolock) on u.EmpresaTransID = e.EmpresaTransID
	join MtoCat_Membresias m with (nolock) on m.MembresiaID = e.MembresiaID
	where u.EmpresaTransID = @EmpresaTransID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_UsuarioTokenAgregar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Raúl Juárez Parra
-- Create date: 08/07/2021
-- Description:	Procedimiento almacenado para almacenar el token del usuario logeado
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_UsuarioTokenAgregar]
	@Token nvarchar(MAX),
	@CorreoUsuario varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @UsuarioID int 

	begin try
		begin transaction;

			set @UsuarioID = (
								select UsuarioID 
								from MtoCat_Usuarios
								where CorreoUsuario = @CorreoUsuario
								)
	
			insert into MtoTra_UsuariosToken 
			values (
				@UsuarioID,
				@Token,
				dbo.Func_GetDate()
			)

		select 'true' success, 'Token de usuario agregado correctamente'

		commit transaction;
	end try

	begin catch
		select 'false' success, ERROR_MESSAGE() as message
		rollback transaction;
	end catch;
		
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_API_ValidarUsuarioRegistroAgregar]    Script Date: 25/07/2025 02:30:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ing. Juan Eduardo Marquez
-- Create date: 17/05/2022
-- Description:	Procedimiento almacenado para validar un usuario previamente registrado
-- =============================================
CREATE PROCEDURE [dbo].[Usp_API_ValidarUsuarioRegistroAgregar] 
	@CorreoUsuario varchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @ExisteUsuario bit

	set @ExisteUsuario = ( 
							select COUNT(CorreoUsuario) 
						    from MtoCat_Usuarios with (nolock) 
						    where CorreoUsuario = @CorreoUsuario
						 )

	if @ExisteUsuario = 0
		select 'true' success, '' message
	else
		select 'false' success, 'El correo que intenta registrar, ya existe. Favor de verificar la información' message
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nos indica si la descripción de la cuenta fue alterada por la empresa para saber si los datos son encriptados' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MtoCat_Cuentas', @level2type=N'COLUMN',@level2name=N'EsCuentaEmpresa'
GO
