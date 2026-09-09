/**
 * ==============================================================================
 * GENERADOR AUTOMÁTICO DE GOOGLE FORMS: ARQUITECTURA DE MEMORIA (CLASE 1)
 * Asignatura: Laboratorio de Sistemas Operativos (LSO) — 4.º Año
 * Tecnicatura en Informática Personal y Profesional (Res. 3828/09)
 * ==============================================================================
 * 
 * 🚀 INSTRUCCIONES DE USO (EN MENOS DE 1 MINUTO):
 * 1. Ingresá en tu navegador a: https://script.new (abre Google Apps Script).
 * 2. Borrá cualquier código que aparezca y pegá este archivo completo.
 * 3. Hacé clic en el botón "Guardar" (ícono de disquete) y luego en "Ejecutar" (Run).
 * 4. Google te pedirá autorizar el script (hacé clic en "Revisar permisos" -> Elegí tu cuenta
 *    -> "Configuración avanzada" -> "Ir a Proyecto sin título (no seguro)" -> "Permitir").
 * 5. ¡Listo! En el panel inferior (Registro de ejecución) verás el enlace de edición
 *    y el enlace directo para enviar a tus alumnos. El formulario ya estará creado en tu Google Drive.
 * ==============================================================================
 */

function generarGoogleFormMemoriaClase1() {
  // 1. Crear el formulario con título y metadatos
  var titulo = "LSO 4.º Año — Evaluación Formativa: Arquitectura de Memoria y VAS en Windows 11";
  var form = FormApp.create(titulo);
  
  form.setDescription(
    "Laboratorio de Sistemas Operativos (LSO) — 4.º Año\n" +
    "Módulo 3: Arquitectura y Administración de Memoria — Clase 1\n\n" +
    "📌 Temas Evaluados: Jerarquía de memoria, rol de la MMU, Espacio de Direcciones Virtuales (VAS de 32 vs 64 bits) y anillos de protección (Ring 3 vs Ring 0).\n" +
    "⏱️ Modalidad: Evaluación diagnóstica de opción múltiple.\n" +
    "🎯 Puntaje Total: 100 puntos (10 preguntas de 10 puntos cada una)."
  );

  // 2. Configurar como Cuestionario (Quiz autocalificable)
  form.setIsQuiz(true);
  form.setCollectEmail(true);
  form.setAllowResponseEdits(false);
  form.setLimitOneResponsePerUser(false); // Cambiar a true si el colegio usa Google Workspace

  // 3. Campo de Identificación del Estudiante
  form.addTextItem()
      .setTitle("Nombre y Apellido del Estudiante")
      .setHelpText("Ingresá tu nombre completo para el registro de calificaciones de la cátedra.")
      .setRequired(true);

  form.addTextItem()
      .setTitle("Terminal o Equipo N.º (Laboratorio)")
      .setHelpText("Indicá el número de la máquina asignada en el aula (ej: PC-04).")
      .setRequired(false);

  // 4. Banco de Preguntas Mezcladas (Exacto a cuestionario_google_forms_clase1.md)
  var preguntas = [
    {
      titulo: "¿Cuál es la función principal de la Unidad de Manejo de Memoria (MMU) integrada en el microprocesador?",
      puntos: 10,
      feedback: "La MMU traduce en hardware las direcciones lógicas a direcciones físicas de memoria RAM en tiempo real.",
      opciones: [
        { texto: "Aumentar la velocidad del cooler si la RAM se calienta.", correcta: false },
        { texto: "Desfragmentar discos mecánicos en segundo plano.", correcta: false },
        { texto: "Generar claves de cifrado BitLocker del disco del sistema.", correcta: false },
        { texto: "Traducir direcciones virtuales a direcciones físicas de RAM en tiempo real.", correcta: true }
      ]
    },
    {
      titulo: "En Windows 11 (64 bits), ¿cuánto espacio de memoria virtual privada tiene cada proceso de usuario?",
      puntos: 10,
      feedback: "Windows 11 de 64 bits asigna un espacio virtual masivo de 128 Terabytes para cada proceso en modo usuario.",
      opciones: [
        { texto: "16 Megabytes.", correcta: false },
        { texto: "2 Gigabytes.", correcta: false },
        { texto: "128 Terabytes.", correcta: true },
        { texto: "Exactamente la cantidad de RAM física instalada.", correcta: false }
      ]
    },
    {
      titulo: "¿Qué ocurre si un programa en Ring 3 intenta escribir en una dirección del Kernel (Ring 0)?",
      puntos: 10,
      feedback: "El CPU detecta la discrepancia de privilegios, dispara una Violación de Acceso (Access Violation) y Windows finaliza el proceso.",
      opciones: [
        { texto: "Windows se congela y formatea el disco rígido.", correcta: false },
        { texto: "El CPU dispara una Violación de Acceso y Windows cierra el proceso.", correcta: true },
        { texto: "La memoria RAM duplica su voltaje automáticamente.", correcta: false },
        { texto: "Se permite si el usuario tiene sesión de Administrador.", correcta: false }
      ]
    },
    {
      titulo: "¿Cuál es el límite máximo de memoria que puede direccionar un proceso de 32 bits en su VAS?",
      puntos: 10,
      feedback: "Un puntero de 32 bits permite 2^32 combinaciones posibles, limitando el espacio virtual a exactamente 4 Gigabytes.",
      opciones: [
        { texto: "128 Terabytes.", correcta: false },
        { texto: "640 Kilobytes.", correcta: false },
        { texto: "No tiene límite, depende de la RAM física instalada.", correcta: false },
        { texto: "4 Gigabytes (2^32 bytes).", correcta: true }
      ]
    },
    {
      titulo: "¿En qué nivel de privilegio del CPU se ejecutan las aplicaciones de usuario como Chrome o Word?",
      puntos: 10,
      feedback: "Las aplicaciones de usuario corren en Ring 3 (Modo Usuario) para aislar el hardware y la estabilidad del sistema.",
      opciones: [
        { texto: "Ring 3 (Modo Usuario / User Mode).", correcta: true },
        { texto: "Ring 7 (Modo Gráfico).", correcta: false },
        { texto: "Ring 0 (Modo Núcleo / Kernel Mode).", correcta: false },
        { texto: "Ring -1 (Modo BIOS).", correcta: false }
      ]
    },
    {
      titulo: "En el Administrador de Tareas, ¿dónde se ve si un proceso es de 32 bits o de 64 bits?",
      puntos: 10,
      feedback: "En la pestaña Detalles, la columna Plataforma indica explícitamente si el ejecutable corre en 32 o 64 bits.",
      opciones: [
        { texto: "En Historial de aplicaciones, ordenando por consumo de red.", correcta: false },
        { texto: "En el panel de configuración de pantalla de Windows.", correcta: false },
        { texto: "En la pestaña Inicio, clic derecho en el antivirus.", correcta: false },
        { texto: "En la pestaña Detalles, habilitando la columna Plataforma.", correcta: true }
      ]
    },
    {
      titulo: "¿Cuál era el gran defecto del direccionamiento de Memoria Real en sistemas como MS-DOS?",
      puntos: 10,
      feedback: "Al compartir el espacio físico sin aislamiento de memoria, un error en un puntero corrompía el Kernel de MS-DOS.",
      opciones: [
        { texto: "Los programas tardaban días en encender el monitor.", correcta: false },
        { texto: "Un error de puntero podía sobrescribir el Kernel por falta de protección.", correcta: true },
        { texto: "Windows borraba archivos si se abrían dos ventanas.", correcta: false },
        { texto: "No se podían usar teclados ni ratones.", correcta: false }
      ]
    },
    {
      titulo: "¿Por qué las PCs no usan solo Caché L1 si es miles de veces más rápida que la RAM?",
      puntos: 10,
      feedback: "La memoria SRAM estática de la caché es sumamente costosa de fabricar dentro del silicio del CPU y disipa mucho calor.",
      opciones: [
        { texto: "Porque la memoria caché es incompatible con Windows 11.", correcta: false },
        { texto: "Porque el bus al disco no soporta más de 128 MB.", correcta: false },
        { texto: "Los chips SRAM son muy costosos de fabricar y disipan mucho calor.", correcta: true },
        { texto: "Porque la caché solo almacena letras, no binarios.", correcta: false }
      ]
    },
    {
      titulo: "¿Cuál componente de la jerarquía de memoria tiene el menor tiempo de acceso (menor latencia)?",
      puntos: 10,
      feedback: "Los registros internos del CPU operan a la misma frecuencia del núcleo con latencias inferiores a 1 nanosegundo (< 1 ns).",
      opciones: [
        { texto: "Registros internos del procesador (CPU).", correcta: true },
        { texto: "Unidad de estado sólido SSD NVMe.", correcta: false },
        { texto: "Memoria RAM DDR4 o DDR5.", correcta: false },
        { texto: "Memoria Caché de tercer nivel (L3).", correcta: false }
      ]
    },
    {
      titulo: "Si dos programas usan la misma dirección virtual 0x00400000, ¿por qué no colisionan sus datos?",
      puntos: 10,
      feedback: "Cada proceso tiene su propio espacio virtual privado (VAS) y la MMU asigna esa dirección a marcos de RAM física completamente distintos.",
      opciones: [
        { texto: "El CPU mezcla los datos y los separa por contraseñas.", correcta: false },
        { texto: "Windows solo permite un programa abierto en RAM a la vez.", correcta: false },
        { texto: "Tienen VAS privado y la MMU asigna marcos de RAM física distintos.", correcta: true },
        { texto: "Un programa va al disco rígido y el otro a la caché L1.", correcta: false }
      ]
    }
  ];

  // 5. Inserción de preguntas, puntajes y retroalimentación automática
  for (var i = 0; i < preguntas.length; i++) {
    var p = preguntas[i];
    var item = form.addMultipleChoiceItem();
    
    item.setTitle((i + 1) + ". " + p.titulo)
        .setPoints(p.puntos)
        .setRequired(true);

    var choices = [];
    for (var j = 0; j < p.opciones.length; j++) {
      var op = p.opciones[j];
      choices.push(item.createChoice(op.texto, op.correcta));
    }
    item.setChoices(choices);

    // Retroalimentación formativa automática (al ver la nota)
    var feedbackCorrecto = FormApp.createFeedback()
      .setText("✅ ¡Respuesta Correcta! " + p.feedback)
      .build();

    var feedbackIncorrecto = FormApp.createFeedback()
      .setText("❌ Respuesta Incorrecta. Fundamentación: " + p.feedback)
      .build();

    item.setFeedbackForCorrect(feedbackCorrecto);
    item.setFeedbackForIncorrect(feedbackIncorrecto);
  }

  // 6. Mensajes de confirmación y enlaces resultantes
  Logger.log("==================================================================");
  Logger.log("✅ ¡FORMULARIO CREADO CON ÉXITO EN TU GOOGLE DRIVE!");
  Logger.log("==================================================================");
  Logger.log("🔗 URL PARA EDITAR (Docente):");
  Logger.log(form.getEditUrl());
  Logger.log("------------------------------------------------------------------");
  Logger.log("🌐 URL PARA RESPONDER (Alumnos / Classroom):");
  Logger.log(form.getPublishedUrl());
  Logger.log("==================================================================");
}
