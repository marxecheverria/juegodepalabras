# 🚀 Guía de Despliegue FTP - Juegos de Palabras

## 📋 Prerrequisitos

- **PowerShell** instalado en Windows
- **Credenciales FTP** de tu servidor web
- **Acceso a internet** para conectarse al servidor
- **Archivos del proyecto** listos para subir

## 🔧 Configuración Inicial

### **1. Editar Configuración FTP**

Abre el archivo `deploy-config.ps1` y edita las siguientes variables:

```powershell
$FtpServer = "tu-servidor.com"        # Tu servidor FTP
$Username = "tu-usuario-ftp"           # Tu usuario FTP
$Password = "tu-password-ftp"          # Tu contraseña FTP
$RemotePath = "/"                      # Ruta en el servidor
```

### **2. Verificar Archivos**

El script verificará automáticamente que todos los archivos necesarios estén presentes:

- ✅ `index.html` - Menú principal
- ✅ `crucigrama.html` - Juego de crucigrama
- ✅ `letras.html` - Juego de letras
- ✅ `cartas.html` - Juego de cartas
- ✅ `words.json` - Base de datos de palabras
- ✅ `config.json` - Configuración del juego
- ✅ `README.md` - Documentación del proyecto

## 🚀 Opciones de Despliegue

### **Opción 1: Despliegue Básico**

```powershell
.\deploy-clean.ps1 -FtpServer "tu-servidor.com" -Username "usuario" -Password "password"
```

### **Opción 2: Despliegue con Limpieza**

```powershell
.\deploy-clean.ps1 -FtpServer "tu-servidor.com" -Username "usuario" -Password "password" -CleanDeploy
```

**Esta opción eliminará archivos obsoletos del servidor:**
- `index1.html` (renombrado a `letras.html`)
- `crucigrama.txt` (reemplazado por `words.json`)
- `palabras.txt` (reemplazado por `words.json`)

### **Opción 3: Simulación (Sin Subir)**

```powershell
.\deploy-clean.ps1 -FtpServer "tu-servidor.com" -Username "usuario" -Password "password" -DryRun
```

**Útil para:**
- Verificar que todos los archivos estén presentes
- Calcular el tamaño total de la transferencia
- Revisar la configuración antes del despliegue real

## 📱 Ejemplos de Uso

### **Ejemplo 1: Despliegue Completo**

```powershell
# Navegar al directorio del proyecto
cd C:\Users\Usuario\Desktop\juegodepalabras

# Ejecutar despliegue completo con limpieza
.\deploy-clean.ps1 -FtpServer "ezequielrifa.imaynalla.org" -Username "tu-usuario" -Password "tu-password" -CleanDeploy
```

### **Ejemplo 2: Verificación Previa**

```powershell
# Simular despliegue para verificar archivos
.\deploy-clean.ps1 -FtpServer "ezequielrifa.imaynalla.org" -Username "tu-usuario" -Password "tu-password" -DryRun
```

### **Ejemplo 3: Despliegue Rápido**

```powershell
# Despliegue básico sin limpieza
.\deploy-clean.ps1 -FtpServer "ezequielrifa.imaynalla.org" -Username "tu-usuario" -Password "tu-password"
```

## 🔍 Verificación del Despliegue

### **1. Verificar Archivos Subidos**

Después del despliegue, verifica que estos archivos estén en tu servidor:

- `index.html` - Página principal
- `crucigrama.html` - Juego de crucigrama
- `letras.html` - Juego de letras
- `cartas.html` - Juego de cartas
- `words.json` - Base de datos de palabras
- `config.json` - Configuración del juego

### **2. Probar Funcionalidad**

Abre tu sitio web y verifica:

- ✅ **Página principal** se carga correctamente
- ✅ **Menú de juegos** funciona
- ✅ **Todos los juegos** se ejecutan sin errores
- ✅ **Base de datos de palabras** se carga correctamente

### **3. URLs de Verificación**

```
https://tu-sitio.com/index.html
https://tu-sitio.com/crucigrama.html
https://tu-sitio.com/letras.html
https://tu-sitio.com/cartas.html
```

## 🛠️ Solución de Problemas

### **Error: "Credenciales FTP incorrectas"**

```powershell
# Verificar credenciales
.\deploy-clean.ps1 -FtpServer "tu-servidor.com" -Username "usuario" -Password "password" -DryRun
```

### **Error: "Archivo no encontrado"**

```powershell
# Verificar que todos los archivos estén presentes
dir *.html, *.json, *.md
```

### **Error: "Conexión FTP fallida"**

- Verificar conexión a internet
- Verificar que el servidor FTP esté activo
- Verificar credenciales y puerto (normalmente 21)

### **Error: "Permisos insuficientes"**

- Verificar que tu usuario FTP tenga permisos de escritura
- Contactar al administrador del servidor

## 📊 Monitoreo del Despliegue

### **Indicadores de Éxito**

- ✅ Todos los archivos se suben sin errores
- ✅ Mensaje "Despliegue completado exitosamente"
- ✅ Tiempo de despliegue razonable
- ✅ URLs de juegos funcionan correctamente

### **Indicadores de Problemas**

- ❌ Errores durante la subida de archivos
- ❌ Archivos faltantes en el servidor
- ❌ Juegos no funcionan después del despliegue
- ❌ Errores de conexión FTP

## 🔄 Despliegues Automáticos

### **Script de Despliegue Rápido**

Crea un archivo `deploy-quick.ps1`:

```powershell
# Despliegue rápido con credenciales predefinidas
.\deploy-clean.ps1 -FtpServer "ezequielrifa.imaynalla.org" -Username "tu-usuario" -Password "tu-password" -CleanDeploy
```

### **Programación de Despliegues**

```powershell
# Crear tarea programada en Windows
SCHTASKS /CREATE /SC DAILY /TN "Despliegue Juegos" /TR "powershell.exe -File C:\ruta\deploy-quick.ps1" /ST 09:00
```

## 📈 Optimización del Despliegue

### **1. Comprimir Archivos**

```powershell
# Comprimir archivos antes del despliegue
Compress-Archive -Path *.html, *.json, *.md -DestinationPath deploy.zip
```

### **2. Despliegue Incremental**

El script ya incluye verificación de archivos existentes para evitar subidas innecesarias.

### **3. Backup Automático**

```powershell
# Crear backup antes del despliegue
$date = Get-Date -Format "yyyy-MM-dd_HH-mm"
Copy-Item -Path "*.html" -Destination "backup_$date\"
```

## 🎯 Consejos de Despliegue

### **Antes del Despliegue:**
1. **Verificar archivos** con `-DryRun`
2. **Hacer backup** de la versión actual
3. **Probar localmente** todos los juegos
4. **Verificar credenciales** FTP

### **Durante el Despliegue:**
1. **No interrumpir** el proceso
2. **Monitorear** el progreso
3. **Anotar** cualquier error
4. **Verificar** archivos subidos

### **Después del Despliegue:**
1. **Probar** todos los juegos
2. **Verificar** funcionalidad completa
3. **Limpiar** caché del navegador
4. **Documentar** cambios realizados

## 📞 Soporte

### **Problemas Comunes:**
- **Credenciales incorrectas** → Verificar usuario y contraseña
- **Archivos faltantes** → Verificar que todos los archivos estén presentes
- **Errores de conexión** → Verificar conectividad y servidor FTP
- **Permisos insuficientes** → Contactar administrador del servidor

### **Recursos de Ayuda:**
- **Logs del script** - Revisar mensajes de error
- **Documentación del servidor** - Consultar con el proveedor de hosting
- **Comunidad de desarrolladores** - Foros y grupos de soporte

---

**¡Con esta guía tendrás un despliegue exitoso y profesional de tu suite de juegos educativos!** 🎮✨
