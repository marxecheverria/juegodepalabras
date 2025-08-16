# 🎯 WordQuest Elite

**Desafía tu mente con la sopa de letras más avanzada**

## 🚀 Descripción

WordQuest Elite es un juego de sopa de letras moderno y elegante que combina diseño minimalista con funcionalidades avanzadas. El juego se ejecuta completamente en el navegador y ofrece una experiencia de usuario fluida y atractiva.

## ✨ Características

- 🎨 **Diseño moderno**: Interfaz elegante con gradientes y efectos visuales
- 📱 **Responsive**: Funciona perfectamente en dispositivos móviles y de escritorio
- 🎮 **Controles intuitivos**: Selección de palabras mediante arrastre del mouse
- ⏱️ **Temporizador**: Seguimiento del tiempo de juego
- 💡 **Sistema de pistas**: Ayuda cuando te quedas atascado
- 🔄 **Múltiples juegos**: Generación automática de nuevas sopas de letras
- 💾 **Persistencia**: Guardado automático del progreso del juego
- 🏆 **Sistema de puntuaciones**: Registro de mejores tiempos

## 🛠️ Tecnologías

- HTML5
- CSS3 (Variables CSS, Grid, Flexbox, Animaciones)
- JavaScript ES6+ (Async/Await, LocalStorage)
- Fuentes web (Outfit, Space Grotesk)

## 📁 Estructura del Proyecto

```
juegodepalabras/
├── index.html              # Archivo principal del juego
├── SopaDeLetrasNuevo.html # Versión más reciente
├── palabras.txt            # Lista de palabras para el juego
├── .gitignore             # Archivos a ignorar en Git
└── README.md              # Este archivo
```

## 🚀 Instalación y Uso

1. **Clona el repositorio**:
   ```bash
   git clone [URL_DEL_REPOSITORIO]
   cd juegodepalabras
   ```

2. **Abre el archivo principal**:
   - Abre `index.html` en tu navegador web
   - O sube los archivos a tu servidor web

3. **Personaliza las palabras**:
   - Edita `palabras.txt` para agregar o modificar palabras
   - Cada palabra debe estar en una línea separada
   - Solo se permiten letras A-Z (sin acentos ni caracteres especiales)

## 🎮 Cómo Jugar

1. **Inicio**: El juego se inicia automáticamente con 5 palabras seleccionadas al azar
2. **Selección**: Haz clic y arrastra para seleccionar letras en línea recta
3. **Direcciones**: Las palabras pueden estar en 8 direcciones diferentes
4. **Objetivo**: Encuentra todas las palabras antes de que se agote el tiempo
5. **Controles**:
   - 💡 **Pista**: Muestra una pista visual
   - ↶ **Deshacer**: Deshace la última selección
   - ▶️ **Reanudar**: Continúa un juego guardado
   - 🔄 **Nuevo**: Inicia un nuevo juego
   - 🏳️ **Rendirse**: Revela todas las palabras restantes

## 🔧 Personalización

### Colores y Estilos
Edita las variables CSS en `:root` para personalizar:
- Paleta de colores
- Tipografías
- Espaciado
- Bordes y sombras

### Palabras del Juego
Modifica `palabras.txt` para:
- Agregar nuevas palabras
- Cambiar la dificultad
- Adaptar el contenido a diferentes idiomas o temas

## 📤 Despliegue

### Opción 1: Servidor FTP/SFTP
1. Sube todos los archivos a tu servidor web
2. Asegúrate de que `index.html` sea el archivo principal
3. Verifica que `palabras.txt` sea accesible

### Opción 2: GitHub Pages
1. Crea un repositorio en GitHub
2. Sube tu código
3. Activa GitHub Pages en la configuración del repositorio

### Opción 3: Servicios de Hosting
- **Netlify**: Arrastra y suelta la carpeta del proyecto
- **Vercel**: Conecta tu repositorio de GitHub
- **Firebase Hosting**: Despliegue rápido y gratuito

## 🔄 Flujo de Trabajo con Git

### Comandos básicos:
```bash
# Ver estado del repositorio
git status

# Agregar cambios
git add .

# Hacer commit
git commit -m "Descripción de los cambios"

# Subir cambios
git push origin main

# Ver historial
git log --oneline
```

### Flujo recomendado:
1. **Desarrollo**: Trabaja en tu código local
2. **Commit**: Guarda cambios con mensajes descriptivos
3. **Push**: Sube cambios a GitHub
4. **Despliegue**: Sube archivos actualizados al servidor FTP

## 🐛 Solución de Problemas

### El juego no carga palabras
- Verifica que `palabras.txt` esté en la misma carpeta
- Asegúrate de que el archivo contenga al menos 5 palabras válidas
- Revisa la consola del navegador para errores

### Problemas de rendimiento
- El juego está optimizado para navegadores modernos
- Usa Chrome, Firefox, Safari o Edge actualizados

### Problemas de despliegue
- Verifica permisos de archivos en el servidor
- Asegúrate de que todos los archivos estén subidos
- Comprueba la configuración del servidor web

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Para contribuir:

1. Haz fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Haz commit de tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 📞 Contacto

Si tienes preguntas o sugerencias, no dudes en contactar.

---

**¡Disfruta jugando WordQuest Elite! 🎮✨**
