# 🚨 Ejemplos Reales de Dark Patterns (Patrones Oscuros)

Este documento recopila casos reales e históricos de grandes empresas que implementaron **Dark Patterns** (Patrones Oscuros) en sus interfaces. Puede utilizarse como material complementario o de estudio para los alumnos.

---

## 🚪 1. Roach Motel (Trampa de Cucarachas)
> **Definición:** Es extremadamente fácil entrar o suscribirse a un servicio, pero casi imposible salir o darse de baja.

### Caso de Estudio: Amazon Prime (El "Proyecto Ilíada")
*   **El Escenario:** Durante años, Amazon facilitaba la suscripción a Prime con un solo clic (a menudo camuflado durante el proceso de compra de un producto físico). Sin embargo, cancelar la suscripción requería atravesar un proceso laberíntico de múltiples páginas.
*   **Cómo funcionaba la interfaz:**
    1.  El usuario debía navegar por varios menús para encontrar el botón de cancelación.
    2.  Al hacer clic en cancelar, se le presentaba una página llena de texto y advertencias sobre los beneficios que perdería.
    3.  Los botones estaban diseñados para confundir: el botón para continuar con la cancelación solía ser gris y discreto, mientras que el botón para mantener la suscripción era grande, amarillo e interactivo.
    4.  El usuario debía responder a preguntas ambiguas y hacer clic en al menos 3 o 4 pantallas de confirmación con opciones del tipo *"Mantener mis beneficios"*, *"Continuar para cancelar"* o *"Recordarme más tarde"*.
*   **Consecuencias legales:** En 2023, la Comisión Federal de Comercio de EE. UU. (FTC) demandó formalmente a Amazon, alegando que la empresa engañó conscientemente a millones de consumidores para que se suscribieran y dificultó deliberadamente sus cancelaciones mediante este flujo (bautizado internamente por Amazon como *"Proyecto Ilíada"* en referencia a la larga y costosa Guerra de Troya).

---

## 💬 2. Confirmshaming (Culpa Semántica)
> **Definición:** Utilizar el lenguaje, la jerarquía visual y la manipulación emocional para hacer sentir culpable o avergonzado al usuario si decide no tomar la acción deseada por la empresa.

### Casos de Estudio en E-commerce y Blogs de Suscripción
*   **El Escenario:** Al navegar por tiendas de comercio electrónico o blogs, aparece una ventana emergente (pop-up) ofreciendo un código de descuento o una suscripción al boletín de noticias (newsletter).
*   **Cómo funciona la interfaz:**
    *   La opción para aceptar es un botón llamativo: `[Sí, quiero registrarme y obtener un 10% de descuento]`.
    *   La opción para cerrar o rechazar no es una simple "X" o un "No". En su lugar, el enlace para declinar está redactado para ridiculizar o culpar la decisión del usuario.
*   **Ejemplos de textos reales documentados:**
    *   **Sitio de recetas/comida:** Botón de suscripción vs. *"No, gracias, prefiero comer comida aburrida"* o *"No, prefiero pagar el precio completo"*.
    *   **Sitio de finanzas:** Botón para descargar una guía vs. *"No, no me interesa aprender a ahorrar dinero"*.
    *   **Sitio de salud/bienestar:** Botón de registro vs. *"No, no me importa mi salud física"*.

---

## 🎯 3. Misdirection & Interface Interference (Redirección visual)
> **Definición:** Desviar la atención del usuario mediante el diseño visual (colores, contrastes, tamaños) para ocultar las opciones legítimas y destacar las que benefician a la empresa.

### Caso de Estudio: Banners de Consentimiento de Cookies
*   **El Escenario:** Al ingresar a casi cualquier sitio web regulado por normativas de privacidad (como el RGPD europeo), aparece un cartel para gestionar el uso de cookies y rastreo.
*   **Cómo funciona la interfaz:**
    *   **El botón favorable ("Aceptar todo"):** Es enorme, está centrado, tiene colores llamativos con alto contraste (por ejemplo, azul o verde sobre fondo oscuro) y se ejecuta con un solo clic.
    *   **El botón desfavorable ("Rechazar todo" o "Configurar"):** Está diseñado para ser ignorado. A menudo se presenta como un texto gris pequeño sobre fondo gris, sin bordes de botón. 
    *   **El laberinto:** Si haces clic en "Configurar", la interfaz te obliga a desactivar manualmente decenas de interruptores de "socios comerciales" o "interés legítimo". Esto agota la paciencia del usuario (fatiga por consentimiento), quien termina presionando "Aceptar todo" simplemente para hacer desaparecer el cartel.

---

## 🛒 4. Sneak into Basket (Colar en el carrito)
> **Definición:** Aprovechar el descuido o la prisa del usuario para añadir productos, servicios o cargos adicionales al carrito de compras sin su consentimiento explícito.

### Caso de Estudio: Aerolíneas de Bajo Coste (ej. Ryanair) e intermediarios de viajes
*   **El Escenario:** Compras un billete de avión o una entrada para un concierto. Durante el largo proceso de checkout (donde ingresas tus datos, equipaje, etc.), el sistema te ofrece servicios opcionales.
*   **Cómo funcionaba la interfaz:**
    *   Al llegar a la pantalla de pago final, el precio total es más alto de lo esperado porque se han auto-seleccionado opciones como *"Seguro de viaje"*, *"Garantía de reembolso"* o *"Suscripción premium de prueba"*.
    *   **El truco de la lista desplegable:** En versiones anteriores de su web, para evitar comprar el seguro de viaje obligatorio de Ryanair, el usuario debía desplegar un menú de selección de país (bajo la premisa de indicar dónde residía para el seguro). Para rechazar el seguro, el usuario tenía que encontrar la opción *"No deseo contratar seguro"*, la cual no estaba al principio ni al final, sino camuflada alfabéticamente en la lista de países (entre "Nicaragua" y "Noruega"). Si el usuario simplemente seleccionaba su país de origen real, el seguro se agregaba y cobraba automáticamente.

---

## 🔄 5. Bait and Switch (Gato por Liebre)
> **Definición:** El usuario realiza una acción esperando un resultado estándar y predecible (basado en las convenciones del diseño), pero la interfaz ejecuta una acción diferente y no deseada.

### Caso de Estudio: La campaña de actualización a Windows 10 (2016)
*   **El Escenario:** Microsoft deseaba migrar rápidamente a los usuarios de Windows 7 y 8 a la nueva versión de Windows 10 mediante una ventana emergente de notificación.
*   **Cómo funcionaba la interfaz:**
    1.  Durante meses, la ventana emergente daba dos opciones claras: actualizar ahora o programar para más tarde. Si hacías clic en la **"X"** roja superior derecha de la ventana, esta se cerraba y no pasaba nada (comportamiento estándar en Windows).
    2.  En una de las fases más agresivas de la campaña, Microsoft cambió el comportamiento de la ventana: la actualización a Windows 10 se catalogó como una recomendación obligatoria programada.
    3.  Cuando aparecía la ventana emergente y el usuario hacía clic en la **"X"** para cerrarla y evitar la molestia, el sistema interpretaba ese clic de cierre como un **consentimiento implícito** para iniciar la instalación en segundo plano. 
*   **Consecuencias:** Cientos de miles de usuarios vieron cómo sus ordenadores de trabajo se reiniciaban y actualizaban de forma forzada a mitad de su jornada laboral al intentar cerrar un simple anuncio. Tras las quejas masivas y demandas legales, Microsoft tuvo que retirar este diseño.
