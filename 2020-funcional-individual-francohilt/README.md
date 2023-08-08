# Exploradores del Espacio

Es el año 2142 y forman parte de una expedición espacial con destino a Alpha Centauri.
El objetivo es sondear los planetas del sistema estelar desde cerca para conocer mejor cuales son aptos para la vida humana.
Cuando, de repente, una extraña señal destruyó parte del software abordo, por lo que hay que reprogramarlo para completar la misión y volver al planeta Tierra.

## Primer Punto: Modelado de los planetas

De cada planeta conocemos su nombre, su posición en coordenadas PDP (un punto con coordenadas x,y,z) y su porcentaje de agua.

Sabemos que al menos existen 3 planetas:

* Próxima Centauri b, se encuentra orbitando la estrella Próxima Centauri, actualmente en el punto (43.2, 14.2, 8.9). Según nuestros métodos, su porcentaje de agua es 74%. 
* Alpha Centauri Bb, según nuestros reportes se encuentra actualmente en el punto (17, 31.2, 32) y su porcentaje de agua es realmente bajo, solo 3% de agua.
* Alpha Centauri Cc, el último planeta descubierto. Se encuentra en la ubicación (42, 42, 42), el agua que detectamos está congelada pero representa un 60% según los reportes.

## Segundo Punto: Cálculo de distancia estelar

Para poder dirigirnos a explorar los diferentes planetas de Alpha Centauri, primero debemos saber a qué distancia estamos de ellos.
Para ello es necesario tener una función `distanciaA` que dado un planeta destino y nuestra ubicación (en coordenadas PDP) pueda calcular la distancia al mismo.
La fórmula utilizada para calcular la distancia es:

dist((x1, y1, z1), (x2, y2, z2)) = x1x2 + 2y1z2 + |y2 - z1|

## Tercer Punto: Planetas aptos

Ahora que sabemos a qué distancia estamos de cada planeta, necesitamos saber si un planeta es apto. Esto es, cuando su porcentaje de agua es mayor a 52% y la distancia a él desde nuestra nave es menor a 100.

## Cuarto Punto: Próximo destino

Por último, debemos cargar el próximo planeta al que se dirigirá la nave, para ello necesitamos primero modelarla.

De nuestra nave conocemos su nombre, cantidad de combustible expresada en litros, sus tripulantes y el próximo planeta al que se dirigirá.

Inicialmente el planeta destino es Alpha Centauri Bb, pero nos gustaría poder cambiarlo, por lo que deben hacer una función `cargarProximoPlaneta` que dada una nave y una lista de planetas explorados fije el primer planeta de la lista como próximo destino de la nave.

## Quinto Punto: Destinos ordenados

Por último, necesitamos saber si una lista de planetas está ordenada de menor a mayor distancia. Para ello define una función `estaOrdenada` usando recursión.
