/**
 * ==============================================================================
 * GENERADOR AUTOMÁTICO DE GOOGLE FORMS: DIAGNÓSTICO DE RED TCP/IP Y SOCKETS (M4 - CLASE 1)
 * Asignatura: Laboratorio de Sistemas Operativos (LSO) — 4.º Año
 * Tecnicatura en Informática Personal y Profesional (Res. 3828/09)
 * ==============================================================================
 *
 * 🚀 INSTRUCCIONES DE USO (EN MENOS DE 1 MINUTO):
 * 1. Ingresá en tu navegador a: https://script.new (abre Google Apps Script).
 * 2. Borrá cualquier código y pegá este archivo completo.
 * 3. Guardá (ícono de disquete) y hacé clic en "Ejecutar" (Run).
 * 4. Autorizá el script (Revisar permisos -> tu cuenta -> Configuración avanzada -> Permitir).
 * 5. En el Registro de ejecución verás el enlace de edición y el enlace para los alumnos.
 * ==============================================================================
 */

function generarGoogleFormRedesClase1() {
  var titulo = "LSO 4.º Año — Evaluación Formativa: Diagnóstico de Red TCP/IP y Sockets en Windows 11";
  var form = FormApp.create(titulo);

  form.setDescription(
    "Laboratorio de Sistemas Operativos (LSO) — 4.º Año\n" +
    "Módulo 4: Redes, Recursos Compartidos y Seguridad — Clase 1\n\n" +
    "📌 Temas Evaluados: Direccionamiento IPv4 (loopback, APIPA, gateway), DNS, diagnóstico por capas (ping, tracert), TTL, sockets, puertos y asociación con procesos.\n" +
    "⏱️ Modalidad: Evaluación formativa de opción múltiple.\n" +
    "🎯 Puntaje Total: 100 puntos (10 preguntas de 10 puntos cada una)."
  );

  form.setIsQuiz(true);
  form.setCollectEmail(true);
  form.setAllowResponseEdits(false);
  form.setLimitOneResponsePerUser(false);

  form.addTextItem()
      .setTitle("Nombre y Apellido del Estudiante")
      .setHelpText("Ingresá tu nombre completo para el registro de calificaciones de la cátedra.")
      .setRequired(true);

  form.addTextItem()
      .setTitle("Terminal o Equipo N.º (Laboratorio)")
      .setHelpText("Indicá el número de la máquina asignada en el aula (ej: PC-04).")
      .setRequired(false);

  // Banco de preguntas con opciones de longitud homogénea y sin pistas por paréntesis
  var preguntas = [
  {
    "titulo": "¿Qué dirección IP identifica a la propia máquina para pruebas internas de loopback?",
    "puntos": 10,
    "feedback": "127.0.0.0/8 es el rango loopback: el tráfico no sale de la máquina y prueba la pila TCP/IP local.",
    "opciones": [
      {
        "texto": "127.0.0.1",
        "correcta": true
      },
      {
        "texto": "169.254.0.1",
        "correcta": false
      },
      {
        "texto": "192.168.0.1",
        "correcta": false
      },
      {
        "texto": "172.16.0.1",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "En la salida de netstat, ¿qué indica el estado LISTENING?",
    "puntos": 10,
    "feedback": "LISTENING indica que un proceso abrió un socket servidor esperando clientes.",
    "opciones": [
      {
        "texto": "El puerto se cerró y espera liberación del Kernel.",
        "correcta": false
      },
      {
        "texto": "La conexión fue bloqueada por reglas del firewall.",
        "correcta": false
      },
      {
        "texto": "Un proceso aguarda conexiones entrantes en el puerto.",
        "correcta": true
      },
      {
        "texto": "Existe una transferencia activa de datos en curso.",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "¿Qué función cumple la puerta de enlace predeterminada o gateway?",
    "puntos": 10,
    "feedback": "El gateway es el punto de salida: todo destino fuera de la red local se envía al router.",
    "opciones": [
      {
        "texto": "Encamina el tráfico dirigido hacia redes externas.",
        "correcta": true
      },
      {
        "texto": "Filtra y bloquea puertos inseguros en la red local.",
        "correcta": false
      },
      {
        "texto": "Asigna direcciones IP dinámicas a cada equipo.",
        "correcta": false
      },
      {
        "texto": "Traduce los nombres de dominio en direcciones IP.",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "Si el comando ping a 8.8.8.8 responde pero a google.com falla, ¿cuál es el problema?",
    "puntos": 10,
    "feedback": "La conectividad IP funciona (8.8.8.8 responde), pero falla la traducción de nombres a IP.",
    "opciones": [
      {
        "texto": "Desconexión física en el cable de red local.",
        "correcta": false
      },
      {
        "texto": "Caída total del router o puerta de enlace.",
        "correcta": false
      },
      {
        "texto": "Falla en el servicio de resolución DNS.",
        "correcta": true
      },
      {
        "texto": "Daño permanente en la placa de red local.",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "¿Qué cmdlet de PowerShell se utiliza para diagnosticar la conexión a un puerto TCP?",
    "puntos": 10,
    "feedback": "Test-NetConnection (con el parámetro -Port) prueba la apertura del socket TCP y devuelve TcpTestSucceeded.",
    "opciones": [
      {
        "texto": "Test-NetConnection",
        "correcta": true
      },
      {
        "texto": "Resolve-DnsName",
        "correcta": false
      },
      {
        "texto": "Test-Connection",
        "correcta": false
      },
      {
        "texto": "Get-NetTCPConnection",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "¿Para qué se utiliza principalmente el comando tracert?",
    "puntos": 10,
    "feedback": "tracert envía paquetes con TTL incremental para descubrir cada router del trayecto.",
    "opciones": [
      {
        "texto": "Identificar la ruta y saltos hacia un destino.",
        "correcta": true
      },
      {
        "texto": "Borrar los registros en la caché local de DNS.",
        "correcta": false
      },
      {
        "texto": "Listar los sockets y puertos activos del equipo.",
        "correcta": false
      },
      {
        "texto": "Renovar los datos de la concesión por DHCP.",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "¿Qué combinación de parámetros en netstat muestra sockets numéricos con su PID?",
    "puntos": 10,
    "feedback": "Los modificadores -a (todos los puertos), -n (formato numérico) y -o (incluye PID) asocian el socket al proceso.",
    "opciones": [
      {
        "texto": "netstat -efq",
        "correcta": false
      },
      {
        "texto": "netstat -bsp",
        "correcta": false
      },
      {
        "texto": "netstat -rnv",
        "correcta": false
      },
      {
        "texto": "netstat -ano",
        "correcta": true
      }
    ]
  },
  {
    "titulo": "¿Qué representa el campo TTL en la respuesta de un ping?",
    "puntos": 10,
    "feedback": "Cada router decrementa el TTL en 1; si llega a cero, el paquete se descarta evitando bucles.",
    "opciones": [
      {
        "texto": "Ancho de banda disponible en la placa de red de destino.",
        "correcta": false
      },
      {
        "texto": "Límite de saltos por routers antes de descartar el paquete.",
        "correcta": true
      },
      {
        "texto": "Tamaño del búfer de datos transmitido dentro del paquete.",
        "correcta": false
      },
      {
        "texto": "Tiempo total de respuesta del enlace medido en microsegundos.",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "¿Qué elementos identifican de forma única a un socket de red?",
    "puntos": 10,
    "feedback": "Un socket es la combinación de IP + puerto + protocolo (TCP o UDP).",
    "opciones": [
      {
        "texto": "Máscara de subred, puerta de enlace y DNS.",
        "correcta": false
      },
      {
        "texto": "Dirección física MAC y fabricante de placa.",
        "correcta": false
      },
      {
        "texto": "Dirección IP, número de puerto y protocolo.",
        "correcta": true
      },
      {
        "texto": "Nombre del host, grupo de trabajo y usuario.",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "Una PC tiene la IP 169.254.37.12 y no navega. ¿Qué indica esa dirección?",
    "puntos": 10,
    "feedback": "APIPA (169.254.0.0/16) se autoasigna cuando no hay respuesta de un servidor DHCP: síntoma de falla de red local.",
    "opciones": [
      {
        "texto": "Configuración manual de la interfaz de loopback.",
        "correcta": false
      },
      {
        "texto": "Falla de DHCP y autoasignación de una IP APIPA.",
        "correcta": true
      },
      {
        "texto": "Asignación pública directa a Internet por NAT.",
        "correcta": false
      },
      {
        "texto": "Dirección estática del servidor DNS de la red.",
        "correcta": false
      }
    ]
  }
];

  for (var i = 0; i < preguntas.length; i++) {
    var p = preguntas[i];
    var item = form.addMultipleChoiceItem();
    item.setTitle((i + 1) + ". " + p.titulo)
        .setPoints(p.puntos)
        .setRequired(true);

    var choices = [];
    for (var j = 0; j < p.opciones.length; j++) {
      choices.push(item.createChoice(p.opciones[j].texto, p.opciones[j].correcta));
    }
    item.setChoices(choices);

    if (p.feedback) {
      var feedbackObj = FormApp.createFeedback().setText(p.feedback).build();
      item.setFeedbackForCorrect(feedbackObj);
      item.setFeedbackForIncorrect(feedbackObj);
    }
  }

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
