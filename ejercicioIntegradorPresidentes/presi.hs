import Text.Show.Functions()

data Presidente = UnPresidente {
    nombre :: String,
    periodo :: Periodo
    } deriving (Show)

type Periodo = (Int,Int) --(FechaInicio,FechaFinalizacion)

alfonsin1, menem1, menem2, puerta :: Presidente
alfonsin1 = UnPresidente "Alfonsin" (1983,1989)
menem1 = UnPresidente "Menem" (1989,1995)
menem2 = UnPresidente "Menem" (1995,1999)
puerta = UnPresidente "Puerta" (2001,2001)

presidentes :: [Presidente]
presidentes = [alfonsin1, menem1, menem2, puerta]

--------------------- PUNTO 1-a ---------------------

quienFuePresidentePorMasDeUnPeriodo :: [String]
quienFuePresidentePorMasDeUnPeriodo =  (elementosRepetidos.map nombre) presidentes

elementosRepetidos :: Eq a => [a] -> [a]
elementosRepetidos [] = []
elementosRepetidos lista
    | any (== head lista) (tail lista) = (take 1 lista) ++ elementosRepetidos (filter (/=(head lista)) lista)
    | otherwise = elementosRepetidos (tail lista)

--------------------- PUNTO 1-b ---------------------

quienFuePresidenteEn :: Int -> Presidente
quienFuePresidenteEn fecha = head(filter(periodoPresi fecha) presidentes)

periodoPresi :: Int -> Presidente -> Bool
periodoPresi fecha presidente = fecha >= fst(periodo presidente) && fecha < snd(periodo presidente)


--------------------- PUNTO 2 ---------------------

data AccionDeGobierno = UnaAccionDeGobierno {
    descripcion :: String,
    fechaProducida :: Int,
    lugar :: String,
    beneficiados :: Int
    } deriving Show

juicio, hiperinflacion, privatizacion :: AccionDeGobierno
juicio = UnaAccionDeGobierno "Juicio a las juntas" 1985 "Buenos Aires" 30000000
hiperinflacion = UnaAccionDeGobierno "Hiperinflacion" 1989 "Buenos Aires" 10
privatizacion = UnaAccionDeGobierno "Privatización de YPF" 1992 "Campana" 1


accionesDeGobierno :: [AccionDeGobierno]
accionesDeGobierno = [juicio, hiperinflacion, privatizacion]

fueBueno :: AccionDeGobierno -> Bool
fueBueno acto = beneficiados acto > 10000

hizoAlgoBueno :: Presidente -> Bool
hizoAlgoBueno presidente = head(map(flip periodoPresi presidente) [fechaProducida x| x <- accionesDeGobierno, fueBueno x])


--------------------- PUNTO 3 ---------------------

data Periodista = UnPeriodista {
    nombreP :: String,
    perspectiva :: Perspectiva
    } deriving Show

type Perspectiva = Presidente -> Bool

ernesto, maria, juan :: Periodista
ernesto = UnPeriodista "Ernesto" conformista
maria = UnPeriodista "Maria" complice
juan = UnPeriodista "Juan" (oriundo "Campana")

conformista :: Presidente -> Bool
conformista presidente = hizoAlgoBueno presidente

complice :: Presidente -> Bool
complice presidente = (not.hizoAlgoBueno) presidente

oriundo :: String -> Presidente -> Bool
oriundo unLugar presidente = head(map(flip periodoPresi presidente) [fechaProducida x| x <- accionesDeGobierno, lugar x == unLugar])

quienLeAgradaA :: Periodista -> [Presidente]
quienLeAgradaA periodista = filter(perspectiva periodista) presidentes


