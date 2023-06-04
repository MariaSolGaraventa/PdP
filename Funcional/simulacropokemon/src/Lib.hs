-- https://docs.google.com/document/d/1S11v1MyZRHAOiYuBlFfBE0oqetg0nn0zLx6R98Ei6YM/edit#

data Investigador = unInvestigador {
    nombre :: String,
    experiencia :: Int,
    rango :: Rango,
    companero :: Pokemon,
    mochila :: [Item],
    pokemon :: [Pokemon]
}

data Rango = Cielo | Estrella | Constelacion | Galaxia

data Pokemon = unPokemon {
    mote :: String,
    descripcion :: String,
    nivel :: Int,
    experienciaOtorga :: Int,
   -- variante :: Variante
}

--data Variante = Alfa | NoAlfa

data Item = Baya | Apricorn | Guijarro | FragmentoDeHierro {cantidadDeFragmentos :: Int}


-- 1) modelar a akari

akari :: Investigador {
    nombre = "Akari",
    experiencia = 1499,
    rango = Constelacion,
    companero = oshawott,
    mochila = [],
    pokemon = [oshawott]
}

oshawott :: Pokemon {
    mote = "Oshawott", 
    descripcion = "Una nutria que pelea con el caparazón de su pecho", 
    nivel = 5, 
    experienciaOtorga = 3, 
  --  variante = NoAlfa
}

-- 2) saber rango

saberRango :: Investigador -> Rango 
saberRango unInvestigador = rango unInvestigador

-- 3) modelar actividades

obtenerUnItem :: Investigador -> Item -> Investigador
obtenerUnItem unInvestigador unItem = cambiar mochila (unItem :) . cambiarExperiencia unItem $ unInvestigador 

type Item = Int -> Int

baya :: Item
baya = (^2) . (+1)

apricorn :: Item
apricorn = (* 1.5)

guijarro :: Item
guijarro = (* 2)

fragmentoDeHierro :: Int -> Item
fragmentoDeHierro cantidadDeFragmentos = (/ cantidadDeFragmentos)


{-obtenerUnItem :: Investigador -> Item -> Investigador
obtenerUnItem unInvestigador unItem = cambiar mochila (unItem :) . aplicarModificador unItem $ unInvestigador 

aplicarModificador :: Item -> Investigador -> Investigador
aplicarModificador unItem unInvestigador
    | unItem == Baya = cambiarExperiencia ((^2) . (+1)) unInvestigador
    | unItem == Apricorn = cambiarExperiencia (* 1.5) unInvestigador
    | unItem == Guijarro = cambiarExperiencia (* 2) unInvestigador
    | unItem == FragmentoDeHierro = cambiarExperiencia (/ cantidadDeFragmentos) unInvestigador-}

admirarElPaisaje :: Investigador -> Investigador
admirarElPaisaje unInvestigador = cambiarExperiencia (* 0.05) . cambiarMochila (drop 3) $ unInvestigador 

--pierdeExperiencia :: Int -> Int -> Int
--pierdeExperiencia porcentaje experienciaPrevia = experienciaPrevia - (experienciaPrevia * porcentaje)

capturarUnPokemon :: Investigador -> Investigador
capturarUnPokemon unInvestigador unPokemon = (sumarExperiencia (experienciaOtorga unPokemon) . nuevoCompanero unPokemon . agregarPokemon unPokemon) unInvestigador

sumarExperiencia :: Pokemon -> Investigador -> Investigador
sumarExperiencia unPokemon unInvestigador = cambiarExperiencia (+ (experienciaQueOtorgaPokemon unPokemon)) unInvestigador

experienciaQueOtorgaPokemon :: Pokemon -> Int
experienciaQueOtorgaPokemon unPokemon
    | esAlfa unPokemon = (*2) . experienciaOtorga $ unPokemon
    | otherwise = experienciaOtorga unPokemon

nuevoCompanero :: Pokemon -> Investigador -> Investigador
nuevoCompanero unPokemon unInvestigador 
    | otorgaMasDe20Experiencia unPokemon = actualizarCompanero unPokemon unInvestigador
    | otherwise = unInvestigador

otorgaMasDe20Experiencia :: Pokemon -> Bool
otorgaMasDe20Experiencia unPokemon = experienciaOtorga unPokemon > 20

actualizarCompanero :: Pokemon -> Investigador -> Investigador
actualizarCompanero unPokemon unInvestigador = unInvestigador { companero = unPokemon }

combatirUnPokemon :: Investigador -> Investigador
combatirUnPokemon unInvestigador unPokemon 
    | ganaInvestigador unInvestigador unPokemon = cambiarExperiencia (sumarExperiencia ((/2) . experienciaOtorga $ unPokemon) . experiencia) unInvestigador
    | otherwise = unInvestigador

ganaInvestigador :: Investigador -> Pokemon -> Bool
ganaInvestigador unInvestigador unPokemon = nivel . companero $ unInvestigador > nivel unPokemon

---------
cambiarMochila :: ([Item] -> [Item]) -> Investigador -> Investigador
cambiarMochila funcion unInvestigador = unInvestigador { mochila = funcion (mochila unInvestigador) }

cambiarExperiencia :: (Int -> Int) -> Investigador -> Investigador
cambiarExperiencia funcion unInvestigador = unInvestigador { experiencia = funcion (experiencia unInvestigador) }

agregarPokemon :: Pokemon -> Investigador -> Investigador
agregarPokemon unPokemon unInvestigador = unInvestigador { pokemon = unPokemon : (pokemon unInvestigador) }

-- punto 4

realizarUnaExpedicion :: [Investigador] -> [Actividad] -> [Investigador]
realizarUnaExpedicion unosInvestigadores unasFunciones = map . foldr $ unosInvestigadores unasFunciones 

type Actividad = (a -> b)

masDe3Alfas :: [Investigador] -> [Investigador]
masDe3Alfas unosInvestigadores = mapFilterInvestigadores nombre ((cantidadAlfas unInvestigador) > 3) unosInvestigadores

cantidadAlfas :: [Pokemon] -> Int
cantidadAlfas unosPokemones = length (estosSonAlfas unosPokemones)

estosSonAlfas :: Investigador -> [Pokemon]
estosSonAlfas unInvestigador 
    | map esAlfa (pokemon unInvestigador) = (pokemon unInvestigador) : losQueSonAlfas
    | otherwise = estosSonAlfas unInvestigador

losQueSonAlfas :: [Pokemon]

--esAlfa :: Pokemon -> Bool
--esAlfa unPokemon = variante (pokemon unInvestigador) == Alfa


esAlfa :: Pokemon -> Bool
esAlfa unPokemon = empiezaConAlfa (mote unPokemon) || tieneTodasLasVocales (mote unPokemon)

empiezaConAlfa :: String -> Bool
empiezaConAlfa unMote = take 4 unMote == "Alfa"

tieneTodasLasVocales :: String -> Bool
tieneTodasLasVocales unMote = (all (flip elem vocales) . filter (flip elem vocales)) unMote

vocales = [a,e,i,o,u]


rangoGalaxia :: [Investigador] -> [Investigador] 
rangoGalaxia unosInvestigadores = mapFilterInvestigadores (rango unInvestigador == Galaxia) unosInvestigadores

companeroNivel10 :: [Investigador] -> [Investigador] 
rangoGalaxia unosInvestigadores = mapFilterInvestigadores ((nivel pokemon) unInvestigador == Galaxia) unosInvestigadores

ultimos3PokemonesPar :: [Investigador] -> [Investigador] 
ultimos3PokemonesPar unosInvestigadores = mapFilterInvestigadores (((mod 2) . nivel . (take 3) . reverse $ (pokemon unInvestigador)) == 0) unosInvestigadores

mapFilterInvestigadores :: (a -> b) -> (c -> d) -> [Investigador] -> [Investigador]
mapFilterInvestigadores funcionDelMap funcionDelFilter unosInvestigadores = map funcionDelMap (filter funcionDelFilter) unosInvestigadores


{-
Punto 5: De los reportes del punto anterior: ¿Cuáles podrían realizarse si uno de los investigadores tuviese infinitos Pokemons? ¿Por qué?

El de los alfas (masDe3Alfas) y el de los ultimos 3 pokemones (ultimos3PokemonesPar) no. Nunca terminarian. masDe3Alfas podría terminar en el caso de que no 
necesitara pedir la cantidad total de alfas de la lista, si con encontrar 3 se conformaría sí podría llegar a terminar (pero no es seguro).

El del rango Galaxia (rangoGalaxia) y compañero nivel 10 (companeroNivel10) sí, no tocarían la lista de pokemones así que podrían realizarse.
-}