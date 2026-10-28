"""Genera los derivados de la Clase 3 (M4): kahoot xlsx, Google Form (.js/.md) y HTML del manual y la guía."""
import re, json, zipfile
from pathlib import Path
import openpyxl, markdown

D = Path(__file__).parent
txt = (D / "kahoot_clase3.md").read_text(encoding="utf-8")

# ---------- parseo del Kahoot ----------
qs = []
for blk in re.split(r"### ❓ Pregunta \d+\n", txt)[1:]:
    q = re.search(r"\*\*(.+?)\*\*", blk).group(1)
    opts, corr = [], None
    for m in re.finditer(r"^\* \*\*([ABCD])\)\*\* (.+)$", blk, re.M):
        t = m.group(2)
        ok = "✔️" in t
        t = re.sub(r"\s*✔️.*$", "", t).strip()
        if ok: corr = len(opts)
        opts.append(t)
    fb = re.search(r"^> \* \*\*Opción [ABCD] \(Correcta\):\*\* (.+)$", blk, re.M).group(1)
    assert len(opts) == 4 and corr is not None, q
    assert len(q) <= 120 and all(len(o) <= 75 for o in opts), (q, [len(o) for o in opts])
    qs.append(dict(q=q, o=opts, c=corr, fb=fb))
assert len(qs) == 10

# ---------- Kahoot xlsx (misma plantilla que clase 2) ----------
wb = openpyxl.Workbook(); ws = wb.active; ws.title = "Sheet1"
ws["B2"] = "Quiz template"
ws["B3"] = "Add questions, at least two answer alternatives, time limit and choose correct answers (at least one). Have fun creating your awesome quiz!"
ws["B4"] = "Remember: questions have a limit of 120 characters and answers can have 75 characters max. If several answers are correct, separate them with a comma."
ws["B5"] = "If you're not using Excel you need to export to .xlsx format before you upload to Kahoot!"
for i, h in enumerate(["Question - max 120 characters"] + [f"Answer {n} - max 75 characters" for n in range(1, 5)]
                      + ["Time limit (sec) - 5, 10, 20, 30, 60, 90, 120, or 240 secs", "Correct answer(s) - choose at least one"]):
    ws.cell(row=8, column=2 + i, value=h)
for n, x in enumerate(qs, 1):
    r = 8 + n
    ws.cell(row=r, column=1, value=n); ws.cell(row=r, column=2, value=x["q"])
    for j, o in enumerate(x["o"]): ws.cell(row=r, column=3 + j, value=o)
    ws.cell(row=r, column=7, value=20); ws.cell(row=r, column=8, value=x["c"] + 1)
ws.column_dimensions["B"].width = 70
for c in "CDEF": ws.column_dimensions[c].width = 45
wb.save(D / "kahoot_clase3.xlsx")

# ---------- Google Form .js ----------
TITLE = "LSO 4.º Año — Evaluación Formativa: El Portero y su Lista (Reglas del Firewall)"
js_q = json.dumps([dict(titulo=x["q"], puntos=10, feedback=x["fb"],
                        opciones=[dict(texto=o, correcta=(i == x["c"])) for i, o in enumerate(x["o"])])
                   for x in qs], ensure_ascii=False, indent=2)
js = f'''/**
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

function generarGoogleFormReglasClase3() {{
  var form = FormApp.create({json.dumps(TITLE, ensure_ascii=False)});

  form.setDescription(
    "Laboratorio de Sistemas Operativos (LSO) — 4.º Año\\n" +
    "Módulo 4: Redes, Recursos Compartidos y Seguridad — Clase 3\\n\\n" +
    "📌 Temas: qué es una regla, entrada y salida, las 5 preguntas de una regla, gana el NO (Block > Allow), LocalSubnet, filtrar por programa y abrir lo justo.\\n" +
    "⏱️ Modalidad: Evaluación formativa de opción múltiple.\\n" +
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

  var preguntas = {js_q};

  for (var i = 0; i < preguntas.length; i++) {{
    var p = preguntas[i];
    var item = form.addMultipleChoiceItem();
    item.setTitle((i + 1) + ". " + p.titulo).setPoints(p.puntos);

    var choices = [];
    for (var j = 0; j < p.opciones.length; j++) {{
      var op = p.opciones[j];
      choices.push(item.createChoice(op.texto, op.correcta));
    }}
    item.setChoices(choices);

    var feedback = FormApp.createFeedback().setText(p.feedback).build();
    item.setFeedbackForCorrect(feedback);
    item.setFeedbackForIncorrect(feedback);
  }}

  Logger.log("==================================================================");
  Logger.log("✅ ¡FORMULARIO CREADO CON ÉXITO!");
  Logger.log("📝 Enlace para editar / gestionar respuestas:");
  Logger.log(form.getEditUrl());
  Logger.log("🔗 Enlace para compartir con los estudiantes:");
  Logger.log(form.getPublishedUrl());
  Logger.log("==================================================================");
}}
'''
(D / "crear_google_form_clase3.js").write_text(js, encoding="utf-8")

# ---------- Google Form .md ----------
L = ["# Cuestionario Google Forms: El Portero y su Lista (Reglas del Firewall)",
     "## Asignatura: Laboratorio de Sistemas Operativos (LSO) — 4.º Año",
     "### Módulo 4: Redes, Recursos Compartidos y Seguridad — Clase 3", "", "---", "",
     "## 📌 Configuración del Formulario",
     f"* **Título:** {TITLE}",
     "* **Descripción:** Evaluación formativa del Módulo 4 (Clase 3). Cubre: qué es una regla, entrada/salida, las 5 preguntas de una regla, gana el NO (Block > Allow), LocalSubnet, filtrar por programa y mínimo privilegio.",
     "* **Modo:** Cuestionario con puntuación automática (Quiz: 10 preguntas × 10 puntos = 100 puntos).",
     "* **Campos obligatorios previos:**", "  * Dirección de correo electrónico", "  * Nombre y Apellido del Estudiante",
     "  * Terminal o Equipo N.º (Laboratorio)", "", "---", "", "## 📋 Banco de Preguntas y Opciones", ""]
for n, x in enumerate(qs, 1):
    L += [f"### Pregunta {n} (10 pts)", f"**{x['q']}**"]
    for i, o in enumerate(x["o"]):
        L.append(f"* {'ABCD'[i]}) {o} ({'Correcta' if i == x['c'] else 'Incorrecta'})")
    L += [f"* **Feedback:** {x['fb']}", ""]
(D / "cuestionario_google_forms_clase3.md").write_text("\n".join(L), encoding="utf-8")

# ---------- HTML del manual y la guía ----------
CSS = """body{font-family:'Outfit','Segoe UI',system-ui,sans-serif;max-width:920px;margin:0 auto;padding:32px 24px;line-height:1.65;color:#1e293b;background:#f8fafc;font-size:1.05rem}
h1{color:#3730a3;border-bottom:4px solid #818cf8;padding-bottom:8px;font-weight:800}h2{color:#4338ca;margin-top:2em;font-weight:700}h3{color:#6d28d9}
table{border-collapse:separate;border-spacing:0;width:100%;margin:1em 0;font-size:.95rem;background:#fff;border-radius:12px;overflow:hidden;box-shadow:0 2px 10px rgba(30,41,59,.08)}
th,td{border-bottom:1px solid #e2e8f0;padding:8px 12px;text-align:left}th{background:#eef2ff;color:#3730a3}
code{background:#eef2ff;color:#4338ca;padding:1px 6px;border-radius:6px;font-family:Consolas,monospace;font-size:.9em}
pre{background:#0f172a;color:#e2e8f0;padding:14px;border-radius:12px;overflow-x:auto}pre code{background:none;color:inherit}
blockquote{border-left:5px solid #f59e0b;background:#fffbeb;margin:1em 0;padding:8px 16px;border-radius:0 12px 12px 0}
.mermaid{background:#fff;padding:12px;border-radius:12px;color:inherit}
@media print{body{max-width:none;background:#fff}pre{white-space:pre-wrap}table{box-shadow:none}}"""
def to_html(md_name, html_name, title):
    src = (D / md_name).read_text(encoding="utf-8")
    src = re.sub(r"```mermaid\n(.*?)```", lambda m: '<pre class="mermaid">' + m.group(1) + "</pre>", src, flags=re.S)
    body = markdown.markdown(src, extensions=["tables", "fenced_code", "sane_lists"])
    page = f"""<!DOCTYPE html>
<html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>{title}</title><meta name="description" content="{title} — LSO 4.º Año, Módulo 4, Clase 3">
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;700;800&display=swap" rel="stylesheet">
<style>{CSS}</style></head><body>
{body}
<script type="module">import m from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';m.initialize({{startOnLoad:true}});</script>
</body></html>"""
    (D / html_name).write_text(page, encoding="utf-8")
to_html("manual_teorico_reglas_firewall.md", "manual_teorico_reglas_firewall.html", "Manual Teórico: El Portero y su Lista — Reglas del Firewall")
to_html("guia_actividades_clase3.md", "guia_actividades_clase3.html", "Guía de Actividades N.º 3: El Portero y su Lista")

with zipfile.ZipFile(D / "guia_actividades_clase3.zip", "w", zipfile.ZIP_DEFLATED) as z:
    for f in ["guia_actividades_clase3.md", "guia_actividades_clase3.html"]:
        z.write(D / f, f)
print("OK", len(qs), "preguntas")
