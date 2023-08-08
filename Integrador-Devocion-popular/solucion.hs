data Persona = UnaPersona {
    acciones :: [String],
    trabajo :: Trabajo,
    salud :: Float,
    esperanza :: Bool
} deriving Show

--Modelando el trabajo con Data, se debe completar con 0 los valores que no se usan, dependiendo de la formalida del trabajo

data Trabajo = UnTrabajo {
  formalidad:: String,
  sueldoBasico:: Float, 
  sueldoAdicional:: Float
} deriving Show 

-- Variante 1
-- Con un tipo de dato con múltiples constructores, donde cada uno representa mejor la realidad.
{- data Trabajo = 
    Desempleado |
    Informal Float |
    Registrado Float Float
    deriving Show
 -}

-- Variante 2
-- Más básica, con tuplas en vez de data
-- type Trabajo = (String, Float, Float) 


data Santo = UnSanto {
   requisito :: [String],
   bendicion :: Persona -> Persona
} 

salarioBasico,salarioBajo::Float
salarioBasico = 10000
salarioBajo = 15000

--Santos
sanCayetano, difuntaCorrea, angelelli::Santo
sanCayetano = UnSanto {
  requisito = ["compartir","esfuerzo","tener una estampita"], 
  bendicion = mejorarTrabajo}

difuntaCorrea = UnSanto {
  requisito = ["dejar una botella"],
  bendicion = mejorarSalud}

angelelli = UnSanto {
  requisito = accionesCompromiso,
  bendicion = darEsperanza}

accionesCompromiso::[String]
accionesCompromiso = ["ayudar a la gente","donacion"]

-- Bendiciones de los santos
mejorarTrabajo::Persona->Persona
mejorarTrabajo persona = persona{trabajo = mejoraSituacion (trabajo persona)}

mejoraSituacion::Trabajo->Trabajo
mejoraSituacion (UnTrabajo "desempleado" _ _ ) = UnTrabajo "informal" salarioBasico 0
mejoraSituacion (UnTrabajo "informal" ingreso _ )
  | ingreso < salarioBajo = UnTrabajo "informal" (2*ingreso) 0
  | otherwise = UnTrabajo "registrado" ingreso 0
mejoraSituacion (UnTrabajo "registrado" ingreso adicional) = UnTrabajo "registrado" ingreso (ingreso + adicional) 

-- Variante 1
{- mejoraSituacion Desempleado = Informal salarioBasico
mejoraSituacion (Informal ingreso) 
  | ingreso < salarioBajo = Informal (2*ingreso)
  | otherwise = Registrado ingreso 0
mejoraSituacion (Registrado ingreso adicional) = Registrado ingreso (ingreso + adicional) 
 -}

-- Variante 2
--mejoraSituacion ("desempleado",  _, _ ) = ("informal", salarioBasico, 0)
--mejoraSituacion ("informal", ingreso, _ )  
--  | ingreso < salarioBajo = ("informal", 2*ingreso, 0)
--  | otherwise = ("registrado", ingreso, 0)
--mejoraSituacion ( "registrado", ingreso ,adicional) = ("registrado", ingreso, ingreso + adicional)

mejorarSalud::Persona->Persona
mejorarSalud persona = persona {salud = salud persona + 1}

darEsperanza::Persona->Persona
darEsperanza persona = persona {esperanza = True}

-- Personas
pepe,luis,maria::Persona
pepe = UnaPersona {
  acciones = ["dejar una botella","esfuerzo"],
  trabajo = UnTrabajo "informal" 20000 0,
  --trabajo = Informal 20000 --Variante 1
  --trabajo = ("informal",20000, 0) --Variante 2
  salud = 90,
  esperanza = True}
  
luis = UnaPersona {
  acciones = ["ayudar a la gente","compartir"],
  trabajo = UnTrabajo "desempleado" 0 0, 
  --trabajo = Desempleado --Variante 1
  --trabajo = ("desempleado", 0, 0) --Variante 2
  salud = 30,
  esperanza = True}

maria = UnaPersona {
  acciones = ["ayudar a la gente","poner foto en la ofrenda","saludar"],
  trabajo = UnTrabajo "registrado" 10000 20000,
  --trabajo = Registrado 10000 20000 --Variante 1
  --trabajo = ("registrado", 10000, 20000) --Variante 2
  salud = 90,
  esperanza = False}


-- Visita al santuario
visitaAlSantuario :: Santo -> Persona -> Persona
visitaAlSantuario santo persona 
  | cumpleRequisito persona santo = (bendicion santo) persona
  | otherwise = persona

cumpleRequisito :: Persona -> Santo -> Bool
cumpleRequisito persona santo = any (esDelAgradoDe santo) (acciones persona)
--cumpleRequisito persona santo = any (`elem` (requisito santo) ) (acciones persona) --delegando menos

esDelAgradoDe:: Santo -> String -> Bool
esDelAgradoDe santo accion = elem accion (requisito santo)

-- Fiesta patronal
fiestaPatronal ::  Santo -> [Persona] -> [Persona]
--Con composicion
fiestaPatronal santo personas =  map (visitaAlSantuario santo.visitaAlSantuario santo) personas

--Con expresion lambda
--fiestaPatronal santo personas =  map (\p -> visitaAlSantuario santo (visitaAlSantuario santo p)) personas 

--Delegando en funcion auxiliar
--fiestaPatronal santo personas =  map (dobleBendicion santo) personas

---dobleBendicion santo alguien = visitaAlSantuario santo (visitaAlSantuario santo alguien)

-- Festival
festival::[Santo] -> [Persona] -> [Persona]
festival santos personas =  map (bendicionSucesiva santos) (filter esperanza personas)

bendicionSucesiva::[Santo]->Persona->Persona
bendicionSucesiva santos persona = foldl (flip visitaAlSantuario) persona santos 

--Simplemente para evitar flip
--bendicionSucesiva santos persona = foldl visitaAlSantuario' persona santos 

--visitaAlSantuario' persona santo = visitaAlSantuario santo persona

-- Nuevo santo
abuelaCoco::Santo
abuelaCoco = UnSanto{
  requisito = ["poner foto en la ofrenda"],
  bendicion = bendicionAbuelita "Coco"}

-- Funcion inventada. las abuelas mejoran la salud y agregan como acción recordar su nombre 
bendicionAbuelita:: String -> Persona -> Persona
bendicionAbuelita nombre persona = mejorarSalud (agregarAccion ("Recordar a " ++ nombre) persona)

-- con composicion, aplicación parcial y omitiendo definición de parámetro
--bendicionAbuelita nombre  = mejorarSalud.agregarAccion ("recordar a " ++ nombre)

agregarAccion:: String -> Persona -> Persona
agregarAccion accion persona = persona{acciones = accion:acciones persona}
