select * from sys.database_files

--habilitar FILESTREAM

-- EXECUTAR SCRIPT
EXEC sp_configure filestream_access_level, 2
RECONFIGURE

-- CRIAR DATABASE FILESTREAM
USE [BANCO_PRINCIPAL]
GO
ALTER DATABASE [BANCO_PRINCIPAL] ADD FILEGROUP [PRIMARY_FILESTREAM] CONTAINS FILESTREAM 
GO
ALTER DATABASE [BANCO_PRINCIPAL]
       ADD FILE (
             NAME = N'BANCO_PRINCIPAL_FILES',
             FILENAME = N'CAMINHO_BANCO_PRINCIPAL'
       )
       TO FILEGROUP [PRIMARY_FILESTREAM]
GO

-- CRIAR TABELA
CREATE TABLE [dbo].[VersaoPacote](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[produto] [varchar](30) NOT NULL,
	[versao] [varchar](20) NOT NULL,
	[pacote] [varbinary](max) FILESTREAM  NULL,
	[status] [char](1) NOT NULL,
UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] FILESTREAM_ON [FILESTREAM]
GO

