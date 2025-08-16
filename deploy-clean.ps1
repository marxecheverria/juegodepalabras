# Script de despliegue FTP para WordQuest Elite
# Uso: .\deploy-clean.ps1

param(
    [string]$FtpServer = "",
    [string]$Username = "",
    [string]$Password = "",
    [string]$RemotePath = "/",
    [switch]$DryRun
)

# Colores para la salida
$Green = "Green"
$Yellow = "Yellow"
$Red = "Red"
$Cyan = "Cyan"

Write-Host "WordQuest Elite - Script de Despliegue FTP" -ForegroundColor $Cyan
Write-Host "=============================================" -ForegroundColor $Cyan

# Verificar si se proporcionaron credenciales
if (-not $FtpServer -or -not $Username -or -not $Password) {
    Write-Host "Error: Debes proporcionar las credenciales FTP" -ForegroundColor $Red
    Write-Host ""
    Write-Host "Uso:" -ForegroundColor $Yellow
    Write-Host "  .\deploy-clean.ps1 -FtpServer 'tu-servidor.com' -Username 'tu-usuario' -Password 'tu-password'"
    Write-Host ""
    Write-Host "O configura las variables en el script:" -ForegroundColor $Yellow
    Write-Host "  $FtpServer = 'tu-servidor.com'"
    Write-Host "  $Username = 'tu-usuario'"
    Write-Host "  $Password = 'tu-password'"
    exit 1
}

# Archivos a subir
$FilesToUpload = @(
    "index.html",
    "palabras.txt",
    "index1.html"
)

# Verificar que los archivos existan
Write-Host "Verificando archivos..." -ForegroundColor $Yellow
foreach ($file in $FilesToUpload) {
    if (Test-Path $file) {
        Write-Host "  OK $file" -ForegroundColor $Green
    } else {
        Write-Host "  ERROR $file (no encontrado)" -ForegroundColor $Red
        exit 1
    }
}

Write-Host ""

if ($DryRun) {
    Write-Host "MODO SIMULACION - No se subiran archivos" -ForegroundColor $Yellow
    Write-Host ""
    Write-Host "Archivos que se subirian:" -ForegroundColor $Cyan
    foreach ($file in $FilesToUpload) {
        $size = (Get-Item $file).Length
        $sizeKB = [math]::Round($size / 1KB, 2)
        Write-Host "  $file ($sizeKB KB)" -ForegroundColor $Cyan
    }
    Write-Host ""
    Write-Host "Servidor FTP: $FtpServer" -ForegroundColor $Cyan
    Write-Host "Ruta remota: $RemotePath" -ForegroundColor $Cyan
    exit 0
}

# Funcion para crear URI FTP
function New-FtpUri {
    param([string]$FileName)
    return "ftp://$FtpServer$RemotePath$FileName"
}

# Funcion para subir archivo
function Upload-File {
    param([string]$LocalFile, [string]$RemoteFile)
    
    try {
        $ftpUri = New-FtpUri $RemoteFile
        $webClient = New-Object System.Net.WebClient
        $webClient.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
        
        Write-Host "  Subiendo $LocalFile..." -ForegroundColor $Yellow
        
        $webClient.UploadFile($ftpUri, $LocalFile)
        
        Write-Host "  OK $LocalFile subido exitosamente" -ForegroundColor $Green
        
        $webClient.Dispose()
    }
    catch {
        Write-Host "  ERROR al subir $LocalFile`: $($_.Exception.Message)" -ForegroundColor $Red
        return $false
    }
    
    return $true
}

# Iniciar despliegue
Write-Host "Iniciando despliegue..." -ForegroundColor $Cyan
Write-Host "Servidor: $FtpServer" -ForegroundColor $Cyan
Write-Host "Usuario: $Username" -ForegroundColor $Cyan
Write-Host "Ruta remota: $RemotePath" -ForegroundColor $Cyan
Write-Host ""

$successCount = 0
$totalFiles = $FilesToUpload.Count

foreach ($file in $FilesToUpload) {
    if (Upload-File $file $file) {
        $successCount++
    }
}

Write-Host ""
Write-Host "Resumen del despliegue:" -ForegroundColor $Cyan
Write-Host "  Archivos subidos: $successCount de $totalFiles" -ForegroundColor $Cyan

if ($successCount -eq $totalFiles) {
    Write-Host "Despliegue completado exitosamente!" -ForegroundColor $Green
    Write-Host "Tu sitio estara disponible en: https://ezequielrifa.imaynalla.org/" -ForegroundColor $Green
} else {
    Write-Host "Despliegue parcial. Revisa los errores arriba." -ForegroundColor $Yellow
}

Write-Host ""
Write-Host "Consejos:" -ForegroundColor $Cyan
Write-Host "  - Verifica que tu sitio funcione correctamente" -ForegroundColor $Cyan
Write-Host "  - Limpia la cache del navegador si es necesario" -ForegroundColor $Cyan
Write-Host "  - Revisa los logs del servidor si hay problemas" -ForegroundColor $Cyan

