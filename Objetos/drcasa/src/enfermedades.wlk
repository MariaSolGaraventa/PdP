import persona.*
/*
 * PERSONA contrae ENFERMEDADES
 * 	- CONTRAER una ENFERMEDAD, no da ningun efecto
 * 	- VIVIR una ENFERMEDAD, produce EFECTOS
 * 
 * ENFERMEDADES. 
 * Tienen: - cantidad de CELULAS que amenaza (puede variar)
 * Tipos: Infecciosas y Autoinmunes
 * 
 * EFECTOS.
 * - Infecciosas: a> la TEMPERATURA tantos grados como la milésima parte (0.001)
 * de celulas afectadas. 
 * 		- m>45° -> COMA
 * 		- pueden reproducirse (DUPLICAN la cantidad de CELULAS amenazadas)
 * - Autoinmunes: destruyen la cantidad de CELULAS amenazadas
 * 
 * AGRESIVIDAD.
 * - Infecciosas: la cantidad de células afectadas supera el 10% de las 
 * células totales del cuerpo
 * - Autoinmunes: afectó a la persona por más de un mes (tuvo efecto +30 veces)
 */
 
 class EnfermedadInfecciosa {
 	var property cantidadCelulasAmenazadas
  // puedo NO ponerle el property y hacer el getter, que es lo único que necesito
 	
 	method efecto(unaPersona) {
 		if(unaPersona.temperaturaActual() < 45) {
 			unaPersona.aumentarTemperatura(1/1000, cantidadCelulasAmenazadas)
 		} else {
 			unaPersona.coma(true)
 		}
 	}
 	
 	method reproducirse() {
   // mejor:
   cantidadCelulasAmenazadas *= 2
 		//var nuevaCantidad
 		//nuevaCantidad = cantidadCelulasAmenazadas * 2
 		//self.cantidadCelulasAmenazadas(nuevaCantidad)
 	}
 	
 	method agresividad(paraUnaPersona) {
 		return self.proporcionCelulas(paraUnaPersona) > 0.1
 		}
 	
 	method proporcionCelulas(unaPersona) {
 		return cantidadCelulasAmenazadas / unaPersona.cantidadCelulasTotales()
 	}
 }
 
 /*
 - Autoinmunes: destruyen la cantidad de CELULAS amenazadas
 - Autoinmunes: afectó a la persona por más de un mes (tuvo efecto +30 veces)
 */
 
 class EnfermedadAutoinmune {
  	var property cantidadCelulasAmenazadas
  	
  	method efecto(unaPersona) {
  		var nuevaCantidad
  		nuevaCantidad = unaPersona.cantidadCelulasTotales() - cantidadCelulasAmenazadas
  		unaPersona.cantidadCelulasTotales(nuevaCantidad)
  		if(unaPersona.cantidadCelulasTotales() < 1000000){
  			unaPersona.coma(true)
  		}
  	}
  	
  	method agresividad(paraUnaPersona) {
  		return paraUnaPersona.cantidadDiasAfectada() > 30
  	}
 }
