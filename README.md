# Diseño de Algoritmos con SICP 

"Este libro está dedicado, con respeto y admiración, al espíritu que
vive en la computadora."

Del prefacio:

> Creo que es extraordinariamente importante que en la ciencia de la
> computación mantengamos la diversión en la informática. Cuando comenzó,
> era muy divertido. Por supuesto, los clientes que pagaban se sentían
> estafados de vez en cuando, y después de un tiempo comenzamos a tomar
> sus quejas en serio. Empezamos a sentir que realmente éramos responsables
> del uso exitoso, sin errores y perfecto de estas máquinas. No creo que
> lo seamos. Creo que somos responsables de estirarlas, de ponerlas en
> nuevas direcciones y de mantener la diversión en la casa. Espero que el
> campo de la ciencia de la computación nunca pierda su sentido de diversión.
> Sobre todo, espero que no nos convirtamos en misioneros. No sientas que
> eres un vendedor de Biblias. El mundo ya tiene demasiados de esos. Lo que
> sabes sobre informática, otras personas lo aprenderán. No sientas que la
> clave para una informática exitosa está solo en tus manos. Lo que tienes
> en tus manos, creo y espero, es inteligencia: la capacidad de ver la
> máquina como más de lo que era cuando te la presentaron por primera vez,
> que puedes hacerla más."

Alan J. Perlis (1 de abril de 1922 - 7 de febrero de 1990)

## Preguntas Profundas

* ¿Qué es la computación?
* ¿Qué es la programación?
* ¿Qué es la abstracción?
* ¿Cómo encajan las partes para diseñar algoritmos?

## SICP en Resumen

* Un libro de texto clásico de CS (muy valorado)
* Se enfoca en conseguir entender la ejecución de algoritmos y sus costes
* Incluye muchos otros conceptos en el camino
* El enfoque está en el pensamiento y la resolución de problemas

Del programa de estudios del MIT:

> Aunque el curso incorpora una gran cantidad de programación, su
> enfoque intelectual no está en constructos específicos de lenguajes de
> programación, estructuras de datos o algoritmos, estos se consideran
> detalles. En cambio, se lleva a los estudiantes a apreciar una diversidad
> de paradigmas de programación importantes: abstracción de datos, sistemas
> basados en reglas, programación orientada a objetos, programación
> funcional, programación lógica y construcción de intérpretes embebidos.
> Más allá de eso, hay una preocupación central con la tecnología de
> implementación de lenguajes y el soporte lingüístico para paradigmas de
> programación. Se anima a los estudiantes a considerarse diseñadores e
> implementadores de lenguajes en lugar de solo usuarios de lenguajes.

## Algunas Reflexiones

* SICP es desafiante, y además se añaden proyectos extra sobre algoritmos

* Muchos libros introducen las computadoras (bits, bytes, memoria, etc.) y
  abordan los algoritmos como algo que haces para manipular una computadora.
  De abajo hacia arriba. A menudo enfatizando detalles de bajo nivel.

* SICP introduce un modelo más abstracto de computación y deriva
  todo de eso. De arriba hacia abajo. Alto nivel. Los detalles de bajo nivel
  a menudo son "poco importantes" o "dejados como ejercicio" para más tarde.

* Este modelo de computación es puesto a prueba en los laboratorios, revisando
  y ampliando lo visto en cursos anteriores

> Lisp ha sido llamado en broma "la forma más inteligente de malusar una
> computadora". Creo que esa descripción es un gran cumplido porque
> transmite todo el sabor de la liberación: ha ayudado a varios de nuestros
> compañeros humanos más dotados a pensar pensamientos previamente
> imposibles." - Edsger Dijkstra


## Conclusiones

* Más conocimiento sobre la naturaleza de la computación y estrategias para
  la resolución de problemas


* Te irás viendo todo lo que ya sabes desde una
  perspectiva diferente.

* Un trampolín para un estudio más profundo de los lenguajes de programación y
  la ciencia de la computación.

## Nuestro Plan

Estamos cubriendo el núcleo de SICP que te enseña conceptos de
programación, que finalmente conducen a la implementación de un intérprete de Scheme.

* Día 1 - Procedimientos y funciones
* Día 2 - Abstracción de datos y estructuras de datos
* Día 3 - Objetos, Concurrencia y Flujos
* Día 4 - Evaluador metacircular
* Día 5 - Máquinas de registro (solo la primera parte)

Nota: Cuando SICP se enseña en la universidad, es típico cubrir solo los primeros
cuatro capítulos (e incluso entonces, NO todo el material). Según la
propia admisión del autor, SICP es demasiado grande para cubrirlo en un semestre.

## Enfoque

Voy a presentar notas y ejemplos altamente destilados que se centran en el
corazón de lo que SICP está hablando. Proporcionaré referencias de lectura a
material de apoyo relevante.

Gran parte del aprendizaje de SICP proviene de sus ejercicios. Trabajaremos
ejercicios seleccionados del libro en su forma original.

NO estamos trabajando todos los ejercicios, sin embargo, algunos ejercicios son más una distracción.
Interesantes, sí, pero no absolutamente críticos para la tarea más grande de hacer
tu propio intérprete.
