# Informa��es do banco de dados
$Database = "nome_do_banco"
$User = "usuario_do_banco"
$Password = "senha_do_banco"
$DbHost = "db_host"  

# Gerar o nome do arquivo de backup com data e hora
$CurrentDateTime = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$OutputPath = "C:\\Direotorio_onde\\o_backup\\sera_salvo\\backup_$CurrentDateTime.sql"

# Comando mysqldump e Single Transaction
$DumpCommand = "mysqldump --single-transaction --host=$DbHost --user=$User --password=$Password $Database > `"$OutputPath`""

# Executar o comando
Write-Host "Iniciando o backup do banco de dados..."
$StartTime = Get-Date
$Process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c $DumpCommand" -NoNewWindow -Wait -PassThru
$EndTime = Get-Date

# Verificar se o backup foi conclu�do
if ($Process.ExitCode -eq 0) {
    Write-Host "Backup conclu�do com sucesso!"
    Write-Host "Tempo total: $((New-TimeSpan -Start $StartTime -End $EndTime).TotalSeconds) segundos"
} else {
    Write-Host "Erro ao realizar o backup. C�digo de sa�da: $($Process.ExitCode)"
}
