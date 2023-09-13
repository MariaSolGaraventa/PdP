import lugares.*

object pepita {
	var property energia
	var property lugar = caba
	var distancia
			
	/*method energia(unaEnergia) {
		energia = unaEnergia
	}
	*/
	
	method volar(kilometros) {
		energia -= kilometros + 10
	}
	
	method comer(gramos) {
		energia += 4 * gramos
	}
	
	method dondeEstoy() {
		return lugar
	}
	
	method volarA(unLugar) {
		distancia = (unLugar.kilometroNumero() - lugar.kilometroNumero()).abs()
		lugar = unLugar
		self.volar(distancia)
	}
	
	method puedeIrA(unLugar){
		
		self.energia()
	}
}