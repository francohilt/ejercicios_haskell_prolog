### Examen Paradigma Funcional y Lógico

¿Saben qué se conmemora en esta fecha? Ni más ni menos que el día nacional de
Camboya. Sí, ese lejano país asiático que no clasifica para mundiales, no es destino
top de turismo ni fue escenario -al menos en los últimos años- de ninguna guerra de
interés para la potencias mundiales. Sin embargo, existe y millones de camboyanos
consideran que es un lugar maravilloso y único.

![](https://guias-viajar.com/wp-content/uploads/2017/11/camboya-angkor-013.jpg)

Tenemos información sobre los lugares típicos de este país, por ejemplo, el Templo de Angkor, el río
Mekong, Nom pen que es su ciudad capital. Se conocen muchos otros templos, más ríos y ciudades,
y puede haber otros tipos de lugares como museos, montañas, etc. También puede suceder que
Mekong además de ser el nombre del río, sea también una ciudad o haya otro sitio de igual nombre.
De cada uno de ellos se conoce además la cantidad de visitantes en el último año, y el costo de la
entrada (que puede ser 0 en algunos lugares)

1) Se quiere averiguar cuál es el lugar más visitado de camboya, dentro de su tipo, en el último
   año (no preocuparse por si hay "empate" en la máxima cantidad). Por ejemplo, el templo más
   visitado, la ciudad más visitada, etc. Definir la forma de modelar la información en cada
   paradigma, incluyendo algunos datos de ejemplo, desarrollar las funciones y predicados
   necesarios para resolver lo pedido y mostrar un par de casos de cómo utilizarlos, con la
   correspondiente respuesta.
2) Justificar en cada paradigma según corresponda
   
   ● En lógico, explicar la utilidad del concepto de inversibilidad para resolver el problema planteado.
   
   ● En funcional, explicar si fueron de utilidad (o no) los conceptos de aplicación parcial y composición.
   
3) Hay nuevos requerimientos que pueden implicar cambios o agregados a lo hecho anteriormente. 
   En cada caso implementar lo que sea necesario, mostrar ejemplos de consulta y justificar: 
   ¿qué concepto facilitó la realización de este nuevo requerimiento?
   
    ● Funcional. Ahora se quiere obtener el lugar más visitado, pero con mayores variantes
    a la hora de definir el alcance. Por ejemplo, se puede especificar un conjunto de tipos
    de lugares (ríos, montañas, lagos), analizar sólo los lugares gratuitos o un rango de
    precios, etc. Hacer una nueva función, en la cual preguntar por un tipo de lugar (el
    punto anterior) sea sólo un caso particular. Implementar los ejemplos planteados
    (conjunto de lugares, gratuito, rango de valores) pero previendo que pueda haber otros criterios.
  
    ● Lógico. El gobierno de camboya incorpora impuestos según el tipo de lugar. Para ello
    se agrega a la base de conocimiento la siguiente información.
  
    impuestoPorcentual(templo, 10). Se incrementa en dicho porcentaje el precio de la entrada.
  
    impuestoFijo(montaña, 100). Se suma el cargo fijo al precio de la entrada.
  
    impuestoRango(museo, 100,200,5). Se incrementa un 5% a las entradas a museos que cuestan entre 100 y 200, el resto queda igual.
  
    Las ciudades no tienen impuestos, por lo que su costo es el original.
  
    Averiguar cuánto cuesta entrar a un lugar, considerando los impuestos.
