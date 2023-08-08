import Text.Show.Functions()

{- -- Tipos de Datos

-- Tuplas
pos :: (Integer, Integer)
pos = (1, 2)

tercero :: (a, b, c) -> c
tercero (_, _, c) = c

cuarto :: (a, b, c, d) -> d
cuarto (_, _, _, d) = d

-- 2 formas de escribir funciones usando tuplas

-- accediendo a las componentes usando funciones existentes
-- (fst y snd)

suma :: Num a => (a, a) -> a
suma tupla = fst tupla + snd tupla

-- matcheando directamente en la estructura de la tupla
suma2 :: Num a => (a, a) -> a
suma2 (x, y) = x + y

-- tambien se puede devolver tuplas

duplicar :: b -> (b, b)
duplicar x = (x, x)

-- listas
-- algunos usos
-- length [1,2,4] --> 3
-- head [1,2,3,4] --> 1
-- last [1,2,3,4] --> 4

-- estructura de una lista
-- [] : lista vacia
-- (x:xs) : (cabeza:cola)

sumatoria :: Num p => [p] -> p
sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs
 
-- sumatoria [1,2,3] = 1 + sumatoria [2,3]
--                   = 1 + (2 + sumatoria [3])
--                   = 1 + (2 + (3 + sumatoria []))
--                   = 1 + 2 + 3 + 0
--                   = 6

-- [3] == (3:[])

productoria :: Num p => [p] -> p
productoria [] = 1
productoria (x:xs) = x * productoria xs


-- practicando matcheos en listas
sumarPrimeros2 :: Num a => [a] -> a
sumarPrimeros2 [] = 0
sumarPrimeros2 [x] = x 
sumarPrimeros2 (primero:(segundo:_)) = primero + segundo
--sumarPrimeros2 (primero:(segundo:elResto)) = primero + segundo


-- funciones varias sobre listas
-- primer elemento => head lista
-- head [True, False] ---> True
-- tail [1,2,3,4,5] -----> [2,3,4,5]

-- sumatoria de una lista de numeros usando head y tail
sumatoriaSinPatrones :: Num p => [p] -> p
sumatoriaSinPatrones [] = 0
sumatoriaSinPatrones lista = head lista + sumatoriaSinPatrones (tail lista)

sumarListas :: Num a => [a] -> [a] -> [a]
sumarListas [] [] = []
sumarListas [] _ = []
sumarListas _ [] = []
sumarListas (y:ys) (x:xs) = (x + y) : sumarListas ys xs

-- sumarListas [1,2,3,4] [1,2,3,4] devuelve [2, 4, 6, 8]

sumarLargoDeListas :: (Foldable t1, Foldable t2) =>
                        t1 a1 -> t2 a2 -> Int
sumarLargoDeListas lista1 lista2 = length lista1 + length lista2

--Crear tipos de datos

-- ("marcos", [("chocolate", 200)])
data Ingrediente = Ing String
    deriving Show
data Pastelero = UnPastelero String [Ingrediente]
    deriving Show

-- marcosData = UnPastelero "marcos" ["chocolate"]
marcosData :: Pastelero
marcosData = UnPastelero "marcos" [Ing "chocolate"]

nombre :: Pastelero -> String
nombre (UnPastelero nombreN _) = nombreN

ingrediente :: Pastelero -> [Ingrediente]
ingrediente (UnPastelero _ ingredientes) = ingredientes

-- usamos todos los ingredientes del pastelero

--usarTodosLosIng (UnPastelero nombre ingredientes) = UnPastelero nombre []

-- Record

data PasteleroR = UnPasteleroR {
    nombrePastelero :: String,
    ingredientesPastelero :: [Ingrediente]
    }
    deriving Show

marcosRecord :: PasteleroR
marcosRecord = UnPasteleroR {nombrePastelero = "marcos", ingredientesPastelero = []}

-- modificando records:
-- para cambiar algun campo del record podemos usar la siguiente sintaxis
marcosPastelero :: PasteleroR
marcosPastelero = marcosRecord {nombrePastelero = "pastelero marcos"}

--usarTodosLosIngRecord (UnPasteleroR nombre ingredientes) = UnPasteleroR nombre []

data TuplaDe3 = UnaTuplaDe3 {fst3 :: Bool, snd3 :: Bool, thrd3 :: Bool}
    deriving Show

tupla3 :: TuplaDe3
tupla3 = UnaTuplaDe3 False True True

triple :: Integer -> Integer
triple = (3 *)

sumaEspecial2 :: Num a => (t -> a) -> t -> t -> a
sumaEspecial2 criterio elem1 elem2 =
    criterio elem1 + criterio elem2

----------------------------------------------------------------
aproboAlumno :: Int -> Bool
aproboAlumno nota = nota >= 6

pesosADolares :: Float -> Float
pesosADolares pesos = pesos / 85.50

millasAKilometros :: Float -> Float
millasAKilometros millas = millas * 1.60944

doble :: Int -> Int
doble x = 2 * x
        
puedoAvanzar :: String -> Bool
puedoAvanzar color = color == "verde"

cuadruple:: Int -> Int
cuadruple numero = (doble . doble) numero

nombrePar :: String -> Bool
nombrePar nombree = (even . length) nombree

esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe t y = mod t y == 0

esBisiesto :: Integral a => a -> Bool
esBisiesto x = esMultiploDe x 400 || ((esMultiploDe x 4) && not (esMultiploDe x 100))



pesoPino :: (Ord a, Num a) => a -> a
pesoPino h 
    |h<3 = h * 3
    |otherwise = (h - 3)*2 + 9

esPesoUtil :: (Ord a, Num a) => a -> Bool
esPesoUtil p = p > 400 && p < 1000


sirvePino :: (Ord a, Num a) => a -> Bool
sirvePino h = esPesoUtil (pesoPino h) 

tuitCorto :: Foldable t => (a1, t a2) -> Bool
tuitCorto (_,y) = ((<10).(length)) y

nombreCompleto :: [Char] -> [Char] -> [Char] -> [Char]
nombreCompleto n1 n2 ape = n1 ++" " ++ n2 ++ " "++ ape

porcentaje :: Fractional a => a -> a -> a
porcentaje cantidad total = cantidad * 100 / total

----------------------------------------------------

nombreEsPar :: Foldable t => t a -> Bool
nombreEsPar = even.length
--Ej
-- nombreEsPar "Pepe" = (even.length) "Pepe"
-- length ("Pepito") --> 6
--even 4 --> True

--Dada su edad,saber si una persona es mayor de edad.
 
esMayor :: (Ord a, Num a) => a -> Bool
esMayor =  (>18)

type Persona = (String, Integer)

franco :: Persona


franco = ("Franco",22)


noEsMayor :: (Ord a1, Num a1) => (a2, a1) -> Bool
noEsMayor unaPersona = not (snd unaPersona > 18)


--Necesitamos resolver una función que dado un número nos devuelva el siguiente. 


siguiente :: Integer -> Integer
siguiente = (1+)

elDobleDe :: Integer -> Integer
elDobleDe = (2*)

-- Queremos saber si una palabra comienza con p.

esP :: Char -> Bool
esP = ('p' ==)

comienzaConP :: [Char] -> Bool
comienzaConP unaPalabra = (esP.head) unaPalabra

--El costo de estacionamiento es de 50 pesos la hora, con un mínimo de 2 horas, esto significa que
--si estamos 1 hora, nos cobrarán por 2 horas
--si estamos 3 horas, nos cobrarán por 3 horas

costo :: (Num c, Ord c) => c -> c
costo horas = ((*50).max 2) horas

data Vehiculo = Propio Float | Contratado String Float

type Flota = [Vehiculo]

vehiculos :: Flota
vehiculos = [Propio 9, Propio 15, Contratado "Remixes" 4, Propio 12]

valorLitroNafta :: Float
valorLitroNafta = 16.5

costoPorKm :: Vehiculo -> Float
costoPorKm (Propio consumo)     = valorLitroNafta * (consumo / 10)
costoPorKm (Contratado _ costoo) = costoo

---------------------------------
-- EJEMPLO

type CriterioEstudio = Parcial -> Bool

data Parcial = Parcial {
   materia :: String,
   preguntas :: Int
} 

parcial1 :: Parcial
parcial1 = Parcial  {
    materia = "mates",
    preguntas = 5
}

data Alumno = Alumno {
   nombreA :: String,
   fechaNacimiento :: (Int, Int, Int),
   legajo :: Int,
   materiasQueCursa :: [String],
   criterioEstudio :: CriterioEstudio
} 

nico :: Alumno
nico = Alumno {
    nombreA = "Nico",
    fechaNacimiento = (11,05,1998),
    legajo = 10897,
    materiasQueCursa = ["matematica","lengua"],
    criterioEstudio = estudioso
} 

estudioso :: CriterioEstudio
estudioso _ = True

hijosDelRigor :: CriterioEstudio
hijosDelRigor unParcial = length(materia unParcial ) >  preguntas unParcial

cabuleros :: CriterioEstudio
cabuleros unParcial =  (not.even.length) (materia unParcial)


---------------------------------------------------------------
--Definición con guardas:
{- factorial n 
  | n == 0     = 1
  | n > 0      = n * factorial (n - 1) -}

--Definición con pattern matching:
factorial :: Int -> Int
factorial 0  =  1
factorial n  =  n * factorial (n - 1)

fibonacci :: (Eq a, Num a, Num p) => a -> p
fibonacci 0  = 1
fibonacci 1  = 1
fibonacci n  = fibonacci (n - 1) + fibonacci (n - 2)

--Ejercicio: determinar si un número es primo

primo :: Integral t => t -> Bool
primo 1 = False
primo 2 = True
primo n = noHayDivisores 2 (n - 1) n

noHayDivisores :: Integral t => t -> t -> t -> Bool
noHayDivisores minimo maximo n 
    | esDivisor minimo n = False
    | minimo == maximo   = True
    | otherwise          = noHayDivisores (minimo + 1) maximo n

esDivisor :: Integral a => a -> a -> Bool
esDivisor unNumero otroNumero = mod otroNumero unNumero == 0

longitud :: [a] -> Int
longitud [] = 0
longitud (_:xs) = 1 + length xs -}

---------------------------------------------------

{- data Cliente = Cliente {
    nombre :: String, 
    edad :: Int,
    deuda :: Float,
    facturas :: [Float]
} deriving (Show)

clientes1 :: [Cliente]
clientes1 = [ 
    Cliente "aba" 22 6000 [4000, 5000],
    Cliente "Colombatti" 24 15000 [30000],
    Cliente "Marabotto" 65 200 [500000, 140000]
 ]

clientesEntre20y60 :: [Cliente] -> [Cliente]
clientesEntre20y60 clientes = filter ((\e -> e < 20 || e > 60) . edad) clientes

clientesQueDebenMasDe :: Float -> [Cliente] -> [Cliente]
clientesQueDebenMasDe cantidad  = filter (\unCliente -> deuda unCliente > cantidad)

esPalindromo :: Eq a => [a] -> Bool
esPalindromo unNombre = unNombre == (reverse unNombre)

clientesPalindromos :: [Cliente] -> [Cliente]
clientesPalindromos  = filter(\unCliente -> esPalindromo (nombre unCliente))

clientesConFacturaDe :: Float -> [Cliente] -> [Cliente]
clientesConFacturaDe cantidad  = 
    filter(\unCliente -> (elem cantidad) (facturas unCliente))

deuda0 :: [Cliente] -> [Cliente]
deuda0 = map(\unCliente -> unCliente {deuda = 0}) -}

--Devolver la longitud (en caracteres) de una lista de palabras
{- palabras :: [String]
palabras = ["paradigmas", "rules", "the", "world"]

palabritas :: [String]
palabritas = ["a","b","c","ac"]

cuantosCaracteresTiene :: Foldable t => [t a] -> Int
cuantosCaracteresTiene [] = 0
cuantosCaracteresTiene (x:xs) = length x + cuantosCaracteresTiene (xs) -}

-- Dada dos listas sumar las longitudes de ambas:
{- sumarLongitud :: (Foldable t1, Foldable t2) =>
                   t1 a1 -> t2 a2 -> Int
sumarLongitud lista1 lista2 = foldl1 (+) [length lista1 , length lista2]

data Empleado = Empleado {
    apellido :: String,
    sueldo :: Float,
    cantidadHijos :: Int,
    sector :: String 
} deriving (Show)

type Nomina = [Empleado]

empleados :: Nomina
empleados = [ Empleado "mara" 17000.0 1 "contaduria" ,
              Empleado "maria" 25000.0 3 "contaduria" ] -}


{- intersectar :: (Foldable t, Eq a) => [a] -> t a -> [a]
intersectar [] _ = []
intersectar (x:xs) ys 
    | elem x ys = x: intersectar xs ys
    | otherwise = intersectar xs ys -}


-- Teniendo una lista con tuplas devovler el primer elemento de cada tupla:
{- lista :: [([Char], Integer)]
lista = [("algo",2), ("otroAlgo",5)]

recorrer :: [[Char]]
recorrer = map(\(x,_) -> x) lista

prueba :: [Int] -> Bool
prueba list = ((<=5).head) list

doble :: Integer -> Integer
doble = (2*)

cuadruple :: Integer -> Integer
cuadruple = doble.doble

esPar :: [Char] -> Bool
esPar  = even.length

identidad :: ([Char], Integer)
identidad = ("Franco",22)

esParSuNombre :: Bool
esParSuNombre = esPar(fst identidad) -}

data Obrero = UnObrero {
    tareas :: [String],
    instrumental :: Instrumental,
    sueldo :: Float,
    trabajoEnBlanco :: Bool         
} deriving Show

cacho :: Obrero
cacho = UnObrero ["pulir", "soldar"] (Basico 5) 25000 True

data Instrumental = 
    Ninguno | 
    Basico Int |
    Reforzado Int Int
    deriving Show


data Gerente = UnGerente {
    tareasPreocupantes :: [String],
    mejora :: Obrero -> Obrero
} deriving Show

pepe :: Gerente
pepe = UnGerente ["pulir", "soldar", "fundir"] mejorarSeguridad

argentino :: Gerente
argentino = UnGerente ["hacerMandados"] mejorarSueldo

lePreocupa :: Obrero -> Gerente -> Bool
lePreocupa obrero gerente = any (haceTarea obrero) (tareasPreocupantes gerente)

haceTarea :: Obrero -> String -> Bool
haceTarea obrero tarea = elem tarea (tareas obrero)

mejorarSeguridad :: Obrero -> Obrero
mejorarSeguridad obrero = obrero {instrumental = mejorarInstrumental(instrumental obrero)}

mejorarInstrumental :: Instrumental -> Instrumental
mejorarInstrumental Ninguno = Basico 25
mejorarInstrumental (Basico resistencia)
    | resistencia <= 30 = Basico (2 * resistencia)
    | otherwise = Reforzado resistencia 0
mejorarInstrumental (Reforzado resistencia refuerzo) = Reforzado resistencia (resistencia + refuerzo)

mejorarSueldo :: Obrero -> Obrero
mejorarSueldo obrero = obrero {sueldo = sueldo obrero + 1000}

reclamoIndividual :: Gerente -> Obrero -> Obrero
reclamoIndividual gerente obrero
    | lePreocupa obrero gerente = (mejora gerente) obrero
    | otherwise = obrero

reunion :: [Obrero] -> Gerente -> [Obrero]
reunion obreros gerente = map(reclamoIndividual gerente.reclamoIndividual gerente) obreros


tomaDeLaFabrica :: [Gerente] -> [Obrero] -> [Obrero]
tomaDeLaFabrica gerentes obreros = map(reunionGeneral gerentes) (estanEnBlanco obreros)

estanEnBlanco :: [Obrero] -> [Obrero]
estanEnBlanco obreros = filter(\x-> trabajoEnBlanco x) obreros

reunionGeneral :: [Gerente] -> Obrero -> Obrero
reunionGeneral gerentes obrero = foldr reclamoIndividual obrero gerentes



data Serie = UnaSerie {
    nombre :: String,
    genero :: String,
    duracion :: Int,
    cantTemporadas :: Int,
    calificaciones :: [Int],
    esOriginalDeNetflis :: Bool
    } deriving (Eq, Show)

tioGolpetazo :: Serie
tioGolpetazo = UnaSerie {
    nombre = "One punch man",
    genero = "Monito chino",
    duracion = 24,
    cantTemporadas = 1,
    calificaciones = [5],
    esOriginalDeNetflis = False
    }

cosasExtranias :: Serie
cosasExtranias = UnaSerie {
    nombre = "Stranger things",
    genero = "Misterio",
    duracion = 50,
    cantTemporadas = 2,
    calificaciones = [3,3],
    esOriginalDeNetflis = True
    }

dbs :: Serie
dbs = UnaSerie {
    nombre = "Dragon ball supah",
    genero = "Monito chino",
    duracion = 150,
    cantTemporadas = 5,
    calificaciones = [],
    esOriginalDeNetflis = False
    }

espejoNegro :: Serie
espejoNegro = UnaSerie {
    nombre = "Black mirror",
    genero = "Suspenso",
    duracion = 123,
    cantTemporadas = 4,
    calificaciones = [2,3,3,2],
    esOriginalDeNetflis = True
    }

rompiendoMalo :: Serie
rompiendoMalo = UnaSerie {
    nombre = "Breaking Bad",
    genero = "Drama",
    duracion = 200,
    cantTemporadas = 5,
    calificaciones = [],
    esOriginalDeNetflis = False
    }

treceRazonesPorque :: Serie
treceRazonesPorque = UnaSerie {
    nombre = "13 reasons why",
    genero = "Drama",
    duracion = 50,
    cantTemporadas = 1,
    calificaciones = [3,3,3],
    esOriginalDeNetflis = True
    }

------------------------ Parte 1: Listas básicas ------------------------

-- 1) Crear una maratón con los ejemplos dados. Una maratón es una colección de series.

maratonA :: [Serie]
maratonA = [tioGolpetazo, cosasExtranias, dbs, espejoNegro, rompiendoMalo, treceRazonesPorque]

-- 2) Saber la cantidad de series del maratón

cantidadDeSeries :: [Serie] -> Int
cantidadDeSeries maraton = length maraton

-- 3) Saber si una serie es popular: una serie se considera popular si recibió 3 o más calificaciones.

esPopular :: Serie -> Bool
esPopular serie = length (calificaciones serie) >= 3

-- 4) Averiguar si una serie vale la pena, es decir, si tiene más de una temporada y tiene 3 o más calificaciones.

valeLaPenaS :: Serie -> Bool
valeLaPenaS serie = cantTemporadas serie > 1 && esPopular serie

-- 5) Saber si una maratón vale la pena: 
-- Una maratón vale la pena si la primera y la última serie de la maratón valen la pena, 
-- o bien si está el drama "Breaking Bad", con 5 temporadas y 200 minutos, sin calificar, 
-- que no es original de netflis.

valeLaPenaM :: [Serie] -> Bool
valeLaPenaM maraton = (valeLaPenaS.head) maraton && (valeLaPenaS.last) maraton || estaLaSerie rompiendoMalo maraton

estaLaSerie :: Serie -> [Serie] -> Bool
estaLaSerie serie maraton = elem serie maraton

-- 6) Averiguar si una maratón repunta al final, 
-- lo que sucede si la primera mitad de las series constituyen una maratón que no valdría la pena, 
-- pero la segunda mitad sí. (si es cantidad impar de series de la maratón, 
-- la segunda mitad tiene una serie más que la primera)

repuntaAlFinal :: [Serie] -> Bool
repuntaAlFinal maraton = (not.valeLaPenaM) (primerMitadDeLasSerires maraton) && valeLaPenaM (segundaMitadDeLasSerires maraton) 

primerMitadDeLasSerires :: [a] -> [a]
primerMitadDeLasSerires maraton = take((truncate.(/2).fromIntegral.length) maraton) maraton

segundaMitadDeLasSerires :: [a] -> [a]
segundaMitadDeLasSerires maraton = take((ceiling.(/2).fromIntegral.length) maraton) (reverse maraton)

-- 7) Calcular la calificación de una serie. Es el promedio de las calificaciones recibidas, 
-- (redondeado hacia abajo)

--calificacionPromedio serie = sum(calificaciones serie) / length(calificaciones serie)
-- Así seria la solucion, pero da error ya que no puedo dividr dos numeros enteros.

-- 8) Obtener la dispersión de las calificaciones de la serie, 
-- que es la diferencia entre la mejor y peor calificación. 
-- (Si todas las calificaciones son coincidentes, se deduce que la dispersión es 0),

dispersion :: Serie -> Int
dispersion serie = laMejorCalificacion serie - laPeorCalificacion serie

laPeorCalificacion :: Serie -> Int
laPeorCalificacion serie = minimum(calificaciones serie)

laMejorCalificacion :: Serie -> Int
laMejorCalificacion serie = maximum(calificaciones serie)

-- 9) Calificar una serie, que significa agregar una nueva calificación al final de las anteriores.

calificar :: Serie -> Int -> Serie
calificar serie puntaje = serie{calificaciones = (calificaciones serie) ++ [puntaje]}

-- 10) Hypear una serie: cuando se hypea una serie, 
-- se alteran la primer y última calificación recibida, 
-- aumentándola en 2 estrellas (recordá que la escala de calificación es de 5 estrellas máximo). 
-- Si la serie recibió alguna calificación de 1 estrella, no se puede hypear.

sumarAlPrimerYSegundoElemento :: Num a => [a] -> [a]
sumarAlPrimerYSegundoElemento [] = []
sumarAlPrimerYSegundoElemento (x:xs) = [x + 2] ++ take (length(xs) -1) xs ++ [last(xs) +2]

hypear :: Serie -> [Int]
hypear serie 
        | (not.elem 1) c && head(c)<=3 && last(c) <= 3 = sumarAlPrimerYSegundoElemento(c)
        | otherwise = c
        where c = calificaciones serie