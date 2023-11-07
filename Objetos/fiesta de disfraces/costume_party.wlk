// https://docs.google.com/document/d/15GSlTJnE2B4w43FAofSYShbJI0BdpWhsYiysEZFShoY/edit

/*
------------------------------------------------------------------------------------
------------------------------------- INVITADO.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Invitado {
    var property disfraz // apunta a una instancia de Disfraz
    const property caracteristicas // set: default Y ADEMAS caprichoso, pretencioso, numerologo
    var property personalidad // alegre o taciturna
    var property edad

    method puedoIntercambiarDisfraz(otroInvitado, unaFiesta) {
        return self.estamosInvitados(otroInvitado, unaFiesta) && self.unoEstaDisconforme(otroInvitado) && self.estariamosConformes(otroInvitado)
    }

    method estamosInvitados(otroInvitado, unaFiesta){
        return unaFiesta.estaComoInvitado(self) && unaFiesta.estaComoInvitado(otroInvitado)
    }

    method unoEstaDisconforme(otroInvitado) {
        return self.estoyDisconforme() || otroInvitado.estoyDisconforme()
    }

    method estoyDisconforme(){
        return self.caracteristicas().any { caracteristica => !caracteristica.estoyConformeCon(self.disfraz()) }
    }

    method estariamosConformes(otroInvitado) {
        
    }

    method tengoMenosDe30Anios() {
        return self.edad() < 30
    }

    method esSexy(){
        return personalidad.soySexy()
    }
}

/*
------------------------------------------------------------------------------------
------------------------------------- DISFRAZ.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Disfraz {
    const property nombre
    const property fechaConfeccion = new Date()
    const property caracteristicas = #{} // gracioso y/o tobara y/o careta y/o sexy

    method puntajeDelDisfraz(unInvitado) {
        return self.caracteristicas().sum { caracteristica => caracteristica.puntaje(unInvitado) }
    }

    method nombreConLetrasPares() {
        return self.nombre().size().even()
    }

    method esteHechoHaceMenosDe30Dias(fechaActual) {
        return self.fechaConfeccion().plusDays(30) < fechaActual
    }
}

/*
------------------------------------------------------------------------------------
------------------------------------- CARACTERISTICAS_DISFRAZ.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Gracioso {
    const property nivelDeGracia

    method puntaje(unInvitado) {
        return nivelDeGracia * self.multiplicador(unInvitado)
    }

    method multiplicador(unInvitado) {
        if(unInvitado.edad() > 50) {
            return 3
        }
    }
}

class Tobara {
    const fechaCompra

    method puntaje(_unInvitado) {
        const fechaActual = new Date()
        if(fechaCompra.plusDays(2) < fechaActual){
            return 5
        }else{
            return 3
        }
    }
}

class Careta {
    const valorDelPersonaje

    method puntaje(_unInvitado) {
        return valorDelPersonaje
    }
}

class Sexy {

    method puntaje(unInvitado) {
        if(unInvitado.esSexy()) {
            return 15
        }else{
            return 2
        }
    }
}
/*
------------------------------------------------------------------------------------
------------------------------------- PERSONALIDADES.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Alegre {

    method soySexy() {
        return false
    }
}

class Taciturna {

    method soySexy() {
        return unaPersona.tengoMenosDe30Anios()
    }
}

/*
------------------------------------------------------------------------------------
------------------------------------- CARACTERISTICAS_INVITADO.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Default {
    
    method estoyConformeCon(unDisfraz) {
        return unDisfraz.puntajeDelDisfraz() > 10
    }
}

class Caprichoso {

     method estoyConformeCon(unDisfraz) {
        return unDisfraz.nombreConLetrasPares()
    }
}

class Pretencioso {

     method estoyConformeCon(unDisfraz) {
        return unDisfraz.esteHechoHaceMenosDe30Dias(new Date())
    }

}

class Numerologo {
    const property cifraDeterminada

     method estoyConformeCon(unDisfraz) {
        return unDisfraz.puntajeDelDisfraz() == cifraDeterminada
    }
}

/*
------------------------------------------------------------------------------------
------------------------------------- FIESTA.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Fiesta {
    const lugar
    const fecha
    const property asistentes = #{}

    method esUnBodrio() {
        return self.asistentes().all { asistente => !asistente.estoyConforme() }
    }

    method mejorDisfrazDeLaFiesta() {
        return self.asistentes().maxIfEmpty({asistente => asistente.puntajeDelDisfraz()}, {"No hay nadie en la fiesta"})
    }

    method agregarAsistente(unaPersona) {
        if(unaPersona.tieneDisfraz()){
            self.asistentes().add(unaPersona)
        }
    }

    method esFiestaInolvidable(){
        return self.todoAsistenteEsSexy() && self.todosEstanConformes()
    }
        method todoAsistenteEsSexy() {
            return asistentes.all { asistente => asistente.soySexy() }
        }
        
        method todosEstanConformes() {
            return asistentes.all { asistente => asistente.estoyConforme() }
        }

    method estaComoInvitado(unaPersona) {
        return self.asistentes().contains(unaPersona)
    }
}