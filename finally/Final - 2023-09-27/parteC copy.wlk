
class Jurado {
    const property criticos = #{}
    const property festival // WKO

    method elegidosDelJurado() {
        return self.criticos().map { critico => critico.leGustanEstosDel(festival) }
    }
}

class Critico() {
    const property preferencias = #{}

    method leGustanEstosDel(festival) {
        return festival.estosRestaurantesCumplenEstasPreferencias(self.preferencias())
    }
}

object origenChino {

    method seCumplePara(unFestival) {
        return unFestival.tieneRestaurantesConOrigenChino()
    }
}

object festival {
    const property restaurantes = #{} 
    // los restaurantes ya están modelados y se conoce: cada plato del menu. 
    // para cada plato se conoce: origen, chef, calorias y si contiene gluten
    // de los chef se conoce el nombre y si gano algun premio
}