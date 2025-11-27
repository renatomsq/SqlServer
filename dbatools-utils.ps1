# Configura certification trust

Set-DbatoolsConfig -FullName sql.connection.trustcert -Value $true -Register
Set-DbatoolsConfig -FullName sql.connection.encrypt -Value $false -Register 

# Mover arquivos
$fileToMove=@{
'BD_TESTE_DATAFILE1'='D:\Data 1'
'BD_TESTE_DATAFILE2'='D:\Data 2'
}
Move-DbaDbFile -SqlInstance "srv-sua-instancia" -Database BD_TESTE -FileToMove $fileToMove -DeleteAfterMove
