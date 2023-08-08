% TP Envio de Paquetes %

% paquete(Paquete, CiudadOrigen, CiudadDestino, Tamanio). 

paquete(cz001,campana,zarate,3).
paquete(cc001,campana,campana,1).
paquete(cc002,campana,campana,2).
paquete(ce002,campana,escobar,1).
paquete(ce001,campana,escobar,1).
paquete(ze004,zarate,escobar,1).
paquete(cp001,zarate,pilar,2).
paquete(p20,campana,zarate, 5).

% horarioEntrega(Paquete, Dia, HoraInicio, HoraFin).

horarioEntrega(cz001, martes, 9, 15).
horarioEntrega(ce002, jueves, 11, 17).
horarioEntrega(cp001, martes, 8, 16).
horarioEntrega(cc001, sabado, 8, 12).
horarioEntrega(cc002,lunes, 6, 10).
horarioEntrega(ce001, martes, 8, 16).
horarioEntrega(ze004, martes, 8, 16).
horarioEntrega(p20, lunes, 9, 12).

% sucursal(Nombre, Ciudad).

sucursal(s22, zarate).
sucursal(s02, zarate).
sucursal(correoCampana, campana).
sucursal(correoArgentino, campana).
sucursal(correoZarate, zarate).
sucursal(correoEscobar, escobar).
sucursal(correoPilar, pilar).

% mensajero(Nombre, Sucursal, Dia, HoraInicio, HoraFin).

mensajero(luis, coreoCampana, martes, 8, 19).
mensajero(luis, coreoArgentino, jueves, 8, 16).
% luis trabaja en dos sucursales de la misma ciudad.

mensajero(juan, s25, lunes, 9, 12).
mensajero(jose, s22, lunes, 9, 15).
mensajero(marcos, coreoCampana, martes, 9, 15).
mensajero(pedro, coreoPilar, martes, 8, 16).
mensajero(marcos, coreoArgentino, jueves, 8, 16).
mensajero(beto, coreoZarate, martes, 8, 14).
mensajero(alonso, coreoEscobar, martes, 8, 16).


% 1.Envíos express 

envioExpress(Paquete):-
    paquete(Paquete, CiudadOrigen, CiudadDestino, Tamanio),
    CiudadOrigen == CiudadDestino,
    Tamanio =< 3.

envioExpress(Paquete):-
    paquete(Paquete, CiudadOrigen, CiudadDestino, 1),
    CiudadOrigen \= CiudadDestino.

% Decimos que un predicado es inversible cuando 
% admite consultas con variables libres para sus argumentos;
% en el caso de envioExpress si hacemos la consulta con una variable:
% envioExpress(Paquete). --> Paquete = cc001 
% pero en el caso que elijamos un paquete determinado:
% envioExpress(cc001). --> true.

% 2.Multiempleo

multiEmpleo(Nombre):-
    mensajero(Nombre, Sucursal1,_,_,_),
    mensajero(Nombre, Sucursal2,_,_,_),
    sucursal(_, Ciudad1),
    sucursal(_, Ciudad2),
    Ciudad1 == Ciudad2,
    Sucursal1 \= Sucursal2.

% multiEmpleo(luis). --> true.
% multiEmpleo(beto). --> false.

% 3.Entregas

entregas(Nombre,Paquete):-
    mensajero(Nombre,_, Dia, HoraInicio, HoraFin),    
    sucursal(_, Ciudad),
    paquete(Paquete,_, CiudadDestino,_),
    Ciudad == CiudadDestino,
    horarioEntrega(Paquete, DiaE, HoraE, FinE),
    Dia == DiaE,
    HoraInicio >= HoraE,
    HoraFin =< FinE.

% entregas(juan,Paquete). --> Paquete = p20 .
% entregas(luis,Paquete). --> false.

% 4.Calificación de paquetes

imposible(Paquete):-
    paquete(Paquete,_,_,_),
    not(entregas(_,Paquete)).

% imposible(Paquete). --> Paquete = cc001 ;
%                         Paquete = cc002 ;
%                         Paquete = ce002 ; 
%                         false.

disputado(Paquete):-
    paquete(Paquete,_,_,_),
    entregas(Nombre1,Paquete),
    entregas(Nombre2,Paquete),
    Nombre1 \= Nombre2.

% disputado(ce001). --> true.
% disputado(cc001). --> false.

indiscutido(Paquete):-
    paquete(Paquete,_,_,_),
    not(imposible(Paquete)),
    not(disputado(Paquete)).

% indiscutido(Paquete). --> Paquete = cz001 ;
%                           Paquete = p20.


% Nuevas Calificaciones

% Todos los empleados de una misma sucursal 
% de la ciudad destino pueden entregarlo.

todosPuedenEntregarMismaSucursal(Paquete):-
    paquete(Paquete,_,CiudadDestino,_),
    mensajero(Nombre, SucursalM,_,_,_),
    sucursal(Sucursal, Ciudad),
    Sucursal == SucursalM,
    Ciudad == CiudadDestino,
    forall(mensajero(Nombre,SucursalM,_,_,_),entregas(Nombre,Paquete)).

% Todos los empleados de cualquiera de las sucursales 
% de la ciudad destino pueden entregarlo.

todosPuedenEntregar(Paquete):-
    paquete(Paquete,_,Ciudad,_),
    sucursal(NombreS, Ciudad),
    forall(mensajero(Nombre,NombreS,_,_,_),entregas(Nombre,Paquete)).

% 5.Empleado modelo

horasTrabajadas(Nombre, Horas):-
    mensajero(Nombre,_,_,HoraInicio,HoraFin), 
    Horas is HoraFin - HoraInicio.

empleadoModelo(Nombre,Dia):-
    mensajero(Nombre,_,Dia,HoraInicio,HoraFin), 
    mensajero(OtroNombre,_,Dia,HoraInicio,HoraFin), 
    Nombre \= OtroNombre,
    horasTrabajadas(Nombre, Horas),
    not((horasTrabajadas(_,OtrasHoras), Horas < OtrasHoras)).

% empleadoModelo(luis,AlgunDia). --> AlgunDia = jueves
% empleadoModelo(Alguien,jueves). --> Alguien = luis