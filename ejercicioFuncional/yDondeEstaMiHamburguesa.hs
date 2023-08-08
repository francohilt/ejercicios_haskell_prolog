-- ¿Y donde está mi hamburguesa? --

------------- TIPOS DE DATOS -------------

data Combo = Combo {
    hamburguesa :: [Ingrediente],
    bebida :: Bebida,
    acompaniamiento :: String 
    } deriving Show
    
data Bebida = Bebida {
    tipo :: String,
    tamanio :: Tamanio,
    light :: Bool
    } deriving (Show, Eq)

type Ingrediente = String
type Tamanio = Int


------------- DATOS PARA CONSULTAS -------------

cajitaFeliz, dobleMcBacon :: Combo
cajitaFeliz = Combo ["Carne", "Queso", "Pan"] aguaSinGas "Papas"
dobleMcBacon = Combo ["Carne", "Queso", "Pan", "Cheddar", "Panceta", "Cebolla", "Mostaza", "Ketchup"] cocaColaLight "Papas"

aguaSinGas, cocaColaLight :: Bebida
aguaSinGas = Bebida "Agua Mineral" regular False
cocaColaLight = Bebida "Gaseosa" mediano True

regular, mediano, grande :: Tamanio
regular = 1
mediano = 2
grande = 3

informacionNutricional :: [(Ingrediente, Integer)]
informacionNutricional = [
    ("Carne", 250), 
    ("Queso", 50), 
    ("Pan", 20), 
    ("Panceta", 541),
    ("Lechuga", 5), 
    ("Tomate", 6),
    ("Cebolla", 4),
    ("Cheddar", 75)
    ]

condimentos :: [String]
condimentos = ["Barbacoa", "Mostaza", "Mayonesa", "Ketchup"]

----------------------------------------------------------------------

-- 1. Queremos saber cuántas calorías tiene un ingrediente, 
-- esto puede obtenerse a partir de la información nutricional, 
-- a menos que sea un condimento, en cuyo caso la cantidad de calorías es 10.

cuantasCaloriasTiene :: Ingrediente -> Integer
cuantasCaloriasTiene unIngrediente
    | unIngrediente `elem` condimentos = 10
    | otherwise = calorias unIngrediente

calorias :: Ingrediente -> Integer
calorias unIngrediente = (head.map snd) (filter(\x-> (fst x) == unIngrediente) informacionNutricional)

-- EJEMPLOS DE CONSULTAS:
--      cuantasCaloriasTiene "Barbacoa" --> 10
--      cuantasCaloriasTiene "Carne" --> 250
--      cuantasCaloriasTiene "Panceta" --> 541  
--      cuantasCaloriasTiene "Mostaza" --> 10

----------------------------------------------------------------------

-- 2. Se quiere saber si un combo esMortal. 
-- Esto se cumple cuando la bebida no es dietética y la hamburguesa es una bomba 
-- (si tiene entre sus ingredientes al menos uno que tenga más de 300 calorías, 
-- o si en total la hamburguesa supera las 1000 calorías).

esMortal :: Combo -> Bool
esMortal unCombo = (tipo.bebida) unCombo /= "Dietetica" && esUnaBomba (hamburguesa unCombo)

esUnaBomba :: [Ingrediente] -> Bool
esUnaBomba unaHamburguesa = any ((>300).cuantasCaloriasTiene) unaHamburguesa || tieneMasDe1000Calorias unaHamburguesa

tieneMasDe1000Calorias :: [Ingrediente] -> Bool
tieneMasDe1000Calorias unaHamburguesa = (sum.map cuantasCaloriasTiene) unaHamburguesa > 1000

-- EJEMPLOS DE CONSULTAS:
--      esMortal dobleMcBacon  --> True
--      esMortal cajitaFeliz --> False

----------------------------------------------------------------------

-- 3. Definir una función que permita obtener a partir de un combo y una lista de alteraciones, 
-- el combo resultante de alterar el combo con todas las alteraciones indicadas. 
-- Las alteraciones puedan ser las siguientes:

-- a. cambiarAcompaniamientoPor: retorna el combo con otro acompaniamiento elegido por el cliente.

cambiarAcompaniamientoPor :: String -> Combo -> Combo
cambiarAcompaniamientoPor unAcompaniamiento unCombo = unCombo {acompaniamiento = unAcompaniamiento}

-- EJEMPLO DE CONSULTA:
-- cambiarAcompaniamientoPor "Nugets" cajitaFeliz.
--  Combo {
    --      hamburguesa = ["Carne","Queso","Pan"], 
    --      bebida = Bebida {tipoBebida = "Agua Mineral", tamanioBebida = 1, light = False}, 
    --      acompaniamiento = "Nugets"}

-- b. agrandarBebida: retorna el combo agrandando la bebida al tamanio siguiente 
-- (teniedo en cuenta que el máximo es el tamanio grande, 
-- no importa cuánto se lo trate de seguir agrandando).

-- Ya que el mayor tamanio es 3 en ese caso devuelvo el mismo combo.
-- Y en caso de que no sea 3, se que es 2 o bien 1, y por eso le sumo 1 al tamanio.

agrandarBebida :: Combo -> Combo
agrandarBebida (Combo unaHamburguesa unaBebida unAcompaniamiento)
    | tamanio unaBebida == 3 = Combo unaHamburguesa unaBebida unAcompaniamiento
    | otherwise = Combo unaHamburguesa (aumentarTamanio unaBebida) unAcompaniamiento

aumentarTamanio :: Bebida -> Bebida
aumentarTamanio unaBebida = unaBebida {tamanio = tamanio unaBebida +1}


-- OTRA FORMA:

{- agrandarBebida :: Combo -> Combo
agrandarBebida (Combo hamburguesa bebida acompaniamiento) = Combo hamburguesa (cambiarTamanio bebida) acompaniamiento

cambiarTamanio :: Bebida -> Bebida
cambiarTamanio bebida
    | tamanio bebida == regular = bebida{tamanio = mediano}
    | tamanio bebida == mediano = bebida{tamanio = grande}
    | otherwise = bebida -}


-- EJEMPLOS DE CONSULTAS:
-- agrandarBebida cajitaFeliz --> 
    -- Combo {
        --hamburguesa = ["Carne","Queso","Pan"], 
        -- bebida = Bebida {tipoBebida = "Agua Mineral", tamanioBebida = 2, light = False}, 
        -- acompaniamiento = "Papas"}

-- agrandarBebida dobleMcBacon -->
    -- Combo {
        -- hamburguesa = ["Carne","Queso","Pan","Cheddar","Panceta","Cebolla","Mostaza","Ketchup"], 
        -- bebida = Bebida {tipoBebida = "Gaseosa", tamanioBebida = 3, light = True}, 
        -- acompaniamiento = "Papas"}

-- c. peroSin: 
-- retorna el combo de modo que su hamburguesa no incluya ingredientes que cumplan con
-- una determinada restricción.

peroSin :: (Ingrediente -> Bool) -> Combo -> Combo
peroSin unaRestriccion unCombo = unCombo {hamburguesa = filter(not.unaRestriccion)  (hamburguesa unCombo)}

condimento :: Ingrediente -> Bool
condimento ingrediente = any(==ingrediente) condimentos

masCaloricoQue :: Integer -> Ingrediente -> Bool
masCaloricoQue cal ingrediente = cuantasCaloriasTiene ingrediente > cal

-- EJEMPLO DE CONSULTA:
-- peroSin (masCaloricoQue 100) dobleMcBacon -->
    -- Combo {
        -- hamburguesa = ["Queso","Pan","Cheddar","Cebolla","Mostaza","Ketchup"], 
        -- bebida = Bebida {tipoBebida = "Gaseosa", tamanioBebida = 2, light = True}, 
        -- acompaniamiento = "Papas"}

----------------------------------------------------------------------

-- 4. Asumiendo que se tiene una constante comboDePrueba :: Combo , realizar una consulta con la función
-- definida anteriormente para alterar ese combo considerando que se quieren hacer las siguientes
-- alteraciones: agrandar la bebida, cambiar el acompañamiento por “Ensalada César”, que venga sin
-- condimento, que venga sin ingredientes con más de 400 calorías y que venga sin queso.

comboDePrueba :: Combo
comboDePrueba = Combo ["Carne", "Queso", "Pan", "Cheddar", "Panceta", "Cebolla", "Mostaza", "Ketchup"] cocaColaLight "Papas"
 
alteracionesDePrueba:: [Combo -> Combo]
alteracionesDePrueba = [agrandarBebida,(cambiarAcompaniamientoPor "Ensalada Cesar"), (peroSin condimento), (peroSin (masCaloricoQue 400)),(quitar "Queso")]

aplicar :: Combo -> (Combo -> Combo) -> Combo
aplicar combo alteracion = alteracion combo

quitar :: Ingrediente -> Combo -> Combo
quitar elemento combo = combo {hamburguesa = quitarElemento elemento (hamburguesa combo)}

quitarElemento :: Ingrediente -> [Ingrediente] -> [Ingrediente]
quitarElemento elemento unaHamburguesa = filter(/= elemento) unaHamburguesa

realizar :: [(Combo -> Combo)] -> Combo -> Combo
realizar alteraciones combo = foldl aplicar combo alteraciones

-- EJEMPLO DE CONSULTA:
-- realizar alteracionesDePrueba comboDePrueba -->
    -- Combo {hamburguesa = ["Carne","Pan","Cheddar","Cebolla"], 
    -- bebida = Bebida {tipoBebida = "Gaseosa", tamanioBebida = 3, light = True}, 
    -- acompaniamiento = "Ensalada Cesar"}

----------------------------------------------------------------------

--5. Saber si un conjunto de alteraciones alivianan un combo, 
-- que será cierto si el combo recibido es mortal,
-- pero luego de aplicar las alteraciones indicadas no lo es.

-- EJEMPLO DE CONSULTA:
-- esMortal comboDePrueba --> True
-- esMortal (realizar alteracionesDePrueba comboDePrueba) --> False

