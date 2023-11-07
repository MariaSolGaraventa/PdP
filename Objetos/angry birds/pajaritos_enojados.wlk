// https://docs.google.com/document/d/1VWjnxw1aOuve_oRyB55AU5LK3XDvln2uKEq_HnL3710/edit

// 4) habría que crear un metodo que añada pajaros al set de habitantes de la isla, nada más. el polimorfismo es el principal ayudante, además de la herencia de clases.
/*
------------------------------------------------------------------------------------
------------------------------------- PAJARO.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Pajaro {
    var property ira

    method obtenerFuerza()

    method enojarse() {
        self.ira(*2)
    }

    method soyFuerte() {
        return self.obtenerFuerza() > 50
    }

    method puedoDerribar(unObstaculo) {
        return self.obtenerFuerza() > unObstaculo.resistencia()
    }

    method serLanzado() {
        if(self.puedoDerribar(unObstaculo)) {
           unObstaculo.derribarse() 
        }
    }
}

class Comun inherits Pajaro {

    override method obtenerFuerza() {
        return self.ira() * 2
    }
}

class Bomb inherits Pajaro {
    var property topeFuerza = 9000

    override method obtenerFuerza() {
        if(self.estoyDentroDelLimite()) {
            return self.iraPor(2)
        }
    }

        method iraPor(unNumero) {
            return self.ira() * unNumero
        }
        
        method estoyDentroDelLimite() {
            return self.iraPor(2) =< self.topeFuerza()
        }
}

class Chuck inherits Pajaro {
    var property velocidad

    override method obtenerFuerza() {
        if(self.velocidad() =< 80) {
            return 150
        }else{
            return 150 + 5 * (self.velocidad() - 80)
        }
    }

    override method enojarse()  {
        self.velocidad(*2)
    }
}

class Matilda inherits Pajaro {
    const property huevos = []

    override method obtenerFuerza() {
        return self.ira() * 2 + self.huevos().sum { huevo => huevo.pesoKg() }
    }

    override method enojarse() {
        self.huevos().add(new Huevo(pesoKg = 2))
    }
}

class Terence inherits Pajaro {
    var cantidadEnojadas = 0
    var property multiplicador 

    override method obtenerFuerza() {
        return self.ira() * cantidadEnojadas * self.multiplicador()
    }

    override method enojarse() {
        cantidadEnojadas += 1
        super()
    }
}

class Red inherits Terence(multiplicador = 10){

}

/*
------------------------------------------------------------------------------------
------------------------------------- ISLAS.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Isla {
    const property habitantes = #{}
    const property eventos = []

    method pajarosFuertes() {
        return self.habitantes().filter { pajaro => pajaro.soyFuerte() }
    }

    method fuerzaDeLaIsla() {
        return self.pajarosFuertes.sum { pajaro => pajaro.obtenerFuerza() }
    }

    method sucederUnEvento() {
        self.eventos().anyOne().suceder(self.habitantes())
    }

    method atacarA(otraIsla) {
        self.habitantes().forEach { pajaro => pajaro.serLanzado() }
    }

    method recuperamosLosHuevosContra(otraIsla) {
        return otraIsla.obstaculos().size() == 0
    }
}

class IslaCerdito {
    const property obstaculos = []
}

/*
------------------------------------------------------------------------------------
------------------------------------- OBSTACULOS.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Pared {
    const property material
    const property ancho

    method resistencia() {
        return ancho * material.resistencia()
    }
}

object vidrio {
    const property resistencia = 10
}

object madera {
    const property resistencia = 25
}

object piedra {
    const property resistencia = 50
}

class Cerdito {
    const property rol

    method resistencia() {
        return rol.resistencia()
    }
}

object obrero {
    const property resistencia = 50
}

object armados {
    const property resistenciaAdicional

    method resistencia() {
        return 10 * self.resistenciaAdicional()
    }
}

/*
------------------------------------------------------------------------------------
------------------------------------- EVENTOS.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

object sesionDeManejoDeIra {

    method suceder(unosPajaros) {
        self.sesionDeManejoDeIra(unosPajaros)
    }

    method sesionDeManejoDeIra(unosPajaros) {
        pajaros.filter { pajaro => pajaro != chuck }.forEach { pajaro => pajaro.ira() -= 5 }
    }
}

class InvasionDeCerditos {
    const property cantidadCerditosInvasores

    method suceder(unosPajaros) {
        self.invasionDeCerditos(unosPajaros)
    }

    method invasionDeCerditos(unosPajaros) {
        const cantidad = (cantidadCerditosInvasores / 100).truncate(0)
        cantidad.times { i => unosPajaros.forEach { pajaro => pajaro.enojarse() } }
    }
}

class FiestaSorpresa {
        
    method suceder(unosPajaros) {
        self.fiestaSorpresa(unosPajaros)
    }

    method fiestaSorpresa(unosPajaros) {
        unosPajaros.forEach { pajaro => pajaro.enojarse() }
    }

}

class SerieDesafortunada {
    const property eventosComponentes = []

    method suceder(unosPajaros) {
        self.serieDesafortunada(unosPajaros)
    }

    method serieDesafortunada(unosPajaros) {
        self.eventosComponentes().forEach{ evento => evento.suceder(unosPajaros) }
    }
}

/*
------------------------------------------------------------------------------------
------------------------------------- HUEVO.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Huevo {
    const property pesoKg
}