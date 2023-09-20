import enfermedad_general.*
 
 /*
  * Tiene: 
  * - cantidad de CELULAS que amenaza (puede variar)
  * EFECTOS.
  - Destruyen la cantidad de CELULAS amenazadas
  *
  * AGRESIVIDAD.
  - Afectó a la persona por más de un mes (tuvo efecto +30 veces)
 */
 
 class EnfermedadAutoinmune inherits Enfermedad {
  	var diasAfectando
  	
  	method efecto(unaPersona) {
  		unaPersona.perderCelulas(celulasAmenazadas)
  		self.afectarUnDiaMas()
  	}
  	
  	method agresividad(paraUnaPersona) {
        return diasAfectando > 30
    }
    
  	method afectarUnDiaMas() {
  		diasAfectando += 1
  	}
 }
