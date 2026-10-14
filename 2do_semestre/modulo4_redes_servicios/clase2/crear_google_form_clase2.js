/**
 * ==============================================================================
 * GENERADOR AUTOMÁTICO DE GOOGLE FORMS: PERFILES DE RED Y FIREWALL (M4 - CLASE 2)
 * Asignatura: Laboratorio de Sistemas Operativos (LSO) — 4.º Año
 * Tecnicatura en Informática Personal y Profesional (Res. 3828/09)
 * ==============================================================================
 *
 * 🚀 INSTRUCCIONES DE USO:
 * 1. Ingresá en tu navegador a: https://script.new (abre Google Apps Script).
 * 2. Borrá cualquier código y pegá este archivo completo.
 * 3. Guardá (ícono de disquete) y hacé clic en "Ejecutar" (Run).
 * 4. Autorizá el script (Revisar permisos -> tu cuenta -> Avanzado -> Permitir).
 * 5. En el Registro de ejecución verás el enlace de edición y el enlace para los alumnos.
 * ==============================================================================
 */

function generarGoogleFormFirewallClase2() {
  var titulo = "LSO 4.º Año — Evaluación Formativa: Perfiles de Red y Windows Defender Firewall";
  var form = FormApp.create(titulo);

  form.setDescription(
    "Laboratorio de Sistemas Operativos (LSO) — 4.º Año\n" +
    "Módulo 4: Redes, Recursos Compartidos y Seguridad — Clase 2\n\n" +
    "📌 Temas Evaluados: Perfiles de red (Público, Privado, Dominio), políticas de filtrado Inbound y Outbound, inspección con estado (Stateful), bloqueo ICMP (ping), auditoría con PowerShell y seguridad ante WannaCry.\n" +
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

  var preguntas = [
    {
      "titulo": "¿Qué perfil de red debe activarse al conectarse al Wi-Fi de un aeropuerto o bar?",
      "puntos": 10,
      "feedback": "El perfil público aplica máxima restricción, oculta el equipo ante otros dispositivos y desactiva el uso compartido de archivos.",
      "opciones": [
        { "texto": "Perfil Privado", "correcta": false },
        { "texto": "Perfil Público", "correcta": true },
        { "texto": "Perfil de Dominio", "correcta": false },
        { "texto": "Perfil de Invitado", "correcta": false }
      ]
    },
    {
      "titulo": "¿Cuál es la acción predeterminada del Firewall para el tráfico Inbound en Windows?",
      "puntos": 10,
      "feedback": "Por defecto, cualquier conexión entrante que no cuente con una regla explícita de permiso es bloqueada silenciosamente.",
      "opciones": [
        { "texto": "Permitir todo el tráfico", "correcta": false },
        { "texto": "Redirigir hacia el router", "correcta": false },
        { "texto": "Bloquear las conexiones", "correcta": true },
        { "texto": "Cifrar los paquetes de red", "correcta": false }
      ]
    },
    {
      "titulo": "¿Qué característica permite recibir respuestas web si el tráfico Inbound está bloqueado?",
      "puntos": 10,
      "feedback": "Un firewall con estado reconoce que el paquete entrante es la respuesta directa a una conexión iniciada desde adentro.",
      "opciones": [
        { "texto": "La inspección con estado", "correcta": true },
        { "texto": "El uso de direcciones APIPA", "correcta": false },
        { "texto": "El aislamiento de procesos", "correcta": false },
        { "texto": "La traducción de nombres DNS", "correcta": false }
      ]
    },
    {
      "titulo": "¿Qué cmdlet de PowerShell muestra si la red actual está configurada como pública o privada?",
      "puntos": 10,
      "feedback": "Get-NetConnectionProfile informa la categoría de red (NetworkCategory), el nombre y la placa asociada.",
      "opciones": [
        { "texto": "Get-NetIPAddress", "correcta": false },
        { "texto": "Get-NetConnectionProfile", "correcta": true },
        { "texto": "Get-NetFirewallRule", "correcta": false },
        { "texto": "Test-NetConnection", "correcta": false }
      ]
    },
    {
      "titulo": "En el laboratorio dos PC tienen red, pero el comando ping entre ellas falla. ¿Por qué ocurre?",
      "puntos": 10,
      "feedback": "Windows Defender Firewall bloquea por defecto los paquetes ICMPv4 (solicitud de eco) para evitar escaneos de red.",
      "opciones": [
        { "texto": "El cable de red del switch se encuentra averiado", "correcta": false },
        { "texto": "El servidor DHCP asignó direcciones repetidas", "correcta": false },
        { "texto": "El Firewall bloquea los paquetes ICMP por defecto", "correcta": true },
        { "texto": "La puerta de enlace predeterminada está apagada", "correcta": false }
      ]
    },
    {
      "titulo": "¿Qué comando de PowerShell evalúa si un puerto TCP específico responde en un equipo?",
      "puntos": 10,
      "feedback": "Test-NetConnection con el parámetro -Port prueba el saludo de tres vías TCP y valida si el puerto está abierto.",
      "opciones": [
        { "texto": "Resolve-DnsName", "correcta": false },
        { "texto": "Clear-DnsClientCache", "correcta": false },
        { "texto": "Get-Process", "correcta": false },
        { "texto": "Test-NetConnection", "correcta": true }
      ]
    },
    {
      "titulo": "¿Qué diferencia principal existe entre el Perfil Privado y el Perfil Público?",
      "puntos": 10,
      "feedback": "El perfil privado habilita la detección de dispositivos y el intercambio de archivos e impresoras en la red local.",
      "opciones": [
        { "texto": "El privado deshabilita la placa de red física", "correcta": false },
        { "texto": "El privado permite compartir recursos en red", "correcta": true },
        { "texto": "El público apaga el acceso hacia sitios de Internet", "correcta": false },
        { "texto": "El público asigna direcciones de enlace local", "correcta": false }
      ]
    },
    {
      "titulo": "Un programa abre el puerto 8080 en la PC. ¿Qué componente decide si otra máquina entra?",
      "puntos": 10,
      "feedback": "El firewall inspecciona los paquetes en el kernel y los filtra antes de que alcancen el socket del proceso.",
      "opciones": [
        { "texto": "El Administrador de Tareas", "correcta": false },
        { "texto": "El registro de Windows", "correcta": false },
        { "texto": "El Windows Defender Firewall", "correcta": true },
        { "texto": "El controlador de video", "correcta": false }
      ]
    },
    {
      "titulo": "¿Por qué el ataque masivo de WannaCry aprovechaba el puerto SMB 445?",
      "puntos": 10,
      "feedback": "Explotaba una vulnerabilidad remota en el protocolo SMB de carpetas compartidas para infectar sin intervención del usuario.",
      "opciones": [
        { "texto": "Para alterar los servidores de nombres DNS", "correcta": false },
        { "texto": "Para saturar la memoria caché del navegador", "correcta": false },
        { "texto": "Para propagarse a través de carpetas de red", "correcta": true },
        { "texto": "Para cambiar la dirección MAC de las placas", "correcta": false }
      ]
    },
    {
      "titulo": "Si un técnico necesita auditar las políticas activas de cada perfil, ¿qué comando utiliza?",
      "puntos": 10,
      "feedback": "Get-NetFirewallProfile informa el estado y la acción predeterminada para Inbound y Outbound de cada perfil.",
      "opciones": [
        { "texto": "Get-NetFirewallProfile", "correcta": true },
        { "texto": "Format-Volume", "correcta": false },
        { "texto": "Stop-Computer", "correcta": false },
        { "texto": "Restart-Service", "correcta": false }
      ]
    }
  ];

  for (var i = 0; i < preguntas.length; i++) {
    var p = preguntas[i];
    var item = form.addMultipleChoiceItem();
    item.setTitle((i + 1) + ". " + p.titulo)
        .setPoints(p.puntos);

    var choices = [];
    for (var j = 0; j < p.opciones.length; j++) {
      var op = p.opciones[j];
      choices.push(item.createChoice(op.texto, op.correcta));
    }
    item.setChoices(choices);

    var feedback = FormApp.createFeedback()
        .setText(p.feedback)
        .build();
    item.setFeedbackForCorrect(feedback);
    item.setFeedbackForIncorrect(feedback);
  }

  Logger.log("==================================================================");
  Logger.log("✅ ¡FORMULARIO CREADO CON ÉXITO!");
  Logger.log("📝 Enlace para editar / gestionar respuestas:");
  Logger.log(form.getEditUrl());
  Logger.log("🔗 Enlace para compartir con los estudiantes:");
  Logger.log(form.getPublishedUrl());
  Logger.log("==================================================================");
}
