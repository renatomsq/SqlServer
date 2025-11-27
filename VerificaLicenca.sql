CREATE or ALTER procedure sp_licenca  
as  
begin  
exec sp_configure 'show advanced options', 1;  
RECONFIGURE  
  
exec sp_configure 'Agent XPs', 1;  
RECONFIGURE  
   
  
DECLARE @RemainingTime INT  
DECLARE @InstanceName SYSNAME  
SELECT @InstanceName = CONVERT(SYSNAME, SERVERPROPERTY('InstanceName'))  
EXEC @RemainingTime = xp_qv '2715127595', @InstanceName  
SELECT @RemainingTime 'Remaining evaluation days:',   
dateadd(day,@RemainingTime,getdate()) as DataExpiracao  
   
end
