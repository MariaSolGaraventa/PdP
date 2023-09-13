/*
 * PERSONA contrae ENFERMEDADES
 * 	- CONTRAER una ENFERMEDAD, no da ningun efecto
 * 	- VIVIR una ENFERMEDAD, produce EFECTOS
 * 
 */

class Persona {
	var property temperaturaActual
	var property cantidadCelulasTotales
	var property coma = false
	var property enfermedades = #{}
	var property cantidadDiasAfectada

        method contraerEnfermedad(unaEnfermedad) {
                enfermedades().add(unaEnfermedad)
	}
		
	method aumentarTemperatura(proporcion, cantidad) {
		temperaturaActual += proporcion * cantidad
	}

	method vivirUnDia(_i) {
		if(enfermedades != #{} && coma == false) {
			self.enfermedades().fold(self.enfermedades().anyOne(), {_acum, 
				enfermedad => enfermedad.efecto(self)
			})
			cantidadDiasAfectada += 1
		}
	}
}
