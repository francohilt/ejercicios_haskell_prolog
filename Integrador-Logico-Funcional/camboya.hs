--------------------------- FUNCIONAL ---------------------------

data Lugar = UnLugar {
    tipo :: TipoLugar,
    visitantes :: Int,
    entrada :: Float
    } deriving (Show, Eq, Ord)

type TipoLugar = String

--------------------------- PUNTO 1 ---------------------------

todosLosDelMismoTipo :: TipoLugar -> [Lugar]
todosLosDelMismoTipo unTipo = filter(\x-> tipo x == unTipo) lugares

-- Otra forma --
todosLosDelMismoTipo2 :: TipoLugar -> [Lugar]
todosLosDelMismoTipo2 unTipo = filter (esDelMismoTipo unTipo) lugares

esDelMismoTipo :: TipoLugar -> Lugar -> Bool
esDelMismoTipo unTipo lugar = tipo lugar == unTipo
--

maximoDeVisitantes :: TipoLugar-> Int
maximoDeVisitantes unTipo = (maximum.map visitantes) (todosLosDelMismoTipo unTipo)

lugarMasVisitado :: TipoLugar-> [Lugar]
lugarMasVisitado unTipo = filter(\x-> visitantes x == maximoDeVisitantes unTipo) (todosLosDelMismoTipo unTipo)

{- Hago que me devuelva una lista de lugares por si hay dos o mas lugares con la cantidad maxima de visitantes -}


--------------------------- PUNTO 2 ---------------------------

{- En la composición, 
construimos funciones nuevas a partir de la aplicación sucesiva de funciones existentes, 
mientras que en la aplicación parcial 
generamos una nueva función con la técnica de no pasar todos los parámetros que la definición propone.

En este caso utilizamos composición en la funcion de maximoDeVisitantes con maximum.map -}


--------------------------- PUNTO 3 ---------------------------

maximoVisitantesEntre :: [TipoLugar] -> Int
maximoVisitantesEntre tipos = (maximum.map maximoDeVisitantes) tipos

type Criterio = [TipoLugar] -> [Lugar]


lugarMasVisitadoEntre :: Criterio
lugarMasVisitadoEntre tipos = filter(\x-> visitantes x == (maximoVisitantesEntre tipos)) lugares

lugarMasVisitadoSegun :: Criterio -> [TipoLugar] -> [Lugar]
lugarMasVisitadoSegun criterio tipos = criterio tipos

--------------------------- DATOS PARA CONSULTAS ---------------------------
temploAgnkor,temploNom :: Lugar
temploAgnkor = UnLugar "templo" 1500 200
temploNom = UnLugar "templo" 100 100

rioNom,rioChico,rioMekong :: Lugar
rioNom = UnLugar "rio" 250 0
rioChico = UnLugar "rio" 250 0
rioMekong = UnLugar "rio" 100 0

museoCamboya,museoDeCera,museoDeArte :: Lugar
museoCamboya = UnLugar "museo" 2000 150
museoDeCera = UnLugar "museo" 100 50
museoDeArte = UnLugar "museo" 100 500

montaniaSolitaria :: Lugar
montaniaSolitaria = UnLugar "montania" 500 0

camboya :: Lugar
camboya = UnLugar "ciudad" 5000 0

lugares :: [Lugar]
lugares = [temploAgnkor,temploNom,rioNom,rioChico,rioMekong,museoCamboya,museoDeCera,museoDeArte,montaniaSolitaria,camboya]


