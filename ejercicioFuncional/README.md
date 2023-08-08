## ¿Y dónde está mi hamburguesa?
Queremos hacer un sistema para un emprendimiento de comida
rápida. Principalmente nos interesa modelar los combos que
vende para tomar pedidos, pero tenemos que hacerlo lo
suficientemente flexible para que se ajuste a los gustos de los
clientes. Se tiene algunos combos prearmados como punto de
partida, luego el cliente puede pedir agrandar su bebida,
cambiar el acompañamiento por otro y quitarle ingredientes a la
hamburguesa, entre otras cosas que tal vez tengamos que
soportar a futuro.

Los datos del programa están modelados de la siguiente forma:
```
data Combo = Combo {
  hamburguesa :: [Ingrediente],
  bebida :: Bebida,
  acompañamiento :: String }
```
```
data Bebida = Bebida {
  tipoBebida :: String,
  tamañoBebida :: Tamaño,
  light :: Bool
} deriving (Show, Eq)
```
```
type Ingrediente = String
-- Hay 3 tamaños válidos para las bebidas
type Tamaño = Int
regular = 1
mediano = 2
grande = 3
```
Además disponemos de la siguiente constante que nos indica cuántas calorías tienen los distintos ingredientes
usados para hacer hamburguesas que no sean condimentos:
``` 
informacionNutricional = [("Carne", 250), ("Queso", 50), ("Pan", 20), ("Panceta", 541),
("Lechuga", 5), ("Tomate", 6)] 
```
Y también sabemos cuáles son los condimentos que se usan en la preparación de hamburguesas:
```
condimentos = ["Barbacoa","Mostaza","Mayonesa","Ketchup"]
```
Se pide desarrollar las siguientes funciones poniendo en práctica orden superior, aplicación parcial y composición
cuando sea conveniente. Explicitar el tipo de todas las funciones desarrolladas.

1. Queremos saber cuántas calorías tiene un ingrediente, esto puede obtenerse a partir de la información
nutricional, a menos que sea un condimento, en cuyo caso la cantidad de calorías es 10.
> calorias "Panceta"
541
> calorias "Mostaza"
10

2. Se quiere saber si un combo esMortal. Esto se cumple cuando la bebida no es dietética y la hamburguesa
es una bomba (si tiene entre sus ingredientes al menos uno que tenga más de 300 calorías, o si en total la
hamburguesa supera las 1000 calorías).

3. Definir una función que permita obtener a partir de un combo y una lista de alteraciones, el combo resultante
de alterar el combo con todas las alteraciones indicadas. Las alteraciones puedan ser las siguientes:

  a. cambiarAcompañamientoPor: retorna el combo con otro acompañamiento elegido por el cliente.
  
  b. agrandarBebida: retorna el combo agrandando la bebida al tamaño siguiente (teniedo en cuenta
  que el máximo es el tamaño grande, no importa cuánto se lo trate de seguir agrandando).
  
  c. peroSin: retorna el combo de modo que su hamburguesa no incluya ingredientes que cumplan con
  una determinada restricción. En principio nos interesan las siguientes restricciones, pero podría
  haber otras:

  i. esCondimento: un ingrediente cumple esta restricción si es igual a alguno de los
  condimentos conocidos.

  ii. masCaloricoQue: se cumple esta restricción si las calorías del ingrediente superan un valor
  dado.

4. Asumiendo que se tiene una constante comboDePrueba :: Combo, realizar una consulta con la función
definida anteriormente para alterar ese combo considerando que se quieren hacer las siguientes
alteraciones: agrandar la bebida, cambiar el acompañamiento por “Ensalada César”, que venga sin
condimento, que venga sin ingredientes con más de 400 calorías y que venga sin queso.

5. Saber si un conjunto de alteraciones alivianan un combo, que será cierto si el combo recibido es mortal,
pero luego de aplicar las alteraciones indicadas no lo es.





