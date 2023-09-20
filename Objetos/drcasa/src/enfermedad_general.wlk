class Enfermedad {
    var celulasAmenazadas

    method celulasAmenazadas() {
        return celulasAmenazadas
    }

    method atenuarseEn(unaCantidadDeCelulas) {
        celulasAmenazadas = 0.max(celulasAmenazadas - unaCantidadDeCelulas)
    }

    method atenuatePara(unaPersona, unaDosis) {
        self.atenuarseEn(unaDosis * 15)
        self.validarCuracion(unaPersona)
    }

    method validarCuracion(unaPersona) {
        if (self.celulasAmenazadas() == 0) {
            unaPersona.curarseDe(self)
        }
    }
}

object muerte {    
    method celulasAmenazadas() {
        return 0
    }

    method atenuatePara(_unaPersona, _unaDosis) {
        // No hace nada porque no se atenua
    }

    method efecto(unaPersona) {
        unaPersona.morir()
    }

    method agresividad(_unaPersona) {
        return true
    }
}

class HIV {
    const autoinmune
    const infecciosa
    
    method celulasAmenazadas() {
        return autoinmune.celulasAmenazadas() + infecciosa.celulasAmenazadas()
    }

    method atenuatePara(unaPersona, unaDosis) {
        infecciosa.atenuatePara(unaPersona, unaDosis)
        autoinmune.atenuatePara(unaPersona, unaDosis)
    }

    method efecto(unaPersona) {
        infecciosa.efecto(unaPersona)
        autoinmune.efecto(unaPersona)
    }

    method agresividad(unaPersona) {
        return infecciosa.agresividad(unaPersona) && autoinmune.agresividad(unaPersona)
    }
}