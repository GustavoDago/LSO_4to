/**
 * ==============================================================================
 * GENERADOR AUTOMÁTICO DE GOOGLE FORMS: EL PORTERO Y SU LISTA - REGLAS DEL FIREWALL (M4 - CLASE 3)
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

function generarGoogleFormReglasClase3() {
  var form = FormApp.create("LSO 4.º Año — Evaluación Formativa: El Portero y su Lista (Reglas del Firewall)");

  form.setDescription(
    "Laboratorio de Sistemas Operativos (LSO) — 4.º Año\n" +
    "Módulo 4: Redes, Recursos Compartidos y Seguridad — Clase 3\n\n" +
    "📌 Temas: qué es una regla, entrada y salida, las 5 preguntas de una regla, gana el NO (Block > Allow), LocalSubnet, filtrar por programa y abrir lo justo.\n" +
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
    "titulo": "En nuestra analogía, ¿qué es una regla del firewall?",
    "puntos": 10,
    "feedback": "Cada regla es una instrucción de la lista que el firewall consulta para decidir.",
    "opciones": [
      {
        "texto": "El timbre de un departamento",
        "correcta": false
      },
      {
        "texto": "Un renglón de la lista del portero",
        "correcta": true
      },
      {
        "texto": "La dirección del edificio",
        "correcta": false
      },
      {
        "texto": "El vecino que atiende la puerta",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "Por defecto, ¿qué hace Windows con una conexión que ENTRA y no tiene ninguna regla?",
    "puntos": 10,
    "feedback": "La entrada sin regla se descarta en silencio: si nadie avisó, no entra.",
    "opciones": [
      {
        "texto": "La deja pasar sin revisar",
        "correcta": false
      },
      {
        "texto": "Le pregunta al usuario qué hacer",
        "correcta": false
      },
      {
        "texto": "La bloquea sin avisar",
        "correcta": true
      },
      {
        "texto": "La guarda para revisarla después",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "¿Qué significa que una regla sea Inbound?",
    "puntos": 10,
    "feedback": "Inbound es entrada: otra PC intenta conectarse a la nuestra.",
    "opciones": [
      {
        "texto": "Que controla lo que entra a mi PC",
        "correcta": true
      },
      {
        "texto": "Que controla lo que sale de mi PC",
        "correcta": false
      },
      {
        "texto": "Que funciona solo dentro del aula",
        "correcta": false
      },
      {
        "texto": "Que está desactivada por ahora",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "Si una regla no dice desde qué IP se puede entrar, ¿a quién se le aplica?",
    "puntos": 10,
    "feedback": "Lo que no se escribe vale cualquiera, por eso una regla corta es muy abierta.",
    "opciones": [
      {
        "texto": "Solo a las PC del aula",
        "correcta": false
      },
      {
        "texto": "Solo a mi propia PC",
        "correcta": false
      },
      {
        "texto": "A nadie, queda anulada",
        "correcta": false
      },
      {
        "texto": "A cualquier PC del mundo",
        "correcta": true
      }
    ]
  },
  {
    "titulo": "Una regla Allow y una regla Block coinciden con la misma conexión. ¿Qué pasa?",
    "puntos": 10,
    "feedback": "Block gana siempre, igual que Denegar sobre Permitir en los permisos NTFS.",
    "opciones": [
      {
        "texto": "Pasa, porque Allow es primero",
        "correcta": false
      },
      {
        "texto": "No pasa, porque gana Block",
        "correcta": true
      },
      {
        "texto": "Gana la regla más nueva",
        "correcta": false
      },
      {
        "texto": "Windows apaga el firewall",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "Quiero que solo las PC del aula entren a mi servidor. ¿Qué pongo en la IP remota?",
    "puntos": 10,
    "feedback": "LocalSubnet significa las PC de mi red local, y Windows la calcula solo.",
    "opciones": [
      {
        "texto": "Any",
        "correcta": false
      },
      {
        "texto": "127.0.0.1",
        "correcta": false
      },
      {
        "texto": "LocalSubnet",
        "correcta": true
      },
      {
        "texto": "Inbound",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "¿Qué comando de PowerShell crea una regla nueva de firewall?",
    "puntos": 10,
    "feedback": "New significa nuevo: crea la regla con las respuestas de la ficha.",
    "opciones": [
      {
        "texto": "Get-NetFirewallRule",
        "correcta": false
      },
      {
        "texto": "Test-NetConnection",
        "correcta": false
      },
      {
        "texto": "Remove-NetFirewallRule",
        "correcta": false
      },
      {
        "texto": "New-NetFirewallRule",
        "correcta": true
      }
    ]
  },
  {
    "titulo": "En el laboratorio no somos administradores. ¿Qué podemos hacer con las reglas?",
    "puntos": 10,
    "feedback": "Mirar reglas es libre; por eso podemos revisar lo que crea el profe.",
    "opciones": [
      {
        "texto": "Verlas y contarlas",
        "correcta": true
      },
      {
        "texto": "Crear reglas nuevas",
        "correcta": false
      },
      {
        "texto": "Cambiar sus puertos",
        "correcta": false
      },
      {
        "texto": "Borrarlas todas",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "Quiero bloquear solo a curl.exe sin cortarle Internet a Chrome. ¿Qué completo en la ficha?",
    "puntos": 10,
    "feedback": "El campo Programa apunta a un solo ejecutable y no afecta a los demás.",
    "opciones": [
      {
        "texto": "El puerto 443",
        "correcta": false
      },
      {
        "texto": "La IP remota",
        "correcta": false
      },
      {
        "texto": "El programa",
        "correcta": true
      },
      {
        "texto": "La dirección Inbound",
        "correcta": false
      }
    ]
  },
  {
    "titulo": "¿Cuál de estas reglas es la MÁS peligrosa?",
    "puntos": 10,
    "feedback": "Sin puerto, sin IP y sin programa, deja pasar todo: es como apagar el firewall.",
    "opciones": [
      {
        "texto": "Permitir el puerto 8080 solo al aula",
        "correcta": false
      },
      {
        "texto": "Permitir todo lo que entra, desde cualquiera",
        "correcta": true
      },
      {
        "texto": "Bloquear a una PC que tiene virus",
        "correcta": false
      },
      {
        "texto": "Permitir el ping solo desde el aula",
        "correcta": false
      }
    ]
  }
];

  for (var i = 0; i < preguntas.length; i++) {
    var p = preguntas[i];
    var item = form.addMultipleChoiceItem();
    item.setTitle((i + 1) + ". " + p.titulo).setPoints(p.puntos);

    var choices = [];
    for (var j = 0; j < p.opciones.length; j++) {
      var op = p.opciones[j];
      choices.push(item.createChoice(op.texto, op.correcta));
    }
    item.setChoices(choices);

    var feedback = FormApp.createFeedback().setText(p.feedback).build();
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
