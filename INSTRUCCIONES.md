# 📋 Instrucciones de Configuración - WordQuest Elite

## 🎯 Objetivo
Configurar un sistema de control de versiones con GitHub y automatizar el despliegue FTP para tu aplicación WordQuest Elite.

## 📋 Prerrequisitos

### 1. Instalar Git
- Descarga Git desde: https://git-scm.com/download/win
- Instala con opciones por defecto
- Reinicia PowerShell después de la instalación

### 2. Crear cuenta en GitHub
- Ve a: https://github.com
- Crea una cuenta gratuita
- Verifica tu email

## 🚀 Paso a Paso

### Paso 1: Configurar Git localmente

```powershell
# Abrir PowerShell en la carpeta del proyecto
cd C:\Users\Usuario\Desktop\juegodepalabras

# Configurar tu identidad Git
git config --global user.name "Tu Nombre"
git config --global user.email "tu-email@ejemplo.com"

# Verificar configuración
git config --list
```

### Paso 2: Inicializar repositorio Git

```powershell
# Inicializar repositorio
git init

# Ver estado
git status

# Agregar todos los archivos
git add .

# Primer commit
git commit -m "🎉 Versión inicial de WordQuest Elite"
```

### Paso 3: Crear repositorio en GitHub

1. Ve a https://github.com
2. Haz clic en "New repository"
3. Nombre: `juegodepalabras` o `wordquest-elite`
4. Descripción: "Juego de sopa de letras moderno y elegante"
5. **NO** inicialices con README (ya lo tenemos)
6. Haz clic en "Create repository"

### Paso 4: Conectar repositorio local con GitHub

```powershell
# Agregar origen remoto (reemplaza USERNAME y REPO_NAME)
git remote add origin https://github.com/USERNAME/REPO_NAME.git

# Verificar origen remoto
git remote -v

# Subir código a GitHub
git branch -M main
git push -u origin main
```

### Paso 5: Configurar credenciales FTP

1. **Edita el archivo `deploy-config.ps1`**
2. Cambia las siguientes líneas:
   ```powershell
   Server = "tu-servidor-ftp.com"      # Tu servidor FTP real
   Username = "tu-usuario"             # Tu usuario FTP real
   Password = "tu-password"            # Tu password FTP real
   RemotePath = "/"                    # Ruta en el servidor
   ```

3. **Ejemplo real:**
   ```powershell
   Server = "ftp.ezequielrifa.imaynalla.org"
   Username = "usuario123"
   Password = "password123"
   RemotePath = "/public_html/"
   ```

### Paso 6: Probar conexión FTP

```powershell
# Ejecutar menú de configuración
.\deploy-config.ps1

# Selecciona opción 2: "Probar conexión FTP"
```

### Paso 7: Desplegar actualizaciones

```powershell
# Simular despliegue (sin subir archivos)
.\deploy-config.ps1
# Selecciona opción 3: "Simular despliegue"

# Despliegue completo
.\deploy-config.ps1
# Selecciona opción 4: "Ejecutar despliegue completo"
```

## 🔄 Flujo de Trabajo Diario

### 1. Hacer cambios en el código
```powershell
# Edita los archivos HTML, CSS, JavaScript
# Agrega nuevas palabras a palabras.txt
```

### 2. Guardar cambios en Git
```powershell
# Ver qué archivos cambiaron
git status

# Agregar cambios
git add .

# Hacer commit con mensaje descriptivo
git commit -m "✨ Agregar nuevas palabras y mejorar interfaz"

# Subir a GitHub
git push origin main
```

### 3. Desplegar al servidor
```powershell
# Desplegar cambios
.\deploy-config.ps1
# Selecciona opción 4
```

## 🛠️ Comandos Git Útiles

```powershell
# Ver historial de cambios
git log --oneline

# Ver diferencias
git diff

# Deshacer último commit (mantiene cambios)
git reset --soft HEAD~1

# Ver ramas
git branch

# Crear nueva rama
git checkout -b nueva-funcionalidad

# Cambiar entre ramas
git checkout main

# Ver estado del repositorio
git status
```

## 🔧 Solución de Problemas

### Error: "git no se reconoce"
- Reinstala Git y reinicia PowerShell
- Verifica que Git esté en el PATH del sistema

### Error de conexión FTP
- Verifica credenciales en `deploy-config.ps1`
- Comprueba que el servidor FTP esté activo
- Verifica el puerto (normalmente 21)

### Error al subir a GitHub
- Verifica que tengas permisos en el repositorio
- Asegúrate de que el origen remoto esté correcto
- Usa `git remote -v` para verificar

## 📁 Estructura Final del Proyecto

```
juegodepalabras/
├── index.html              # Archivo principal del juego
├── SopaDeLetrasNuevo.html # Versión más reciente
├── palabras.txt            # Lista de palabras
├── .gitignore             # Archivos a ignorar en Git
├── README.md              # Documentación del proyecto
├── LICENSE                # Licencia MIT
├── deploy.ps1             # Script de despliegue FTP
├── deploy-config.ps1      # Configuración FTP (NO subir a GitHub)
└── INSTRUCCIONES.md       # Este archivo
```

## 🎉 ¡Listo!

Una vez completados todos los pasos, tendrás:
- ✅ Control de versiones con Git y GitHub
- ✅ Despliegue automatizado al servidor FTP
- ✅ Historial completo de cambios
- ✅ Backup en la nube (GitHub)
- ✅ Sistema profesional de desarrollo

## 📞 Soporte

Si encuentras problemas:
1. Revisa los mensajes de error
2. Verifica la configuración
3. Consulta la documentación de Git y PowerShell
4. Busca ayuda en foros de desarrolladores

---

**¡Disfruta desarrollando WordQuest Elite! 🎮✨**
