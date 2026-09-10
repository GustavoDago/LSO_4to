/**
 * ==============================================================================
 * GENERADOR AUTOMÁTICO DE GOOGLE FORMS: PAGINACIÓN Y POOLS DE MEMORIA (CLASE 2)
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

function generarGoogleFormMemoriaClase2() {
  // 1. Crear el formulario con título y metadatos
  var titulo = "LSO 4.º Año — Evaluación Formativa: Paginación, Hard Faults y Pools de Kernel en Windows 11";
  var form = FormApp.create(titulo);
  
  form.setDescription(
    "Laboratorio de Sistemas Operativos (LSO) — 4.º Año\n" +
    "Módulo 3: Arquitectura y Administración de Memoria — Clase 2\n\n" +
    "📌 Temas Evaluados: Mecanismo de paginación (4 KB), Soft vs Hard Page Faults, rol de pagefile.sys, lista En Espera (Standby), límite de memoria confirmada (Commit Charge) y división entre Paged Pool y Non-Paged Pool en Modo Kernel.\n" +
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

  // 4. Banco de Preguntas Mezcladas (Exacto a cuestionario_google_forms_clase2.md)
  var preguntas = [
    {
      titulo: "¿Qué sucede en el sistema operativo durante un Fallo de Página Suave (Soft Page Fault)?",
      puntos: 10,
      feedback: "En un Soft Fault la página requerida ya se encuentra cargada físicamente en la memoria RAM (en caché o lista Standby); el Kernel únicamente debe enlazar la entrada en la tabla de páginas del proceso sin demoras de I/O.",
      opciones: [
        { texto: "El microprocesador sufre un error de hardware irreparable y reinicia la PC.", correcta: false },
        { texto: "Se reinicia el servicio de Windows Update en segundo plano.", correcta: false },
        { texto: "La página ya está en la memoria RAM (en caché/Standby) y el Kernel solo actualiza la tabla de páginas.", correcta: true },
        { texto: "Se lee el archivo pagefile.sys desde el almacenamiento secundario.", correcta: false }
      ]
    },
    {
      titulo: "¿Cuál es el tamaño estándar de una página virtual y de un marco físico en sistemas x86 y x64 de Windows?",
      puntos: 10,
      feedback: "El Administrador de Memoria de Windows organiza la memoria en bloques estándar de 4 KB (4096 bytes), tanto a nivel de página lógica como de marco físico en RAM.",
      opciones: [
        { texto: "4 Kilobytes (4096 bytes).", correcta: true },
        { texto: "64 Kilobytes.", correcta: false },
        { texto: "1 Megabyte.", correcta: false },
        { texto: "512 Bytes.", correcta: false }
      ]
    },
    {
      titulo: "¿Por qué es un grave error técnico desactivar por completo el archivo de paginación (pagefile.sys) aunque la máquina tenga mucha RAM?",
      puntos: 10,
      feedback: "Sin pagefile.sys, Windows no puede garantizar el Commit Limit cuando los programas reservan memoria virtual, lo que provoca cierres forzados por 'memoria insuficiente' e impide generar volcados Crash Dump ante fallos de pantalla azul.",
      opciones: [
        { texto: "La velocidad de descarga de la conexión de red se limitará a 1 Mbps.", correcta: false },
        { texto: "El microprocesador pierde la capacidad de ejecutar instrucciones de 64 bits.", correcta: false },
        { texto: "La memoria RAM física aumentará su temperatura hasta quemar los circuitos.", correcta: false },
        { texto: "Windows no podrá garantizar el límite de memoria confirmada (Commit Charge), causando cierres inesperados de aplicaciones y bloqueando los volcados de memoria (Crash Dumps).", correcta: true }
      ]
    },
    {
      titulo: "¿Por qué un Fallo de Página Duro (Hard Page Fault) provoca congelamientos o lentitud perceptible para el usuario?",
      puntos: 10,
      feedback: "Al no estar los datos en RAM, el hilo se suspende a la espera de una lectura de disco (I/O) en milisegundos, miles de veces más lenta que la velocidad de la RAM en nanosegundos.",
      opciones: [
        { texto: "Porque el procesador debe suspender el hilo y realizar una operación lenta de lectura al disco para traer los 4 KB a RAM.", correcta: true },
        { texto: "Porque el monitor reduce automáticamente su tasa de refresco a 30 Hz.", correcta: false },
        { texto: "Porque borra la memoria caché L1 para permitir que el disipador se enfríe.", correcta: false },
        { texto: "Porque desconecta la placa madre de la fuente de poder por microsegundos.", correcta: false }
      ]
    },
    {
      titulo: "En el Monitor de Recursos (resmon.exe), ¿qué función cumple la memoria física en estado 'En espera' (Standby)?",
      puntos: 10,
      feedback: "La memoria en espera es memoria útil: mantiene en RAM copias de programas y archivos usados para reaperturas ultrarrápidas, pero cede su lugar inmediatamente si otra aplicación pide memoria.",
      opciones: [
        { texto: "Es memoria defectuosa que Windows aisló para que ningún programa la utilice.", correcta: false },
        { texto: "Es memoria asignada de forma exclusiva a la BIOS/UEFI de la placa madre.", correcta: false },
        { texto: "Es una caché activa de datos y programas usados recientemente que aceleran el sistema y están disponibles de inmediato si otra app los necesita.", correcta: true },
        { texto: "Es memoria que ha sido consumida por software espía y no puede ser recuperada.", correcta: false }
      ]
    },
    {
      titulo: "¿Qué tipo de información traslada el Administrador de Memoria de Windows hacia el archivo pagefile.sys?",
      puntos: 10,
      feedback: "Al archivo pagefile.sys solo se traslada memoria privada anónima modificada. El código ejecutable (.exe, .dll) inalterado se descarta de RAM y se recarga directamente desde su archivo ejecutable en disco.",
      opciones: [
        { texto: "Archivos ejecutables .exe y librerías .dll inalterados.", correcta: false },
        { texto: "Exclusivamente páginas de memoria privada y modificada (anónima) creadas por procesos en ejecución que no tienen un archivo original en disco.", correcta: true },
        { texto: "Las fotos, videos y documentos personales de la carpeta del usuario.", correcta: false },
        { texto: "El código de inicio rápido de la BIOS/UEFI guardado en el motherboard.", correcta: false }
      ]
    },
    {
      titulo: "¿A qué equivale el Límite de Compromiso (Commit Limit) que reporta Windows en el Administrador de Tareas?",
      puntos: 10,
      feedback: "El Commit Limit representa la cantidad máxima de memoria virtual que el Kernel puede respaldar: equivale a la memoria RAM física más el tamaño actual del archivo pagefile.sys.",
      opciones: [
        { texto: "Al tamaño de almacenamiento total disponible en la unidad C:.", correcta: false },
        { texto: "Al tamaño de la memoria caché de tercer nivel (L3) del procesador.", correcta: false },
        { texto: "A la cantidad de memoria consumida exclusivamente por los programas de 32 bits.", correcta: false },
        { texto: "A la suma de la memoria RAM física instalada más el tamaño actual del archivo de intercambio pagefile.sys.", correcta: true }
      ]
    },
    {
      titulo: "¿Cuál es la regla operativa fundamental del Grupo No Paginado (Non-Paged Pool) del Kernel?",
      puntos: 10,
      feedback: "El Non-Paged Pool contiene estructuras esenciales del Kernel y buffers de hardware que deben permanecer siempre en RAM física para evitar caídas del sistema por bloqueos de paginación.",
      opciones: [
        { texto: "Reside de forma garantizada y permanente en la memoria RAM física; jamás puede ser trasladado al disco.", correcta: true },
        { texto: "Se comprime y se transfiere automáticamente a una memoria USB si la RAM se llena.", correcta: false },
        { texto: "Se vacía y resetea automáticamente cada 10 minutos para ahorrar batería.", correcta: false },
        { texto: "Es un área compartida accesible libremente por cualquier ejecutable en Modo Usuario (Ring 3).", correcta: false }
      ]
    },
    {
      titulo: "¿Por qué las rutinas de atención de interrupciones del hardware (ISRs) deben residir obligatoriamente en memoria Non-Paged?",
      puntos: 10,
      feedback: "Si una rutina de interrupción de alta prioridad sufriera un fallo de página, la CPU entraría en interbloqueo esperando la respuesta del subsistema de disco, causando una pantalla azul (BSOD).",
      opciones: [
        { texto: "Porque los controladores de red y teclado no están escritos en código binario.", correcta: false },
        { texto: "Para evitar que la CPU sufra un fallo de página hacia el disco en medio de una interrupción crítica, lo que causaría un interbloqueo (deadlock) y colapso del sistema.", correcta: true },
        { texto: "Para aumentar la sensibilidad y aceleración del puntero del mouse.", correcta: false },
        { texto: "Para permitir que el Firewall de Windows filtre paquetes sin consumir ciclos de CPU.", correcta: false }
      ]
    },
    {
      titulo: "Si en el Administrador de Tareas observás que el Grupo No Paginado creció hasta 6 GB en una PC de 8 GB de RAM causando lentitud extrema, ¿cuál es el diagnóstico técnico?",
      puntos: 10,
      feedback: "Un desborde anómalo del Non-Paged Pool evidencia una fuga de memoria (leak) en un driver en Ring 0 que solicita recursos al Kernel y olvida liberarlos, agotando la RAM física sin poder ser paginado.",
      opciones: [
        { texto: "Hay un archivo de texto de Word demasiado grande abierto en el escritorio.", correcta: false },
        { texto: "Una fuga de memoria (memory leak) en un controlador de dispositivo (driver) en Modo Kernel (Ring 0) que reserva páginas y nunca las libera.", correcta: true },
        { texto: "El disco rígido fue formateado incorrectamente con el sistema FAT32.", correcta: false },
        { texto: "La resolución de la pantalla fue configurada en una escala superior al 100%.", correcta: false }
      ]
    }
  ];

  // 5. Cargar las preguntas en el Formulario
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

    // Configurar retroalimentación pedagógica para respuestas correctas e incorrectas
    if (p.feedback) {
      var feedbackObj = FormApp.createFeedback()
          .setText(p.feedback)
          .build();
      item.setFeedbackForCorrect(feedbackObj);
      item.setFeedbackForIncorrect(feedbackObj);
    }
  }

  // 6. Mensaje final en consola con los links de acceso
  Logger.log("==============================================================================");
  Logger.log("✅ ¡FORMULARIO DE EVALUACIÓN CREADO EXITOSAMENTE!");
  Logger.log("==============================================================================");
  Logger.log("📝 Enlace para que el DOCENTE edite el cuestionario:");
  Logger.log(form.getEditUrl());
  Logger.log("------------------------------------------------------------------------------");
  Logger.log("🚀 Enlace directo para COMPARTIR con los ALUMNOS (Classroom / Chat):");
  Logger.log(form.getPublishedUrl());
  Logger.log("==============================================================================");
}
