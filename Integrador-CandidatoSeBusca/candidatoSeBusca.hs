{-
Los dirigentes los modelamos con un tipo de dato propio
La imagen positiva conviene que sea numérica, podría también ser un entero
Las habilidades es suficiente que sean strings, sólo se van a usar para compararse
Para el cargo actual, ante la posibilidad que haya diferentes alternativas, 
le ponemos un tipo específico, que definimos en otro lugar.
Tal como está dado en la consigna, las alianzas son una lista de partidos, que son strings.
Cada dirigente sabe de qué partido es.
(Una variante mas compleja es que la relación sea al revés 
y el partido tenga una lista de dirigentes)
-}
type Partido = String
type Alianza = [Partido]

data Dirigente = UnDirigente {
    nombre:: String,
    imagen:: Float,
    habilidades :: [String],
    cargo :: Cargo,
    partido :: Partido
} deriving (Eq,Show)

{-
Lo más práctico es definir un tipo de dato propio para los cargos, como una 
enumeración de valores, ya que son pocos e identificables
Definir el tipo como Ord nos facilita la comparación entre cargos.
Los ordenamos de manera ascendente por importancia. 
Que sea Eq, además de ser necesario para ser Ord, nos va a permitir 
encontrar a uno en particular.
-}
data Cargo = Intendente|Gobernador|Senador|Vicepresidente|Presidente 
    deriving (Eq, Ord, Show)

{-
Una alternativa es definir el cargo como String y luego con otra función, 
obtener un valor comparable a partir de dicho string 
-}
--type Cargo = String
--importancia "presidente" = 5
--importancia "gobernador" = 2

{- 
Otra alternativa, es definir el cargo directamente como un
valor numérico y definir constantes para no perder expresividad
-}
--type Cargo = Int
--presidente = 5
--gobernador = 2

{- 
Otras variantes más complejas son definir tuplas con descripción y valor 
o un nuevo tipo de dato con sus correspondientes funciones.
Una solución más genérica aunque más imperativa sería tener una lista de String
con los cargos ubicados orden de importancia y compararlo a partir de cuál 
está ubicado antes en la  lista 
-}
--ordenDeCargos = ["presidente","vicepresidente"...]


{- 
Para la fórmula alcanza con una tupla, 
aunque también se podría haber definido un nuevo tipo de dato.
Siendo sólo dos valores, no justifica una lista 
-}
type Formula = (Dirigente,Dirigente) 

{- 
Los modos de construcción política los modelamos como un par de funciones
que devuelven un dirigente de entre una lista de dirigentes 
-}

type Construccion = [Dirigente]->Dirigente

{- 
El armado de la fórmula se puede como dos problemas:
Por un lado un función que hace la busqueda de todos los dirigentes 
de todos los partidos de la alianza,
y por otro lado, una funcion que aplica sobre ellos 
los dos modos de construcción política y permite obtener la fórmula 
-}

armarFormula:: (Construccion,Construccion) -> Alianza -> [Dirigente]->   Formula
armarFormula modoConstruccion alianza dirigentes =
    elegirCandidatos  modoConstruccion (dirigentesDe alianza dirigentes)
-- armarFormula modoConstruccion alianza = 
--    elegirCandidatos modoConstruccion . dirigentesDe alianza

elegirCandidatos:: (Construccion,Construccion) -> [Dirigente]  -> Formula
elegirCandidatos (constrPresi,constrVice) dirigentes  =
    (constrPresi dirigentes, constrVice dirigentes)

{- 
Otra forma es definir una funcion local 
-}
--armarFormula (constrPresi,constrVice) alianza dirigentes  =
--    (constrPresi dirigentesAlianza, constrVice dirigentesAlianza)
--        where dirigentesAlianza = dirigentesDe alianza dirigentes)

dirigentesDe alianza dirigentes = 
    filter (\d -> elem (partido d) alianza) dirigentes
--    filter (suPartidoEstaEn alianza) dirigentes
--    filter (flip elem alianza.partido) dirigentes
-- suPartidoEstaEn alianza dirigente = elem (partido dirigente) partidos

{- 
Los modos de construcción política requeridos resultan ser muy similares
entre sí y en definitiva responden a dos patrones:
- la búsqueda de un mejor dirigente de acuerdo a alguna cualidad, 
(la importancia del cargo, la buena imagen, la cantidad de habilidades)
- cualquier dirigente que verifique cierta condición
(ser gobernador y honesto, tener buena imagen) 
Para ello, vamos a utilizar dos funciones de orden superior, 
las cuales aplicamos parcialmente con el correpondiente criterio,
para que luego al armar la fórmula completen su aplicación.
Los definimos como constantes para facilitar las pruebas 
-}

granCargo,conGobernador,habilidoso::(Construccion,Construccion)
granCargo = (maximoSegun cargo, cualquieraQue buenaImagen )
conGobernador = (maximoSegun imagen, cualquieraQue gobernadorHonesto )
habilidoso = (maximoSegun cantHabilidades, maximoSegun imagen)

{- 
Si bien hay varias formas de obtener un máximo de acuerdo a un criterio,
la más simple es foldeando con una función de orden superior que permita
obtener el mejor entre dos elementos. 
Si bien acá la utilizamos con dirigentes y cualidades, 
en realidad su definición es más genérica 
y puede servir para cualquier tipo de dato. 
La función que se recibe como criterio tiene que poder aplicarse 
sobre un elemento de la lista y devolver algo ordenable 
-}

maximoSegun::Ord b => (a->b)->[a]->a
maximoSegun criterio elementos = foldl1 (maxSegun criterio) elementos
--maximoSegun criterio = foldl1 (maxSegun criterio) 

{- 
Dado un criterio y dos elementos, 
retorna el elemento para el cual aplicar el criterio resulta un mayor valor
-}
maxSegun::Ord b => (a->b)->a->a->a
maxSegun criterio x1 x2 
   | criterio x1 > criterio x2 = x1
   | otherwise = x2

{- 
Una variante sutil es utilizando foldl, que requiere identificar un valor inicial 
-}
--maximoSegun criterio elementos 
--    = foldl (maxSegun criterio) (head elementos) (tail elementos)

{- 
Una variante mucho más algorítmica es utilizando el maximum de las listas, 
pero requiere luego buscar a cuál elemento le corresponde ese máximo 
-}
--maximoSegun criterio elementos = head (filter (\e => criterio e == maximum (map criterio elementos) ) elementos)

{- 
Otro camino es usar la función de biblioteca maximumBy pero que tiene sus particularidades 
-}   

{- 
Para obtener algun dirigente que cumpla con una condición, 
tambíen definimos una función de orden superior que reciba la condición
y la hacemos de tipo variable.
En este caso usamos arbitrariamente un head, podría ser last u otra función 
-}

cualquieraQue:: (a -> Bool) -> [a] -> a
cualquieraQue criterio elementos = head (filter criterio elementos)
--cualquieraQue criterio elementos = (head.filter criterio) elementos
--cualquieraQue criterio = head.filter criterio

{- 
Lo que es considerado una solución poco funcional, es hacer una función diferente
 para cada una de las búsquedas, repitiendo lógica una y otra vez 
 -}
--dirigenteMayorImagen:: [Dirigente]->Dirigente
--dirigenteMayorImagen dirigentes = foldl1 mayorImagen dirigentes
--mayorImagen d1 d2 
--  | imagen d1 > imagen d2 = d1
--  | otherwise = d2

--cualquieraBuenaImagen:: [Dirigente]->Dirigente
--cualquieraBuenaImagen dirigentes = head (filter buenaImagen dirigentes)


---------------- FUNCIONES AUXILIARES ------------------

buenaImagen dirigente = imagen dirigente > 20
--buenaImagen  = (>20).imagen  

cantHabilidades = length.habilidades 
--cantHabilidades dirigente = length (habilidades dirigente)

gobernadorHonesto dirigente = 
    cargo dirigente == Gobernador &&
    elem "honestidad" (habilidades dirigente)


{- Una construcción inventada, reutilizando lo anterior, puede ser:
Como presidente el que tiene el cargo de presidente
Como vice, el de peor imagen -}
reeleccion = (cualquieraQue ((==Presidente).cargo), maximoSegun (((-1)*).imagen) )

------------------- DATOS DE EJEMPLO ----------------------

pepe = UnDirigente {
    nombre = "Jose",
    imagen = 34,
    habilidades = ["hablar","rosquear"],
    cargo = Gobernador,
    partido = "ucr"
}

carlos = UnDirigente {
    nombre = "Carlos",
    imagen = 17,
    habilidades = ["honestidad","trabajo","programar en haskell"],
    cargo = Gobernador,
    partido = "cc"
}

mauri = UnDirigente {
    nombre = "Mauricio",
    imagen = 10,
    habilidades = ["timbrear"],
    cargo = Presidente,
    partido = "pro"
}

migue = UnDirigente {
    nombre = "Miguel",
    imagen = 5,
    habilidades = [],
    cargo = Senador,
    partido = "pro"
}

juan = UnDirigente {
    nombre = "Juan",
    imagen = 50,
    habilidades = ["honestidad"],
    cargo = Gobernador,
    partido = "pj"
}


--La lista de todos los dirigentes.
dirigentesEjemplo = [juan,mauri,pepe,carlos,migue] 
--La lista de los partidos políticos de cada alianza.
cambiemos = ["pro","ucr","cc"] 
todos = ["uc","pj"] 

----------------------------- CONSULTAS ----------------------------------
p1 = armarFormula granCargo cambiemos dirigentesEjemplo
p2 = armarFormula conGobernador cambiemos dirigentesEjemplo
p3 = armarFormula habilidoso cambiemos dirigentesEjemplo
p4 = armarFormula reeleccion cambiemos dirigentesEjemplo

p5 = armarFormula granCargo todos dirigentesEjemplo
p6 = armarFormula conGobernador todos dirigentesEjemplo
p7 = armarFormula habilidoso todos dirigentesEjemplo
