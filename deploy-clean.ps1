# Script de despliegue FTP para Juegos de Palabras
# Uso: .\deploy-clean.ps1

param(
    [string]$FtpServer = "",
    [string]$Username = "",
    [string]$Password = "",
    [string]$RemotePath = "/",
    [switch]$DryRun,
    [switch]$CleanDeploy
)

# Colores para la salida
$Green = "Green"
$Yellow = "Yellow"
$Red = "Red"
$Cyan = "Cyan"
$Magenta = "Magenta"

Write-Host "Juegos de Palabras - Script de Despliegue FTP" -ForegroundColor $Cyan
Write-Host "=================================================" -ForegroundColor $Cyan

# Verificar si se proporcionaron credenciales
if (-not $FtpServer -or -not $Username -or -not $Password) {
    Write-Host "Error: Debes proporcionar las credenciales FTP" -ForegroundColor $Red
    Write-Host ""
    Write-Host "Uso:" -ForegroundColor $Yellow
    Write-Host "  .\deploy-clean.ps1 -FtpServer 'tu-servidor.com' -Username 'tu-usuario' -Password 'tu-password'"
    Write-Host ""
    Write-Host "Opciones adicionales:" -ForegroundColor $Yellow
    Write-Host "  -DryRun          : Simula el despliegue sin subir archivos"
    Write-Host "  -CleanDeploy     : Limpia archivos obsoletos del servidor"
    Write-Host ""
    Write-Host "Ejemplo completo:" -ForegroundColor $Yellow
    Write-Host "  .\deploy-clean.ps1 -FtpServer 'tu-servidor.com' -Username 'usuario' -Password 'password' -CleanDeploy"
    exit 1
}

# Archivos principales a subir
$FilesToUpload = @(
    "index.html",                    # Menú principal interactivo
    "ahorcado.html",                # Juego del ahorcado Pro
    "crucigrama.html",              # Juego de crucigrama
    "letras.html",                  # Juego de letras
    "cartas.html",                  # Juego de cartas
    "words.json",                   # Base de datos de palabras
    "config.json",                  # Configuración del juego
    "palabras.txt",                 # Archivo de palabras adicionales
    ".htaccess",                    # Configuración de seguridad y HTTPS
    "README.md",                    # Documentación del proyecto
    "INSTRUCCIONES.md",             # Instrucciones generales
    "INSTRUCCIONES_DESPLIEGUE.md",  # Instrucciones de despliegue
    "INSTRUCCIONES_OPTIMIZACION.md" # Documentación técnica
)

# Archivos opcionales (si existen)
$OptionalFiles = @(
    "LICENSE",
    ".gitignore"
)

# Verificar que los archivos principales existan
Write-Host "Verificando archivos principales..." -ForegroundColor $Yellow
$missingFiles = @()
foreach ($file in $FilesToUpload) {
    if (Test-Path $file) {
        Write-Host "  OK $file" -ForegroundColor $Green
    } else {
        Write-Host "  ERROR $file (no encontrado)" -ForegroundColor $Red
        $missingFiles += $file
    }
}

# Verificar archivos opcionales
Write-Host "Verificando archivos opcionales..." -ForegroundColor $Yellow
foreach ($file in $OptionalFiles) {
    if (Test-Path $file) {
        Write-Host "  OK $file (opcional)" -ForegroundColor $Green
        $FilesToUpload += $file
    } else {
        Write-Host "  ADVERTENCIA $file (no encontrado, se omitira)" -ForegroundColor $Yellow
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host ""
    Write-Host "Error: Faltan archivos principales necesarios para el despliegue" -ForegroundColor $Red
    Write-Host "Archivos faltantes:" -ForegroundColor $Red
    foreach ($file in $missingFiles) {
        Write-Host "  - $file" -ForegroundColor $Red
    }
    exit 1
}

Write-Host ""

if ($DryRun) {
    Write-Host "MODO SIMULACION - No se subiran archivos" -ForegroundColor $Yellow
    Write-Host ""
    Write-Host "Archivos que se subirian:" -ForegroundColor $Cyan
    $totalSize = 0
    foreach ($file in $FilesToUpload) {
        $size = (Get-Item $file).Length
        $totalSize += $size
        $sizeKB = [math]::Round($size / 1KB, 2)
        Write-Host "  $file ($sizeKB KB)" -ForegroundColor $Cyan
    }
    $totalSizeMB = [math]::Round($totalSize / 1MB, 2)
    Write-Host ""
    Write-Host "Resumen:" -ForegroundColor $Magenta
    Write-Host "  Total de archivos: $($FilesToUpload.Count)" -ForegroundColor $Magenta
    Write-Host "  Tamaño total: $totalSizeMB MB" -ForegroundColor $Magenta
    Write-Host ""
    Write-Host "Configuración:" -ForegroundColor $Magenta
    Write-Host "  Servidor FTP: $FtpServer" -ForegroundColor $Magenta
    Write-Host "  Ruta remota: $RemotePath" -ForegroundColor $Magenta
    Write-Host "  Usuario: $Username" -ForegroundColor $Magenta
    exit 0
}

# Función para crear URI FTP
function New-FtpUri {
    param([string]$FileName)
    return "ftp://$FtpServer$RemotePath$FileName"
}

# Función para subir archivo
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

# Función para limpiar archivos obsoletos del servidor
function Clean-OldFiles {
    Write-Host "Limpiando archivos obsoletos del servidor..." -ForegroundColor $Magenta
    
    $obsoleteFiles = @(
        "index1.html",      # Renombrado a letras.html
        "crucigrama.txt",   # Reemplazado por words.json
        "palabras.txt"      # Reemplazado por words.json
    )
    
    foreach ($file in $obsoleteFiles) {
        try {
            $ftpUri = New-FtpUri $file
            $webClient = New-Object System.Net.WebClient
            $webClient.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
            
            Write-Host "  Eliminando $file..." -ForegroundColor $Yellow
            
            # Intentar eliminar el archivo
            $webClient.UploadString($ftpUri, "DELETE", "")
            
            Write-Host "  OK $file eliminado del servidor" -ForegroundColor $Green
            
            $webClient.Dispose()
        }
        catch {
            Write-Host "  ADVERTENCIA No se pudo eliminar $file (puede no existir)" -ForegroundColor $Yellow
        }
    }
}

# Iniciar despliegue
Write-Host "Iniciando despliegue..." -ForegroundColor $Cyan
Write-Host "Servidor: $FtpServer" -ForegroundColor $Cyan
Write-Host "Usuario: $Username" -ForegroundColor $Cyan
Write-Host "Ruta remota: $RemotePath" -ForegroundColor $Cyan
Write-Host ""

# Limpiar archivos obsoletos si se solicita
if ($CleanDeploy) {
    Clean-OldFiles
    Write-Host ""
}

$successCount = 0
$totalFiles = $FilesToUpload.Count
$startTime = Get-Date

foreach ($file in $FilesToUpload) {
    if (Upload-File $file $file) {
        $successCount++
    }
}

$endTime = Get-Date
$duration = $endTime - $startTime

Write-Host ""
Write-Host "Resumen del despliegue:" -ForegroundColor $Cyan
Write-Host "  Duración: $($duration.TotalSeconds.ToString('F1')) segundos" -ForegroundColor $Cyan
Write-Host "  Archivos subidos: $successCount de $totalFiles" -ForegroundColor $Cyan

if ($successCount -eq $totalFiles) {
    Write-Host ""
    Write-Host "¡Despliegue completado exitosamente!" -ForegroundColor $Green
    Write-Host "Tu sitio estará disponible en: https://ezequielrifa.imaynalla.org/" -ForegroundColor $Green
    Write-Host ""
    Write-Host "Juegos disponibles:" -ForegroundColor $Green
    Write-Host "  Crucigrama Elite: https://ezequielrifa.imaynalla.org/crucigrama.html" -ForegroundColor $Green
    Write-Host "  Juego de Letras: https://ezequielrifa.imaynalla.org/letras.html" -ForegroundColor $Green
    Write-Host "  Juego de Cartas: https://ezequielrifa.imaynalla.org/cartas.html" -ForegroundColor $Green
} else {
    Write-Host "Despliegue parcial. Revisa los errores arriba." -ForegroundColor $Yellow
}

Write-Host ""
Write-Host "Consejos post-despliegue:" -ForegroundColor $Cyan
Write-Host "  Limpia la caché del navegador si es necesario" -ForegroundColor $Cyan
Write-Host "  Prueba en diferentes dispositivos" -ForegroundColor $Cyan
Write-Host "  Verifica que todos los juegos funcionen correctamente" -ForegroundColor $Cyan
Write-Host "  Revisa los logs del servidor si hay problemas" -ForegroundColor $Cyan
Write-Host ""
Write-Host "¡Tu suite de juegos educativos está lista para usar!" -ForegroundColor $Green

