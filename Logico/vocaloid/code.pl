
% vocaloid(nombreVocaloid, cancion).
vocaloid(megurineLuka, [nightFever1, foreverYoung1]).
vocaloid(hatsuneMiku, [tellYourWorld1]).
vocaloid(gumi, [foreverYoung2, tellYourWorld2]).
vocaloid(seeU, [novemberRain, nightFever2]).

cancion(nightFever1, 2).
cancion(foreverYoung1, 6).
% 4 y 5
cancion(tellYourWorld1, 4).

cancion(foreverYoung2, 4).
cancion(tellYourWorld2, 5).

cancion(novemberRain, 6).
cancion(nightFever2, 5).

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