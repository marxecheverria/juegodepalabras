# 📊 Contador de Visitas - WordQuest Elite

## 🎯 Descripción

El contador de visitas es una funcionalidad que registra automáticamente cada vez que alguien abre la página web principal. Se incrementa en +1 cada visita y se almacena en un archivo de texto simple.

## 🔧 Componentes del Sistema

### 1. **Archivo PHP (`counter.php`)**
- **Función**: Maneja la lógica del contador
- **Métodos HTTP**:
  - `GET`: Incrementa el contador y retorna el nuevo valor
  - `POST`: Solo obtiene el contador actual (sin incrementar)
- **Archivo de almacenamiento**: `visit_counter.txt`

### 2. **Archivo de Texto (`visit_counter.txt`)**
- **Contenido**: Número entero que representa el total de visitas
- **Valor inicial**: 1000
- **Formato**: Texto plano, un número por línea

### 3. **Interfaz Visual (`index.html`)**
- **Ubicación**: Header principal, debajo de la descripción
- **Diseño**: Tarjeta con icono, texto y número
- **Animaciones**: Efectos de entrada y hover

## 🚀 Funcionamiento

### **Flujo de una Visita:**

1. **Usuario abre la página** → Se ejecuta `index.html`
2. **JavaScript detecta la carga** → Llama a `initializeVisitCounter()`
3. **Fetch a `counter.php`** → Método GET para incrementar
4. **PHP lee el archivo** → Obtiene el valor actual
5. **PHP incrementa +1** → Guarda el nuevo valor
6. **PHP retorna JSON** → Con el nuevo contador
7. **JavaScript actualiza UI** → Muestra el número con animación

### **Código JavaScript Clave:**

```javascript
async function initializeVisitCounter() {
    const response = await fetch('counter.php', {
        method: 'GET',
        headers: {
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache'
        }
    });
    
    if (response.ok) {
        const data = await response.json();
        // Actualizar UI con data.count
    }
}
```

## 📁 Estructura de Archivos

```
juegodepalabras/
├── index.html          # Página principal con contador
├── counter.php         # Lógica del contador
├── visit_counter.txt   # Almacenamiento del número
├── .htaccess          # Configuración del servidor
└── CONTADOR_VISITAS.md # Esta documentación
```

## ⚙️ Configuración del Servidor

### **Requisitos:**
- **Servidor web** con soporte PHP (Apache, Nginx, etc.)
- **PHP 7.0+** habilitado
- **Permisos de escritura** en el directorio para `visit_counter.txt`

### **Archivo .htaccess:**
- Configura tipos MIME para PHP
- Establece headers de seguridad
- Configura caché apropiado
- Previene caché del contador

## 🔒 Seguridad y Consideraciones

### **Protecciones Implementadas:**
- **Headers de seguridad** contra XSS y clickjacking
- **Validación de entrada** en PHP
- **Manejo de errores** robusto
- **Logs de consola** para debugging

### **Limitaciones:**
- **Contador local**: Solo cuenta visitas al servidor actual
- **Sin persistencia**: Se reinicia si se elimina el archivo
- **Sin autenticación**: Cualquier acceso incrementa el contador

## 🎨 Personalización

### **Cambiar Valor Inicial:**
```php
// En counter.php, línea 8
$defaultCount = 1000; // Cambiar por el valor deseado
```

### **Cambiar Estilos CSS:**
```css
/* En index.html, buscar .visit-counter */
.visit-counter {
    /* Modificar colores, tamaños, etc. */
}
```

### **Cambiar Texto:**
```html
<!-- En index.html, buscar el div visit-counter -->
<span class="counter-text">Visitas:</span> <!-- Cambiar texto -->
```

## 🐛 Solución de Problemas

### **Contador no se incrementa:**
1. Verificar permisos de escritura en `visit_counter.txt`
2. Comprobar que PHP esté habilitado en el servidor
3. Revisar logs de error del servidor

### **Error "Cargando...":**
1. Verificar que `counter.php` sea accesible
2. Comprobar la consola del navegador para errores
3. Verificar que el archivo `visit_counter.txt` exista

### **Contador muestra "Error":**
1. Verificar permisos del directorio
2. Comprobar sintaxis de `counter.php`
3. Revisar configuración del servidor web

## 📈 Estadísticas y Monitoreo

### **Información Disponible:**
- **Total de visitas** en tiempo real
- **Formato con separadores** de miles (1.000, 2.500, etc.)
- **Logs de consola** para debugging
- **Respuestas JSON** para integración con APIs

### **Monitoreo:**
- **Archivo de contador**: `visit_counter.txt`
- **Logs del servidor**: Errores de PHP y Apache/Nginx
- **Consola del navegador**: Errores de JavaScript y fetch

## 🔄 Mantenimiento

### **Backup del Contador:**
```bash
# Copiar el archivo de contador
cp visit_counter.txt visit_counter_backup.txt

# Restaurar si es necesario
cp visit_counter_backup.txt visit_counter.txt
```

### **Reiniciar Contador:**
```bash
# Establecer nuevo valor inicial
echo "1000" > visit_counter.txt
```

### **Verificar Funcionamiento:**
1. Abrir la página web
2. Verificar que el contador se incremente
3. Comprobar que `visit_counter.txt` se actualice
4. Revisar la consola del navegador

## 📞 Soporte

Para problemas o preguntas sobre el contador de visitas:
1. Revisar esta documentación
2. Verificar logs del servidor
3. Comprobar permisos de archivos
4. Revisar configuración PHP

---

**Desarrollado para WordQuest Elite** 🎮✨
**Versión**: 1.0.0
**Última actualización**: Diciembre 2024
