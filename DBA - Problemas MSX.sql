--Executar no Servidor <em>Target</em></code>
 
USE MSDB
 
GO
 
 
-- No TSX, seleciona todos os jobs que são do MSX. Salve a definição.
 
SELECT 'EXEC msdb.dbo.sp_add_jobserver @job_name=N"' + name +'", @server_name = N"ServerName"'
FROM msdb.dbo.sysjobs
WHERE originating_server_id = 1
ORDER BY name

--  No MSX, deleta o target problemático

USE MSDB
BEGIN TRAN
DELETE FROM dbo.systargetservers 
WHERE server_name = 'SQLH108'

-- Adiciona manualmente o servidor como TSX (Make this a Target)

/***********************
No caso do erro: https://msdn.microsoft.com/en-us/ms365379.aspx
The enlist operation Filed 
(reason: SQLServerAgent Error: 
The target server cannot establish an encrypted connection to the master server 
‘Server Name


************************/