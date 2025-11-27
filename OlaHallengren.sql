/* Faz backup full */
EXECUTE master.[dbo].[DatabaseBackup]
@Databases = 'BD_TESTE',
@Directory = 'C:\Backup',
@BackupType = 'FULL',
@LogToTable = 'Y',
@Compress = 'Y'

/* Atualização de estatísticas */ 
EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES,-BD_EXCLUSAO' ,  
@FragmentationLow = NULL ,  
@FragmentationMedium = NULL ,    
@FragmentationHigh = NULL , 
@UpdateStatistics = 'ALL' ,
@OnlyModifiedStatistics = 'Y',   
@LogToTable = 'Y'
