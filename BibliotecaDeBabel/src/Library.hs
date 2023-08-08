module Library where
import PdePreludat
import Data.Char (toUpper)

-------------------
-- PRIMERA PARTE --
-------------------

type Genero = String

data Libro = UnLibro { 
    generos :: [Genero], 
    titulo :: String, 
    paginas :: Number, 
    contenido :: String 
    } deriving (Show, Eq)

data Biblioteca = UnaBiblioteca {
    ubicacion:: String, 
    libros :: [Libro],
    validacion::Libro -> Bool
    } deriving (Show, Eq)

cenicienta  = UnLibro ["cuento"] "La Cenicienta" 10 "Había una vez"
caperucita  = UnLibro ["Cuento","Terror"] "Caperucita Roja" 20 "Qué ojos tan grandes tienes"
haskell = UnLibro ["Ciencia","Programacion"] "Aprenda haskell en 10 minutos" 100 "La funcion funcional funciona"
babel = UnaBiblioteca "Babel" [cenicienta, caperucita, haskell] validoParaBabel


-- 1) Estadísticas 


-- Conocer el promedio de páginas por libro de una biblioteca.

promedioPaginas::Biblioteca -> Number
promedioPaginas biblioteca = promedio (map paginas (libros biblioteca))

promedio:: [Number] -> Number
promedio lista = sum lista / length lista

-- Conocer cuántos libros en común tienen dos bibliotecas. 
cantidadLibrosEnComun:: Biblioteca -> Biblioteca -> Number 
cantidadLibrosEnComun biblioteca1 biblioteca2 = 
--    length (filter (\libro -> elem libro (libros biblioteca1)) (libros biblioteca2))
--    length (filter (flip elem (libros biblioteca1)) (libros biblioteca2))
    count (contieneLibro biblioteca1) (libros biblioteca2)

contieneLibro:: Biblioteca -> Libro -> Bool
contieneLibro biblioteca libro = elem libro (libros biblioteca)

count:: (a -> Bool) -> [a] -> Number
count condicion lista = length (filter condicion lista)

-- 2) Integridad de la biblioteca 
--simbolos = "abcdefghijklmnopqrstuv .,"
simbolos = "1234567890"

--Saber si un libro es válido para la biblioteca de Babel, es decir, si posee exactamente 410 páginas y está formado por alguna combinación de los símbolos válidos. 
validoParaBabel :: Libro -> Bool
validoParaBabel libro = paginas libro == 410 && all esValido (contenido libro) 

esValido simbolo = elem simbolo simbolos





-- Depurar la biblioteca de Babel: verificar si la biblioteca de babel tiene todos libros válidos y en caso que haya alguno que no lo sea, quitarlo.

depurarBabel :: Biblioteca -> Biblioteca
depurarBabel biblioteca = biblioteca{ libros = filter validoParaBabel (libros biblioteca)}

depurar :: Biblioteca -> Biblioteca
depurar biblioteca = biblioteca{ libros = filter (validacion biblioteca) (libros biblioteca)}


--alternativa para depurar, recibiendo la funcion como parámetro
depurarGeneral :: (Libro -> Bool) -> Biblioteca -> Biblioteca
depurarGeneral cond unaBiblioteca = unaBiblioteca {libros = (filter (cond) .libros) unaBiblioteca}


-- 3) Géneros

-- Saber cuántos libros de un género determinado hay en una biblioteca

cantidadDeGenero :: Genero -> Biblioteca -> Number

cantidadDeGenero genero biblioteca = length (filter (esDeGenero genero) (libros biblioteca))

esDeGenero :: Genero -> Libro -> Bool
esDeGenero genero libro = any (mismoGenero genero) (generos libro)

mismoGenero:: Genero -> Genero -> Bool
mismoGenero genero1 genero2 = map toUpper genero1 == map toUpper genero2
-----


-- Obtener el conjunto de géneros diferentes de los cuales hay libros 

todosLosGeneros:: Biblioteca -> [Genero]
todosLosGeneros biblioteca = sinRepetidos (concatMap generos (libros biblioteca))

sinRepetidos:: [Genero] -> [Genero]
sinRepetidos [] = []
sinRepetidos (genero:generos)
    | any (mismoGenero genero) generos = sinRepetidos generos
    | otherwise = genero:sinRepetidos generos


-- Obtener el género del cuál hay más libros en una biblioteca. 

generoConMasLibros::Biblioteca-> Genero
generoConMasLibros biblioteca = foldl1 (mejorGenero biblioteca) (todosLosGeneros biblioteca)

mejorGenero::Biblioteca -> Genero -> Genero -> Genero
mejorGenero biblioteca genero1 genero2
    | cantidadDeGenero genero1 biblioteca > cantidadDeGenero genero2 biblioteca = genero1
    | otherwise = genero2

-- Bibliotecas selectivas

alejandria = UnaBiblioteca "Biblioteca de Alejandria" [] validoParaAlejandria
validoParaAlejandria libro = length (contenido libro) == paginas libro

berlin = UnaBiblioteca "Biblioteca de Berlin" [] (esDeGenero "policial")
paris = UnaBiblioteca "Biblioteca de Paris" [] (esDeGenero "romantico")

miCiudad = UnaBiblioteca "Biblioteca de mi ciudad" [] (\libro -> titulo libro == "")

-- Obtener todas las bibliotecas en las que podría estar un libro.
bibliotecasPosiblesPara::Libro -> [Biblioteca] -> [Biblioteca]
bibliotecasPosiblesPara libro bibliotecas = filter (\biblioteca -> (validacion biblioteca) libro) bibliotecas

-------------------
-- SEGUNDA PARTE --
-------------------

-- Generar la Biblioteca de Babel, con todos sus libros, y cada libro con su correspondiente contenido, para luego poder buscar libros en ella

generarLibro::String -> Libro
generarLibro texto = UnLibro{generos = [],contenido = texto, paginas = 410, titulo = "Babel" }

tamanioPersonalizado = 5
tamanioLiteral = 410*40*80
tamanioSimplificado = 410

bibliotecaBabel = 
    UnaBiblioteca{
        ubicacion = "Babel",
        libros = map generarLibro (palabrasDe tamanioPersonalizado),
        validacion = validoParaBabel
    } 


palabrasConUnSimboloMas palabra = map (:palabra) simbolos

palabrasDe 0 = [""]
palabrasDe n = concatMap palabrasConUnSimboloMas (palabrasDe (n-1))

-- A partir de un fragmento de texto dado, encontrar el primer libro de la biblioteca que 
-- lo contenga
-- empiece con el
-- termine con el

primerLibroCon::String -> Biblioteca -> Libro
primerLibroCon fragmento biblioteca = head (filter (contieneA fragmento.contenido) (libros biblioteca) )

empiezaCon :: Eq a =>[a] -> [a] -> Bool
empiezaCon fragmento texto = take (length fragmento) texto == fragmento

terminaCon :: Eq a =>[a] -> [a] -> Bool
terminaCon fragmento texto = drop (length texto - length fragmento) texto == fragmento

contieneA :: Eq a =>[a] -> [a] -> Bool
contieneA fragmento [] = False
contieneA fragmento texto = empiezaCon fragmento texto || contieneA fragmento (tail texto) 

-- Permitir averiguar cuántos libros de la biblioteca contienen un fragmento dado
cuantosLibrosCon fragmento biblioteca = length (filter (contieneA fragmento.contenido) (libros biblioteca) )
