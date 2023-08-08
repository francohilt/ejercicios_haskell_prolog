import Data.List
import Text.Show.Functions

type Enfermedad =  String

data Persona = UnaPersona {
    nombre::String, 
    edad::Int, 
    dinero::Float, 
    enfermedades::[Enfermedad] 
    } deriving Show

carlos, jorge, juan::Persona
carlos = UnaPersona "Carlos" 25 1000 ["Dispepsia Muscular", "Mal de la Guarda Loca", "Paradigmitis"]
jorge = UnaPersona "Jorge" 55 140 []
juan = UnaPersona "Juan" 75 100 ["Mal de la Guarda Loca", "Capitalismitis"]

type Dosis = Float
type Componente = (Droga, Dosis)

data Remedio = UnRemedio {
    componentes :: [Componente], 
    precio :: Float 
    } deriving Show

type Droga = Dosis -> Enfermedad -> Bool

-- Drogas conocidas
benzoprolamina :: Droga 
benzoprolamina _ enfermedad = enfermedad == "Dispepsia Muscular"

trifosfatoDeAnarcokirchnerismo :: Droga
trifosfatoDeAnarcokirchnerismo dosis enfermedad = enfermedad == "Paradigmitis" && dosis < 25

barbaduranio :: Droga
barbaduranio dosis enfermedad = esLoca enfermedad && nombreLargo enfermedad dosis
    
esLoca::Enfermedad -> Bool
esLoca enfermedad = take 4 (reverse enfermedad) == "acoL"

nombreLargo:: Enfermedad->Dosis->Bool
nombreLargo enfermedad dosis = dosis > genericLength enfermedad

trumpacio::Enfermedad -> Droga
trumpacio tipoDeTrumpacio _ enfermedad = enfermedad == tipoDeTrumpacio


-- Ejemplo de remedio
leninol:: Remedio 
leninol = UnRemedio [(trumpacio "Capitalismitis", 50)] 1

gariol::Remedio
gariol = UnRemedio [(trifosfatoDeAnarcokirchnerismo, 10), (trumpacio "Mal de la Guarda Loca", 5)] 500

otroRemedio::Remedio
otroRemedio = UnRemedio [(barbaduranio, 500), (benzoprolamina, 5)] 200

-- 1) Tomar remedios

tomarRemedio ::  Remedio -> Persona -> Persona
tomarRemedio remedio  persona =  persona { 
    enfermedades = enfermedadesSinCurar remedio persona, 
    dinero = dinero persona - precio remedio }

enfermedadesSinCurar:: Remedio -> Persona -> [Enfermedad]
enfermedadesSinCurar remedio persona = filter (not . curaEnfermedad remedio) (enfermedades persona)

curaEnfermedad:: Remedio -> Enfermedad -> Bool
curaEnfermedad remedio enfermedad = any (\(droga, dosis) -> droga dosis enfermedad) (componentes remedio)

-- 2) Reforzar remedios

reforzarRemedio:: Float -> Remedio -> Remedio
reforzarRemedio _ (UnRemedio [_] importe) = UnRemedio [] importe
reforzarRemedio veces (UnRemedio componentes importe) = UnRemedio (reforzarComponentes veces componentes) importe

reforzarComponentes :: Float -> [Componente] -> [Componente]
reforzarComponentes veces componentes = map (\(droga,dosis)->(droga,veces*dosis)) componentes

-- 3) Mejor remedio

esMejorRemedioPara::Persona -> Remedio -> Remedio ->  Bool
esMejorRemedioPara persona remedio1 remedio2 = cantEnfermedadesCuradas persona remedio1 > cantEnfermedadesCuradas persona remedio2

cantEnfermedadesCuradas::Persona -> Remedio -> Int
cantEnfermedadesCuradas persona remedio = length (enfermedades persona) - length (enfermedadesSinCurar remedio persona )

-- 4) Estafa 

-- Ejemplo de coctel 
type Coctel = [Remedio]

unCoctel::Coctel
unCoctel = [leninol, gariol]

estafa :: Coctel -> Persona -> Bool
estafa coctel persona = noPuedeComprar coctel persona && noCura coctel persona

noPuedeComprar ::Coctel -> Persona -> Bool
noPuedeComprar coctel persona = precioCoctel coctel > dinero persona

precioCoctel:: Coctel -> Float
precioCoctel = sum.map precio

noCura:: Coctel -> Persona -> Bool
noCura coctel persona = all ((==0).cantEnfermedadesCuradas persona) coctel

-- 5) Récord Guinness de Hipocondría.
-- Si una persona con infinitas enfermedades toma un remedio, se obtiene una persona con infinitas enfermadades, no estarán las que la droga cura, pero de todas maneras infinita.
-- En caso de no poder pagarlo, se puede saber que el coctel es una estafa, ya que no es necesario evaluar las enfermedades
-- En caso contrario, no se puede saber ya que la evaluación de la cantidad de enfermedades curadas no se completa. 