# Examen Logico Funcional

A 35 años de la recuperación de la democracia, queremos hacer un sistema de análisis de la las getsiones de gobierno.

1)	Los presidentes
Se cuenta con informacion acerca de los períodos presidenciales. Se conoce el nombre del presidente, la fecha de inico y la fecha de finalización, ambas con día mes y año.  Si un presidente fue electo en más de una ocasión se encuentra la información de cada uno de sus períodos

   Por ejemplo
   
    ●	Alfonsin: 10/12/1983 - 7/7/1989
   
    ●	Menem: 8/7/1989 - 9/12/1995
    
    ●	Menem: 10/12/1995 - 9/12/1999
    
    ●	Puerta: 21/12/2001 - 23/12/2001


   Se quiere averiguar, en ambos paradigmas:

   a)	Quiénes fueron presidente por más de un período (sin importar si fueron sucesivos o no)
    (Menem)
  
   b)	En una fecha dada, quién era el presidente.
   (22/12/2001?  Puerta)

2) Acciones de gobierno
Se conocen las acciones de gobierno que se realizan. De cada una de ellas se conoce una  descripción que identifica al suceso, la fecha en la que se produjo, el lugar y la cantidad de gente beneficiada. Las acciones que benefician a más de 10000 personas se consideran buenas. 

Por ejemplo
●	Juicio a las juntas: 9/12/1985. Buenos Aires. Beneficio a 30 millones de argentinos. 
●	Hiperinflacion: 1/1/1989. Buenos Aires. Beneficio a 10 empresarios con mucha plata. 
●	Privatización de YPF: 3/5/1992. Campana. 1 beneficiario: repsol.

Se quiere saber, en ambos paradigmas:
a)	Si un determinado acto de gobierno fue bueno. 
(el juicio a las juntas? Si -  La hiper? No)

b)	Si un presidente hizo algo bueno, es decir, si en alguno de sus periodos de gobierno hizo alguna accion de gobierno que se considere buena. 
(Alfonsin? Si - Menem? No - Puerta? No)

3-a) Calificacion **Logica** de presidentes 
Calificar a los presidentes con las siguientes categorias:
-	Insulso. En su período no hizo nada. (Puerta)
-	Malo. Hizo cosas, pero nada bueno. (Menem)
-	Regular. En todos sus períodos hizo al menos una cosa buena (Alfonsín)
-	Bueno. Tuvo al menos un período en el que hizo cosas y todo lo que hizo en ese período fue bueno. 
-	Muy bueno. En todos los periodos en los que estuvo hizo cosas y todas las cosas que hizo en cada período fueron buenas.
(Realizar en Lógico)


3-b) Calificacion **Funcional** de presidentes 
Aparecen los periodistas ( tambíen politólogos, columnistas y otros formadores de opinión pública) que califican a los presidentes según sus propias perspectivas políticas.
Se busca encontrar los nombres de todos los presidentes que sean del agrado de un determinado periodista .
De cada periodista  se conoce su nombre y su perspectiva, que puede ser alguna de las siguientes:
-	Conformista: Le agradan los presidentes que alguna vez hicieron algo bueno.
-	Complice: Le agrada un presidente si hizo algo malo, alguna vez
-	Oriundo de un lugar: Le agrada un presidente cuando hizo algo en el lugar indicado.
(Realizar en Funcional)

Por ejemplo:
●	Ernesto es conformista, el único que le va a agradar es Alfonsin
●	María es complice, le va a agradar tanto Alfonsin como Menem
●	Juan es oriundo de Campana, le va a agradar Menem


Aclaraciones:
En el caso de logico, modelar la base de conocimiento y poner algunos hechos de ejemplo. Mostrar consultas para ejemplificar el uso de los predicados.

En el caso de funcional, determinar los parámetros que recibe cada función y mostrar ejemplos de invocación.
