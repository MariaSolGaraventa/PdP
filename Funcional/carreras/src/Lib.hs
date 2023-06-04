-- https://docs.google.com/document/d/1g2Gc81R62_xAIiGF0H663ypAz1vxJybr5LDo1sj9tAU/edit#heading=h.ielqgky5ojzp

-- punto 1
data Auto = UnAuto {
    color :: String,
    velocidadALaQueVa :: Int,
    distancia :: Int
}

type Carrera = [Auto]

estaCerca :: Auto -> Auto -> Bool
estaCerca esteAuto deEsteAuto = abs (distancia deEsteAuto - distancia esteAuto) < 10

vaTranquilo :: Carrera -> Bool
vaTranquilo unosAutos = estaCerca (head (estadoActualDeLosAutos unosAutos)) . (flip (!!) 2) $ unosAutos

puesto :: Carrera -> Auto -> Int
puesto unosAutos unAuto = (+1) . length . takeWhile (/=color unAuto) . map color $ unosAutos

-- punto 2

corra :: Auto -> Int -> Auto
corra unAuto unTiempo = cambiarDistancia unAuto (unTiempo * (velocidadALaQueVa unAuto))

cambiarDistancia :: Auto -> Incremento -> Auto
cambiarDistancia unAuto unIncremento = unAuto { distancia = unaFuncion + (distancia unAuto) }

type Incremento = Int

data Modificador = Int -> Int

alterarLaVelocidad :: Auto -> Modificador -> Auto
alterarLaVelocidad unAuto unModificador = cambiarVelocidad unAuto unModificador

cambiarVelocidad :: Auto -> Modificador -> Auto
cambiarVelocidad unAuto unModificador = unAuto { velocidad = unModificador (velocidad unAuto) }

bajarLaVelocidad :: Auto -> Decremento -> Auto
bajarLaVelocidad unAuto unDecremento
    | alterarLaVelocidad unAuto (- unDecremento) >= 0 = alterarLaVelocidad unAuto (- unDecremento)
    | otherwise = alterarLaVelocidad unAuto (- velocidad unAuto)

type Decremento = Int


--terremoto :: PowerUp
--terremoto = (-50)

terremoto :: Auto -> Carrera -> Carrera 
terremoto unAuto unosAutos = afectarALosQueCumplen (estaCerca unAuto) (flip bajarLaVelocidad 50) unosAutos

--miguelitos :: Int -> PowerUp
--miguelitos unaCantidad =  (-unaCantidad)

miguelitos :: Int -> Auto -> Carrera -> Carrera
miguelitos unaCantidad unAuto unosAutos = afectarALosQueCumplen (leVaGanandoA unAuto) (flip bajarLaVelocidad unaCantidad) unosAutos

leVaGanandoA :: Auto -> Auto -> Bool
leVaGanandoA unAuto otroAuto = puesto unAuto > puesto otroAuto

--jetpack :: Int -> PowerUp
--jetpack unaCantidad = (/2) . corra unaCantidad . (*2)

jetpack :: Int -> Auto -> Carrera -> Carrera
jetpack unaCantidad unAuto unosAutos = afectarALosQueCumplen (tienenElMismoColor unAuto) ((/2) . corra unaCantidad . (*2)) unosAutos

tienenElMismoColor :: Auto -> Auto -> Bool
tienenElMismoColor unAuto otroAuto = color otroAuto == color unAuto

type Evento = [Carrera -> Carrera]
type Color = String

simularCarrera :: Carrera -> Evento -> [(Int, Color)]
simularCarrera unosAutos unosEventos = zip (sacarPuesto sacarColor) . unosEventos $ unosAutos

tablaDePosiciones :: Carrera -> Carrera
tablaDePosiciones unosAutos = reverse . sortOn distancia $ unosAutos

sacarPuesto :: Carrera -> Carrera
sacarPuesto unosAutos = map puesto . tablaDePosiciones $ unosAutos

sacarColor :: Carrera -> Carrera
sacarColor unosAutos = map color . tablaDePosiciones $ unosAutos

correnTodos :: Int -> Evento
correnTodos unTiempo unosAutos = map (flip corra unTiempo) unosAutos

usaPowerUp :: Criterio -> PowerUp -> Evento 
usaPowerUp criterio unModificador unosAutos = afectarALosQueCumplen criterio unModificador unosAutos

type Criterio = (a -> Bool)

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
  = (map efecto . filter criterio) lista ++ filter (not.criterio) lista}



autoRojo :: Auto {
    color = "Rojo",
    velocidadALaQueVa = 120,
    distancia = 0
}

autoBlanco :: Auto {
    color = "Blanco",
    velocidadALaQueVa = 120,
    distancia = 0
}

autoAzul :: Auto {
    color = "Azul",
    velocidadALaQueVa = 120,
    distancia = 0
}

autoNegro :: Auto {
    color = "Negro",
    velocidadALaQueVa = 120,
    distancia = 0
}

Carrera = [autoRojo, autoBlanco, autoAzul, autoNegro]

laPrimeraCarrera :: Carrera

eventosDeLaPrimeraCarrera :: [Evento]
eventosDeLaPrimeraCarrera = [correnTodos 30,
                            usaPowerUp (jetpack 3 autoAzul), --azul
                            usaPowerUp terremoto autoBlanco, --blanco
                            correnTodos 40,
                            usaPowerUp (miguelitos 20 autoBlanco) --blanco
                            usaPowerUp (jetpack 6 autoNegro) --negro
                            correnTodos 10]

{-
5

Si se quisiera agregar un nuevo power up, un misil teledirigido, que para poder activarlo se deba indicar el color del auto al que se quiere impactar, 
¿la solución actual lo permite o sería necesario cambiar algo de lo desarrollado en los puntos anteriores? Justificar.

Sí, armando una funcion 

esDelColor:: Color -> Auto -> Bool
esDelColor unColor unAuto = unColor == (color unAuto)

queda definido un nuevo criterio que coincide con el tipo Criterio (a -> Bool)

Si una carrera se conformara por infinitos autos,
¿sería posible usar las funciones del punto 1b y 1c de modo que terminen de evaluarse? Justificar.

Sí, sería posible:
1b) toma las primera 2 posiciones, gracias a la lazy evaluation, no necesita evaluar toda la lista.

1c) Del mismo modo, la busqueda en la lista frenaría cuando el color a buscar coincida, así que también podría evaluarse.
-}
