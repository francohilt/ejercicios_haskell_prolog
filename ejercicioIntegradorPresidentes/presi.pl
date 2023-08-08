%--------------------- BASE DE CONOCIMIENTO ---------------------%

% periodo(nombre,inicioMandato,finalizacionMandato).
periodo(alfonsin, 1983, 1989).
periodo(menem, 1989, 1995).
periodo(menem, 1995, 1999).
periodo(puerta, 2001, 2001).

% accionDeGobierno(descripcion,fecha,lugar,beneficiados).
accionDeGobierno(juicioALasJuntas, 1985, buenosAires, 30000000).
accionDeGobierno(hiperinflacion, 1989, buenosAires, 10).
accionDeGobierno(privatizacionDeYPF, 1985, campana, 1).

%--------------------- PUNTO 1 ---------------------%

tuvoMasDeUnPeriodo(Presidente):-
    periodo(Presidente, InicioMandato1, _),
    periodo(Presidente, InicioMandato2, _),
    InicioMandato1 \= InicioMandato2.

fuePresidente(Fecha, Presidente):-
    periodo(Presidente, InicioMandato, FinalizacionMandato),
    between(InicioMandato, FinalizacionMandato, Fecha).

%--------------------- PUNTO 2 ---------------------%

fueBuena(Accion):-
    accionDeGobierno(Accion, _, _, Beneficiados),
    Beneficiados > 10000.

hizoAlgoBueno(Presidente):-
    periodo(Presidente, InicioMandato, FinalizacionMandato),
    accionDeGobierno(Accion, Fecha, _, _),
    fueBuena(Accion),
    between(InicioMandato, FinalizacionMandato, Fecha).

%--------------------- PUNTO 3 ---------------------%

hizoAlgo(Presidente):-
    periodo(Presidente, InicioMandato, FinalizacionMandato),
    accionDeGobierno(_, Fecha, _, _),
    between(InicioMandato, FinalizacionMandato, Fecha).
   
% Insulso. En su período no hizo nada (Alfonsin)
insulso(Presidente):-
    periodo(Presidente, _, _),
    not(hizoAlgo(Presidente)).

% Malo. Hizo cosas, pero nada bueno (Menem)
malo(Presidente):-
    periodo(Presidente, _, _),
    hizoAlgo(Presidente),
    not(hizoAlgoBueno(Presidente)).

% Regular. En todos sus períodos hizo al menos una cosa buena (Alfonsín)
regular(Presidente):-
    periodo(Presidente, _, _),
    forall(periodo(Presidente, _, _),hizoAlgoBueno(Presidente)).

% Bueno. Tuvo al menos un período en el que hizo cosas y todo lo que hizo en ese período fue bueno (Alfonsín)
bueno(Presidente):-
    periodo(Presidente, _, _),
    hizoAlgoBueno(Presidente).

% Muy bueno. En todos los periodos en los que estuvo hizo cosas y todas las cosas que hizo en cada período fueron buenas.
muyBueno(Presidente):-
    periodo(Presidente, _, _),
    forall(periodo(Presidente, _, _),hizoAlgo(Presidente)), hizoAlgoBueno(Presidente).




