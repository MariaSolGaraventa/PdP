/*                           Las Fichas                       */
 /*                               1                        */

ficha(0, blanco).
ficha(0, negro).
ficha(1, blanco).
ficha(1, negro).
ficha(2, blanco).
ficha(2, negro).
ficha(3, blanco).
ficha(3, negro).
ficha(4, blanco).
ficha(4, negro).
ficha(5, verde(1)).
ficha(5, verde(2)).
ficha(6, blanco).
ficha(6, negro).
ficha(7, blanco).
ficha(7, negro).
ficha(8, blanco).
ficha(8, negro).
ficha(9, blanco).
ficha(9, negro).

esFichaValida(ficha(Numero, Color)) :-
    ficha(Numero, Color).

% 1c) Sí, si ponemos tanto Numero y Color como variables en la consulta, 
%     responderá con todas las fichas que existen en la base de conocimiento.


/*                           Los Jugadores                       */
 /*                                2                          */

%  ------------------------------------ a ----------------------------

jugador(jugador1,[ficha(8, negro), ficha(5, verde(1)), ficha(0, blanco), ficha(2, negro), ficha(2, blanco)]).

%  ------------------------------------ b ----------------------------

conocerSuCodigo(Jugador, Codigo) :-
    jugador(Jugador, Fichas),
    msort(Fichas, Codigo).

%  ------------------------------------ c ----------------------------

codigoValidoParaAdversario(UnJugador, CodigoAdversario) :-
    conocerSuCodigo(UnJugador, UnasFichas),
    codigoDeCincoFichas(CodigoAdversario),
    noSeRepitenFichas(UnasFichas, CodigoAdversario).


codigoDeCincoFichas([Ficha1, Ficha2, Ficha3, Ficha4, Ficha5]) :-
    esFichaValida(Ficha1),
    esFichaValida(Ficha2),
    esFichaValida(Ficha3),
    esFichaValida(Ficha4),
    esFichaValida(Ficha5).


noSeRepitenFichas(UnasFichas, OtrasFichas) :-
    intersection(UnasFichas, OtrasFichas, []),
    sort(OtrasFichas, OtrasFichas). 

%  ------------------------------------ d ----------------------------

% Sí, Prolog los especifica uno a uno, la cantidad podría ser averiguada por combinatoria.


/*                           Las Pistas                       */
 /*                                3                        */

%  ------------------------------------ a ----------------------------

sumaDeFichas(Codigo, Resultado) :-
    sumaSegun(Codigo, _, Resultado).

sumaDeUnColor(Codigo, Color, Resultado) :-
    sumaSegun(Codigo, Color, Resultado).

%  ------------------------------------  -----------------------------

sumaSegun(Codigo, Criterio, Resultado) :-
    codigoValidoParaAdversario(_, Codigo),
    findall(Numero, member(ficha(Numero, Criterio), Codigo), ListaCriterio),
    sumlist(ListaCriterio, Resultado).

%  ------------------------------------ b ----------------------------
cosultarPosicionDeUnNumero(Numero, Codigo, Posicion) :-
    consultarSegun(_, Numero, Codigo, Posicion).

%  ------------------------------------  -----------------------------

consultarPosicionDeUnColor(Color, Codigo, Posicion) :-
    consultarSegun(Color, _, Codigo, Posicion).

consultarSegun(Color, Numero, Codigo, Posicion) :-
    nth1(Posicion, Codigo, ficha(Numero, Color)).

%  ------------------------------------ c ----------------------------

posicionesConsecutivas(Codigo, PosicionesOrdenadas) :-
    findall(Posicion, consultarNumConsecutivos(Codigo, Posicion), Posiciones),
    sort(Posiciones, PosicionesOrdenadas).

consultarNumConsecutivos(Codigo, Posicion) :-
    member(ficha(Numero1, _), Codigo),
    member(ficha(Numero2, _), Codigo),
    consecutivo(Numero1, Numero2),
    consultarSegun(_, Numero1, Codigo, Posicion).

consecutivo(Numero, NumeroConsecutivo):-
   Numero is (NumeroConsecutivo + 1).

consecutivo(Numero, NumeroConsecutivo):-
   Numero is (NumeroConsecutivo - 1).

/*                                3                        */

%  ------------------------------------ d ----------------------------

%% sebas

pistasParaAdversario(sebas, [sumaFichas(19), posicionNumero(3, [2, 3]), posicionColor(negro, [1, 3, 4])]).

%% josepha

pistasParaAdversario(josepha, [sumaColor(negro, 16), posicionNumero(9, [5]), posicionColor(verde, [2]), numerosConsecutivos([3, 4, 5])]).

%% thibault

pistasParaAdversario(thibault, [sumaFichas(24), posicionNumero(5, []), sumaColor(blanco, 19), posicionColor(negro, [1, 3]), numerosConsecutivos([])]).

posicionDeFicha(Codigo, Numero, Color, Posiciones) :-
    findall(Posicion, nth1(Posicion, Codigo, ficha(Numero, Color)), Posiciones).

%  ------------------------------------ a ----------------------------

cumplePistas(Codigo, sumaFichas(Numero)) :- sumaDeFichas(Codigo, Numero).
cumplePistas(Codigo, sumaColor(Color, Numero)) :- sumaDeUnColor(Codigo, Color, Numero).
cumplePistas(Codigo, posicionNumero(Numero, Posiciones)) :- posicionDeFicha(Codigo, Numero, _, Posiciones).
cumplePistas(Codigo, posicionColor(Color, Posiciones)) :- posicionDeFicha(Codigo, _, Color, Posiciones).
cumplePistas(Codigo, numerosConsecutivos(Posiciones)) :- posicionesConsecutivas(Codigo, Posiciones).

averiguarCodigosValidos(Codigo, UnJugador, UnAdversario) :-
    codigoValidoParaAdversario(UnJugador, Codigo),
    pistasParaAdversario(UnAdversario, Pistas),
    forall(member(Pista, Pistas), cumplePistas(Codigo, Pista)),
    UnJugador \= UnAdversario.

%  ------------------------------------ b ----------------------------

hackear(UnJugador, UnAdversario, Codigo) :-
    pistasParaAdversario(UnAdversario, _),
    jugador(UnJugador,_),
    findall(CodigoPosible, averiguarCodigosValidos(CodigoPosible, UnJugador, UnAdversario), [Codigo]).

/*  averiguarCodigosValidos(UnCodigo, UnJugador, UnAdversario),
    forall(averiguarCodigosValidos(CodigoPosible, UnJugador, UnAdversario), sonIguales(UnCodigo, CodigoPosible)).

sonIguales(A, A).
*/

%  ------------------------------------ c ----------------------------

% 3c) Sí, el predicado cumplePistas tiene problemas de inversibilidad por ser polimórfico -> no responde bien a consultas total o parcialmente variables.
