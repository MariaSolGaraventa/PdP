// https://docs.google.com/document/d/1302g3KFNodi5Kbr_rFBGu1gBCELYEKTO9jQQ3VVxXrg/edit#heading=h.aesgj2rh7vh1

class Guerrero {
    var potencialOfensivo
    var nivelDeExperiencia
    const energiaMaxima
    var nivelDeEnergia
    var traje

    /*
    Un ataque involucra:
    - 1 ataca con todo su potencial
    - 2 disminuye su energia en un 10% del potencial ofensivo de 1
    - 2 aumenta su XP en uno.
    */
    method atacarA(otroGuerrero) {
        otroGuerrero.recibirAtaqueDe(self.potencialOfensivo)
    }

    method recibirAtaqueDe(ciertoPotencialOfensivo) {
        self.disminuirEnergiaPorcentual(ciertoPotencialOfensivo)
        self.incrementarExperiencia()
        traje.desgastarse()
    }

    method disminuirEnergiaPorcentual(ciertoPotencialOfensivo) {
        nivelDeEnergia = ciertoPotencialOfensivo - (ciertoPotencialOfensivo * traje.porcentajeDeProteccion())    
    }

    method incrementarExperiencia() {
        nivelDeExperiencia = 1 * traje.multiplicadorExperiencia()
    }

    method comerSemillaErmitanio() {
        nivelDeEnergia = energiaMaxima
    }
}

class Saiyan inherits Guerrero {
    var nivel = saiyanBase // WKO saiyanUno ó saiyanDos ó saiyanTres ó saiyanBase

    method convertirseEnSuperSaiyan() {
        nivel.aumentarResistencia()
        self.aumentarAtaque(0,5)
    }

    method aumentarAtaque(unaCantidad) {
        potencialOfensivo += potencialOfensivo * unaCantidad
    }

    override method disminuirEnergiaPorcentual(ciertoPotencialOfensivo) {
        nivelDeEnergia = ciertoPotencialOfensivo * (1 - nivel.multiplicadorResistencia()) * (1 - traje.porcentajeDeProteccion())
        self.volverASaiyanPorEnergia()
    }

    method volverASaiyan() {
        nivel = saiyanBase
    }

    method volverASaiyanPorEnergia() {
        if(nivelDeEnergia < self.unoPorcientoDeLaEnergiaOriginal()){
            self.volverASaiyan()
        }
    }

    method unoPorcientoDeLaEnergiaOriginal() {
        return energiaMaxima * 0,01
    }

    override method comerSemillaErmitanio() {
        nivelDeEnergia = energiaMaxima * 1,05
    }

}

object saiyanBase {

    method multiplicadorResistencia() {
        return 0
    }
}

object saiyanUno {

    method multiplicadorResistencia() {
        return 0,05
    }
}

object saiyanDos {

    method multiplicadorResistencia() {
        return 0,07
    }
}

object saiyanTres {

    method multiplicadorResistencia() {
        return 0,15
    }
}


class TrajePrefabricado {
    const guerrero
    var nivelDeDesgaste = 0
    const property cantidadDeElementosEnSuTraje = 1
    
    method multiplicadorExperiencia() {
        return self.multiplicador()
    }

    method porcentajeDeProteccion() {
        if(self.estaGastado()) {
            return 0
        }else{ 
            return porcentajeProteccion
        }
    }

    method desgastarse() {
            nivelDeDesgaste += 5
    }

    method estaGastado() {
        return nivelDeDesgaste >= 100
    }
}

class Comun inherits TrajePrefabricado {

    method porcentajeProteccion() {
        return proteccionParaComunes.porcentajeProteccion()
    }

    method multiplicador() {
        return 1
    }
}

object proteccionParaComunes {
    var porcentajeProteccion
}

class Entrenamiento inherits TrajePrefabricado {
    var multiplicador = 2
    const porcentajeProteccion = 0

    method multiplicador() {
        return multiplicador
    }
}

class Modularizado {
    const guerrero
    const property piezas // es un set de instancias de Pieza

    method multiplicadorExperiencia() {
        return 1 - (self.cantidadDeElementosEnSuTraje() - self.cantidadPiezasGastadas())
    }

    method porcentajeProteccion() {
        return self.piezas().sum { pieza => pieza.porcentajeDeResistencia() }
    }

    method desgastarse() {
        self.piezas().forEach { pieza => pieza.desgastarse() }
    }

    method estaGastado() {
        return self.piezas().all { pieza => pieza.estaGastada() }
    }


    method cantidadPiezasGastadas() {
        return self.piezas().filter { pieza => pieza.estaGastada() }.size()
    }

    method cantidadDeElementosEnSuTraje() {
        return self.piezas().size()
    }
}

class Pieza {
    const porcentajeResistencia
    var valorDeDesgaste = 0

    method porcentajeDeResistencia() {
        if(self.estaGastada) {
            return 0
        }else{
            return porcentajeResistencia
        }
    }

    method desgastarse() {
            valorDeDesgaste += 1
    }

    method estaGastada() {
        return valorDeDesgaste >= 20
    }
}


class Pelea {
    const modalidad // apunta a un WKO PowerIsBest ó Funny ó Surprise
    const jugadores = #{}

    method agregarJugadores(cantidad) {
        cantidad.times { i => self.jugadores().add(modalidad.agregarJugador()) }
    }
}


object powerIsBest {

    method agregarJugador() {
        return guerrerosExistentes.elMasFuerte()
    }
}

object funny {

    method agregarJugador() {
        return guerrerosExistentes.elQueMasElementosTiene()
    }
}

object surprise {

    method agregarJugador() {
        return guerrerosExistentes.tirameCualquiera()
    }
}

object guerrerosExistentes {
    const property guerreros

    method elMasFuerte() {
        return self.elGuerreroConMas(potencialOfensivo())
    }

    method elQueMasElementosTiene() {
        return self.elGuerreroConMas(cantidadDeElementosEnSuTraje())
    }

    method elGuerreroConMas(criterio) {
        return self.guerreros().max { guerrero => guerrero.criterio}
    }

    method tirameCualquiera() {
        return self.guerreros().anyOne()
    }
}