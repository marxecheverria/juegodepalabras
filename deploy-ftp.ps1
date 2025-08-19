# 🚀 Script de Despliegue FTP para Juegos de Palabras
# Autor: Marx Echeverría
# Fecha: $(Get-Date -Format "yyyy-MM-dd")

param(
    [Parameter(Mandatory=$true)]
    [string]$FtpServer,
    
    [Parameter(Mandatory=$true)]
    [string]$Username,
    
    [Parameter(Mandatory=$true)]
    [string]$Password,
    
    [Parameter(Mandatory=$false)]
    [string]$RemotePath = "/",
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun
)

# Configuración de colores para la consola
$Host.UI.RawUI.ForegroundColor = "Cyan"
Write-Host "🎮 Desplegando Juegos de Palabras al Servidor FTP" -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Green

# Verificar que estamos en el directorio correcto
if (-not (Test-Path "index.html")) {
    Write-Host "❌ Error: No se encontró index.html. Ejecuta este script desde el directorio del proyecto." -ForegroundColor Red
    exit 1
}

# Lista de archivos a subir (excluyendo archivos de desarrollo)
$filesToUpload = @(
    "index.html",
    "crucigrama.html", 
    "letras.html",
    "cartas.html",
    "ahorcado.html",
    "words.json",
    "config.json",
    "palabras.txt",
    "README.md",
    "LICENSE"
)

# Función para crear la conexión FTP
function New-FtpConnection {
    param([string]$Server, [string]$User, [string]$Pass)
    
    try {
        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$Server/")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($User, $Pass)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
        $ftpRequest.UsePassive = $true
        $ftpRequest.UseBinary = $true
        
        $response = $ftpRequest.GetResponse()
        $response.Close()
        
        Write-Host "✅ Conexión FTP exitosa a $Server" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ Error de conexión FTP: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para subir un archivo
function Upload-File {
    param([string]$LocalPath, [string]$RemotePath, [string]$Server, [string]$User, [string]$Pass)
    
    try {
        if (-not (Test-Path $LocalPath)) {
            Write-Host "⚠️  Archivo no encontrado: $LocalPath" -ForegroundColor Yellow
            return $false
        }
        
        $ftpUri = "ftp://$Server$RemotePath"
        $ftpRequest = [System.Net.FtpWebRequest]::Create($ftpUri)
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($User, $Pass)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
        $ftpRequest.UsePassive = $true
        $ftpRequest.UseBinary = $true
        
        $fileBytes = [System.IO.File]::ReadAllBytes($LocalPath)
        $ftpRequest.ContentLength = $fileBytes.Length
        
        $requestStream = $ftpRequest.GetRequestStream()
        $requestStream.Write($fileBytes, 0, $fileBytes.Length)
        $requestStream.Close()
        
        $response = $ftpRequest.GetResponse()
        $response.Close()
        
        Write-Host "✅ Subido: $LocalPath -> $ftpUri" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ Error subiendo $LocalPath : $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para crear directorio remoto
function Create-RemoteDirectory {
    param([string]$DirPath, [string]$Server, [string]$User, [string]$Pass)
    
    try {
        $ftpUri = "ftp://$Server$DirPath"
        $ftpRequest = [System.Net.FtpWebRequest]::Create($ftpUri)
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($User, $Pass)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
        $ftpRequest.UsePassive = $true
        
        $response = $ftpRequest.GetResponse()
        $response.Close()
        
        Write-Host "📁 Directorio creado: $DirPath" -ForegroundColor Blue
        return $true
    }
    catch {
        # El directorio ya existe o no se puede crear
        return $false
    }
}

# Función principal de despliegue
function Deploy-Project {
    param([string]$Server, [string]$User, [string]$Pass, [string]$RemotePath)
    
    Write-Host "🚀 Iniciando despliegue..." -ForegroundColor Yellow
    
    # Verificar conexión
    if (-not (New-FtpConnection -Server $Server -User $User -Pass $Pass)) {
        return $false
    }
    
    # Crear directorio remoto si no existe
    if ($RemotePath -ne "/") {
        Create-RemoteDirectory -DirPath $RemotePath -Server $Server -User $User -Pass $Pass
    }
    
    $successCount = 0
    $totalFiles = $filesToUpload.Count
    
    # Subir archivos
    foreach ($file in $filesToUpload) {
        if ($DryRun) {
            Write-Host "🔍 [DRY RUN] Se subiría: $file -> $RemotePath$file" -ForegroundColor Cyan
            $successCount++
        } else {
            $remoteFilePath = if ($RemotePath.EndsWith("/")) { "$RemotePath$file" } else { "$RemotePath/$file" }
            if (Upload-File -LocalPath $file -RemotePath $remoteFilePath -Server $Server -User $User -Pass $Pass) {
                $successCount++
            }
        }
    }
    
    # Resumen del despliegue
    Write-Host "`n📊 Resumen del Despliegue:" -ForegroundColor Magenta
    Write-Host "=========================" -ForegroundColor Magenta
    Write-Host "✅ Archivos subidos exitosamente: $successCount/$totalFiles" -ForegroundColor Green
    
    if ($successCount -eq $totalFiles) {
        Write-Host "🎉 ¡Despliegue completado exitosamente!" -ForegroundColor Green
        Write-Host "🌐 Tu proyecto está disponible en: ftp://$Server$RemotePath" -ForegroundColor Cyan
        return $true
    } else {
        Write-Host "⚠️  Despliegue completado con advertencias" -ForegroundColor Yellow
        return $false
    }
}

# Función para mostrar ayuda
function Show-Help {
    Write-Host "`n📖 Uso del Script de Despliegue FTP:" -ForegroundColor Yellow
    Write-Host "=====================================" -ForegroundColor Yellow
    Write-Host "`nSintaxis:" -ForegroundColor White
    Write-Host "  .\deploy-ftp.ps1 -FtpServer <servidor> -Username <usuario> -Password <contraseña> [opciones]`n" -ForegroundColor White
    
    Write-Host "Parámetros obligatorios:" -ForegroundColor Cyan
    Write-Host "  -FtpServer    : Dirección del servidor FTP" -ForegroundColor White
    Write-Host "  -Username     : Nombre de usuario FTP" -ForegroundColor White
    Write-Host "  -Password     : Contraseña FTP" -ForegroundColor White
    
    Write-Host "`nParámetros opcionales:" -ForegroundColor Cyan
    Write-Host "  -RemotePath   : Ruta remota en el servidor (por defecto: /)" -ForegroundColor White
    Write-Host "  -DryRun       : Simular el despliegue sin subir archivos" -ForegroundColor White
    
    Write-Host "`nEjemplos:" -ForegroundColor Cyan
    Write-Host "  .\deploy-ftp.ps1 -FtpServer ftp.misitio.com -Username miuser -Password mipass" -ForegroundColor White
    Write-Host "  .\deploy-ftp.ps1 -FtpServer ftp.misitio.com -Username miuser -Password mipass -RemotePath /public_html" -ForegroundColor White
    Write-Host "  .\deploy-ftp.ps1 -FtpServer ftp.misitio.com -Username miuser -Password mipass -DryRun" -ForegroundColor White
}

# Verificar si se solicitó ayuda
if ($FtpServer -eq "-h" -or $FtpServer -eq "--help" -or $FtpServer -eq "help") {
    Show-Help
    exit 0
}

# Ejecutar despliegue si se proporcionaron los parámetros necesarios
if ($FtpServer -and $Username -and $Password) {
    Deploy-Project -Server $FtpServer -User $Username -Pass $Password -RemotePath $RemotePath
} else {
    Write-Host "❌ Error: Faltan parámetros obligatorios" -ForegroundColor Red
    Show-Help
    exit 1
}

Write-Host "`n✨ ¡Gracias por usar el script de despliegue FTP!" -ForegroundColor Green
