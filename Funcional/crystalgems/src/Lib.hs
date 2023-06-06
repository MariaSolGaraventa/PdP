-- https://docs.google.com/document/d/1BepktcQsT2GVsduUq8ldi6JXZ4u3A9cjyc-cxZcdQBE/edit#

data Aspecto = UnAspecto {
  tipoDeAspecto :: String,
  grado :: Float
} deriving (Show, Eq)

type Situacion = [Aspecto]

mejorAspecto mejor peor = grado mejor < grado peor

mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2

buscarAspecto aspectoBuscado = head.filter (mismoAspecto aspectoBuscado)

buscarAspectoDeTipo tipo = buscarAspecto (UnAspecto tipo 0)

reemplazarAspecto aspectoBuscado situacion =
    aspectoBuscado : (filter (not.mismoAspecto aspectoBuscado) situacion)

tension :: Aspecto
tension = UnAspecto "Tension" 0

incertidumbre :: Aspecto
incertidumbre = UnAspecto "Incertidumbre" 0

peligro :: Aspecto
peligro = UnAspecto "Peligro" 0

-- punto 1

modificarAspecto :: (Float -> Float) -> Aspecto -> Aspecto
modificarAspecto unaFuncion unAspecto = unAspecto { grado = unaFuncion (grado unAspecto) }

esMejorSituacion :: Situacion -> Situacion -> [Bool]
esMejorSituacion unaSituacion otraSituacion = repeat (length unaSituacion) (map mejorAspecto (head unaSituacion) . filter (mismoAspecto (take 1 unaSituacion)) $ otraSituacion)
-- esMejorSituacion unaSituacion otraSituacion = map mejorAspecto unaSituacion otraSituacion

modificarSituacion :: (Float -> Float) -> Situacion -> Situacion
modificarSituacion unaFuncion unaSituacion unTipo = map unaFuncion . filter (tipoDeAspecto unAspecto == buscarAspecto unTipo) $ unaSituacion

-- punto 2

data Gemas = UnaGema {
    nombre :: String,
    fuerza :: Int,
    personalidad :: Personalidad
}

type Personalidad = (Situacion -> Situacion)

vidente :: Personalidad
vidente unaSituacion = (modificarAspecto (-10.0) (buscarAspecto tension) . modificarAspecto (flip div 2) (buscarAspecto incertidumbre)) unaSituacion