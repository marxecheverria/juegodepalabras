# 🚀 Script de Despliegue GitHub para Juegos de Palabras
# Autor: Marx Echeverría
# Fecha: $(Get-Date -Format "yyyy-MM-dd")

param(
    [Parameter(Mandatory=$false)]
    [string]$CommitMessage = "🔄 Actualización automática del proyecto",
    
    [Parameter(Mandatory=$false)]
    [switch]$Force,
    
    [Parameter(Mandatory=$false)]
    [switch]$ShowStatus
)

# Configuración de colores para la consola
$Host.UI.RawUI.ForegroundColor = "Cyan"
Write-Host "🚀 Desplegando Juegos de Palabras a GitHub" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green

# Función para verificar el estado de Git
function Test-GitStatus {
    try {
        $status = git status --porcelain
        if ($status) {
            Write-Host "📝 Cambios detectados en el repositorio:" -ForegroundColor Yellow
            $status | ForEach-Object { Write-Host "  $_" -ForegroundColor White }
            return $true
        } else {
            Write-Host "✅ No hay cambios pendientes para commit" -ForegroundColor Green
            return $false
        }
    }
    catch {
        Write-Host "❌ Error al verificar estado de Git: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para verificar si hay un remote configurado
function Test-GitRemote {
    try {
        $remotes = git remote -v
        if ($remotes) {
            Write-Host "🌐 Repositorios remotos configurados:" -ForegroundColor Cyan
            $remotes | ForEach-Object { Write-Host "  $_" -ForegroundColor White }
            return $true
        } else {
            Write-Host "❌ No hay repositorios remotos configurados" -ForegroundColor Red
            return $false
        }
    }
    catch {
        Write-Host "❌ Error al verificar remotos: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para hacer commit y push
function Push-ToGitHub {
    param([string]$Message)
    
    try {
        Write-Host "📝 Agregando archivos al staging..." -ForegroundColor Yellow
        git add .
        
        Write-Host "💾 Creando commit: $Message" -ForegroundColor Yellow
        git commit -m $Message
        
        Write-Host "🚀 Subiendo cambios a GitHub..." -ForegroundColor Yellow
        
        # Intentar push a la rama actual
        $currentBranch = git branch --show-current
        Write-Host "📍 Rama actual: $currentBranch" -ForegroundColor Cyan
        
        git push origin $currentBranch
        
        Write-Host "✅ ¡Despliegue a GitHub completado exitosamente!" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ Error durante el push: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para mostrar ayuda
function Show-Help {
    Write-Host "`n📖 Uso del Script de Despliegue GitHub:" -ForegroundColor Yellow
    Write-Host "=======================================" -ForegroundColor Yellow
    Write-Host "`nSintaxis:" -ForegroundColor White
    Write-Host "  .\deploy-github.ps1 [opciones]`n" -ForegroundColor White
    
    Write-Host "Parámetros opcionales:" -ForegroundColor Cyan
    Write-Host "  -CommitMessage : Mensaje personalizado para el commit" -ForegroundColor White
    Write-Host "  -Force         : Forzar el despliegue incluso sin cambios" -ForegroundColor White
    Write-Host "  -ShowStatus    : Mostrar estado detallado del repositorio" -ForegroundColor White
    
    Write-Host "`nEjemplos:" -ForegroundColor Cyan
    Write-Host "  .\deploy-github.ps1" -ForegroundColor White
    Write-Host "  .\deploy-github.ps1 -CommitMessage '🐛 Corregir bug en crucigrama'" -ForegroundColor White
    Write-Host "  .\deploy-github.ps1 -Force" -ForegroundColor White
    Write-Host "  .\deploy-github.ps1 -ShowStatus" -ForegroundColor White
}

# Verificar si se solicitó ayuda
if ($CommitMessage -eq "-h" -or $CommitMessage -eq "--help" -or $CommitMessage -eq "help") {
    Show-Help
    exit 0
}

# Verificar que estamos en un repositorio Git
if (-not (Test-Path ".git")) {
    Write-Host "❌ Error: No se detectó un repositorio Git en este directorio" -ForegroundColor Red
    Write-Host "💡 Ejecuta 'git init' para inicializar un repositorio" -ForegroundColor Yellow
    exit 1
}

# Mostrar estado si se solicita
if ($ShowStatus) {
    Write-Host "`n📊 Estado del Repositorio Git:" -ForegroundColor Magenta
    Write-Host "===============================" -ForegroundColor Magenta
    
    Write-Host "`n📍 Rama actual:" -ForegroundColor Cyan
    git branch --show-current
    
    Write-Host "`n🌐 Repositorios remotos:" -ForegroundColor Cyan
    git remote -v
    
    Write-Host "`n📝 Estado de los archivos:" -ForegroundColor Cyan
    git status
    
    Write-Host "`n📈 Historial de commits:" -ForegroundColor Cyan
    git log --oneline -5
    
    exit 0
}

# Verificar si hay un remote configurado
if (-not (Test-GitRemote)) {
    Write-Host "`n💡 Para configurar un repositorio remoto, ejecuta:" -ForegroundColor Yellow
    Write-Host "   git remote add origin https://github.com/USERNAME/juegodepalabras.git" -ForegroundColor White
    Write-Host "   Reemplaza USERNAME con tu nombre de usuario de GitHub" -ForegroundColor White
    exit 1
}

# Verificar estado de Git
$hasChanges = Test-GitStatus

if (-not $hasChanges -and -not $Force) {
    Write-Host "`n💡 No hay cambios para subir. Usa -Force para forzar el despliegue." -ForegroundColor Yellow
    exit 0
}

# Confirmar despliegue
if (-not $Force) {
    Write-Host "`n❓ ¿Deseas continuar con el despliegue? (S/N): " -ForegroundColor Yellow -NoNewline
    $response = Read-Host
    if ($response -notmatch "^[Ss]$") {
        Write-Host "❌ Despliegue cancelado por el usuario" -ForegroundColor Red
        exit 0
    }
}

# Ejecutar despliegue
Write-Host "`n🚀 Iniciando despliegue a GitHub..." -ForegroundColor Green

if (Push-ToGitHub -Message $CommitMessage) {
    Write-Host "`n🎉 ¡Proyecto desplegado exitosamente en GitHub!" -ForegroundColor Green
    
    # Mostrar información adicional
    $remotes = git remote -v | Select-String "origin"
    if ($remotes -match "github\.com") {
        $repoUrl = $remotes -replace ".*github\.com[:/]([^/]+/[^/]+)\.git.*", "https://github.com/`$1"
        Write-Host "🌐 Repositorio: $repoUrl" -ForegroundColor Cyan
        
        # Intentar detectar si GitHub Pages está configurado
        Write-Host "`n💡 Para habilitar GitHub Pages:" -ForegroundColor Yellow
        Write-Host "   1. Ve a Settings > Pages en tu repositorio" -ForegroundColor White
        Write-Host "   2. Selecciona 'Deploy from a branch'" -ForegroundColor White
        Write-Host "   3. Elige la rama 'main' y carpeta '/' (root)" -ForegroundColor White
    }
} else {
    Write-Host "`n❌ El despliegue falló. Revisa los errores arriba." -ForegroundColor Red
    exit 1
}

Write-Host "`n✨ ¡Gracias por usar el script de despliegue GitHub!" -ForegroundColor Green
