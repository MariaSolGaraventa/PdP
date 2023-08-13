% ------------ VOCALOIDS
% ------------ 1
novedoso(Vocaloid) :-
    vocaloid(Vocaloid, Lista),
    tieneMasDeDosCanciones(Lista),
    todasSusCancionesDuranMenosDe15(Lista).

tieneMasDeDosCanciones(Lista) :-
    length(Lista, Cantidad),
    Cantidad >= 2.

todasSusCancionesDuranMenosDe15(Lista) :-
    member(Cancion, Lista),
    forall(cancion(Cancion, Duracion), Duracion < 15).

% ------------ 2
esAcelerado(Vocaloid) :-
    vocaloid(Vocaloid, Lista),
    member(Cancion, Lista),
    forall(cancion(Cancion, Duracion), Duracion =< 4).

% ------------ CONCIERTOS
% ------------ 2

puedeParticiparDelConcierto(Concierto, Vocaloid) :-
    vocaloid(Vocaloid, _),
    requisitos(Concierto, Requisitos),
    cumpleRequisitos(Vocaloid, Requisitos).

puedeParticiparDelConcierto(_, hatsuneMiku).

cumpleRequisitos(Vocaloid, Requisitos) :-
    forall(member(Requisito, Requisitos), cumpleElRequisito(Vocaloid, Requisito)).

cumpleElRequisito(Vocaloid, masDeXCanciones(Cantidad)) :- % saber mas de X canciones
    vocaloid(Vocaloid, Lista),
    length(Lista, CantidadDeCanciones),
    CantidadDeCanciones >= Cantidad.

cumpleElRequisito(Vocaloid, tiempoMinimoCancion(Tiempo)) :- % tiempoMinimoCancion
    vocaloid(Vocaloid, Lista),
    member(Cancion, Lista),
    forall(cancion(Cancion, Duracion), Duracion >= Tiempo).

cumpleElRequisito(Vocaloid, tiempoTotal(Criterio, Tiempo)) :- % tiempo max o min 
    vocaloid(Vocaloid, Lista),
    member(Cancion, Lista),
    findall(Duracion, cancion(Cancion, Duracion), Duraciones),
    sumlist(Duraciones, Suma),
    segunCriterio(tiempoTotal(Criterio, Tiempo), Suma).

segunCriterio(tiempoTotal(maximo, Tiempo), Suma) :-
    Suma < Tiempo.
    
segunCriterio(tiempoTotal(minimo, Tiempo), Suma) :-
    Suma > Tiempo.

% ------------ 3
vocaloidMasFamoso(Vocaloid) :-
    cantidadDeCancionesDelVocaloid(Vocaloid, CantidadDeCanciones),
    famosidad(Vocaloid, CantidadDeCanciones, FamaTotal),
    cantidadDeCancionesDelVocaloid(OtroVocaloid, OtraCantidadDeCanciones),
    forall(famosidad(OtroVocaloid, OtraCantidadDeCanciones, OtraFamaTotal), FamaTotal > OtraFamaTotal),
    OtroVocaloid \= Vocaloid.

cantidadDeCancionesDelVocaloid(Vocaloid, CantidadDeCanciones) :-
    vocaloid(Vocaloid, Lista),
    length(Lista, CantidadDeCanciones).

famosidad(Vocaloid, CantidadDeCanciones, FamaTotal) :-
    puedeParticiparDelConcierto(Concierto, Vocaloid),
    findall(Concierto, puedeParticiparDelConcierto(Concierto, Vocaloid), Conciertos),
    sumaSegunFama(Conciertos, Fama),
    FamaTotal is Fama * CantidadDeCanciones.

sumaSegunFama(Conciertos, CantidadDeFama) :-
    member(Concierto, Conciertos),
    findall(Fama, concierto(Concierto, _, Fama, _), Famas),
    sumlist(Famas, CantidadDeFama).

% ------------ 4
esteConoceA(megurineLuka, hatsuneMiku).
esteConoceA(megurineLuka, gumi).
esteConoceA(gumi, seeU).

unicoDelConcierto(Vocaloid, Concierto) :-
    puedeParticiparDelConcierto(Vocaloid, Concierto),
    not((loConoce(Vocaloid, Conocido), puedeParticiparDelConcierto(Conocido, Concierto))).
    
loConoce(Vocaloid, OtroVocaloid) :-
    esteConoceA(Vocaloid, OtroVocaloid).

loConoce(Vocaloid, OtroVocaloid) :-
    esteConoceA(Vocaloid, Intermedio),
    esteConoceA(Intermedio, OtroVocaloid).

/* ------------ 5
Tendría que definir una nueva clausula de concierto y establecerle las restricciones necesarias. Al no calcular los requisitos por el tipo de concierto, no habría que cambiar
nada más que agregar eso, obviamente respetando la regla del tipo del concierto, pero eso es semántica.
*/

% -------------- Base de Conocimiento

% vocaloid(nombreVocaloid, cancion).
vocaloid(megurineLuka, [nightFever1, foreverYoung1]). %2200
vocaloid(hatsuneMiku, [tellYourWorld1]). %6100
vocaloid(gumi, [foreverYoung2, tellYourWorld2]). %2200
vocaloid(seeU, [novemberRain, nightFever2]). %6200

cancion(nightFever1, 4).
cancion(foreverYoung1, 5).
% 4 y 5
cancion(tellYourWorld1, 4).

cancion(foreverYoung2, 4).
cancion(tellYourWorld2, 5).

cancion(novemberRain, 6).
cancion(nightFever2, 5).

%concierto(nombre, pais, cantidadFama, tipo).
concierto(mikuExpo, estadosUnidos, 2000, gigante).
concierto(magicalMirai, japon, 3000, gigante).
concierto(vocalektVisions, estadosUnidos, 1000, mediano).
concierto(mikuFest, argentina, 100, pequenio).

requisitos(mikuExpo, [masDeXCanciones(2), tiempoMinimoCancion(6)]).
requisitos(magicalMirai, [masDeXCanciones(3), tiempoTotal(minimo, 10)]).
requisitos(vocalektVisions, [tiempoTotal(maximo, 9)]).
requisitos(mikuFest, [masDeXCanciones(1)]).