/*
Parte A
La fábrica de muebles Armando requiere de su manejo de stock de los productos que realiza en sus distintos locales. Manejan los siguientes productos:
Sillones: que tiene un tipo (común, cama, reclinable) y cantidad de módulos
Mesas: forma (rectangular, cuadrada, circular) y material (madera, vidrio)
Sillas: material (metal, madera)


Saber si una sucursal trabaja un determinado material. Trabaja el mismo si alguno de sus artículos son de ese material, y se sabe que todos los sillones que trabajan son de madera. ¿Qué concepto resalta en la resolución de este punto y dónde puede verse?
Saber si hay una sucursal ideal para un cliente, del cual se conoce su nombre y la información que se agregó en los puntos anteriores. Una sucursal es ideal si tiene en stock todo lo que el cliente busca. ¿Qué concepto aparece que no estaba siendo usado antes?

*/

%stock(sucursal, producto, cantidad)
stock(boedo, sillon(comun, 3), 4).
stock(boedo, silla(madera), 12).
stock(flores, sillon(cama, 2), 1).
stock(flores, silla(metal), 4).
stock(belgrano, sillon(reclinable, 2), 3).
stock(belgrano, silla(madera), 8).

% 1) Sabiendo que tenemos los siguientes clientes: 
% Mati, que busca una mesa circular de vidrio y 4 sillas de metal. 
% Leo, que busca un sillón cama de 2 módulos y otro reclinable de 1. 
% Agregar la información a la base de conocimientos, sabiendo que se debe poder responder la consulta “¿Qué busca Leo?” (por ejemplo). ¿Hace falta usar listas para representar la información? Si es posible, hacerlo sin usar listas y explicar los conceptos que lo permiten, y en caso contrario hacerlo con listas y explicar por qué son necesarias.

% Podemos no usar listas gracias al algoritmo de backtracking ("búsqueda hacia atrás") y múltiples respuestas que nos ofrece Prolog.

cliente(mati, mesa(circular, vidrio), 1).
cliente(mati, silla(metal), 4).
cliente(leo, sillon(cama, 2), 1).
cliente(leo, sillon(reclinable, 1), 1).

% 2) Saber si una sucursal trabaja un determinado material. Trabaja el mismo si alguno de sus artículos son de ese material, y se sabe que todos los sillones que trabajan son de madera. ¿Qué concepto resalta en la resolución de este punto y dónde puede verse?

% El Principio de Universo Cerrado, ya que sólo se tomará como que "una sucursal trabaja ese material" si es que está en la base de conocimiento. Además podemos ver el polimorfismo entre sillon(_,_), silla(_) y mesa(_,_). Los functores nos permiten tratar a estas tres estructuras indistintamente (o sea, polimórifcamente).

trabaja(UnMaterial, UnaSucursal) :-
    stock(UnaSucursal, silla(UnMaterial), _).

trabaja(UnMaterial, UnaSucursal) :-
    stock(UnaSucursal, mesa(UnMaterial), _).

trabaja(madera, UnaSucursal) :-
    stock(UnaSucursal, sillon(_), _).

% 3) Saber si hay una sucursal ideal para un cliente, del cual se conoce su nombre y la información que se agregó en los puntos anteriores. Una sucursal es ideal si tiene en stock todo lo que el cliente busca. ¿Qué concepto aparece que no estaba siendo usado antes?

% Se utiliza el concepto de predicado de orden superior (forall), que trae consigo problemas de inversibilidad. Estos problemas surgen a la hora de realizar consultas variables, y pueden ser solucionados limitando el universo para que la liga se limite a lo que esta en nuestra base de conocimiento.

sucursalIdeal(UnaSucursal, UnCliente) :-
    stock(UnaSucursal, _, _),
    cliente(UnCliente, _, _),
    forall(cliente(UnCliente, Busqueda, CantidadBuscada), laSucursalLoTiene(UnaSucursal, Busqueda, CantidadBuscada)).
    
laSucursalLoTiene(UnaSucursal, Busqueda, CantidadBuscada) :-
    stock(UnaSucursal, Busqueda, CantidadEnStock),
    CantidadEnStock >= CantidadBuscada.