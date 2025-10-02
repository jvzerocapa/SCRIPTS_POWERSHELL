# Caminhos
$fonte = "caminho\para\diretorio\de\backup"
$destino = "caminho\para\diretorio\de\destino"
$dataAtual = Get-Date -Format "yyyy-MM-dd"
$nomeArquivo = "BKP_$dataAtual.rar"
$caminhoArquivo = Join-Path -Path $destino -ChildPath $nomeArquivo

# Caminho do execut�vel do WinRAR (ajuste se necess�rio)
$winrar = "C:\Program Files\WinRAR\rar.exe"

# Verifica se o WinRAR est� instalado
if (-Not (Test-Path $winrar)) {
    Write-Error "WinRAR n�o encontrado em '$winrar'. Verifique o caminho."
    exit 1
}

# Cria a pasta de destino se n�o existir
if (-Not (Test-Path $destino)) {
    New-Item -Path $destino -ItemType Directory | Out-Null
}

# Limpa todo o conte�do do diret�rio de destino antes de criar o novo backup
Write-Host "Limpando conte�do anterior de $destino..."
Get-ChildItem -Path $destino -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

# Monta o comando completo de compacta��o
$argumentos = @(
    "a",                        # Adicionar ao arquivo
    "-r",                       # Recursivo, inclui subpastas
    "-ep1",                     # Mant�m estrutura relativa
    "-m5",                      # Compress�o m�xima
    "-ma5",                     # Formato RAR5
    "-s",                       # Modo s�lido (melhor compress�o)
    "-o+",                      # Sobrescreve se j� existir
    "$caminhoArquivo",          # Destino do arquivo compactado
    "$fonte\*"                  # Origem dos arquivos
)

Write-Host "Compactando $nomeArquivo..."
Start-Sleep -Seconds 1

# Inicia o processo do WinRAR e redireciona a sa�da ao vivo para a tela
$processo = Start-Process -FilePath $winrar -ArgumentList $argumentos -NoNewWindow -RedirectStandardOutput "STDOUT.TXT" -PassThru

# Aguarda enquanto mostra progresso
while (-not $processo.HasExited) {
    if (Test-Path "STDOUT.TXT") {
        Clear-Host
        Write-Host "Compactando... aguarde..."
        Get-Content "STDOUT.TXT" -Tail 20
    }
    Start-Sleep -Seconds 2
}

# Exibe sa�da final
Clear-Host
Write-Host "`nCompacta��o finalizada com sucesso!"
Write-Host "Arquivo salvo em: $caminhoArquivo"

# Remove o arquivo tempor�rio da sa�da
Remove-Item "STDOUT.TXT" -ErrorAction SilentlyContinue
