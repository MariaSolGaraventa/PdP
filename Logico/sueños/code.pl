% https://docs.google.com/document/d/1QcIfJEvOb-oxIFH4jeXEfiVTgMFQa00V0nvF11wIEAg/edit#heading=h.ewbxvcbwu7zc

% Punto 1
% Queremos reflejar que 
%   - Gabriel cree en Campanita, el Mago de Oz y Cavenaghi
%   - Juan cree en el Conejo de Pascua
%   - Macarena cree en los Reyes Magos, el Mago Capria y Campanita
%   - Diego no cree en nadie

% persona(Nombre, enQueCree)

persona(gabriel, campanita).
persona(gabriel, magoDeOz).
persona(gabriel, cavenaghi).
persona(juan, conejoDePascua).
persona(macarena, reyesMagos).
persona(macarena, magoCapria).
persona(macarena, campanita).

% suenio(persona, cantante(cantidadDiscos)).
% suenio(persona, futbolista(equipo)).
% suenio(persona, ganarLaLoteria(numerosApostados)).

suenios(gabriel, [ganarLaLoteria([5, 9]), futbolista(arsenal)]).
suenios(juan, [cantante(100000)]).
suenios(macarena, [cantante(10000)]).

equipo(chico(arsenal)).
equipo(chico(aldosivi)).

personaje(campanita).
personaje(magoDeOz).
personaje(cavenaghi).
personaje(conejoDePascua).
personaje(reyesMagos).
personaje(magoCapria).

/* punto 2
Queremos saber si una persona es ambiciosa, esto ocurre cuando la suma de dificultades de los sueños es mayor a 20. 
La dificultad de cada sueño se calcula como
    - 6 para ser un cantante que vende más de 500.000 ó 4 en caso contrario
    - ganar la lotería implica una dificultad de 10 * la cantidad de los números apostados
    - lograr ser un futbolista tiene una dificultad de 3 en equipo chico o 16 en caso contrario. Arsenal y Aldosivi son equipos chicos.

Gabriel es ambicioso, porque quiere ganar a la lotería con 2 números (20 puntos de dificultad) y quiere ser futbolista de Arsenal (3 puntos) = 23 que es mayor a 20. 
En cambio Juan y Macarena tienen 4 puntos de dificultad (cantantes con menos de 500.000 discos)
*/

esAmbiciosa(UnaPersona) :-
    suenios(UnaPersona, _),
    findall(Dificultad, dificultadesDeCadaSuenio(UnaPersona, Dificultad), Dificultades),
    sumlist(Dificultades, DificultadTotal),
    DificultadTotal > 20.

dificultadesDeCadaSuenio(UnaPersona, Dificultad) :-
    suenios(UnaPersona, UnosSuenios),
    member(UnSuenio, UnosSuenios),
    dificultadDeUnSuenio(UnSuenio, Dificultad).

dificultadDeUnSuenio(cantante(CantidadDiscos), 6) :-
    CantidadDiscos > 500000.

dificultadDeUnSuenio(cantante(CantidadDiscos), 4) :-
    CantidadDiscos =< 500000.

dificultadDeUnSuenio(ganarLaLoteria(Numeros), Dificultad) :-    
    length(Numeros, CantidadNumerosApostados),
    Dificultad is 10 * CantidadNumerosApostados.
    
dificultadDeUnSuenio(futbolista(Equipo), 3) :-
    esEquipoChico(Equipo).

dificultadDeUnSuenio(futbolista(Equipo), 16) :-
    not(esEquipoChico(Equipo)).

esEquipoChico(Equipo) :-
    equipo(chico(Equipo)).

/* Punto 3
Queremos saber si un personaje tiene química con una persona. Esto se da
si la persona cree en el personaje y...
para Campanita, la persona debe tener al menos un sueño de dificultad menor a 5.
para el resto, 
todos los sueños deben ser puros (ser futbolista o cantante de menos de 200.000 discos)
y la persona no debe ser ambiciosa
*/

tieneQuimica(UnPersonaje, UnaPersona) :-
    persona(UnaPersona, UnPersonaje),
    elPersonajeTieneQuimica(UnPersonaje, UnaPersona).

elPersonajeTieneQuimica(campanita, UnaPersona) :-
    dificultadesDeCadaSuenio(UnaPersona, Dificultad),
    Dificultad < 5.
    
elPersonajeTieneQuimica(UnPersonaje, UnaPersona) :-
    personaje(UnPersonaje),
    not(esCampanita(UnPersonaje)),
    todosLosSueniosSonPuros(UnaPersona),
    not(esAmbiciosa(UnaPersona)).

esCampanita(campanita).

todosLosSueniosSonPuros(UnaPersona) :-
    forall(suenio(UnaPersona, UnSuenio), esPuro(UnSuenio)).
    
suenio(UnaPersona, UnSuenio) :-
    suenios(UnaPersona, UnosSuenios),
    member(UnSuenio, UnosSuenios).

esPuro(futbolista(_)).

esPuro(cantante(CantidadDiscos)) :-
    CantidadDiscos < 200000.
