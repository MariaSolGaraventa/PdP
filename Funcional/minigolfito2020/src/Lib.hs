-- https://docs.google.com/document/d/1LeWBI6pg_7uNFN_yzS2DVuVHvD0M6PTlG1yK0lCvQVE/edit

-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

-- punto 1
putter :: Habilidad -> Tiro
putter unaHabilidad = UnTiro {
    velocidad = 10,
    precision = (precisionJugador unaHabilidad) * 2,
    altura = 0
}

madera :: Habilidad -> Tiro
madera unaHabilidad = UnTiro {
    velocidad = 100,
    precision = (precisionJugador unaHabilidad) / 2,
    altura = 5
}

hierro :: Habilidad -> Int -> Tiro
hierro unaHabilidad numero = UnTiro {
    velocidad = (fuerzaJugador unaHabilidad) * numero,
    precision = (precisionJugador unaHabilidad) / numero,
    altura = alturaDelTiro numero
}

alturaDelTiro :: Int -> Int
alturaDelTiro numero
    | numero - 3 >= 0 = numero - 3
    | otherwise = 0

--Definir una constante palos que sea una lista con todos los palos que se pueden usar en el juego.

type Palo = (Habilidad -> Tiro)

palos :: [Palo]
palos = [putter, madera, flip hierro numero]

numero :: Int

-- punto 2

golpe :: Jugador -> Palo -> Tiro
golpe unJugador unTiro = unTiro (habilidad unJugador)

-- punto 3

data Obstaculo = UnObstaculo {
    puedeSuperar :: Tiro -> Bool,
    efectoCuandoSuperado :: Tiro -> Tiro
}

tunelConRampita :: Obstaculo 
tunelConRampita unTiro = UnObstaculo superaTunelConRampita unTiro efectoTunelConRampita unTiro

superaTunelConRampita :: Obstaculo
superaTunelConRampita unTiro = verificar precision (> 90) unTiro && verificar altura (== 0) unTiro

efectoTunelConRampita :: Tiro -> Tiro
efectoTunelConRampita unTiro = cambiarVelocidad (* 2) . cambiarPrecision (hasta100 (precision unTiro)) . cambiarAltura (- altura unTiro) $ unTiro 

hasta100 :: Int -> Int
hasta100 precision 
    | precision > 100 = hasta100 . (-1) $ precision
    | precision < 100 = hasta100 . (+1) $ precision
    | otherwise = precision


laguna :: Obstaculo 
laguna unTiro = UnObstaculo superaLaguna unTiro efectoLaguna longitudLaguna unTiro

superaLaguna :: Obstaculo
superaLaguna unTiro = verificar velocidad (> 80) unTiro && verificar altura (between 1 5) unTiro

efectoLaguna :: Int -> Efecto -> Tiro -> Tiro
efectoLaguna unaLongitud funcion unTiro = cambiarAltura (/ unaLongitud) unTiro



hoyo :: Obstaculo
hoyo unTiro = UnObstaculo superaHoyo unTiro efectoHoyo unTiro

superaHoyo :: Obstaculo
superaHoyo unTiro = verificar velocidad (between 5 20) unTiro && verificar altura (== 0) unTiro && verificar precision (> 95) $ unTiro

efectoHoyo :: Efecto -> Tiro -> Tiro
efectoHoyo funcion unTiro = cambiarVelocidad (*0) . cambiarAltura (*0) . cambiarPrecision (*0) $ unTiro


verificar ::  Aspecto -> Criterio -> Tiro -> Bool
verificar unAspecto unCriterio unTiro = unCriterio . unAspecto $ unTiro

type Criterio = (a -> Bool)
type Aspecto = (Tiro -> Int)


cambiarVelocidad :: Efecto -> Tiro -> Tiro
cambiarVelocidad funcion unTiro = unTiro { velocidad = funcion (velocidad unTiro) }

cambiarPrecision :: Efecto -> Tiro -> Tiro
cambiarPrecision funcion unTiro = unTiro { precision = funcion (precision unTiro) }

cambiarAltura :: Efecto -> Tiro -> Tiro
cambiarAltura funcion unTiro = unTiro { altura = funcion (altura unTiro) }

type Efecto = (Int -> Int)


intentaSuperarElObstaculo ::
intentaSuperarElObstaculo unTiro unObstaculo
    | puedeSuperarElObstaculo unTiro unObstaculo = aplicarEfectos unTiro unObstaculo
    | otherwise = ponerTodoEn0 unTiro

puedeSuperarElObstaculo :: Tiro -> Obstaculo -> Bool
puedeSuperarlo unTiro unObstaculo = unObstaculo puedeSuperar unTiro

aplicarEfectos :: Tiro -> Obstaculo -> Tiro
aplicarEfectos unTiro unObstaculo = unObstaculo efectoCuandoSuperado unTiro

-- punto 4

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles unJugador unObstaculo = 


