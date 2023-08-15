% https://docs.google.com/document/d/1RNgFMlSqOKiwe9SEi1U2cQjCmdFfWNflqycSfp7Qa-w/edit#heading=h.8z5fk89ui0rg

% ----------- BASE DE CONOCIMIENTO
turno(dodain, lunes, horario(9, 15)).
turno(dodain, miercoles, horario(9, 15)).
turno(dodain, viernes, horario(9, 15)).
turno(lucas, martes, horario(10, 20)).
turno(juanC, sabado, horario(18, 22)).
turno(juanC, domingo, horario(18, 22)).
turno(juanFdS, jueves, horario(10, 20)).
turno(juanFdS, viernes, horario(12, 20)).
turno(leoC, lunes, horario(14, 18)).
turno(leoC, miercoles, horario(14, 18)).
turno(martu, miercoles, horario(23, 24)).
% ----------- 1
turno(vale, lunes, horario(9, 15)).
turno(vale, miercoles, horario(9, 15)).
turno(vale, viernes, horario(9, 15)).
turno(vale, sabado, horario(18, 22)).
turno(vale, domingo, horario(18, 22)).

responsable(dodain).
responsable(lucas).
responsable(juanC).
responsable(juanFdS).
responsable(martu).
responsable(vale).

% El ítem del medio no se escribe por el principio de universo cerrado, que implica que todo lo que está en nuestra base de conocimiento es verdadero.
% Esto nos lleva al tercer ítem, que no es algo cierto o seguro, por lo que hasta que no lo sea, no se incluye en la base de conocimiento.

% ----------- 2
atiendeEnElHorario(Persona, Dia, Hora) :-
    responsable(Persona),
    turno(Persona, Dia, horario(Inicio, Final)),
    Hora =< Final,
    Hora >= Inicio.

% ----------- 3
foreverAlone(Persona, Dia, Hora) :-
    atiendeEnElHorario(Persona, Dia, Hora),
    responsable(OtraPersona),
    not(atiendeEnElHorario(OtraPersona, Dia, Hora)),
    Persona \= OtraPersona.                     %REVISAR ultimo caso

% ----------- 4
diasDeAtencion(Dia, Persona) :-
    turno(Persona, Dia, horario(_, _)).
% Backtracking

% ----------- 5
/*
venta(golosina, Dinero).
venta(cigarrillos, Marca).
venta(bebida, Tipo, Cantidad).
*/
ventas(dodain, momento(lunes, 10), [venta(golosinas, 1200), venta(cigarrillos, jockey), venta(golosinas, 50)]).
ventas(dodain, momento(miercoles, 12), [venta(bebida, alcoholica, 8), venta(bebida, noAlcoholica, 1), venta(golosinas, 10)]).
ventas(martu, momento(miercoles, 12), [venta(golosinas, 1000), venta(cigarrillos, chesterfield), venta(cigarrillos, colorado), venta(cigarrillos, parisiennes)]).
ventas(lucas, momento(martes, 11), [venta(golosinas, 600)]).
ventas(lucas, momento(martes, 18), [venta(bebida, noAlcoholica, 2), venta(cigarrillos, derby)]).

esSuertuda(Persona) :-
    turno(Persona, Dia, _),
    forall(ventas(Persona, momento(Dia, _), Ventas), nth1(1, Ventas, Venta)),
    laPrimeraVentaCumple(Persona, Ventas).

laPrimeraVentaCumple(Persona, venta(golosina, _)) :-
    ventas(Persona, _, venta(golosina, Importe)),
    Importe > 100.

/*
laPrimeraVentaCumple(Persona, venta(cigarrilos, Marca)) :-
    ventas(Persona, _, venta(cigarrillos, Marca)),
*/

laPrimeraVentaCumple(Persona, venta(bebida, _, _)) :-
    ventas(Persona, _, venta(bebida, alcoholica, _)).

    laPrimeraVentaCumple(Persona, venta(bebida, _, _)) :-
        ventas(Persona, _, venta(bebida, noAlcoholica, Cantidad)),
        Cantidad > 5.


