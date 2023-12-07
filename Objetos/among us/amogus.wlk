// amogus ඞ
object nave {
    const property jugadores // set
    var cantidadDeImpostores
    var cantidadDeTripulantes

    method todosTerminaronSusTareas() {
        return self.jugadores().all { jugador => jugador.hiceTodasMisTareas() }
    }
}

class Jugador {
    const color
    var nivelDeSospecha = 40
    const property mochila = #{}
    const property tareas // lista de tareas

    method esSospechoso() {
        return nivelDeSospecha >= 50
    }

    method buscarUnItem(item) {
        self.mochila().add(item)
    }

    method hiceTodasMisTareas() {
        return self.tareas() == []
    }

    method intentarHacerUnaTarea() {
        const tarea = self.unaTarea()
        const requerimentos = tarea.requerimentos()
        if(self.cumploLosRequerimentos(requerimentos)) {
            self.hacerLaTarea(tarea, requerimentos)
        }
    }

    method unaTarea() {
        return self.tareas().anyOne()
    }

    method cumploLosRequerimentos(requerimentos) {
        return requerimentos.all { requerimento => self.tengoEnMiMochilaEl(requerimento) }
    }

    method tengoEnMiMochilaEl(requerimento) {
        return self.mochila().contains(requerimento)
    }

    method hacerLaTarea(tarea, requerimentos) {
        tarea.efecto()
        self.tareas().remove(tarea)
        requerimentos.forEach{ requerimento => self.removerDeLaMochila(requerimento)} 
    }

    method removerDeLaMochila(requerimento) {
        self.mochila().remove(requerimento)
    }
}

class Impostor inherits Jugador {
    const property sabotajes // set

    override method hacerUnaTarea() {}

    override method hiceTodasMisTareas() {
        return true
    }

    method hacerUnSabotaje() {
        unSabotaje.efectoDeSerRealizado()
    }

    method unSabotaje() {
        return self.sabotajes().anyOne()
    }
}

object arreglarElTableroElectrico {

    method requerimentos() {
        return llaveInglesa
    }

    method efectoDeSerRealizado(){

    }
}

object sacarLaBasura {

    method requerimentos() {
        return [escoba, bolsaConsorcio]
    }

    method efectoDeSerRealizado(){

    }
}

object sacarLaBasura {

    method requerimentos() {}

    method efectoDeSerRealizado(){

    }
}

object reducirOxigeno {

    method requerimentos() {

    }
    
    method efectoDeSerRealizado(){

    }
}