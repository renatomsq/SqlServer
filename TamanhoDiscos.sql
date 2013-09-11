/* 
	Objetivo: Retorna informações sobre espaço em disco.
	Referência: http://technet.microsoft.com/pt-br/library/hh223223.aspx?sentenceGuid=93c89b87-7b2f-580d-6782-762f5b5e88ed#mt1

	Dependências: sys.dm_os_volume_stats - Disponível apenas no SQL Server 2008 R2 e superiores
	Execute preferencialmente em um Central Management Server pra capturar de uma vez o espaço de várias instâncias. 

*/

SELECT  DISTINCT  
      M.volume_mount_point  [Montagem]
     ,M.logical_volume_name  AS [Volume] 
     ,CAST(CAST(M.total_bytes AS DECIMAL(19,2))/1024 /1024 /1024 AS DECIMAL (10,2)) AS [Total (GB)]  
     ,CAST(CAST(M.available_bytes AS DECIMAL(19,2))/1024 /1024 /1024 AS DECIMAL (10,2)) AS [Espaço Disponível (GB)]  
     ,CAST((CAST(M.available_bytes AS DECIMAL(19,2)) / CAST(M.total_bytes AS DECIMAL(19,2)) * 100 ) AS DECIMAL(10,2))  AS [Espaço Disponível ( % )]
     ,CAST((100 - CAST(M.available_bytes AS DECIMAL(19,2)) / CAST(M.total_bytes AS DECIMAL(19,2)) * 100) AS DECIMAL (10,2))  AS [Espaço em uso ( % )]
   FROM sys.master_files AS A    
   CROSS APPLY [sys].[dm_os_volume_stats](A.database_id,A.FILE_ID) AS M  
   WHERE CAST(M.available_bytes AS DECIMAL(19,2)) / CAST(M.total_bytes AS DECIMAL(19,2)) * 100 < 100  
