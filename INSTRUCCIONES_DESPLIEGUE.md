# 🚀 Guía Completa de Despliegue - Juegos de Palabras

## 📋 Índice
1. [Despliegue en GitHub](#despliegue-en-github)
2. [Despliegue en Servidor FTP](#despliegue-en-servidor-ftp)
3. [Configuración de Dominio](#configuración-de-dominio)
4. [Solución de Problemas](#solución-de-problemas)

---

## 🌟 Despliegue en GitHub

### Paso 1: Crear Repositorio en GitHub

1. **Ve a GitHub.com** e inicia sesión
2. **Haz clic en "New"** (botón verde)
3. **Configura el repositorio:**
   - **Nombre**: `juegodepalabras`
   - **Descripción**: `🎮 Suite Educativa Interactiva de Juegos de Palabras`
   - **Visibilidad**: ✅ **Público** (Public)
   - **NO marques**: README, .gitignore, o licencia
4. **Haz clic en "Create repository"**

### Paso 2: Conectar Repositorio Local con GitHub

```powershell
# Agregar el repositorio remoto (reemplaza USERNAME con tu usuario de GitHub)
git remote add origin https://github.com/USERNAME/juegodepalabras.git

# Verificar que se agregó correctamente
git remote -v

# Subir el código a GitHub
git branch -M main
git push -u origin main
```

### Paso 3: Configurar GitHub Pages (Opcional)

1. **Ve a Settings** en tu repositorio
2. **Selecciona "Pages"** en el menú izquierdo
3. **En "Source" selecciona "Deploy from a branch"**
4. **Selecciona la rama "main"** y carpeta "/ (root)"
5. **Haz clic en "Save"**

Tu sitio estará disponible en: `https://USERNAME.github.io/juegodepalabras`

---

## 🌐 Despliegue en Servidor FTP

### Paso 1: Preparar Credenciales FTP

Necesitarás:
- **Servidor FTP**: `ftp.tudominio.com` o IP del servidor
- **Usuario**: Tu nombre de usuario FTP
- **Contraseña**: Tu contraseña FTP
- **Ruta remota**: `/public_html/` o `/www/` (depende del hosting)

### Paso 2: Usar el Script de Despliegue Automático

#### Opción A: Despliegue Directo
```powershell
# Ejecutar el script de despliegue
.\deploy-ftp.ps1 -FtpServer "ftp.tudominio.com" -Username "tu_usuario" -Password "tu_contraseña" -RemotePath "/public_html/"
```

#### Opción B: Simulación (Dry Run)
```powershell
# Simular el despliegue sin subir archivos
.\deploy-ftp.ps1 -FtpServer "ftp.tudominio.com" -Username "tu_usuario" -Password "tu_contraseña" -RemotePath "/public_html/" -DryRun
```

#### Opción C: Despliegue en Subdirectorio
```powershell
# Desplegar en una subcarpeta específica
.\deploy-ftp.ps1 -FtpServer "ftp.tudominio.com" -Username "tu_usuario" -Password "tu_contraseña" -RemotePath "/public_html/juegos/"
```

### Paso 3: Verificar el Despliegue

1. **Conecta por FTP** a tu servidor
2. **Verifica que los archivos estén en la ubicación correcta**
3. **Abre tu sitio web** en el navegador
4. **Prueba todos los juegos** para asegurar funcionamiento

---

## 🔧 Configuración de Dominio

### Configuración DNS

Si tienes un dominio personalizado:

1. **Ve a tu proveedor de DNS** (Cloudflare, GoDaddy, etc.)
2. **Crea un registro A** apuntando a la IP de tu servidor
3. **Crea un registro CNAME** para `www` apuntando a tu dominio principal

### Configuración del Servidor Web

#### Apache (.htaccess)
```apache
# Crear archivo .htaccess en la raíz
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)$ index.html [L]

# Compresión GZIP
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/plain
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE text/xml
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE application/xhtml+xml
    AddOutputFilterByType DEFLATE application/rss+xml
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
</IfModule>

# Caché del navegador
<IfModule mod_expires.c>
    ExpiresActive on
    ExpiresByType text/css "access plus 1 year"
    ExpiresByType application/javascript "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
</IfModule>
```

#### Nginx
```nginx
server {
    listen 80;
    server_name tudominio.com www.tudominio.com;
    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    # Compresión GZIP
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
}
```

---

## 🚨 Solución de Problemas

### Problemas Comunes de GitHub

#### Error: "Repository not found"
- Verifica que el repositorio existe y es público
- Confirma que tienes permisos de escritura
- Revisa que la URL del remote sea correcta

#### Error: "Authentication failed"
- Verifica tu token de acceso personal
- Confirma que el token tenga permisos de repo
- Regenera el token si es necesario

### Problemas Comunes de FTP

#### Error: "Connection timeout"
- Verifica la dirección del servidor FTP
- Confirma que el puerto 21 esté abierto
- Revisa la configuración del firewall

#### Error: "Authentication failed"
- Verifica usuario y contraseña
- Confirma que la cuenta FTP esté activa
- Revisa si el hosting requiere SFTP en lugar de FTP

#### Error: "Permission denied"
- Verifica que tengas permisos de escritura
- Confirma que la ruta remota sea correcta
- Revisa la configuración de permisos del servidor

### Problemas de Despliegue

#### Los juegos no funcionan
- Verifica que todos los archivos se subieron
- Confirma que las rutas relativas sean correctas
- Revisa la consola del navegador para errores

#### Problemas de rendimiento
- Activa la compresión GZIP
- Configura el caché del navegador
- Optimiza las imágenes si las hay

---

## 📱 Pruebas Post-Despliegue

### Checklist de Verificación

- [ ] **Página principal** se carga correctamente
- [ ] **Todos los juegos** son accesibles
- [ ] **Navegación** funciona en móvil y desktop
- [ ] **Funcionalidades** de cada juego operan correctamente
- [ ] **Responsive design** se ve bien en todos los dispositivos
- [ ] **Tiempo de carga** es aceptable (< 3 segundos)

### Herramientas de Prueba

- **Google PageSpeed Insights**: Para rendimiento
- **GTmetrix**: Para análisis de velocidad
- **BrowserStack**: Para pruebas en diferentes dispositivos
- **Lighthouse**: Para auditoría completa

---

## 🔄 Actualizaciones Futuras

### Flujo de Trabajo para Actualizaciones

1. **Hacer cambios** en tu código local
2. **Commit y push** a GitHub:
   ```powershell
   git add .
   git commit -m "Descripción de los cambios"
   git push origin main
   ```
3. **Desplegar** al servidor FTP:
   ```powershell
   .\deploy-ftp.ps1 -FtpServer "ftp.tudominio.com" -Username "tu_usuario" -Password "tu_contraseña"
   ```

### Automatización (Opcional)

Para automatizar el despliegue, puedes:
- **Configurar GitHub Actions** para deploy automático
- **Usar webhooks** para sincronización automática
- **Configurar cron jobs** para sincronización periódica

---

## 📞 Soporte

### Recursos de Ayuda

- **Documentación oficial**: [GitHub Docs](https://docs.github.com/)
- **Guía FTP**: [FileZilla Wiki](https://wiki.filezilla-project.org/)
- **Soporte del hosting**: Contacta a tu proveedor de hosting

### Contacto del Proyecto

- **Desarrollador**: Marx Echeverría
- **Repositorio**: [github.com/marxecheverria/juegodepalabras](https://github.com/marxecheverria/juegodepalabras)
- **Issues**: Reporta problemas en GitHub

---

## 🎉 ¡Felicidades!

Has desplegado exitosamente tu suite de juegos de palabras. Ahora puedes:

- **Compartir** el enlace con amigos y familia
- **Usar** en entornos educativos
- **Contribuir** al desarrollo del proyecto
- **Recibir feedback** de la comunidad

**¡Disfruta de tu proyecto en línea!** 🚀✨
