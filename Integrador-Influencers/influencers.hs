type Miedo = (String,Int)
type Gusto = String

data Persona = UnaPersona {
    gustos :: [Gusto],
    miedos :: [Miedo],
    estabilidad :: Float
} deriving (Show,Eq)

maria, juanCarlos, artista :: Persona
maria = UnaPersona ["mecanica"] [("extraterrestres", 600), ("desempleo", 300)] 85
juanCarlos = UnaPersona ["maquillaje","trenes"] [("insectos",100),("coronavirus",10),("vacunas",20)] 51
artista = UnaPersona ["chocolate","trenes"] [] 60

-- Que una persona se vuelva miedosa a algo en cierta medida,
-- agregándole el nuevo miedo o aumentando su medida, en caso de ya tener ese miedo previamente.

agregarMiedo :: Miedo -> Persona -> Persona
agregarMiedo miedo persona
    | tieneMiedo miedo persona = aumentarMiedo miedo persona 
    | otherwise = nuevoMiedo miedo persona

tieneMiedo :: Miedo -> Persona -> Bool
tieneMiedo (descripcion,_) persona = any (\(x,_) -> x == descripcion) (miedos persona)

aumentarMiedo :: Miedo -> Persona -> Persona
aumentarMiedo (descripcion,medida) persona = 
    persona{miedos = (aumentar medida (miedoAnterior descripcion persona)):otrosMiedos descripcion persona }

miedoAnterior :: String -> Persona -> Miedo
miedoAnterior descripcion persona = head (filter (\(x,_) -> x == descripcion) (miedos persona))

otrosMiedos :: String -> Persona -> [Miedo]
otrosMiedos descripcion persona = filter (\(x,_) -> x /= descripcion) (miedos persona)

aumentar :: Int -> Miedo -> Miedo
aumentar incremento (descripcion, medida) = (descripcion, medida + incremento)

nuevoMiedo :: Miedo -> Persona -> Persona
nuevoMiedo miedo persona = persona{miedos = miedo:miedos persona}

--Variante con recursividad
agregarMiedo' :: Miedo -> Persona -> Persona
agregarMiedo' miedo persona = persona{miedos = agregar miedo (miedos persona)}

agregar:: Miedo -> [Miedo] -> [Miedo]
agregar miedo [] = [miedo]
agregar (nuevaDescripcion,nuevaMedida) ((descripcion,medida):miedos) 
    | nuevaDescripcion == descripcion = (descripcion,medida+nuevaMedida):miedos
    | otherwise = (descripcion,medida):agregar (nuevaDescripcion,nuevaMedida) miedos

-- Que una persona pierda pierda el miedo a algo, lo que independiente de en qué medida lo tuviera,
-- lo deja de tener. (En caso de no tener ese miedo, no cambia nada)

perderMiedo :: String->Persona->Persona
perderMiedo descripcion persona = 
    persona {miedos = otrosMiedos descripcion persona}

-- Que una persona pueda variar su estabilidad en una cierta proporción dada,
-- pero sin salirse de los límites de la escala.

variarEstabilidad :: Float -> Persona -> Persona
variarEstabilidad indice persona =
    persona {estabilidad = (max 0.min 100.(indice*).estabilidad) persona}

-- Que una persona se vuelva fan de otra persona, en ese caso asume como propios todos los gustos de la otra persona
-- (si ya tenía previamente alguno de esos gustos, lo va a tener repetido)

-- Le agrega al primero los gustos del segundo
volverseFan :: Persona -> Persona -> Persona
volverseFan deQuien persona = 
    persona { gustos = gustos persona ++ gustos deQuien }

-- Averiguar si una persona es fanática de un gusto dado, que es cuando tiene más de tres veces dicho gusto.

fanatico :: Gusto -> Persona -> Bool
fanatico gusto persona = masDe3 (repeticionesGusto gusto persona)

masDe3 :: [a] -> Bool
masDe3 lista = length lista > 3

-- Utilizando evaluación diferida 
masDe3' (_:_:_:_:_) = True
masDe3' _ = False 

repeticionesGusto :: Gusto -> Persona -> [Gusto]
repeticionesGusto gusto persona = filter (==gusto) (gustos persona)


-- Averiguar si una persona es miedosa, cuando el total de la medida de todos sus miedos sumados supera 1000.

esMiedosa :: Persona -> Bool
esMiedosa persona = sum (map snd (miedos persona)) > 1000

------ INFLUENCIADORES ------

-- No se sabe si los influencers son personas, seres de otra especie o conglomerados anónimos de bits,
-- pero lo que sí sabemos es que existen y afectan a las personas de distintas formas.
-- Pese a que muchas personas se creen que son inmunes a las influencias externas,
-- lo cierto es que el influencer actúa directamente sobre una persona sin que esta persona lo sepa. Algunos de ellos son:

type Influencer = Persona -> Persona

-- Hay uno que podría intervenirle la televisión a María para hacerle creer
-- que los extraterrestres están instalando una falsa pandemia. El impacto sería que se disminuya su estabilidad en 20 unidades,
-- que tenga miedo a los extraterrestres en 100 y al coronavirus en 50.
et :: Influencer
et = agregarMiedo ("extraterrestres", 100).agregarMiedo ("coronavirus", 50).variarEstabilidad (-1.2)

-- Hay otro, Marcos, que hace que una persona le de miedo a la corrupción en 10, le pierda el miedo a convertirse en Venezuela
-- y que agrega el gusto por escuchar.
escuchador :: Influencer
escuchador = perderMiedo "convertirseEnVenezuela".agregarMiedo ("corrupcion",10).agregarGusto "escuchar"

agregarGusto :: Gusto->Persona->Persona
agregarGusto gusto persona = persona {gustos = gusto:gustos persona}

-- El community manager de un artista es un influencer que hace que la gente se haga fan de dicho artista.
communityManager :: Persona -> Influencer
communityManager alguien = volverseFan alguien

-- influencer inutil, que no lograr alterar nada
inutil :: Influencer
inutil = id

-- Uno a tu elección, pero que tambien realice uno o más cambios en una persona.
-- El influencer copión, que hace lo mismo que otro influencer, perodos veces 
copion:: Influencer->Influencer
copion deQuien = deQuien.deQuien

-- 1) Hacer una campaña de marketing básica, que dado un conjunto de personas hace que todas ellas
-- sean influenciadas por un influencer dado.

campania ::  Influencer -> [Persona] -> [Persona]
campania influencer personas = map influencer personas
-- campania = map 

-- Variante

type Influencer' = [Persona->Persona]

et' = [
    agregarMiedo ("extraterrestres", 100),
    agregarMiedo ("coronavirus", 50),
    variarEstabilidad (-1.2)]


escuchador' = [ 
    perderMiedo "convertirseEnVenezuela",
    agregarMiedo ("corrupcion", 10),
    agregarGusto "escuchar"]

communityManager' = [ volverseFan artista ]

inutil' = []

copion' deQuien = deQuien ++ deQuien

-- influencer copion infinito
copionInfinito deQuien = concatMap (\_ -> deQuien) [1..]

influenciar :: Influencer' -> Persona -> Persona
influenciar influencer persona = foldr ($) persona influencer
--influenciar influencer = foldl1 (.) infuencer (falla con lista vacia, hacer inutil' = [id])

campania' ::  Influencer' -> [Persona] -> [Persona]
campania' influencer personas = map (influenciar influencer) personas


-- 2) Saber qué influencer es más generador de miedo: dada una lista de personas y dos influencer,
-- saber cuál de ellos provoca que más personas se vuelvan miedosas.

cantidadMiedosas :: Influencer -> [Persona] -> Int
cantidadMiedosas influencer = length.filter esMiedosa.campania influencer

masAterrador :: [Persona] -> Influencer -> Influencer -> Influencer
masAterrador personas inf1 inf2 
    | cantidadMiedosas inf1 personas > cantidadMiedosas inf2 personas = inf1
    | otherwise = inf2

------ LA INFLUENCIACION ------

-- El objetivo principal de influenciar, sin embargo, es vender productos.
-- De cada producto se saben dos cosas: el gusto que se necesita que tenga la persona para
-- comprarlo y una condición adicional específica de ese producto.

data Producto = UnProducto {
    gustoNecesario :: Gusto,
    condicion :: Persona->Bool
}

compraProducto :: Producto -> Persona -> Bool
compraProducto producto persona = 
    elem (gustoNecesario producto) (gustos persona) && 
    (condicion producto) persona

-- El desodorante Acks necesita que a la gente le guste el chocolate pero además que la estabilidad de la persona sea menor a 50.
acks :: Producto
acks = UnProducto "chocolate" ((>50).estabilidad)

-- El llavero de plato volador necesita que a la persona le gusten los extraterrestres pero que no sea miedosa.
llaveroOvni :: Producto
llaveroOvni = UnProducto "extraterrestres" (not.esMiedosa)

-- El pollo frito Ca Efe Se necesita que a la persona le guste lo frito y que sea fanática del pollo.
caEfeSe :: Producto
caEfeSe = UnProducto "frito" (fanatico "pollo")

-- Calcular la eficiencia de un campaña de marketing con un influencer para un producto en particular.
-- Es el porcentaje de variación de la cantidad de gente que antes de la campaña
-- no hubiera comprado el producto, pero luego sí.

eficienciaCampania :: Producto -> Influencer -> [Persona] -> Int
eficienciaCampania producto influencer personas 
    | compranAntes == 0 = 0 
    | otherwise = (compranDespues-compranAntes) *100 `div` compranAntes
        where
            compranAntes = cantidadCompradores producto personas
            compranDespues = cantidadCompradores producto (campania influencer personas)

cantidadCompradores:: Producto -> [Persona] -> Int
cantidadCompradores producto personas = length (filter (compraProducto producto) personas)

-- Analizar qué sucede en caso de utilizar una lista infinita.

willyWonca :: Persona
willyWonca = UnaPersona (repeat "chocolate") [] 100

-- Mostrar formas de utilizar algunas de las funciones hechas de manera que:
-- Se quede iterando infinitamente sin arrojar un resultado.
-- *Main> fanatico "chocolate" willyWonca
-- *Main> influenciar (copionInfinito escuchador') maria

-- Se obtenga una respuesta finita.
-- Reemplazando masDe3 por masDe3'
-- *Main> fanatico "chocolate" willyWonca
-- True
-- Y cualqueir otra que no requiera el ultimo elemento de la lista, o que directamente no use la lista
-- *Main> esMiedosa willyWonca 
-- False
-- miedos = [("corrupcion",330)], estabilidad = 60.0}]
-- *Main> campania' (take (3*4) (copionInfinito escuchador')) [maria,juanCarlos,artista]
-- [UnaPersona {gustos = ["escuchar","escuchar","escuchar","escuchar","mecanica"], miedos = [("corrupcion",40),("extraterrestres",600),("desempleo",300)], estabilidad = 85.0},
--  UnaPersona {gustos = ["escuchar","escuchar","escuchar","escuchar","maquillaje","trenes"], miedos = [("corrupcion",40),("insectos",100),("coronavirus",10),("vacunas",20)], estabilidad = 51.0},
--  UnaPersona {gustos = ["escuchar","escuchar","escuchar","escuchar","chocolate","trenes"], miedos = [("corrupcion",40)], estabilidad = 60.0}] 


-- La respuesta que se obtiene sea a su vez infinita.
-- *Main> agregarGusto "chocolateBlanco" willyWonca
-- UnaPersona {gustos = ["chocolateBlanco","chocolate","chocolate","chocolate",...
-- *Main> volverseFan willyWonca maria   
-- UnaPersona {gustos = ["mecanica","chocolate","chocolate","chocolate"...

-- Ejemplo de consulta
-- *Main> eficienciaCampania acks (communityManager willyWonca) [maria,juanCarlos,artista,willyWonca]
-- 100
-- (Paso de 2 a 4 compradores)
-- *Main> eficienciaCampania acks inutil [maria,juanCarlos,artista,willyWonca]        
-- 0 
-- (no cambió la cantidad de compradores)

-- Prueba de la variante de influecers con listas
-- *Main> campania et [maria,juanCarlos,artista] == campania' et' [maria,juanCarlos,artista]
-- True
-- *Main> campania escuchador [maria,juanCarlos,artista] == campania' escuchador' [maria,juanCarlos,artista]
-- True