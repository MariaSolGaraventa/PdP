% plato(restaurante, plato, precio)
plato(laAngioplastia, mila, 180).
plato(laAngioplastia, bife, 230).
plato(laAngioplastia, molleja, 220).
plato(lasVioletas, bife, 450).
plato(elCuartito, muzza, 290).

bodegon(Restaurante):-
   not((plato(Restaurante, _,Precio),
        Precio >= 300)).

bodegon(Restaurante):-
   tieneMila(Restaurante).

tieneMila(Restaurante):-
   findall(Plato, plato(Restaurante,Plato,_), Platos),
   member(mila,Platos).

% Punto 1
/*
V o F y justificar
a. F. Podríamos usar el not de tal forma que su tabla de verdad sea igual a la del forall.
b. F. No es inversible ya que no entran al not las variables ligadas. not es un predicado de orden superior que tiene problemas de inversibilidad; las variables que entran sin ligar al not, salen sin ligar. Para lograr que sea inversible, antes del not deberíamos limitar el universo.

V x : p(x) => q(x) = ~ [ E x : p(x) => ~ q(x) ]
*/

% Punto 2
/*
En ninguno de los dos términos la solución es muy buena.
Expresividad: los terminos "mila", "muzza", "tieneMila", "bodegon" no son del todo expresivos. Hay mejores nombres, como escribir la palabra completa o revelar un poco más de información acerca del predicado en su nombre.
Como punto bueno, no hay variables sin usar (se usó un _ dentro de la primera cláusula de bodegón o en tieneMila), lo cual nos ayuda a entender mucho mejor el código (intention revealing).
Declaratividad: El not de la primera cláusula de bodegón es malo declarativamente, ya que poner dos predicados en un sólo not da lugar a interpretaciones o incorrectas o inseguras.

*/

% Punto 3

% plato(restaurante, plato, precio)
plato(laAngioplastia, milanesa, 180).
plato(laAngioplastia, bife, 230).
plato(laAngioplastia, molleja, 220).
plato(lasVioletas, bife, 450).
plato(elCuartito, muzzarella, 290).

esBodegon(UnRestaurante):-
    plato(UnRestaurante, milanesa, _),
    forall(plato(UnRestaurante, _, PrecioDelPlato), elPlatoSaleMenosDe(PrecioDelPlato, 300)).

elPlatoSaleMenosDe(UnPrecio, UnPrecioMaximo) :-
    UnPrecio < UnPrecioMaximo.
    
