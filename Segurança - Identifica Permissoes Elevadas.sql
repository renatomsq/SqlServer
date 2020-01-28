/* 
	Script: Identifica permissões elevadas no SQL Server 
	Autor: Renato Siqueira
	Fonte: https://renatomsiqueira.com.br/2015/09/21/identificando-logins-com-permissoes-elevadas-no-sql-server/
*/


SELECT DISTINCT Suser_name(member_principal_id)      AS [Login], 
                Upper(Suser_name(role_principal_id)) AS [Permissão], 
                Getdate()                            AS [Data Coleta] 
FROM   sys.server_role_members rm 
       INNER JOIN sys.server_principals p 
               ON p.principal_id = rm.member_principal_id 
       LEFT JOIN sys.server_permissions per 
              ON per.grantee_principal_id = rm.member_principal_id 
WHERE  Suser_name(role_principal_id) IN ( 'SYSADMIN', 'SECURITYADMIN' ) 
       AND Suser_name(member_principal_id) NOT LIKE '%SERVICE\%' 
       AND P.is_disabled = 0 

UNION ALL 

SELECT NAME             AS [Login], 
       'CONTROL SERVER' AS [Permissão], 
       Getdate()        AS [Data Coleta] 
FROM   sys.server_principals p 
       INNER JOIN sys.server_permissions per 
               ON per.grantee_principal_id = p.principal_id 
WHERE  PER.permission_name = 'CONTROL SERVER ' 
       AND P.is_disabled = 0 
 
