subioA(prudencio, montaniaRusa(hulk)). 
subioA(prudencio, autosChocadores). 
subioA(hermenegildo, montaniaRusa(rockit)). 
subioA(hermenegildo, simulador(minions)). 
subioA(hermenegildo, autosChocadores). 
subioA(rigoberta, simulador(ikran)). 
subioA(brunilda, simulador(simpsons)).

disfruto(prudencio, montaniaRusa(hulk)). 
disfruto(prudencio, autosChocadores).
disfruto(hermenegildo, simulador(minions)).
disfruto(rigoberta, simulador(ikran)).

foo(Persona) :- 
    forall(subioA(Persona, Atraccion), disfruto(Persona, Atraccion)).

% Punto 1
/*
El objetivo es que dada una Persona, el predicado foo es verdadero si todas las atracciones a las que subió esa Persona, esa Persona disfrutó la atracción.
El predicado foo es cierto para: prudencio y rigoberta.
El nombre que yo le pondría sería: aLasQueSubioLasDisfruto(UnaPersona).
*/

% Punto 2
% foo no es inversible, no se limita el universo de Personas que podrían llegar ligadas al forall. Para que fuera inversible, quedaría:

foo(Persona) :- 
    subioA(Persona, _),
    forall(subioA(Persona, Atraccion), disfruto(Persona, Atraccion)).

% así nos aseguramos que la Persona que se ligue sea una Persona que esté en la base de conocimiento.

% Punto 3

esValiente(UnaPersona) :-
    subioA(UnaPersona, montaniaRusa(_)).