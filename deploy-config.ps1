# Configuración de despliegue FTP para Juegos de Palabras
# IMPORTANTE: Edita este archivo con tus credenciales FTP reales

# Configuración del servidor FTP
$FtpServer = "ezequielrifa.imaynalla.org"  # Tu servidor FTP real
$Username = "tu-usuario-ftp-real"           # Tu usuario FTP real
$Password = "tu-password-ftp-real"          # Tu contraseña FTP real
$RemotePath = "/"                           # Ruta en el servidor (normalmente "/")

# Configuración adicional
$CleanOldFiles = $true                      # ¿Eliminar archivos obsoletos?
$ShowProgress = $true                       # ¿Mostrar barra de progreso?

# Exportar variables para el script principal
Export-ModuleMember -Variable FtpServer, Username, Password, RemotePath, CleanOldFiles, ShowProgress

Write-Host "✅ Configuración de despliegue cargada" -ForegroundColor Green
Write-Host "🌐 Servidor: $FtpServer" -ForegroundColor Cyan
Write-Host "👤 Usuario: $Username" -ForegroundColor Cyan
Write-Host "📁 Ruta: $RemotePath" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  IMPORTANTE: Edita este archivo con tus credenciales reales antes de usar" -ForegroundColor Yellow
Write-Host ""
Write-Host "💡 Para usar esta configuración:" -ForegroundColor Yellow
Write-Host "  1. Edita este archivo con tus credenciales reales" -ForegroundColor Yellow
Write-Host "  2. Ejecuta: .\deploy-clean.ps1 -FtpServer '$FtpServer' -Username '$Username' -Password '$Password'" -ForegroundColor Yellow
Write-Host "  3. O usa: .\deploy-clean.ps1 -FtpServer '$FtpServer' -Username '$Username' -Password '$Password' -CleanDeploy" -ForegroundColor Yellow
Write-Host ""
Write-Host "🔒 NOTA: No subas este archivo a GitHub con tus credenciales reales" -ForegroundColor Red
