import Text.Show.Functions
--Pollos Ninjas Espaciales Mutantes
--Ejercicios integrador, Paradigma Funcional

--Pollos

data Pollo = UnPollo {
    nombre :: String,
    diasVivos :: Float,
    peso :: Float,
    artesMarciales :: [String]
    } deriving Show

yin :: Pollo
yin = UnPollo "Yin" 3000 3000 []

yang :: Pollo
yang = UnPollo "Yang" 10 150 []

--1.Engordar a un pollo una cierta cantidad de gramos

engordarA :: Pollo -> Float -> Pollo
engordarA unPollo cantidad = unPollo {peso =  peso unPollo +  cantidad }

--engordarA yin 300 --> UnPollo {nombre = "Yin", diasVivos = 3000.0, peso = 3300.0, artesMarciales = []}
--engordarA yang 50 --> UnPollo {nombre = "Yang", diasVivos = 10.0, peso = 200.0, artesMarciales = []}

--2.Saber si un pollo es mayor de edad: se dice que un pollo es mayor de edad si tiene más de 6 meses de vida

esMayorDeEdad :: Pollo -> Bool
esMayorDeEdad unPollo = (diasVivos unPollo)/30  > 6

--esMayorDeEdad yin --> True
--esMayorDeEdad yang --> False

--3.Saber si el último atributo de un pollo es vacío. 

noSabeArtesMarciales :: Pollo -> Bool
noSabeArtesMarciales unPollo = null (artesMarciales unPollo) 

--noSabeArtesMarciales yin--> True

--4.Cruzar un conjunto de pollos

cruzar :: [Pollo] -> Pollo
cruzar losPollos = UnPollo {
    nombre = "Super " ++ nombre (head losPollos),
    diasVivos = maximum (map (\pollo -> diasVivos pollo) losPollos),
    peso = minimum (map (\pollo -> peso pollo) losPollos),
    artesMarciales = [] 
}

--cruzar [yin,yang] --> UnPollo {nombre = "Super Yin", diasVivos = 3000.0, peso = 150.0, artesMarciales = []}

--Pollos ninja 

chickenDamme :: Pollo
chickenDamme = UnPollo "chickenDamme" 2000 3000 ["judo","sumo","taekwondo"]

poli :: Pollo
poli = UnPollo "Poli" 10 40 ["karate"]

--entrenadores

arguiniano :: Pollo -> Pollo
arguiniano unPollo = engordarA unPollo 100

sabe :: Pollo -> String -> Bool
sabe unPollo arteMarcial = elem arteMarcial (artesMarciales unPollo)

miyagi :: Pollo -> Pollo
miyagi unPollo  | not(sabe unPollo "karate") = unPollo {artesMarciales = "karate":artesMarciales unPollo}
                | otherwise = unPollo

--miyagi yin --> UnPollo {nombre = "Yin", diasVivos = 3000.0, peso = 3000.0, artesMarciales = ["karate"]}

marcelito :: Pollo -> Pollo
marcelito unPollo =  miyagi unPollo {artesMarciales = []}

--ratones

data Raton = UnRaton {
    nombreR :: String, 
    pesoR :: Float,
    altura :: Float, 
    bigotes :: Float
    } deriving Show

tito :: Raton
tito = UnRaton "Tito" 10 5 2     

manolito :: Raton
manolito = UnRaton "Manolito" 5 5 0 

ratones :: [Raton]
ratones = [tito,manolito]

comerRaton :: Pollo -> Raton -> Pollo
comerRaton unPollo raton = unPollo {peso=(peso unPollo)+((pesoR raton * altura raton)- bigotes raton)} 

brujaTapita :: Pollo -> Pollo
brujaTapita unPollo = comerRaton unPollo (head ratones) 

marioBros :: String -> Pollo -> Pollo
marioBros arteMarcial unPollo = 
  unPollo {nombre = nombre unPollo ++ " super mario",
            artesMarciales = foldl agregarSiNoSabe (artesMarciales unPollo) [arteMarcial,"saltar"]}

agregarSiNoSabe :: Eq a => [a] -> a -> [a]
agregarSiNoSabe aMarciales disciplinas  | elem disciplinas aMarciales = aMarciales
                                            | otherwise = disciplinas : aMarciales 
                                        
cantidadArtesMarciales :: (a -> Pollo) -> a -> Int
cantidadArtesMarciales unEntrenador unPollo = (length.artesMarciales.unEntrenador) unPollo


entrenaMejor :: (Pollo -> Pollo) -> (Pollo -> Pollo) -> Pollo -> (Pollo -> Pollo)
entrenaMejor ent1 ent2 unPollo
    | cantidadArtesMarciales ent1 unPollo > cantidadArtesMarciales ent2 unPollo = ent1
    | otherwise = ent2

--Pollos ninja espaciales 

--Planetas

data Planeta = UnPlaneta {
    entrenador :: Pollo -> Pollo, 
    pollos :: [Pollo]
    } deriving Show
    
marte :: Planeta
marte = UnPlaneta brujaTapita [yin,yang,poli]

jupiter :: Planeta
jupiter = UnPlaneta miyagi [chickenDamme]
  
saturno :: Planeta
saturno = UnPlaneta (marioBros "judo") [yin,yang,poli] 

maximaCantidadDeArtesMarciales :: Planeta -> Int
maximaCantidadDeArtesMarciales planeta = maximum (map length (map artesMarciales (pollos planeta)))

--maximaCantidadDeArtesMarciales marte --> 1

-- 1

elMejorPollo :: Planeta -> [Pollo]
elMejorPollo planeta = filter (\unPollo -> length (artesMarciales unPollo) == maximaCantidadDeArtesMarciales planeta) (pollos planeta)

--elMejorPollo marte --> [UnPollo {nombre = "Poli", diasVivos = 10.0, peso = 40.0, artesMarciales = ["karate"]}]

adultosNovatos :: Planeta -> Bool
adultosNovatos planeta = all (<= 2) (map length (map artesMarciales (filter esMayorDeEdad (pollos planeta))))     

--adultosNovatos marte --> True

novatos :: Planeta -> Bool
novatos planeta = length (filter (==0) (map length (map artesMarciales (pollos planeta)))) >= 2 

--novatos jupiter --> False

--2

esDebil :: Planeta -> Bool
esDebil planeta = adultosNovatos planeta || novatos planeta

--esDebil marte --> True
--esDebil jupiter --> False

--3

entrenar :: Planeta -> Planeta
entrenar planeta = planeta {pollos = map (entrenador(planeta)) (pollos(planeta))}

--entrenar marte --> UnPlaneta {entrenador = <function>, pollos = [UnPollo {nombre = "Yin", diasVivos = 3000.0, peso = 3048.0, artesMarciales = []},UnPollo {nombre = "Yang", diasVivos = 10.0, peso = 198.0, artesMarciales = []},UnPollo 
--{nombre = "Poli", diasVivos = 10.0, peso = 88.0, artesMarciales = ["karate"]}]}

--4

entrenamientoKaio :: Planeta -> Planeta -> Planeta
entrenamientoKaio planeta1 planeta2 =
     planeta1 {pollos = map (entrenador(planeta2)) (map (entrenador(planeta1)) (pollos(planeta1)))}

--entrenamientoKaio marte jupiter --> UnPlaneta {entrenador = <function>, pollos = [UnPollo {nombre = "Yin", diasVivos = 3000.0, peso = 3048.0, artesMarciales = ["karate"]},UnPollo {nombre = "Yang", diasVivos = 10.0, peso = 198.0, artesMarciales = ["karate"]},UnPollo {nombre = "Poli", diasVivos = 10.0, peso = 88.0, artesMarciales = ["karate"]}]}

--5
hacerViajeEspiritual :: Pollo -> [Pollo -> Pollo] -> Pollo 
hacerViajeEspiritual  unPollo entrenadores = foldl aplicar unPollo entrenadores

--hacerViajeEspiritual poli [miyagi,marcelito] --> UnPollo {nombre = "Poli", diasVivos = 10.0, peso = 40.0, artesMarciales = ["karate"]}

aplicar :: Pollo -> (Pollo -> Pollo) -> Pollo 
aplicar unPollo unEntrenador = unEntrenador unPollo  

--aplicar poli miyagi --> UnPollo {nombre = "Poli", diasVivos = 10.0, peso = 40.0, artesMarciales = ["karate"]}

--6 

planetaDebilEntrenado :: Planeta -> [Pollo -> Pollo] -> Bool
planetaDebilEntrenado planeta entrenadores = 
    esDebil(planeta {pollos = map (\unPollo -> hacerViajeEspiritual unPollo entrenadores) (pollos planeta)})

-- planetaDebilEntrenado marte [miyagi] -> True
-- planetaDebilEntrenado jupiter [miyagi] -> False 

-- OTRA FORMA:

--planetaDebilEntrenado :: Planeta -> [Pollo -> Pollo] -> Bool
--planetaDebilEntrenado planeta entrenadores = 
    --esDebil(planeta {pollos = map  ((flip hacerViajeEspiritual) entrenadores) (pollos planeta)})

-- Pollos nijas espaciales mutantes 

--1 

chickenNorris :: Pollo
chickenNorris = UnPollo "ChickenNorris" 9000 100 (map ("karate" ++) (map show  [1..]))

-- Ejemplos de invocación:

-- CASO 1) Marcelito puede entrenar a chickenNorris ya que  cuando ejecutamos "marcelito chickenNorris" la función devuelve:  
-- UnPollo {nombre = "ChickenNorris", diasVivos = 9000000, peso = 100000, artesMarciales = ["karate"]}

-- CASO 2) Arguiniano y brujaTapita puede entrenar a chickenNorris ya que si ejecutamos 
-- "arguiniano chickenNorris" o "brujaTapita chickenNorris" observamos que el peso del pollo incrementa. 
-- (Al tener una lista infinita nunca se termina de mostrar el pollo)

-- CASO 3) Miyagi y MarioBros no puede entrenar a chickenNorris ya que no se puede agregar un elemento a una lista infinita.

--2

--mutándolo a entrenador:

nuevoEntrenador :: Pollo -> Pollo -> Pollo
nuevoEntrenador elmejor unPollo  = unPollo {artesMarciales = artesMarciales elmejor}

mutar :: Planeta -> Planeta
mutar planeta = planeta {entrenador = nuevoEntrenador(head (elMejorPollo planeta))} 

--3

marceniano :: Pollo -> Pollo
marceniano unPollo = (marcelito.arguiniano) unPollo

-- marceniano poli --> UnPollo {nombre = "Poli", diasVivos = 10.0, peso = 140.0, artesMarciales = ["karate"]}






hayElementoComun = any (`elem` lista2) lista1

lista1 = [1, 2, 3, 4, 5]
lista2 = [3, 6, 9, 12, 15]


