<?php
// Contador de visitas para WordQuest Elite
// Archivo: counter.php

// Configuración
$counterFile = 'visit_counter.txt';
$defaultCount = 1000; // Contador inicial

// Función para obtener el contador actual
function getCurrentCount($filename) {
    if (file_exists($filename)) {
        $count = file_get_contents($filename);
        return is_numeric($count) ? (int)$count : 0;
    }
    return 0;
}

// Función para incrementar el contador
function incrementCounter($filename) {
    $currentCount = getCurrentCount($filename);
    $newCount = $currentCount + 1;
    
    // Guardar el nuevo valor
    if (file_put_contents($filename, $newCount) !== false) {
        return $newCount;
    }
    return $currentCount; // Retornar el valor anterior si falla
}

// Función para inicializar el contador si no existe
function initializeCounter($filename, $defaultValue) {
    if (!file_exists($filename)) {
        file_put_contents($filename, $defaultValue);
        return $defaultValue;
    }
    return getCurrentCount($filename);
}

// Función para formatear el número con separadores de miles
function formatNumber($number) {
    return number_format($number, 0, ',', '.');
}

// Manejar la solicitud
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Inicializar contador si no existe
    initializeCounter($counterFile, $defaultCount);
    
    // Incrementar contador
    $newCount = incrementCounter($counterFile);
    
    // Configurar headers para evitar caché
    header('Content-Type: application/json');
    header('Cache-Control: no-cache, no-store, must-revalidate');
    header('Pragma: no-cache');
    header('Expires: 0');
    
    // Retornar respuesta JSON
    echo json_encode([
        'success' => true,
        'count' => $newCount,
        'formatted' => formatNumber($newCount),
        'message' => 'Contador incrementado exitosamente'
    ]);
    
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Endpoint para obtener solo el contador (sin incrementar)
    $currentCount = getCurrentCount($counterFile);
    
    header('Content-Type: application/json');
    header('Cache-Control: no-cache, no-store, must-revalidate');
    
    echo json_encode([
        'success' => true,
        'count' => $currentCount,
        'formatted' => formatNumber($currentCount),
        'message' => 'Contador obtenido exitosamente'
    ]);
    
} else {
    // Método no permitido
    header('HTTP/1.1 405 Method Not Allowed');
    header('Content-Type: application/json');
    
    echo json_encode([
        'success' => false,
        'error' => 'Método no permitido',
        'message' => 'Solo se permiten solicitudes GET y POST'
    ]);
}
?>
