import enfermedad_general.*
/* 
 * Tiene: 
 * - cantidad de CELULAS que amenaza (puede variar)
 * 
 * EFECTOS.
 * - Infecciosas: a> la TEMPERATURA tantos grados como la milésima parte (0.001)
 * de celulas afectadas. 
 * 		- m>45° -> COMA
 * 		- pueden reproducirse (DUPLICAN la cantidad de CELULAS amenazadas)
 * 
 * AGRESIVIDAD.
 * - La cantidad de células afectadas supera el 10% de las 
 * células totales del cuerpo
 */
 

class EnfermedadInfecciosa inherits Enfermedad {
 	
 	method efecto(unaPersona) {
 		unaPersona.aumentarTemperatura(1/1000, celulasAmenazadas)
 	}
 	
 	method reproducirse() {
   		celulasAmenazadas *= 2
    }
 	
 	method agresividad(paraUnaPersona) {
 		return self.proporcionCelulas(paraUnaPersona) > 0.1
 	}
 	
 	method proporcionCelulas(unaPersona) {
 		return celulasAmenazadas / unaPersona.cantidadCelulasTotales()
 	}
 }