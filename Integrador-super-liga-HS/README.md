# Super Liga

## Ejercicio integrador


**Queremos replantear la popularidad de los clubes y potenciar sus hinchadas.**

La información que se conoce de cada club es la ciudad donde se ubica y su cantidad de hinchas. También se conoce cuáles clubes son los que tienen mucha plata.
Un club se considera grande cuando es de buenos aires y tienen mucha plata.

*Ejemplo:*

Algunos clubes
- boca - bsas - 100.
- racing - bsas - 80.
- nob - rosario - 50.
- godoy - mendoza - 5.
- central - rosario - 60.
- velez - bsas - 5.
- lanus - bsas - 10.

Tienen mucha plata: boca, racing, velez y nob.

### Clubes populares
Obtener a los clubes populares, que son aquellos que sin ser considerados grandes, tienen más hinchas que alguno de los grandes y también los que siendo considerados grandes realmente tienen más hinchas que todos los que no lo son.

En el ejemplo, son populares central, nob y lanus, (por tener mas hinchas que velez). Boca y racing también. Velez no (porque hay otros equipos de los chicos que lo superan)

### Potenciar hinchadas
Hay varias iniciativas de la liga para potenciar a los clubes. Entre ellas:
	
- Campaña publicitaria: aumenta en un 5% la cantidad de hinchas de un club
- Mudar de ciudad al club: el club se muda a la nueva ciudad y aumenta la cantidad de hinchas en un % igual a la cantidad de letras del nombre de la nueva ciudad.
- Tirar maíz en la cancha: en los clubes que tienen una "v" en su nombre, eso aumenta la cantidad de hinchas y en otros la disminuye, en tantos hinchas como 10 veces el maíz que se tira.
- Recibir apoyo de otro club: el club original suma como propios a los hinchas del otro club.
- Inventar una nueva iniciativa, pero que disminuya la cantidad de hinchas. Pista/restricción: se debe utilizar composición.

**Se pide:**

a) Implementar las formas de potenciar las hinchadas

b) Dado dos clubes y una iniciativa, implementar la función que permita obtener el nombre del club que quedaría con más hinchas luego de implementar la iniciativa. 

c) Dado un club y varias iniciativas a analizar, implementar la función que permita obtener la cantidad máxima de hinchas que podría tener aplicando individualmente alguna de las iniciativas. 

d) Mostrar ejemplos de consulta de las funciones anteiores, entre ellos el siguiente:

* _Si boca analiza las iniciativas: compaña publicitaria, mudarse a rosario, mudarse a jujuy, recibir el apoyo de velez, tirar 3 granos de maíz y una iniciativa inventada, lo máximo que podría tener es 107 hinchas (por mudarse a rosario)_

e) Justificar la utilización de orden superior en la solución.
