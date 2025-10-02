# Definir nome da VM e diret�rio de backup
$vmName = "nome_da_sua_vm"
$backupDir = "C:\Caminho\Para\Diretorio\De\Backup"

# Verifica se o diret�rio de backup existe, se n�o, cria
if (!(Test-Path -Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

# Apagar todos os arquivos no diret�rio de backup, mantendo o diret�rio
Write-Host "[INFO] Apagando arquivos antigos no diret�rio de backup..."
Get-ChildItem -Path $backupDir | ForEach-Object { Remove-Item $_.FullName -Force }

# Desligar a VM antes de exportar
Write-Host "[INFO] Desligando a VM '$vmName'..."
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm "$vmName" poweroff

# Esperar um momento para garantir que a VM foi desligada corretamente
Start-Sleep -Seconds 5

# Caminho do arquivo de exporta��o do appliance
$exportFile = "$backupDir\$vmName-$(Get-Date -Format 'yyyyMMdd_HHmmss').ova"

# Exportar a VM para um arquivo OVA (appliance)
Write-Host "[INFO] Exportando a VM '$vmName' para o arquivo OVA..."
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" export "$vmName" --output "$exportFile"

Write-Host "[INFO] A exporta��o foi conclu�da com sucesso!"
Write-Host "[INFO] O arquivo OVA foi salvo em: $exportFile"

# Ligar a VM novamente ap�s a exporta��o
Write-Host "[INFO] Ligando a VM '$vmName' novamente..."
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm "$vmName" --type headless

Write-Host "[INFO] A VM '$vmName' foi ligada novamente!"
