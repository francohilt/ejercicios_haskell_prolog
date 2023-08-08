-- Definicion de Tipos de datos

-- Los obreros tienen estas cuatro características, todas de distinto tipo. 
data Obrero = UnObrero {
 tareas :: [String],
 seguridad :: Seguridad,
 sueldo :: Float,
 estaEnBlanco :: Bool
} deriving Show

-- De los gerentes nos interesa representar su forma de mejora de condiciones hacia los obreros 
-- y la información para saber si realiza la mejora o no.
-- Las formas de mejorar son funciones que reciben un obrero y lo devuelven modificaro. 
-- Cada gerente puede tener su forma de mejorar, siempre y cuando respenten el tipo de dato. 
-- Para analizar si corresponde hacer la mejora, basta con definir una lista con tareas, 
-- ya que todas las formas de verificar de los gerentes dados son similares y se basan sólo en esas tareas.
-- Una variante para permitir que el gerente pueda analizar si realiza las mejoras con mas variedad de alternativas
-- sería definirla también como función de tipo Obrero -> Bool. 

data Gerente = UnGerente {
    tareasQuePreocupan :: [String],
    mejora:: Obrero -> Obrero
} 
--Usar un tipo con diferentes constructores es la forma que mejor se ajusta a la variedad de instrumentos de seguridad
data Seguridad = 
    Ninguno | 
    Basico Int |
    Reforzado Int Int
    deriving Show

--Una forma mas precaria, pero que también funciona es con un tipo de dato con un único constructor, o con tupla, 
--pero se vuelve necesario definir valores que no se utilizan para completar la estructura.
--Por ejemplo, se deberia agregar arbitrariamente un 0 y 0 como valor de resistencia y refuerzo del que no tiene seguridad.

-- type Seguridad = (String, Float, Float)
{-
data Seguridad = UnInstrumental {
 descripcion :: String,
 resistencia :: Int,
 refuerzo :: Int
} deriving Show
-}

---------------------------------- 1 -----------------------------------------------
--MEJORAS
mejorarSeguridad :: Obrero -> Obrero
mejorarSeguridad obrero = obrero {seguridad = mejorarInstrumental (seguridad obrero)}

-- Con pattern matching con los diferentes constructores manejamos las alternativas de mejoras
mejorarInstrumental::Seguridad -> Seguridad
mejorarInstrumental Ninguno = Basico 10
mejorarInstrumental (Basico resistencia) 
  | resistencia <= 50 = Basico (resistencia + resistencia)
  | otherwise = Reforzado resistencia 0
mejorarInstrumental (Reforzado resistencia refuerzo) = Reforzado resistencia (refuerzo + resistencia) 

--mejorar el sueldo equivale a aumentarles 1000  
aumentarSueldo :: Obrero -> Obrero
aumentarSueldo obrero = obrero {sueldo = sueldo obrero *1.1} 

ponerEnBlanco :: Obrero -> Obrero
ponerEnBlanco obrero = obrero {estaEnBlanco = True} 

------------------ a
reclamoIndividual :: Gerente ->  Obrero -> Obrero
reclamoIndividual gerente obrero  
 | lePreocupa obrero gerente = (mejora gerente) obrero 
 | otherwise = obrero
-- Aquí esta la logica genérica con la que todos los gerentes responden a los reclamos:
-- cuando al gerente le preocupa alguna de las tareas del obrero, aplica su mejora.
-- al hacer (mejora gerente) obtenemos la funcion de mejora que tiene el gerente y así la aplicamos al obrero
-- cuando no cumple con el requisito, el obrero se retorna igual que como estaba

lePreocupa :: Obrero -> Gerente -> Bool
lePreocupa obrero gerente = any (haceTarea obrero) (tareasQuePreocupan gerente)

-- se fija si a alguna de las tareas que le procupan al gerente, el obrero la hace.

haceTarea :: Obrero -> String -> Bool
haceTarea obrero tarea = elem tarea (tareas obrero)

------------------ b
reunion :: [Obrero] -> Gerente -> [Obrero]
reunion obreros gerente = map (reclamoIndividual gerente.reclamoIndividual gerente) obreros
-- Usamos map para que la reunion afecte a todos los obreros que participan. 
-- Para lograr el doble efecto, componemos la función consigo misma, y la aplicamos parcialmente.

------------------- c
tomaDeLaFabrica :: [Obrero] -> [Gerente] -> [Obrero]
tomaDeLaFabrica obreros gerentes = map (reclamoGeneral gerentes) (filter estaEnBlanco obreros)

reclamoGeneral:: [Gerente] -> Obrero -> Obrero
reclamoGeneral gerentes obrero = foldr reclamoIndividual obrero gerentes

------------------------ 2 -------------------------------------------
--gerente nuevo
gerenteCopado::Gerente
gerenteCopado = UnGerente ["bailar salsa en la oficina del jefe","cantar reggae"] mejoraCopada

mejoraCopada :: Obrero -> Obrero
mejoraCopada obrero = obrero {tareas = "cantar cumbia con la supervisora":tareas obrero} 
 

------------------------ 3 --------------------------------------------
--Datos de ejemplo
juan, ana, pedro, luis, nn ::Obrero
juan = UnObrero ["pulir","soldar","bailar salsa en la oficina del jefe"] (Basico 40) 1000 True
ana = UnObrero ["fundir","hacer mandados"] Ninguno 5000 False
pedro = UnObrero ["soldar","hacer mandados"] (Reforzado 100 200) 10000 True
luis = UnObrero ["cantar reggae","pulir"] Ninguno 0 False
nn = UnObrero  [] Ninguno 0 False 

gerenteDeSeguridad::Gerente
gerenteDeSeguridad = UnGerente ["pulir","soldar","fundir"] mejorarSeguridad
gerenteAdministrativo::Gerente
gerenteAdministrativo = UnGerente ["hacer mandados"] aumentarSueldo
gerentePersonal::Gerente
gerentePersonal = UnGerente tareasImprescindibles ponerEnBlanco

tareasImprescindibles::[String]
tareasImprescindibles = ["fundir","soldar"]

ejemploObreros::[Obrero]
ejemploObreros = [juan,ana,pedro,luis,nn]
ejemploGerentes::[Gerente]
ejemploGerentes = [gerenteAdministrativo,gerenteCopado,gerenteDeSeguridad,gerentePersonal]

--Consultas

{-
*Main> reclamoIndividual gerenteDeSeguridad juan
UnObrero {tareas = ["pulir","soldar","bailar salsa en la oficina del jefe"], seguridad = Basico 80, sueldo = 1000.0, estaEnBlanco = True}

*Main> reclamoIndividual gerenteDeSeguridad juan
UnObrero {tareas = ["pulir","soldar","bailar salsa en la oficina del jefe"], seguridad = Basico 80, sueldo = 1000.0, estaEnBlanco = True}

*Main> reclamoIndividual gerenteDeSeguridad luis
UnObrero {tareas = ["cantar reggae","pulir"], seguridad = Basico 10, sueldo = 0.0, estaEnBlanco = False}

*Main> reclamoIndividual gerenteDeSeguridad pedro
UnObrero {tareas = ["soldar","hacer mandados"], seguridad = Reforzado 100 300, sueldo = 10000.0, estaEnBlanco = True}

*Main> reunion ejemploObreros gerenteDeSeguridad
[UnObrero {tareas = ["pulir","soldar","bailar salsa en la oficina del jefe"], seguridad = Reforzado 80 0, sueldo = 1000.0, estaEnBlanco = True},UnObrero
{tareas = ["fundir","hacer mandados"], seguridad = Basico 20, sueldo = 5000.0, estaEnBlanco = False},UnObrero {tareas = ["soldar","hacer mandados"], seguridad = Reforzado 100 400, sueldo = 10000.0, estaEnBlanco = True},UnObrero {tareas = ["cantar reggae","pulir"], seguridad = Basico 20, sueldo = 0.0, estaEnBlanco = False},UnObrero {tareas = [], seguridad = Ninguno, sueldo = 0.0, estaEnBlanco = False}]

*Main> reclamoIndividual gerenteCopado juan
UnObrero {tareas = ["cantar cumbia con la supervisora","pulir","soldar","bailar salsa en la oficina del jefe"], seguridad = Basico 40, sueldo = 1000.0, estaEnBlanco = True}

*Main> reclamoIndividual gerenteCopado ana
UnObrero {tareas = ["fundir","hacer mandados"], seguridad = Ninguno, sueldo = 5000.0, estaEnBlanco = False}

*Main> tomaDeLaFabrica [ana,juan] [gerenteDeSeguridad,gerenteCopado]
[UnObrero {tareas = ["cantar cumbia con la supervisora","pulir","soldar","bailar salsa en la oficina del jefe"], seguridad = Basico 80, sueldo = 1000.0,
estaEnBlanco = True}]

*Main> tomaDeLaFabrica [ana,juan,pedro] [gerenteDeSeguridad,gerenteCopado]
[UnObrero {tareas = ["cantar cumbia con la supervisora","pulir","soldar","bailar salsa en la oficina del jefe"], seguridad = Basico 80, sueldo = 1000.0,
estaEnBlanco = True},UnObrero {tareas = ["soldar","hacer mandados"], seguridad = Reforzado 100 300, sueldo = 10000.0, estaEnBlanco = True}]

-}