# Super liga

## Ejercicio integrador

**Viajamos al pasado, al momento de armado de los grupos para la superliga, para reemplazar los "sorteos" que se hicieron por un programa en prolog que lo haga de mejor manera.**

### Grupo válido
Queremos armar los posibles grupos válidos, teniendo en cuenta que cada uno debe constar de: 
- un "cabeza de grupo" que es uno de los clubes denominados grandes (son los clubes del AMBA que tienen plata).
- un equipo del amba que no sea de los denominados grandes
- un equipo del mal llamado interior del país, que en realidad significa que no están en el AMBA.
- un equipo más que puede ser tanto del amba como del interior, pero que no sea uno de los grandes ni tampoco que sea un clasico rival de alguno de los dos anteriores

Para eso contamos con la siguiente base de conocimiento:

~~~prolog
%club(Nombre, Ubicacion, Hinchas).
club(boca,amba, 100).
club(racing,amba, 80).
club(nob,rosario, 50).
club(godoy,mendoza, 5).
club(central,rosario,60).
club(velez, amba,5).
club(lanus, amba,10).
club(banfield, amba,4).

tienePlata(velez).
tienePlata(boca).
tienePlata(racing).
tienePlata(nob).

clasico(central, nob).
clasico(banfield, lanus).
~~~

Con esta info, un grupo válido podria ser: boca - banfield - central - godoy

pero no: boca - banfield - central - nob

tampoco: boca - banfield - central - lanus

tampoco: boca - lanus - central - banfield 

obviamente, tampoco: boca - banfield - central - central

Lo mismo para similares combinaciones, con velez o racing en vez de boca.

Hay muchas otras combinaciones válidas. 

### Clubes populares

Encontrar a los clubes populares, que son aquellos que sin ser considerados grandes, tienen más hinchas que alguno de los grandes y también los que siendo considerados grandes realmente tienen más hinchas que todos los que no lo son.

En el ejemplo, son populares central, nob y lanus, (por tener mas hinchas que velez). Boca y racing también. Velez no (porque hay otros equipos de los chicos que lo superan)


### Ciudades importantes

Saber si una ciudad es importante futbolísticamente, lo cual ocurre cuando todos sus equipos son populares. 


### Consultas

Mostrar ejemplos de consulta, modificando los datos de ejemplo para probar las diferentes alternativas.

### Conceptos

Analizar la inversibilidad de los predicados principales.
