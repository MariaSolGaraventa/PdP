% Simulacro Lógico 2023 - Age of Empires 2

% --------- JUGADORES ---------

% jugador(Nombre, Rating, Civilizacion).
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

jugador(romario, 4596, polacos).

% tiene(Nombre, QueTiene).
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).

tiene(romario, unidad(espadachin, 10)).
tiene(romario, unidad(lenador, 10)).

% --------- UNIDADES ---------

% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero).

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(0, 0, 25)).

% --------- EDIFICIOS ---------

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).

% --------- COSTOS ---------
cuesta(aldeano, costo(0, 50, 0)).
cuesta(carreta, costo(100, 0, 50)).
cuesta(urnaMercante, costo(100, 0, 50)).

% --------- PRODUCCION ---------
produccionPorMinuto(carreta, produce(0, 0, 32)).
produccionPorMinuto(urnaMercante, produce(0, 0, 32)).
produccionPorMinuto(keshik, produce(0, 0, 10)).

%-----------------------------------------------------------

%              --------- 1 ---------

esUnAfano(Jugador1, Jugador2) :-
    jugador(Jugador1, Rating1, _),
    jugador(Jugador2, Rating2, _),
    DiferenciaDeRating is Rating1 - Rating2,
    DiferenciaDeRating > 500.

%              --------- 2 ---------

% La caballería le gana a la arquería.
esEfectivo(Unidad1, Unidad2) :-
    militar(Unidad1, _, caballeria),
    militar(Unidad2, _, infanteria).

%La arquería le gana a la infantería.
esEfectivo(Unidad1, Unidad2) :-
    militar(Unidad1, _, arqueria),
    militar(Unidad2, _, infanteria).

% La infantería le gana a los piqueros.
esEfectivo(Unidad1, Unidad2) :-
    militar(Unidad1, _, infanteria),
    militar(Unidad2, _, piqueros).

% Los piqueros le ganan a la caballería..
esEfectivo(Unidad1, Unidad2) :-
    militar(Unidad1, _, piqueros),
    militar(Unidad2, _, caballeria).

% los Samuráis son efectivos contra otras unidades únicas (incluidos los samurái).
esEfectivo(samurai, Unidad2) :-
    militar(samurai, _, unica),
    militar(Unidad2, _, unica).

%              --------- 3 ---------

alarico(Jugador) :-
    jugador(Jugador, _, _),
    forall(tiene(Jugador, unidad(Unidad, _)), militar(Unidad, _, infanteria)).

%              --------- 4 ---------
%Definir el predicado leonidas/1, que se cumple para un jugador si solo tiene unidades de piqueros.

leonidas(Jugador) :-
    jugador(Jugador, _, _),
    forall(tiene(Jugador, unidad(Unidad, _)), militar(Unidad, _, piqueros)).

%              --------- 5 ---------

nomada(Jugador) :-
    jugador(Jugador, _, _),
    not(tiene(Jugador, edificio(casa, _))).

%              --------- 6 ---------

cuantoCuesta(Unidad, Costo) :- %militar
    militar(Unidad, Costo, _).

cuantoCuesta(AldenaoUObjeto, Costo) :- %aldeano u objeto
    cuesta(AldenaoUObjeto, Costo).

cuantoCuesta(Construccion, Costo) :- %edificio
    edificio(Construccion, Costo).

%              --------- 7 ---------

produccion(Unidad, recurso(Madera, Alimento, Oro)) :- 
    aldeano(Unidad, produce(Madera, Alimento, Oro)).

produccion(Objeto, Madera, Alimento, Oro) :- 
    produccionPorMinuto(Objeto, produce(Madera, Alimento, Oro)).

produccion(keshik, Madera, Alimento, Oro) :- 
    produccionPorMinuto(keshik, produce(Madera, Alimento, Oro)).

%              --------- 8 ---------
/*
produccionTotal(Jugador, recurso(Madera, Alimento, Oro), ProduccionTotal) :-
    tiene(Jugador, unidad(Unidad, produce(CantidadMadera, CantidadAlimento, CantidadOro))),
    produccionDeMadera(CantidadMadera, recurso(Madera, _, _), Produccion),
    produccionDeAlimento(CantidadAlimento, recurso(_, Alimento, _), Produccion),
    produccionDeOro(CantidadOro, recurso(_, _, Oro), Produccion),
    sumlist(Produccion, ProduccionSumada),
    ProduccionTotal is ProduccionSumada * CantidadMadera.

produccionDeMadera(Jugador, recurso(Madera, _, _), Produccion) :-  
    findall(Madera, aldeano(_, produce(Madera, _, _)), Produccion),
produccionDeMadera(Jugador, recurso(Madera, _, _), Produccion).

produccionDeAlimento(Jugador, recurso(_, Alimento, _), Produccion) :-
    findall(Alimento, aldeano(_, produce(_, Alimento, _)), Produccion).

produccionDeOro(Jugador, recurso(_, _, Oro), Produccion) :-
    findall(Alimento, aldeano(_, produce(_, _, Oro)), Produccion).

*/



productorDe(recurso(madera, _, _), lenador).
/*productorDe(alimento, granjero).
productorDe(alimento, cazador).
productorDe(alimento, pescador).
productorDe(oro, carreta).
productorDe(oro, urnaMercante).
productorDe(oro, keshik).
productorDe(oro, minero).
productorDe(oro, alquimista).
*/

produccionTotal(Jugador, recurso(Madera, Alimento, Oro), ProduccionTotal) :-
    tiene(Jugador, unidad(Unidad, CantidadUnidad)),
    productorDe(recurso(Madera, Alimento, Oro), Unidad),
    produccionDe(Unidad, recurso(Madera, Alimento, Oro), Producciones),
    sumlist(Producciones, ProduccionSumada),
    ProduccionTotal is ProduccionSumada * CantidadUnidad.

/*
produccionTotal(Jugador, alimento, ProduccionTotal) :-
    tiene(Jugador, unidad(Unidad, CantidadUnidad)),
    produccionDe(Recurso, Madera, Alimento, Oro, Producciones)),
    sumlist(Producciones, ProduccionSumada),
    ProduccionTotal is ProduccionSumada * CantidadUnidad.

produccionTotal(Jugador, oro, ProduccionTotal) :-
    tiene(Jugador, unidad(Unidad, CantidadUnidad)),
    produccionDe(Recurso, Madera, Alimento, Oro, Producciones),
    sumlist(Producciones, ProduccionSumada),
    ProduccionTotal is ProduccionSumada * CantidadUnidad.
*/

produccionDe(Unidad, recurso(madera, _, _), Producciones) :-
    productorDe(recurso(madera, alimento, oro), Unidad),
    findall(recurso(Madera, Alimento, Oro), produccion(Unidad, recurso(Madera, Alimento, Oro)), Producciones).

/*

Definir el predicado produccionTotal/3 que relaciona a un jugador con su producción total por minuto de cierto recurso, 
que se calcula como la suma de la producción total de todas sus unidades de ese recurso.




Definir el predicado estaPeleado/2 que se cumple para dos jugadores cuando no es un afano para ninguno, 
tienen la misma cantidad de unidades y la diferencia de valor entre su producción total de recursos por minuto es menor a 100. 
¡Pero cuidado! No todos los recursos valen lo mismo: el oro vale cinco veces su cantidad; la madera, tres veces; y los alimentos, dos veces.



Definir el predicado avanzaA/2 que relaciona un jugador y una edad si este puede avanzar a ella:
    Siempre se puede avanzar a la edad media.
    Puede avanzar a edad feudal si tiene al menos 500 unidades de alimento y una casa.
    Puede avanzar a edad de los castillos si tiene al menos 800 unidades de alimento y 200 de oro. 
    También es necesaria una herrería, un establo o una galería de tiro.
    Puede avanzar a edad imperial con 1000 unidades de alimento, 800 de oro, un castillo y una universidad.

*/