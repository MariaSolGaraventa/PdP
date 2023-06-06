-- https://docs.google.com/document/d/1b-dhR_yAQui07DvZCk2vvwIkcs-d9jxM7mX203nMaz8/edit

                                        -- 1 --

data Chofer = UnChofer {
    nombreChofer :: String,
    kilometrajeAuto :: Int,
    viajes :: Viajes,
    condición :: Condicion
}

data Viaje = UnViaje {
    fecha :: Int,
    cliente :: Cliente,
    costo :: Int
}

data Cliente = UnCliente {
    nombreCliente :: String,
    lugarDondeVive :: String
}

type Condicion = (a -> Bool)

type Viajes = [Viaje]

{-cualquierViaje :: Condicion
cualquierViaje unViaje = id unViaje

viajesQueValganMasde200 :: Condicion
viajesQueValganMasde200 unViaje = (> 200) . costo $ unViaje

elNombreDelClienteTieneMasDeNLetras :: Int -> Condicion
elNombreDelClienteTieneMasDeNLetras n unCliente = (> n) . length . nombreCliente $ unCliente

queElClienteNoVivaEn :: Lugar -> Condicion
queElClienteNoVivaEn unLugar unCliente = (!= unLugar) . lugarDondeVive $ unCliente-}

type Lugar = String

                                        -- 2 --

generalizacionCondicion :: Funcion -> Condicion
generalizacionCondicion unaFuncion algoSobreLoQueAplicarlo = funcion algoSobreLoQueAplicarlo

cualquierViaje :: Condicion
cualquierViaje unViaje = True

viajesQueValganMasde200 :: Condicion
viajesQueValganMasde200 unViaje = generalizacionCondicion ((> 200) . costo) unViaje

elNombreDelClienteTieneMasDeNLetras :: Int -> Condicion
elNombreDelClienteTieneMasDeNLetras n unCliente = generalizacionCondicion ((> n) . length . nombreCliente) unCliente

queElClienteNoVivaEn :: Lugar -> Condicion
queElClienteNoVivaEn unLugar unCliente = generalizacionCondicion ((!= unLugar) . lugarDondeVive) unCliente

type Funcion = (a -> a)

                                        -- 3 --

lucas :: Cliente
lucas = UnCliente "Lucas" "Victoria"

daniel :: Chofer
daniel = UnChofer "Daniel" 23500 [UnViaje 20042017 lucas 150] (queElClienteNoVivaEn "Olivos")

alejandra :: Chofer
alejandra = UnChofer "Alejandra" 180000 [] cualquierViaje

                                        -- 4 --

esteChoferPuedeTomarElViaje :: Chofer -> Viaje -> Bool
esteChoferPuedeTomarElViaje unChofer unViaje = (condicion unChofer) unViaje

                                        -- 5 --

liquidacionDelChofer :: Chofer -> Int
liquidacionDelChofer unChofer = sum . map costo $ (costo . viajes $ unChofer)

                                        -- 6 --

realizarUnViaje :: Viaje -> [Chofer] -> Chofer
realizarUnViaje unViaje unosChoferes = (agregarViaje unViaje . choferConMenosViajes . filter (flip esteChoferPuedeTomarElViaje unViaje)) $ unosChoferes

choferConMenosViajes :: [Chofer] -> Chofer
choferConMenosViajes = (head . minimumBy (compare `on`) . map length viajes)

{-filter esteChoferPuedeTomarElViaje --> unosChoferes unViaje
me devuelve [Chofer]

head . minimumBy (compare `on`) . map length viajes --> [unChofer]
me devuelve Chofer

agregarViaje --> unViaje unChofer
me devuelve Chofer-}

agregarViaje :: Viaje -> Chofer -> Chofer
agregarViaje unViaje unChofer = UnChofer { viajes = unViaje : (viajes unChofer)}

-- 6c. Como no se pueden realizar cambios en el paradigma funcional ya que no hay efecto de lado, lo que hacemos para simular dicha modificacion es tomar un chofer y devolver uno nuevo con exactamente los mismos valores a excepcion del que se quería modificar (ese campo en el nuevo chofer será distinto al del chofer original)

                                        -- 7 --

nitoInfy :: Chofer
nitoInfy = UnChofer "Nito Infy" 70000 (repetirViaje UnViaje 11032017 lucas 50) (elNombreDelClienteTieneMasDeNLetras 3)

repetirViaje :: Viaje -> [Viaje]
repetirViaje viaje = viaje : repetirViaje viaje

{-
b. La liquidacion del chofer se calcula con la siguiente funcion:

liquidacionDelChofer :: Chofer -> Int
liquidacionDelChofer unChofer = sum . map costo $ (costo . viajes $ unChofer)

No se podrá calcular la liquidacion de Nito Infy ya que al tener infinitos viajes la funcion sum jamás terminará de sumar los costos de TODOS los viajes.

c. Si un chofer puede tomar el viaje o no se calcula con la siguiente funcion: 

esteChoferPuedeTomarElViaje :: Chofer -> Viaje -> Bool
esteChoferPuedeTomarElViaje unChofer unViaje = (condicion unChofer) unViaje

en este caso unViaje seria: UnViaje 02052017 lucas 50

Sí, podríamos evaluar si Nito Infy puede tomar dicho viaje, ya que depende de la condicion del chofer ((elNombreDelClienteTieneMasDeNLetras 3) en este caso). Que tenga viajes infinitos no modifica nada.
-}

                                        -- 8 --

gongNeng :: Ord a => a -> (a -> Bool) -> (b -> a) -> [b] -> a 
gongNeng arg1 arg2 arg3 = max arg1 . head . filter arg2 . map arg3

{-map --> funcion lista
lista
=> arg3 debe ser una funcion

filter --> condicion lista
lista
=> arg2 debe ser una condicion

head --> lista
un elemento

max --> elemento1 elemento2
un elemento
=> arg1 debe ser un elemento

el parametro esta implicito: es de tipo [b], con el map se transformará al tipo a-}
