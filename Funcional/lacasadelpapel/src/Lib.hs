-- https://www.utnianos.com.ar/foro/attachment.php?aid=20202



data Ladron = Ladron {
    nombreLadron :: String,
    habilidades  :: [Habilidad],
    armas        :: [Arma]
}

data Rehen = Rehen {
   nombreRehen  :: String,
   nivelComplot :: Int,
   nivelMiedo   :: Int,
   plan         :: [Actividad]

}
type Habilidad = String

type Arma = Rehen -> Rehen

type Actividad = String

-----------------------------
------------- 1 -------------
-----------------------------

tokio :: Ladron 
tokio = Ladron "Tokio" [ "trabajo psicologico", "entrar en moto"] [pistola 9, pistola 9, ametralladora 30]

profesor :: Ladron
profesor = Ladron "Profesor" ["disfrazarse de linyera", "disfrazarse de payaso", "estar siempre un paso adelante"] []

pablo :: Rehen
pablo = Rehen "Pablo " 40 30 ["esconderse"]


cata :: Ladron
cata = Ladron "Cata" ["robar entradas para taylor", "lanzar piedras magicas en los parciales"] [pistola 9, pistola 10, ametralladora 54]

arturito :: Rehen
arturito = Rehen "Arturito" 70 50 ["esconderse", "atacar a pablo"]


{-
Pistola: reduce el nivel de complot de un rehén en 5 veces su calibre, y aumenta su miedo en 3 por
la cantidad de letras de su nombre
● Ametralladora: siempre reduce el nivel de complot a la mitad, y aumenta su miedo en la cantidad
de balas que le quedan.
-}
type Calibre = Int
type Balas = Int

pistola ::  Calibre -> Arma
pistola  calibre rehen = modificarMiedo (+ 3 * length (nombreRehen rehen)) . modificarComplot (reducirComplotEn5 calibre) $ rehen


reducirComplotEn5 :: Int -> (Int -> Int) 
reducirComplotEn5 calibre =  (*(calibre * 0.20))


ametralladora :: Balas -> Arma
ametralladora balas = modificarMiedo (+ balas) . modificarComplot (/2)

modificarComplot :: Modificacion -> Rehen -> Rehen
modificarComplot funcion rehen = rehen { nivelComplot = funcion (nivelComplot rehen) }

type Modificacion = (Int -> Int)
    
modificarMiedo :: Modificacion -> Rehen -> Rehen
modificarMiedo funcion rehen = rehen { nivelMiedo = funcion (nivelMiedo rehen) }


{-● Disparos: disparar al techo como medida disuasiva. Se usa el arma que le genera más miedo al
rehén intimidado.-}

---------------------
------Punto 2--------
---------------------

{-Saber si un ladrón es inteligente. Ocurre cuando tiene más de dos habilidades. El Profesor es la
mente maestra, por lo que indudablemente es inteligente. -}



esInteligente :: Ladron -> Bool
esInteligente profesor = True
esInteligente ladron   = (> 2) . length . habilidades $ ladron 


---------------------
------Punto 3--------
---------------------

{-Que un ladrón consiga un arma nueva, y se la agregue a las que ya tiene-}


conseguirArma :: Arma -> Ladron -> Ladron
conseguirArma arma ladron  = modificarArmas (arma :) $ ladron

modificarArmas :: ([Arma] -> [Arma]) -> Ladron -> Ladron
modificarArmas funcion ladron = ladron { armas = funcion (armas ladron) }


---------------------
------Punto 4--------
---------------------


{-Que un ladrón intimide a un rehén, usando alguno de los métodos planeados.
-}


{-Disparos: disparar al techo como medida disuasiva. Se usa el arma que le genera más miedo al
rehén intimidado.
● Hacerse el malo:
○ Cuando el que se hace el malo es Berlín, aumenta el miedo del rehén tanto como la cantidad de
letras que sumen sus habilidades.
○ Cuando Río intenta hacerse el malo, le sale mal y en cambio aumenta el nivel de complot del
rehén en 20.
○ En otros casos, el miedo del rehén sube en 10.
-}


