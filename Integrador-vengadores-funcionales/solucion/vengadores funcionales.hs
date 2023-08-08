data Personaje = UnPersonaje {nombre::String, ataqueFavorito::Personaje->Personaje, elementos::[String], energia::Int}

instance Show Personaje where
 show personaje = nombre personaje

hulk = UnPersonaje "hulk" superFuerza ["pantalones"] 90
thor = UnPersonaje "thor" (relampagos 50) ["mjolnir"] 100
viuda = UnPersonaje "viuda negra" artesMarciales [] 90
capitan = UnPersonaje "capitán américa" arrojarEscudo ["escudo"] 80
halcon = UnPersonaje "ojo de halcón" arqueria ["arco", "flechas"] 70
vision = UnPersonaje "vision" (proyectarRayos 5) ["gema del infinito"] 100
ironMan = UnPersonaje "iron man" (ironia (relampagos (-50))) ["armadura", "jarvis", "plata"] 60
ultron = UnPersonaje "robot ultron"  corromperTecnologia [] 100 

--1) Conociendo a los Vengadores
--A)
esRobot personaje = take 5 (nombre personaje) == "robot" 
--Variante  
esRobot' = ("robot"==).take 5.nombre 

--B)
posee elemento personaje = elem elemento (elementos personaje)
posee' elemento (UnPersonaje _ _ elementos _) = elem elemento elementos


--C)
potencia personaje = length (elementos personaje) * energia personaje

--2) Ataques 

--Los ataques

--Implementación con funciones para modificar cada componente del dato, sin alterar los otros. 
modificarEnergia energia (UnPersonaje n a es _ ) = UnPersonaje n a es energia
modificarPosesiones elementos (UnPersonaje n a _ e ) = UnPersonaje n a elementos e 
modificarAtaque ataque (UnPersonaje n _ es e ) = UnPersonaje n ataque es e
-- Las funciones de acceso que devuelven cada componente, se generan automáticamente al definir el data con {}
-- Existe sintaxis abreviada que permite hacer, por ejemplo
--modificarAtaque nuevoAtaque personaje = personaje {ataque = nuevoAtaque}

superFuerza personaje = modificarEnergia 0 personaje

relampagos potencia personaje = modificarEnergia (energia personaje - potencia) personaje
--relampagos potencia (UnPersonaje n a es energia) = UnPersonaje n a es (energia - potencia) 

arqueria personaje 
 | posee "escudo" personaje = superFuerza personaje
 | otherwise = personaje

proyectarRayos = relampagos
--proyectarRayos potencia personaje = relampagos potencia personaje 

arrojarEscudo = modificarPosesiones []
--arrojarEscudo personaje = modificarPosesiones [] personaje 
--arrojarEscudo (UnPersonaje n a _ e) = UnPersonaje n a [] e

artesMarciales personaje = modificarAtaque id personaje

ironia ataque personaje = modificarAtaque ataque personaje

--ironia = modificarAtaque 
--ironia ataque (UnPersonaje n _ es e ) = UnPersonaje n ataque es e

corromperTecnologia = artesMarciales.superFuerza.arrojarEscudo

--Enfrentamientos
--Importante: el que contraataca lo hace tal como quedó luego de ser atacado
enfrentamiento atacante victima 
 = energia (ataqueFavorito ((ataqueFavorito atacante) victima) atacante) >  energia ((ataqueFavorito atacante) victima)

--Variante delegando más
enfrentamiento' atacante victima = energia (contraAtacar atacante victima ) > energia (atacar atacante victima) 

atacar atacante victima = (ataqueFavorito atacante) victima

contraAtacar atacante victima = ataqueFavorito (atacar atacante victima) atacante

--Variante delegando distinto

enfrentamiento'''' atacante victima = tieneMasEnergia (atacar (atacar atacante victima) atacante) (atacar atacante victima) 

tieneMasEnergia p1 p2 = energia p1 > energia p2

--Variante para no repetir código, con where
enfrentamiento'' atacante victima = 
    energia ((ataqueFavorito victimaDespuesDePelear) atacante) > energia victimaDespuesDePelear
        where victimaDespuesDePelear = (ataqueFavorito atacante) victima


--3)Batalla final

--A)
batallaFinal atacantes defensores
 |tieneGema atacantes && not (tieneGema defensores) = atacantes
 |tieneGema defensores && not (tieneGema atacantes) = defensores
 |ganoMasVeces atacantes defensores = atacantes
 |otherwise = defensores

ganoMasVeces atacantes defensores = length (filter id enfrentamientos) > div (length enfrentamientos) 2
 where enfrentamientos = zipWith enfrentamiento atacantes defensores 

tieneGema ejercito = any (posee "gema del infinito") ejercito

--Variante recursiva, con logica similar 
ganoMasVeces' atacantes defensores = length (filter id (enfrentamientos atacantes defensores)) > div (length (enfrentamientos atacantes defensores)) 2

enfrentamientos [] _ = []
enfrentamientos _ [] = []
enfrentamientos (atacante:atacantes) (defensor:defensores) = 
 enfrentamiento atacante defensor:(enfrentamientos atacantes defensores) 

--Variante recursiva, con otra logica 
ganoMasVeces'' atacantes defensores = diferenciaGanadosPerdidos atacantes defensores > 0

diferenciaGanadosPerdidos [] _ = 0
diferenciaGanadosPerdidos _ [] = 0
diferenciaGanadosPerdidos (atacante:atacantes) (defensor:defensores)
 | enfrentamiento atacante defensor = diferenciaGanadosPerdidos atacantes defensores + 1
 | otherwise = diferenciaGanadosPerdidos atacantes defensores - 1

--B)

robots = [UnPersonaje ("robot "++show n) (proyectarRayos 1) [] 100 | n <-[1..]]

vengadores = [thor,hulk,viuda,capitan,halcon,vision,ironMan]

--Consulta
--batallaFinal vengadores robots

--GanoMasVeces se puede evaluar con el ejercito infinito de robots, en caso que el ejercito de los vengadores sea finito, ya que en la lista de enfrentamientos estarían solo los enfrentamientos que se efectivamente se realizan (tantos como el ejercito menos numeroso). 
--Sin embargo la función tieneGema entra en loop infinito al aplicarse sobre la lista infinita de robots, ya que el any, ante la situación de que no encuntra un robot que tenga la gema, sigue buscando inifinitamente en la lista. 
--De esta manera, no es posible utilizar batallaFinal con una lista infinita de robots.

--4) Bonus
levantanElMartillo personajes = filter puedeMartillo personajes

puedeMartillo personaje = esDigno personaje || nombre personaje == "stan lee"

esDigno personaje = not (esRobot personaje) && potencia personaje > 100


