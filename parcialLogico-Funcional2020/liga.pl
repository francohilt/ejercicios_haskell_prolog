
%-------------------- BASE DE CONOCIMIENTO --------------------%

%club(Nombre, Ubicacion, Hinchas).
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

clasico(central, nob).
clasico(banfield, lanus).

%-------------------- PUNTO 1 --------------------%

esGrande(Club):-
    club(Club, amba, _),
    tienePlata(Club).

esDelAmbaPeroNoGrande(Club):-
    club(Club, amba,_), 
    not(esGrande(Club)).

esDelInteior(Club):-
    club(Club, Ubicacion, _), 
    Ubicacion \= amba.

esClasico(Club,OtroClub):-
    clasico(Club,OtroClub).
    
esClasico(Club,OtroClub):-   
    clasico(OtroClub,Club).

grupoValido(ClubA,ClubB,ClubC,ClubD):-
    esGrande(ClubA),
    esDelAmbaPeroNoGrande(ClubB),
    esDelInteior(ClubC),
    not(esGrande(ClubD)),
    not(esClasico(ClubD,ClubC)),
    not(esClasico(ClubD,ClubB)).

%-------------------- CONSULTAS --------------------%

/* grupoValido(boca,banfield,central,godoy). --> true.

grupoValido(boca,banfield,central,nob). --> false.

grupoValido(boca,lanus,central,banfield). --> false.

grupoValido(velez,banfield,central,godoy). --> true.

grupoValido(velez,banfield,godoy,nob). --> true.

grupoValido(boca,velez,banfield,central). --> false. */

%-------------------- PUNTO 2 --------------------%

esPopular(Club):-
    club(Club, _, Hinchas),
    not(esGrande(Club)),
    club(OtroClub, _, OtrosHinchas),
    esGrande(OtroClub), 
    Hinchas > OtrosHinchas,
    Club \= OtroClub.

esPopular(Club):-
    club(Club, _, Hinchas),
    esGrande(Club),
    forall((club(OtroClub, _, OtrosHinchas), not(esGrande(OtroClub))), Hinchas > OtrosHinchas).

%-------------------- CONSULTAS --------------------%

/* esPopular(Club).
Club = racing ;
Club = nob ;
Club = central ;
Club = lanus ;
Club = boca ;
false. */

%-------------------- PUNTO 3 --------------------%

esImportante(Ciudad):-
    forall(club(Club, Ciudad, _), esPopular(Club)).

%-------------------- CONSULTAS --------------------%

/* esImportante(rosario). --> true.
esImportante(amba). --> false. */

%-------------------- PUNTO 5 --------------------%

/* 
    Decimos que un predicado es inversible cuando admite 
    consultas con variables libres para sus argumentos: 
    En el predicado esImportante(Ciudad) notamos que NO es inversible ya que;
    al hacer la consulta por consola esImportante(Ciudad) no nos da la ciudad,
    pero si hacemos la consulta para un caso particular, si nos da true o false.

    En el predicado esPopular(Club) notamos que SI es inversible ya que;
    al hacer la consulta de esPopular(Club) nos da como resultado todos
    aquellos clubes que son populares.
. */

