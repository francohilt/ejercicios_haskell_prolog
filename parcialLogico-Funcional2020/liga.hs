
data Club = UnClub {
    nombre :: String,
    ubicacion :: String,
    hinchas :: Int,
    tienePlata :: Bool -- Lo agrego para los casos en que sabemos que el club tiene plata.
    } deriving Show

boca,racing,nob,godoy,central,velez,lanus,banfield,river :: Club
boca = UnClub "boca" "amba" 100 True
racing = UnClub "racing" "amba" 80 False
nob = UnClub "nob" "rosario" 50 False
godoy = UnClub "godoy" "mendoza" 5 False
central = UnClub "central" "rosario" 60 False
velez = UnClub "velez" "amba" 5 True
lanus = UnClub "lanus" "amba" 10 False
banfield = UnClub "banfield" "amba" 4 False
river = UnClub "river" "amba" 90 True


clubes :: [Club]
clubes = [boca, velez, racing, nob, godoy, central, lanus, banfield]

-------------------- PUNTO 1 --------------------

esGrande :: Club -> Bool
esGrande club = ubicacion club == "amba" && tienePlata club

esPopular :: Club -> Bool
esPopular club
    | not(esGrande(club)) = any(\x-> hinchas x < hinchas club ) sonGrandes
    | otherwise = all(\x-> hinchas x < hinchas club ) noSonGrandes

sonGrandes :: [Club]
sonGrandes = filter(\x-> esGrande x) clubes

noSonGrandes :: [Club]
noSonGrandes = filter(\x-> not(esGrande x)) clubes

-------------------- PUNTO 2 --------------------

campaniaPublicitaria :: Club -> Club
campaniaPublicitaria club = club{hinchas = x + (5 * x `div` 100)}
    where x = hinchas club

mudarDeCiudad :: String -> Club -> Club
mudarDeCiudad ciudad club = club{hinchas = sumarHinchas(club), ubicacion = ciudad}

sumarHinchas :: Club -> Int
sumarHinchas club = (length(nombre club) `div` 100) * x + x
    where x = hinchas club

tirarMaiz :: Int -> Club -> Club
tirarMaiz maiz club
    | 'v' `elem` nombre club = club{hinchas = x + maiz}
    | otherwise = club{hinchas = x - maiz}
        where x = hinchas club

recibirApoyo :: Club -> Club -> Club
recibirApoyo club otroClub = club{hinchas = hinchas club + hinchas otroClub}

disminuirHinchas :: Int -> Club -> Club
disminuirHinchas cant club = club{hinchas = hinchas club - cant}

tirarPiedras :: Club -> Club
tirarPiedras club
    | nombre club == "river" = (disminuirHinchas(20).disminuirHinchas 10) club
    | otherwise = disminuirHinchas 5 club


-------------------- PUNTO 3 --------------------

queClubQuedaConMasHinchas :: Club -> Club -> (Club -> Club) -> String
queClubQuedaConMasHinchas clubA clubB unaIniciativa
    | hinchas (unaIniciativa clubA) > hinchas (unaIniciativa clubB) = nombre clubA
    | otherwise = nombre clubB

-------------------- PUNTO 4 --------------------

todasLasIniciativas :: [Club -> Club]
todasLasIniciativas = [campaniaPublicitaria, 
                       mudarDeCiudad "rosario", 
                       mudarDeCiudad "jujuy", 
                       recibirApoyo velez, 
                       tirarMaiz 3,
                       tirarPiedras]

cantidadDeHinchasAplicando :: [Club -> Club] -> Club -> Int
cantidadDeHinchasAplicando iniciativas club = maximoDeHinchas(map(\x-> x club) iniciativas)

maximoDeHinchas :: [Club] -> Int
maximoDeHinchas clubConIniciativas = (maximum.map(\x-> hinchas x)) clubConIniciativas

-------------------- PUNTO 5 --------------------

{- Las funciones de Haskell pueden tomar funciones como parámetros y 
devolver funciones como resultado. 
Una función que hace ambas cosas o alguna de ellas 
se llama función de orden superior.
Un ejemplo de esto --> cuando organizamos las iniciativas,le pasamos su 
primer parámetro para que luego todas pudieran funcionar a la vez
al aplicarselo al club. -}

