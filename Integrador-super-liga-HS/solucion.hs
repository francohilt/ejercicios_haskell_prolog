-- PARADIGMA FUNCIONAL

data Equipo = UnEquipo {
    nombre :: String,
    ciudad :: String,
    hinchas :: Float,
    plata :: Bool
}
    deriving Show

boca :: Equipo
boca = UnEquipo "boca" "bsas" 100 True

racing :: Equipo
racing = UnEquipo "racing" "bsas" 80 False

nob :: Equipo
nob = UnEquipo "nob" "rosario" 50  True

godoy :: Equipo
godoy = UnEquipo "godoy" "mendoza" 5 False

central :: Equipo
central = UnEquipo "central" "rosario" 60 False

velez :: Equipo
velez = UnEquipo "velez" "bsas" 5 True

lanus :: Equipo 
lanus = UnEquipo "lanus" "bsas" 10 False

clubes :: [Equipo]
clubes = [boca ,racing, nob, godoy, central, velez, lanus]

-- POPULARES -------------------------------------------------------------------

populares :: [Equipo] -> [Equipo]
populares equipos = filter (esPopular equipos) equipos

esPopular::[Equipo] -> Equipo -> Bool
esPopular equipos equipo = 
  grandeMejorQueLosChicos equipos equipo || 
  chicoMejorQueUnGrande equipos equipo 

grandeMejorQueLosChicos::[Equipo]->Equipo->Bool
grandeMejorQueLosChicos equipos equipo = esGrande equipo && all (mejorHinchada equipo) (equiposChicos equipos)  

chicoMejorQueUnGrande::[Equipo]->Equipo->Bool
chicoMejorQueUnGrande equipos equipo = esChico equipo && any (mejorHinchada equipo) (equiposGrandes equipos)  

equiposGrandes::[Equipo]->[Equipo]
equiposGrandes equipos = filter esGrande equipos

equiposChicos::[Equipo]->[Equipo]
equiposChicos equipos = filter esChico equipos

mejorHinchada::Equipo->Equipo->Bool
mejorHinchada equipo1 equipo2 = hinchas equipo1  >= hinchas equipo2

esChico::Equipo->Bool
esChico = not.esGrande

esGrande :: Equipo -> Bool
esGrande club = ciudad club == "bsas" && plata club

{- 
*Main> map nombre (populares clubes)
["boca","racing","nob","godoy","central","lanus"]

*Main> esPopular clubes central
True

*Main> esPopular clubes velez
False
 -}

------------------------------------------------------------------
-- variante asumiendo como única la lista de clubes,delegando menos

esPopular2 :: Equipo -> Bool
esPopular2 club =
    esChico club && any(< hinchas club) (hinchadas (filter esGrande clubes)) ||
    (esGrande club) && all (<= hinchas club) (hinchadas (filter esChico clubes)) 

hinchadas :: [Equipo] -> [Float]
hinchadas = map hinchas

{- 
*Main> esPopular central
True

*Main> esPopular velez
False 
-}


-- HINCHADAS -----------------------------------------------------------------------------

-- a) ------------------------------------------------------------------------------------

campaniaPublicitaria :: Equipo -> Equipo
campaniaPublicitaria club = sumarHinchada (hinchas club * 0.05) club

mudarse :: String -> Equipo -> Equipo
mudarse nuevaCiudad club = sumarHinchada ((fromIntegral.length) nuevaCiudad) club

tirarMaiz :: Float -> Equipo -> Equipo
tirarMaiz cant club 
    | elem 'v' (nombre club) = sumarHinchada (10* cant) club
    | otherwise = sumarHinchada (-10 * cant) club

sumarHinchada :: Float -> Equipo -> Equipo
sumarHinchada cant club = club {hinchas = hinchas club + cant}

recibirApoyo :: Equipo -> Equipo -> Equipo
recibirApoyo clubQueApoya club  = sumarHinchada (hinchas clubQueApoya) club

inventada :: Equipo -> Equipo
inventada club = (campaniaPublicitaria.sumarHinchada (-10)) club



-- b  ------------------------------------------------------------------------------

hinchadaMasNumerosa :: Equipo -> Equipo -> (Equipo -> Equipo) -> String
hinchadaMasNumerosa club1 club2 iniciativa 
    |(hinchas.iniciativa) club1 > (hinchas.iniciativa) club2 = nombre club1
    |otherwise = nombre club2



-- c  ------------------------------------------------------------------------------

cantidadMaxDeHinchas :: Equipo -> [Equipo -> Equipo] -> Float
cantidadMaxDeHinchas club iniciativas = maximum (hinchadas (map(\i -> i club) iniciativas))


-- d ----------------------------------------------------------------------------------
{- 
*Main> campaniaPublicitaria boca
UnEquipo {nombre = "boca", ciudad = "bsas", hinchas = 105.0, plata = True}

*Main> mudarse racing "Zarate"
UnEquipo {nombre = "racing", ciudad = "bsas", hinchas = 86.0, plata = False}

*Main> tirarMaiz velez 5
UnEquipo {nombre = "velez", ciudad = "bsas", hinchas = 55.0, plata = True} 

*Main> hinchadaMasNumerosa lanus nob inventada     
"nob" 

*Main> cantidadMaxDeHinchas boca [campaniaPublicitaria, inventada]
105.0 

*Main> cantidadMaxDeHinchas boca [campaniaPublicitaria, mudarse "rosario", mudarse "jujuy", recibirApoyo velez, tirarMaiz 3, inventada]
107.0
-}

-- e ----------------------------------------------------------------------------------

{- 
La función cantidadMaxDeHinchas es de orden superior ya que la misma recibe otra función 
por parámetro, en particular una lista de funciones, siendo capaz de ejecutarla internamente. -}


