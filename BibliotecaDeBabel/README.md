# La biblioteca de Babel

_"Todo: la historia minuciosa del porvenir, las autobiografías de los arcángeles, el catálogo fiel de la Biblioteca, miles y miles de catálogos falsos, la demostración de la falacia de esos catálogos..."_

_Jorge Luis Borges_

![biblioteca](biblioteca-babel.jpg)

Se trata de una biblioteca que contiene absolutamente todos los libros de 410 páginas que se pueden escribir. A su vez, sus libros tienen siempre 40 renglones por página y 80 símbolos por renglón. Los símbolos válidos son 25: veintidós letras de un alfabeto, el punto, la coma y el espacio. Tampoco hay dos libros idénticos: pueden diferir apenas en una coma, pero diferentes al fin. De esta manera, pese a ser numerosa, la cantidad de libros que contiene no es infinita. 

En nuestro modelo, vamos a representar una versión adaptada de esta biblioteca con sus libros y de otras bibliotecas más parecidas a las reales. De cada una de ellas se conoce su ubicación, lo que le da el nombre, y los libros que contiene. 
- De los libros, nos interesa saber:
- Un título, por supuesto.
- La cantidad de páginas.
- El texto que contiene
- Uno o más géneros en los que se puede categorizar.

Tenemos información de cuáles son los 25 caracteres con que se representan los símbolos originales de los libros de la biblioteca de babel. 

## Requerimientos funcionales:

### Estadísticas 
- Conocer el promedio de páginas por libro de una biblioteca.
- Conocer cuántos libros en común tienen dos bibliotecas. 

### Integridad de la biblioteca 
- Saber si un libro es válido para la biblioteca de Babel, es decir, si posee exactamente 410 páginas y está formado por alguna combinación de los símbolos válidos. 
- Depurar la biblioteca de Babel: verificar si la biblioteca de babel tiene todos libros válidos y en caso que haya alguno que no lo sea, quitarlo.

### Géneros
- Saber cuántos libros de un género determinado hay en una biblioteca
- Obtener el conjunto de géneros diferentes de los cuales hay libros 
- Obtener el género del cuál hay más libros en una biblioteca. 

### Ejemplos y consultas
Modelar a la biblioteca de Babel con algunos libros y otras bibliotecas y  mostrar ejemplos de consulta y respuesta que sean representativos 

## Problemas de registración 
A medida que avanza el tiempo, se empiezan a encontrar algunos problemas con nuestro programa, principalmente a la hora de registrar los géneros de cada libro. Al parecer, quienes administran la biblioteca no siempre cargan los géneros de igual manera, sino que a veces los cargan en minúsculas, en mayúsculas o en combinaciones extrañas, por ejemplo “policial”, “Policial”, “POLIcIAL”, “policiaL”.

Lo que se requiere es que todo funcione adecuadamente contemplando esta nueva situación. (PISTA: Se puede utilizar la función `toUpper` que se encuentra en `Data.Char`)

## Bibliotecas selectivas
Así como lo hace la biblioteca de Babel, ahora todas las bibliotecas pueden tener su propia lógica de ver si los libros son válidos y por lo tanto de depurarse. Por ejemplo, puede haber bibliotecas que se especializan en libros de un género en especial, o en libros con características muy específicas. 

Adaptar nuevamente la solución para contemplar esta nueva situación.

Contemplar las siguientes bibliotecas:
- De Berlín: se especializa en género policial.
- De Alejandría: verifica que la cantidad de caracteres del libro coincida con su cantidad de páginas. 
- De París: se especializa en género romántico.
- De tu ciudad: Inventar una nueva lógica.

Nuevo requerimiento: Obtener todas las bibliotecas en las que podría estar un libro.
Mostrar nuevos ejemplos de consulta.

## Biblioteca… ¿infinita?
Evidentemente, la cantidad de libros de la Biblioteca de Babel es muy grande, pero ¿qué tan grande? ¿es infinita? ¿Qué significa que sea infinita? ¿qué diferencia hay entre que sea muy, pero muy grande o infinita? 

Muchas preguntas y probablemente aún más respuestas posibles, que iremos encontrando al intentar resolverlo computacionalmente

En definitiva, lo que se quiere hacer es poder generar la Biblioteca de Babel, con todos sus libros, y cada libro con su correspondiente contenido, para luego poder buscar libros en ella.
- En la biblioteca deben haber libros con todos los textos posibles que se puedan armar como combinación símbolos válidos del alfabeto ya utilizado.
- La cantidad de páginas va a ser siempre la misma, el título y el género también puede ser valores arbitrarios. 
- Probar el funcionamiento con diferentes extensiones para el texto. En cada caso permitir averiguar cuántos libros debería haber en toda la biblioteca:
  - Literal: Asumir 410 páginas de 40 renglones cada una, con 80 símbolos por renglón.
  - Simplificada: Tomar un sólo símbolo por página, manteniendo 410 páginas. 
  - Personalizada: Determinar una cantidad mucho menor de símbolos en el texto, por ejemplo probar con 2, 5, 10 o 100 símbolos. 
- A partir de un fragmento de texto dado, encontrar el primer libro de la biblioteca que lo contenga (En caso de querer simplificar, en vez de contemplar que contenga el fragmento en cualquier ubicación del texto del libro, se puede asumir que termine o comience con él)
- Permitir averiguar cuántos libros de la biblioteca contienen un fragmento dado

Por otra parte, es interesante ver qué sucede con esta biblioteca con los requerimientos funcionales anteriores.

Justificar el concepto de evaluación diferida
