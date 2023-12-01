% https://docs.google.com/document/d/1a8RMmT8wsOAsPunOmL_Rgdg-eSBBoB2VJ_AqexdzcgY/edit

% Functores 
%   Jugadores:
%        jugador(Nombre, PuntosVida, PuntosMana, CartasMazo, CartasMano, CartasCampo)
%   Cartas:
%       criatura(Nombre, PuntosDaño, PuntosVida, CostoMana)
%       hechizo(Nombre, FunctorEfecto, CostoMana)
%   Efectos
%       daño(CantidadDaño)
%       cura(CantidadCura)


% Predicados

nombre(jugador(Nombre,_,_,_,_,_), Nombre).
nombre(criatura(Nombre,_,_,_), Nombre).
nombre(hechizo(Nombre,_,_), Nombre).

vida(jugador(_,Vida,_,_,_,_), Vida).
vida(criatura(_,_,Vida,_), Vida).
vida(hechizo(_,curar(Vida),_), Vida).

danio(criatura(_,Danio,_), Danio).
danio(hechizo(_,danio(Danio),_), Danio).

mana(jugador(_,_,Mana,_,_,_), Mana).
mana(criatura(_,_,_,Mana), Mana).
mana(hechizo(_,_,Mana), Mana).

cartasMazo(jugador(_,_,_,Cartas,_,_), Cartas).
cartasMano(jugador(_,_,_,_,Cartas,_), Cartas).
cartasCampo(jugador(_,_,_,_,_,Cartas), Cartas).

% Punto 1
% Relacionar un jugador con una carta que tiene. La carta podría estar en su mano, en el campo o en el mazo.

cartaQueTiene(NombreJugador, UnaCarta) :-
    nombre(jugador(NombreJugador,_,_,_,_,_), NombreJugador),
    cartasMazo(jugador(NombreJugador, _, _, Cartas, _, _), Cartas),
    member(UnaCarta, Cartas).

cartaQueTiene(NombreJugador, UnaCarta) :-
    nombre(jugador(NombreJugador,_,_,_,_,_), NombreJugador),
    cartasMano(jugador(NombreJugador, _, _, _, Cartas, _), Cartas),
    member(UnaCarta, Cartas).


cartaQueTiene(NombreJugador, UnaCarta) :-
    nombre(jugador(NombreJugador,_,_,_,_,_), NombreJugador),
    cartasCampo(jugador(NombreJugador, _, _, _, _, Cartas), Cartas),
    member(UnaCarta, Cartas).

% Punto 2 
% Saber si un jugador es un guerrero. Es guerrero cuando todas las cartas que tiene, ya sea en el mazo, la mano o el campo, son criaturas.

esGuerrero(NombreJugador) :-
    nombre(jugador(NombreJugador,_,_,_,_,_), NombreJugador),
    forall(cartaQueTiene(NombreJugador, NombreDeUnaCarta), esUnaCriatura(NombreDeUnaCarta)).

esUnaCriatura(NombreDeUnaCarta) :-
    nombre(criatura(NombreDeUnaCarta,_,_,_), NombreDeUnaCarta).

% Punto 3
% Relacionar un jugador consigo mismo después de empezar el turno. Al empezar el turno, la primera carta del mazo pasa a estar en la mano 
% y el jugador gana un punto de maná.

empezoElTurno(Jugador, Jugador) :-
    nombre(jugador(Jugador,_,_,_,_,_), Jugador),
    cartasMazo(jugador(Jugador, _, _, CartasMazo, _, _), CartasMazo),    
    nth1(1, CartasMazo, PrimeraCarta).
    
    