
-- Punto 1
data Paquete = UnPaquete {
    direccionOrigen :: String,
    direccionDestino :: Destino,
    contenido :: Contenido
}

type Firewall = [Regla]
type Regla = (Paquete -> Bool)
type Destino = String
type Contenido = String
type ListaNegra = [String]

paqueteInterno :: Regla
paqueteInterno = (==) "192.168" . take 7 . direccionOrigen

paqueteConDestinoPermitido :: Destino -> Regla
paqueteConDestinoPermitido unDestinoProhibido = (/=) unDestinoProhibido . direccionDestino

incluyePalabra :: String -> String -> Bool

paqueteSinContenidoDeLaListaNegra :: ListaNegra -> Regla
paqueteSinContenidoDeLaListaNegra unaLista = not . contieneUnaDeEstasPalabras unaLista . contenido

contieneUnaDeEstasPalabras :: ListaNegra -> Contenido -> Bool
contieneUnaDeEstasPalabras unaLista unContenido = any (flip incluyePalabra unContenido) unaLista

-- Punto 2
firewall :: Firewall
firewall = [paqueteInterno, paqueteConDestinoPermitido "192.168.369", paqueteSinContenidoDeLaListaNegra ["virus", "avast"]]

-- Punto 3

estosPasanElFirewall :: [Paquete] -> Firewall -> [Paquete]
estosPasanElFirewall unosPaquetes reglasDelFirewall = filter (pasanElFirewall reglasDelFirewall) unosPaquetes

pasanElFirewall :: Firewall -> Paquete -> Bool
pasanElFirewall reglasDelFirewall unPaquete = all ($ unPaquete) reglasDelFirewall

-- Punto 4
{-
Composición: paqueteInterno, paqueteConDestinoPermitido, paqueteSinContenidoDeLaListaNegra. Ayuda al manejo de las funciones y a ser más expresivo.
Aplicación parcial: Ídem. Las tres funciones están a la espera de su último parámetro, el paquete.
Orden Superior: contieneUnaDeEstasPalabras. El uso de any, una función que recibe a otra función por parámetro.
-}