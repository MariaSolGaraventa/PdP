% https://docs.google.com/document/d/1BE6MIKzMcQMh_D27sIM3JkcOaZRDjdqAMwqD_udM9ro/edit

% jugador(nombre, items, nivelHambre).
jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

% lugar(seccion, jugadoresAhí, nivelOscuridad).
lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

% comestible(item).
comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

% item(itemAConstruir, componentes)
item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).

% Punto 1
% a. Relacionar un jugador con un ítem que posee. tieneItem/2

tieneItem(UnJugador, Item) :-
   jugador(UnJugador, Items, _),
   member(Item, Items).
    
% b. Saber si un jugador se preocupa por su salud, esto es si tiene entre sus ítems más de un tipo de comestible. 
% (Tratar de resolver sin findall) sePreocupaPorSuSalud/1

sePreocupaPorSuSalud(UnJugador) :-
    jugador(UnJugador, Items, _),
    esUnItemComestible(Items, Item1),
    esUnItemComestible(Items, Item2),
    Item1 \= Item2.

esUnItemComestible(Items, Item) :-
    member(Item, Items),
    comestible(Item).

% c. Relacionar un jugador con un ítem que existe (un ítem existe si lo tiene alguien), y la cantidad que tiene de ese ítem. 
% Si no posee el ítem, la cantidad es 0. cantidadDeItem/3

cantidadDeItem(Item, UnJugador, Cantidad) :-
    jugador(UnJugador, Items, _),
    findall(Item, tiene(Items, Item), ListaDeEseItem),
    length(ListaDeEseItem, Cantidad).

tiene(SusItems, ElItem) :-
    member(ElItem, SusItems).

% d. Relacionar un jugador con un ítem, si de entre todos los jugadores, es el que más cantidad tiene de ese ítem. tieneMasDe/2

tieneMasDe(UnItem, UnJugador) :-
    cantidadDeItem(UnItem, UnJugador, Cantidad),
    forall(cantidadDeItem(UnItem, OtroJugador, OtraCantidad), Cantidad > OtraCantidad),
    OtroJugador \= UnJugador.

% Punto 2
% a. Obtener los lugares en los que hay monstruos. Se sabe que los monstruos aparecen en los lugares cuyo nivel de oscuridad es más de 6. hayMonstruos/1

hayMonstruos(UnLugar) :-
    lugar(UnLugar, _, NivelOscuridad),
    NivelOscuridad > 6.

% b. Saber si un jugador corre peligro. Un jugador corre peligro si se encuentra en un lugar donde hay monstruos; o si está hambriento (hambre < 4) 
% y no cuenta con ítems comestibles. correPeligro/1

correPeligro(UnJugador) :-
    jugador(UnJugador, _, _),
    lugar(UnLugar, JugadoresAhi, _),
    hayMonstruos(UnLugar),
    member(UnJugador, JugadoresAhi).

correPeligro(UnJugador) :-
    jugador(UnJugador, _, _),
    estaHambriento(UnJugador),
    not(tieneItemsComestibles(UnJugador)).

estaHambriento(UnJugador) :-
    jugador(UnJugador, _, NivelHambre),
    NivelHambre < 4.

tieneItemsComestibles(UnJugador) :-
    tieneItem(UnJugador, Item),
    comestible(Item).

% c. Obtener el nivel de peligrosidad de un lugar, el cual es un número de 0 a 100 y se calcula:
%    - Si no hay monstruos, es el porcentaje de hambrientos sobre su población total.
%    - Si hay monstruos, es 100.
%    - Si el lugar no está poblado, sin importar la presencia de monstruos, es su nivel de oscuridad * 10. nivelPeligrosidad/2

nivelPeligrosidad(UnLugar, NivelDePeligrosidad) :-
    lugar(UnLugar, _, _),
    not(hayMonstruos(UnLugar)),
    hambrientosDelLugar(UnLugar, CantidadHambrientos),
    poblacionDelLugar(UnLugar, PoblacionTotal),
    NivelDePeligrosidad is (CantidadHambrientos / PoblacionTotal) * 100.

hambrientosDelLugar(UnLugar, CantidadHambrientos) :-
    lugar(UnLugar, JugadoresAhi, _),
    findall(UnJugador, (member(UnJugador, JugadoresAhi), estaHambriento(UnJugador)), JugadoresHambrientos),
    length(JugadoresHambrientos, CantidadHambrientos).


poblacionDelLugar(UnLugar, PoblacionTotal) :-
    lugar(UnLugar, JugadoresAhi, _),
    length(JugadoresAhi, PoblacionTotal).

nivelPeligrosidad(UnLugar, 100) :-
    lugar(UnLugar, _, _),
    hayMonstruos(UnLugar).

nivelPeligrosidad(UnLugar, NivelDePeligrosidad) :-
    lugar(UnLugar, _, NivelOscuridad),
    poblacionDelLugar(UnLugar, 0),
    NivelDePeligrosidad is NivelOscuridad * 10.

% Punto 3
% El aspecto más popular del juego es la construcción. Se pueden construir nuevos ítems a partir de otros, cada uno tiene ciertos requisitos para poder construirse:
%    - Puede requerir una cierta cantidad de un ítem simple, que es aquel que el jugador tiene o puede recolectar. Por ejemplo, 8 unidades de piedra.
%    - Puede requerir un ítem compuesto, que se debe construir a partir de otros (una única unidad).
% Con la siguiente información, se pide relacionar un jugador con un ítem que puede construir. puedeConstruir/2
% Aclaración: Considerar a los componentes de los ítems compuestos y a los ítems simples como excluyentes, 
% es decir no puede haber más de un ítem que requiera el mismo elemento.

puedeConstruir(UnJugador, UnItemQuePuedeConstruir) :-
    jugador(UnJugador, _, _),
    item(UnItemQuePuedeConstruir, Requisitos),
    forall(member(Requisito, Requisitos), tieneLosMateriales(UnJugador, Requisito)).

tieneLosMateriales(UnJugador, itemSimple(Item, Cantidad)) :-
    jugador(UnJugador, Items, _),
    member(Item, Items),
    cantidadDeItem(Item, UnJugador, CantidadDelItem),
    CantidadDelItem >= Cantidad.

tieneLosMateriales(UnJugador, itemCompuesto(Item)) :-
    item(Item, _),
    puedeConstruir(UnJugador, Item).

% Punto 4

% a. Dará false ya que no está en nuestra base de conocimiento el desierto. Por lo tanto, la consulta no podrá ser satisfecha y dará false.
% b. El backtracking y las múltiples respuestas.