% PARADIGMA LÓGICO

club(boca,amba, 100).
club(racing,amba, 80).
club(nob,rosario, 50).
club(godoy,mendoza, 5).
club(central,rosario,60).
club(velez, amba,5).
club(lanus, amba,10).
club(banfield, amba,4).

tienePlata(velez).
tienePlata(boca).
tienePlata(racing).


clasico(central, nob).
clasico(banfield, lanus).

% 1
grupoValido(ClubGrande,ClubChico,ClubInterior,OtroClub):- 
    esGrande(ClubGrande),
    esChicoDeBsAs(ClubChico),
    delInterior(ClubInterior),
    clubCompatible(OtroClub, ClubChico, ClubInterior). 

esGrande(Club) :-
    club(Club,amba,_),
    tienePlata(Club). 

esChico(Club):-
    club(Club,_,_),
    not(esGrande(Club)).

esChicoDeBsAs(Club):-
    club(Club,amba,_),
    esChico(Club).

delInterior(Club):-
    club(Club,Ciudad,_),
    Ciudad \= amba.  

clubCompatible(Club,Club1,Club2):-
    esChico(Club),
    not(incompatible(Club,Club1)),
    not(incompatible(Club,Club2)).
    
incompatible(Club,Club).
incompatible(Club,OtroClub) :- clasico(Club,OtroClub).
incompatible(Club,OtroClub) :- clasico(OtroClub,Club).
   
% 2
esPopular(Club) :-
    esChico(Club),
    esGrande(OtroClub),
    masHinchas(Club,OtroClub).

esPopular(Club):-
    esGrande(Club),
    forall(esChico(OtroClub), masHinchas( Club, OtroClub)). 

    
masHinchas(Club,OtroClub):-
    club(Club,_,Hinchas),
    club(OtroClub,_,OtrosHinchas),
    Hinchas > OtrosHinchas.

/*
Variante con doble negación. 
"no existe ningun club chico al que no suepere en cantidad de hinchas"
esPopular(Club):-
    esGrande(Club),
    not((esChico(OtroClub), not( masHinchas(Club, OtroClub))). 
*/
    
% 3
esImportanteFutbolisticamente(Ciudad) :-
    club(_,Ciudad,_), 
    forall(club(Equipo,Ciudad,_), esPopular(Equipo)).

% 4 Ejemplos de consulta 

/* ?- grupoValido(Club1,Club2,Club3,Club4).            
Club1 = boca,
Club2 = racing,
Club3 = nob,
Club4 = godoy . 

13 ?- esPopular(Club).
Club = nob ;
Club = central ;
Club = lanus ;
Club = boca ;
Club = racing ;
false.

esImportanteFutbolisticamente(Ciudad). 
Ciudad = rosario ;
Ciudad = rosario ;
false. 

esImportanteFutbolisticamente(amba).   
false. 

5 Inversibilidad 

El predicado esImportanteFutbolisticamente es inversible ya que me permite realizar consultas con constantes 
devolviendome el valor true o false y al consultar con una variable me devuelve todas aquellas ciudades que cumplen
las condiciones propuestas por el predicado. 

*/
