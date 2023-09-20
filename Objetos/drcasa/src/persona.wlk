/*
 * PERSONA contrae ENFERMEDADES
 * 	- CONTRAER una ENFERMEDAD, no da ningun efecto
 * 	- VIVIR una ENFERMEDAD, produce EFECTOS
 * 
 */

class Persona {
	var temperaturaActual
	var celulasTotales
	const enfermedades = #{}

	method temperaturaActual() {
		return temperaturaActual	
	}
	
	method celulasTotales() {
		return celulasTotales
	}
	
	method enfermedades() {
		return enfermedades
	}
	
    method contraerEnfermedad(unaEnfermedad) {
        enfermedades().add(unaEnfermedad)
	}

	method aumentarTemperatura(proporcion, cantidad) {
		temperaturaActual += proporcion * cantidad
	}

	method vivirUnDia() {
		self.enfermedades().forEach({
			enfermedad => enfermedad.efecto(self)
		})
	}
	
	method estaEnComa() {
		return temperaturaActual > 45 || celulasTotales < 1000000
	}
	
	method perderCelulas(cantidad) {
		celulasTotales -= cantidad
	}
		
    method enfermedadMasAmenazante() {
    	return enfermedades.max({ 
    		enfermedad => enfermedad.cantidadCelulasAmenazadas()
    	})
    }
    
    method enfermedadesAgresivas() {
        return enfermedades.filter({ 
        	enfermedad => enfermedad.agresividad(self)
        })
    }
    
    method vivirDias(unosDias) {
        unosDias.times({ 
        	dia => self.vivirUnDia()
        })
    }
    
        method medicateCon(unaDosis) {
        enfermedades.forEach { enfermedad => enfermedad.atenuatePara(self, unaDosis) }
    }

    method curarseDe(unaEnfermedad) {
        enfermedades.remove(unaEnfermedad)
    }
    
    method morir() {
        temperaturaActual = 0
    }
}
