%---------------- BASE DE CONOCIMIENTO ----------------%

%lugar(nombre,tipo,visitantes,entrada).
lugar(temploAgnkor,templo,1500,200).
lugar(temploNom,templo,1000,100).
lugar(rioNom,rio,250,0).
lugar(rioChico,rio,250,0).
lugar(rioMekong,rio,100,0).
lugar(museoCamboya,museo,2000,150).
lugar(museoDeCera,museo,100,50).
lugar(museoDeArte,museo,100,500).
lugar(montaniaSolitaria,montania,500,0).
lugar(camboya,ciudad,5000,0).

impuestoPorcentual(templo, 10). % Se incrementa en dicho porcentaje el precio de la entrada.

impuestoFijo(montania, 100).  % Se suma el cargo fijo al precio de la entrada.

impuestoRango(museo,100,200,5). % Se incrementa un 5% a las entradas a museos que cuestan entre 100 y 200, el resto queda igual.

%---------------- PUNTO 1 ----------------%

lugarMasVisitado(Tipo,Lugar):-
    lugar(Lugar,Tipo,Visitantes,_),
    forall(lugar(_,Tipo,OtrosVisitantes,_), Visitantes >= OtrosVisitantes).

%---------------- PUNTO 2 ----------------%

/* Decimos que un predicado es inversible cuando admite consultas con variables libres para sus argumentos: 
En este caso no hay restricciones así que lugarMasVisitado/2 es totalmente inversible. */

%---------------- PUNTO 3 ----------------%

cuantoCuestaEntrarEn(Lugar,Precio):-
    lugar(Lugar,Tipo,_,Entrada),
    impuestoPorcentual(Tipo, Porcentaje),
    Precio is Entrada + Entrada * Porcentaje/100.

cuantoCuestaEntrarEn(Lugar,Precio):-
    lugar(Lugar,Tipo,_,Entrada),
    impuestoFijo(Tipo, CargoFijo),
    Precio is Entrada + CargoFijo.

cuantoCuestaEntrarEn(Lugar,Precio):-
    lugar(Lugar,Tipo,_,Entrada),
    impuestoRango(Tipo,Min,Max,Porcentaje),
    between(Min,Max,Entrada),
    Precio is Entrada + Entrada * Porcentaje/100.

cuantoCuestaEntrarEn(Lugar,Precio):-
    lugar(Lugar,Tipo,_,Entrada),
    impuestoRango(Tipo,Min,Max,_),
    not(between(Min,Max,Entrada)),
    Precio is Entrada.

cuantoCuestaEntrarEn(Lugar,Precio):-
    lugar(Lugar,Tipo,_,Entrada),
    impuestoRango(Tipo,Min,Max,_),
    not(between(Min,Max,Entrada)),
    Precio is Entrada.

cuantoCuestaEntrarEn(Lugar,Precio):-
    lugar(Lugar,ciudad,_,Entrada),
    Precio is Entrada.

cuantoCuestaEntrarEn(Lugar,Precio):-
    lugar(Lugar,rio,_,Entrada),
    Precio is Entrada.

%---------------- PUNTO EXTRA ----------------%

% Buscar la recaudación total, 
% considerando la cantidad de visitantes y el precio unitario con impuesto.

recaudacionTotal(Lugar,Recaudacion):-
    lugar(Lugar,_,Visitantes,_),
    cuantoCuestaEntrarEn(Lugar,Precio),
    Recaudacion is Visitantes * Precio.

