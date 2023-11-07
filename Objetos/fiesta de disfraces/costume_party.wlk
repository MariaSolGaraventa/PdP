// https://docs.google.com/document/d/15GSlTJnE2B4w43FAofSYShbJI0BdpWhsYiysEZFShoY/edit

class Disfraz {
    const property caracteristicas = #{}

    method puntajeDelDisfraz() {
        
    }
}

class Fiesta {
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
}