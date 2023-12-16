 class Festival {
    const property restaurantes = #{}
      
    method elegidosDelJurado(unJurado) {
        return self.resturantes().filter{ restaurante => restaurante.esElegidoPor(unJurado) }
    }
}

class Restaurante {
    const property platos = #{}
    
    method esElegidoPor(unJurado) {
        return unJurado.votaPositivamenteA(self) 
    }

    method tieneComidaChina() {
        return self.platos().any{ plato => plato.esDeOrigenChino() }
    }
}

class Jurado {
    const property criticos = #{}
    const property festivalACriticar
    
    method elegidosDelJurado() {
        return self.festivalACriticar().elegidosDelJurado(self)
    }

    method votaPositivamenteA(unRestaurante) {
        return self.criticos().all{ critico => critico.leGusta(unRestaurante) }
    }
}

class Critico {
    const property preferencia

    method leGusta(unRestaurante) {
        return preferencia.esSatisfechaEnElRestaurante(unRestaurante)
    }
}

object origenChino {

    method esSatisfechaEnElRestaurante(unRestaurante) {
        return unRestaurante.tieneComidaChina()
    }
}

class Plato {
   // ... 
    method esDeOrigenChino() {
        return self.origen() == "China"
    }
}