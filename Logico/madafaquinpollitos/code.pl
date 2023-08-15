% https://docs.google.com/document/d/1niZqhTo8FbUCzS1CMhniw_WCNLWRQ9nuOZg_Fl7Qt00/edit

% animal(nombre, gallina(peso, cantidadHuevos)).
% animal(nombre, gallo(profesion)).
animal(ginger, gallina(10, 5)).
animal(babs, gallina(15, 2)).
animal(bunty, gallina(23, 6)).
animal(mac, gallina(8, 7)).
animal(turuleca, gallina(15, 1)).
animal(rocky, gallo(animalDeCirco)).
animal(fowler, gallo(piloto)).
animal(oro, gallo(arrocero)).
animal(nick, rata).
animal(fetcher, rata).

%granja(nombre, [animalesQueViven]).
granja(tweedys, [ginger, babs, bunty, mac, fowler]).
granja(delSol, [turuleca, oro, nick, fetcher]).

%----------- 1
puedeCederle(Gallina, OtraGallina) :-
    animal(Gallina, gallina(_, 7)),
    animal(OtraGallina, gallina(_, Cantidad)),
    Cantidad < 3.

%----------- 2
animalLibre(Animal) :-
    animal(Animal, _),
    not(viveEnUnaGranja(Animal)).

viveEnUnaGranja(Animal) :-
    granja(_, Lista),
    member(Animal, Lista).

%----------- 3
valoracionDeGranja(Granja, Valoracion) :-
    granja(Granja, Animales), 
    findall(Valoracion, (member(Animal, Animales), cuantoSuma(Animal, Valoracion)), Valoraciones),
    sumlist(Valoraciones, Valoracion).

cuantoSuma(Nombre, Valoracion) :-
    animal(Nombre, gallina(Peso, Huevos)),
    Valoracion is Peso * Huevos.

cuantoSuma(Nombre, 50) :-
    animal(Nombre, gallo(Tipo)),
    sabeVolar(Tipo).

cuantoSuma(Nombre, 25) :-
    animal(Nombre, gallo(Tipo)),
    not(sabeVolar(Tipo)).

cuantoSuma(Nombre, 0) :-
    animal(Nombre, rata).

sabeVolar(piloto).
sabeVolar(animalDeCirco).

%----------- 4
granjaDeluxe(Granja) :-
    granja(Granja, ListaDeAnimales),
    forall(member(Animal, ListaDeAnimales), not(seaRata(Animal))),
    tieneMasDe50Animales(Granja).

granjaDeluxe(Granja) :-
    granja(Granja, ListaDeAnimales),
    forall(member(Animal, ListaDeAnimales), not(seaRata(Animal))),
    valoracionDeGranja(Granja, 1000).

tieneMasDe50Animales(Granja) :-
    granja(Granja, Lista),
    length(Lista, Cantidad),
    Cantidad > 50.
    
seaRata(Animal) :-
    animal(Animal, rata).

%----------- 5
buenaPareja(UnAnimal, OtroAnimal) :-
    vivenEnLaMismaGranja(UnAnimal, OtroAnimal),
    sonDosGallinasDeCiertaCaracterista(UnAnimal, OtroAnimal).

buenaPareja(UnAnimal, OtroAnimal) :-
    vivenEnLaMismaGranja(UnAnimal, OtroAnimal),
    sonDosGallosYUnoSabeVolar(UnAnimal, OtroAnimal).

buenaPareja(UnAnimal, OtroAnimal) :-
    vivenEnLaMismaGranja(UnAnimal, OtroAnimal),
    sonDosRatas(UnAnimal, OtroAnimal).

vivenEnLaMismaGranja(Animal1, Animal2) :-
    granja(_, Lista),
    member(Animal1, Lista),
    member(Animal2, Lista),
    Animal1 \= Animal2.

sonDosGallinasDeCiertaCaracterista(UnAnimal, OtroAnimal) :-
    pesanLoMismo(UnAnimal, OtroAnimal), 
    puedeCederle(UnAnimal, OtroAnimal).

sonDosGallinasDeCiertaCaracterista(UnAnimal, OtroAnimal) :-
    pesanLoMismo(OtroAnimal, UnAnimal), 
    puedeCederle(OtroAnimal, UnAnimal).

pesanLoMismo(UnAnimal, OtroAnimal) :-
    animal(UnAnimal, gallina(Peso, _)),
    animal(OtroAnimal, gallina(Peso, _)).

sonDosGallosYUnoSabeVolar(UnAnimal, OtroAnimal) :-
    unGalloSabeVolar(UnAnimal, OtroAnimal).

sonDosGallosYUnoSabeVolar(UnAnimal, OtroAnimal) :-
    unGalloSabeVolar(OtroAnimal, UnAnimal).

unGalloSabeVolar(UnAnimal, OtroAnimal) :-
    animal(UnAnimal, gallo(Profesion)),
    sabeVolar(Profesion),
    animal(OtroAnimal, gallo(OtraProfesion)),
    not(sabeVolar(OtraProfesion)).

sonDosRatas(UnAnimal, OtroAnimal) :-
    animal(UnAnimal, rata),
    animal(OtroAnimal, rata).

%----------- 6
escapePerfecto(Granja) :-
    granja(Granja, Lista),
    forall(member(animal(_, gallina(_, Huevos)), Lista), Huevos > 5),
    forall(member(Animal, Lista), tieneAlgunaPareja(Animal, Lista)).

tieneAlgunaPareja(Animal, Lista) :-
    findall(member(OtroAnimal, Lista), buenaPareja(Animal, OtroAnimal), Candidatos),
    length(Candidatos, Cantidad),
    Cantidad >= 1,
    Animal \= OtroAnimal.