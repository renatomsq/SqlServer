/* 
	Objetivo: Retorna informa��es sobre espa�o em disco.
	Refer�ncia: http://technet.microsoft.com/pt-br/library/hh223223.aspx?sentenceGuid=93c89b87-7b2f-580d-6782-762f5b5e88ed#mt1

	Depend�ncias: sys.dm_os_volume_stats - Dispon�vel apenas no SQL Server 2008 R2 e superiores
	Execute preferencialmente em um Central Management Server pra capturar de uma vez o espa�o de v�rias inst�ncias. 

*/

SELECT  DISTINCT  
      M.volume_mount_point  [Montagem]
     ,M.logical_volume_name  AS [Volume] 
     ,CAST(CAST(M.total_bytes AS DECIMAL(19,2))/1024 /1024 /1024 AS DECIMAL (10,2)) AS [Total (GB)]  
     ,CAST(CAST(M.available_bytes AS DECIMAL(19,2))/1024 /1024 /1024 AS DECIMAL (10,2)) AS [Espa�o Dispon�vel (GB)]  
     ,CAST((CAST(M.available_bytes AS DECIMAL(19,2)) / CAST(M.total_bytes AS DECIMAL(19,2)) * 100 ) AS DECIMAL(10,2))  AS [Espa�o Dispon�vel ( % )]
     ,CAST((100 - CAST(M.available_bytes AS DECIMAL(19,2)) / CAST(M.total_bytes AS DECIMAL(19,2)) * 100) AS DECIMAL (10,2))  AS [Espa�o em uso ( % )]
   FROM sys.master_files AS A    
   CROSS APPLY [sys].[dm_os_volume_stats](A.database_id,A.FILE_ID) AS M  
   WHERE CAST(M.available_bytes AS DECIMAL(19,2)) / CAST(M.total_bytes AS DECIMAL(19,2)) * 100 < 100  
