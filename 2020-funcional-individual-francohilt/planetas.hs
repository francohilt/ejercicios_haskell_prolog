--Primer Punto: Modelado de los planetas
data Coordenada = UnaCoordenada {
    x :: Float,
    y :: Float,
    z :: Float
    }
    deriving Show

data Planeta = UnPlaneta {
    nombre :: String,
    coordenadas :: Coordenada,
    porcentajeDeAgua :: Float
    }
    deriving Show

proximaCentaurib :: Planeta
proximaCentaurib = UnPlaneta {nombre = "Proxima Centauri b", 
                            coordenadas = UnaCoordenada{x=43.2, y=14.2, z=8.9}, 
                            porcentajeDeAgua = 74}

alphaCentauriBb :: Planeta
alphaCentauriBb = UnPlaneta {nombre = "Alpha Centauri Bb", 
                            coordenadas = UnaCoordenada{x=17, y=31.2, z=32}, 
                            porcentajeDeAgua = 3}

alphaCentauriCc :: Planeta
alphaCentauriCc = UnPlaneta {nombre = "Alpha Centauri Cc", 
                            coordenadas = UnaCoordenada{x=42, y=42, z=42}, 
                            porcentajeDeAgua = 60}

--Segundo Punto: Cálculo de distancia estelar
distanciaA :: Planeta -> (Float, Float, Float) -> Float
distanciaA (UnPlaneta _ (UnaCoordenada px py pz) _) (nx, ny, nz) = px*nx + 2*py*nz + abs (ny - pz)

--Tercer Punto: Planetas aptos
esApto :: Planeta -> (Float, Float, Float) -> Bool
esApto planeta ubicacionNave = porcentajeDeAgua planeta > 52 && distanciaA planeta ubicacionNave < 100

--Cuarto Punto: Próximo destino
data Nave = UnaNave {
    nombreN :: String,
    cantCombustible :: Float,
    tripulantes :: [String],
    proximoDestino :: Planeta
    }
    deriving Show 

nave :: Nave
nave = UnaNave {
    nombreN = "Nave de exploración", 
    cantCombustible = 500, 
    tripulantes= ["Franco","Ivan"], 
    proximoDestino = alphaCentauriBb
    }

cargarProximoPlaneta :: Nave -> [Planeta] -> Nave
cargarProximoPlaneta unaNave planetasExplorados = unaNave {proximoDestino = head(planetasExplorados)}

--Quinto Punto: Destinos ordenados
estaOrdenada :: [Planeta] -> (Float,Float,Float) -> (Bool)
estaOrdenada ([]) (_,_,_) = False
estaOrdenada (_:[]) (_,_,_) = True
estaOrdenada (x:xs) (x1,y1,z1) = 
    (distanciaA x (x1,y1,z1) <= distanciaA (head xs) (x1,y1,z1)) && (estaOrdenada xs (x1,y1,z1))

--PUNTOS EXTRAS

--Dada una lista de planetas determinar cuantos son aptos
ubicacionNave2 :: (Float, Float, Float)
ubicacionNave2 = (0,0,0)

esApto2 :: Planeta -> Bool
esApto2 planeta = porcentajeDeAgua planeta > 52 && distanciaA planeta ubicacionNave2 < 100

cuantosSonAptos :: [Planeta] -> Int
cuantosSonAptos planetas = length (filter esApto2 planetas)

--Maxima distancia a la nave
distanciaALaNave :: Planeta -> Float
distanciaALaNave planeta = distanciaA planeta ubicacionNave2

mayorDistancia :: [Planeta] -> Float
mayorDistancia planetas = maximum (map distanciaALaNave planetas)

--Dado un planeta aumentarle su porcentaje de agua
aumentarPorcentajeDeAgua :: Planeta -> Planeta
aumentarPorcentajeDeAgua planeta = 
    planeta {porcentajeDeAgua = porcentajeDeAgua planeta * 1.1}

aumentarAgua :: [Planeta] -> [Planeta]
aumentarAgua planetas = map aumentarPorcentajeDeAgua planetas

--Dado dos planetas sumar sus porcentajes de agua
sumaEspecial :: Planeta -> Planeta -> Float
sumaEspecial planeta1 planeta2 =
    porcentajeDeAgua planeta1 + porcentajeDeAgua planeta2

--Para poder utilizarlo en forma generica con algun criterio 
sumaEspecial2 :: Num a => (t -> a) -> t -> t -> a
sumaEspecial2 criterio elem1 elem2 =
    criterio elem1 + criterio elem2

