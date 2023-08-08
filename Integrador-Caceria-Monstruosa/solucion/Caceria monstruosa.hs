import Text.Show.Functions

data Personaje = UnPersonaje 
   {nombre :: String, 
   fuerza :: Float, 
   experiencia :: Float, 
   elemento :: Elemento} deriving Show

type Elemento = Float -> Float

marco = UnPersonaje "marco" 15 10 katanaFilosa
paul  = UnPersonaje "paul" 17 6 baculoDuplicador
lucas = UnPersonaje "lucas" 7 69 espadaMaldita

espadaOxidada = (1.2*)
katanaFilosa  = (10+).(0.9*)
sableLambdico cm = ((1+cm/100)*)
redParadigmatica = sqrt
baculoDuplicador x= x * 2
espadaMaldita = espadaOxidada.sableLambdico 89

nivel (UnPersonaje _ _ experiencia _)  = ceiling ( experiencia * experiencia / (experiencia + 1))
--nivel personaje  = ceiling ( xp * xp / (xp + 1))
--  where xp = experiencia personaje

capacidad (UnPersonaje _ _ experiencia elemento) = elemento experiencia 
--capacidad personaje = (elemento personaje) (experiencia personaje)

type Alquimista = Personaje -> EstiloAlquimista-> Personaje
type EstiloAlquimista = Elemento -> Elemento

alquimista estilo  personaje = personaje { elemento = estilo (elemento personaje) } 

estiloAprendiz elemento = (2*).elemento
--interpretando que "duplicar" consiste en aplicar dos veces el elemento
--estiloAprendiz elemento = elemento.elemento

estiloMaestro anios elemento = coeficienteAntiguedad anios (estiloAprendiz elemento)

coeficienteAntiguedad 0 elemento = elemento  
coeficienteAntiguedad anios elemento = coeficienteAntiguedad (anios-1) ((1.1*).elemento)
--coeficienteAntiguedad anios elemento = (1.1*).coeficienteAntiguedad (anios-1) elemento

--coeficienteAntiguedad 0 = id
--coeficienteAntiguedad anios = (*1.1).coeficienteAntiguedad (anios-1) 

estiloEstafador = id 
--estiloEstafador x = x 
--estiloEstafador = (1*)

estiloInventado = (\x -> x * 3)

--alterarElemento:: Elemento -> Personaje -> Personaje
alterarElemento nuevoElemento personaje = personaje { elemento = nuevoElemento.elemento personaje } 

{-
--Variante sin usar estilo, sino directamente alquimistas que modifican personajes

type Alquimista = Personaje -> Personaje

aprendiz = alterarElemento (2*) 
--aprendiz personaje = alterarElemento (2*) personaje 

maestro anios = alterarElemento (coeficienteAntiguedad anios).aprendiz 

estafador personaje = personaje { elemento = id } 

inventado personaje = personaje { elemento = (\x -> x * 3) } 

-}

capacidadSuperiorA valor personaje alquimista = ((>valor).capacidad.alquimista) personaje
--capacidadSuperiorA valor personaje alquimista = capacidad (alquimista personaje) >valor

capacidadesSuperioresA valor personaje alquimistas = filter (capacidadSuperiorA valor personaje) alquimistas 
convienenTodos alquimistas personaje = all (capacidadSuperiorA (capacidad personaje) personaje) alquimistas 

--habilidades(descriptcion,tipo)
data Monstruo = UnMonstruo 
   {especie :: String, 
   resistencia :: Float, 
   habilidades :: [Habilidad]} deriving Show

type Habilidad = (String, String)
tipo = snd
descripcion = fst

esAgresivo (UnMonstruo especie resistencia habilidades) = mayoriaOfensivas habilidades && especieAgresiva especie && resistencia > 0
-- esAgresivo monstruo = mayoriaOfensivas (habilidades monstruo) && especieAgresiva (especie monstruo) && resistencia monstruo > 0

mayoriaOfensivas habilidades =  length (filter (esAtaque.tipo) habilidades) > div (length habilidades) 2

esAtaque "magia" = True
esAtaque "fisica" = True
esAtaque _ = False
--esAtaque tipo  = tipo == "magia" || tipo == "magia" 

especieAgresiva especie = elem especie ["animal", "chocobo"]

gana personaje monstruo = capacidad personaje > resistencia monstruo

cambiarExperiencia variacion personaje = personaje {experiencia = experiencia personaje + variacion} 

pelear personaje monstruo
    | gana personaje monstruo = cambiarExperiencia 100 personaje
    | otherwise =  alterarElemento (0.9*) (cambiarExperiencia (-50) personaje)

pelearConTodos personaje monstruos = foldl pelear personaje monstruos

hayInvencible personaje alquimista  = all (gana (alquimista personaje))
