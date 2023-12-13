/* 
Responder V o F y justificar conceptualmente en todos los casos.
a. No está bien aprovechado el polimorfismo entre las prendas.
    V. Podrían estar todas las faldas, blusas y shorts en una sola lista lo que derivaría en implementar UN SOLO forEach{}.
b. Entre las faldas no hay repetición de lógica.
    F. Hay repetición de lógica en toda la clase menos el multiplicador por la tela.
c. Usando herencia puedo resolver toda repetición de lógica de esta solución.
    F. Pueden ocurrir dos situaciones:
1) Un objeto heredaría de dos clases/objetos. Sólo se puede heredar de un objeto/clase.
2) Para evitar la situación anterior, se estaría repitiendo la lógica en los objetos "modalParaFalda", "modalParaShort", "modalParaBlusa" y los otros 6 respectivamente.
d. La solución es poco declarativa.
    V. Existen partes donde predomina el cómo resolver el problema más que qué resolver. Por ejemplo en cualquier prenda que no sea de modal, se está multiplicando por algo que podría abstraerse en "multiplicador".
*/

class Pedido {
    const property prendas = []
    
    method tiempoDeConfeccion(){
        var tiempoTotal = 0
        self.prendas().forEach{ prenda => tiempoTotal += prenda.tiempo() }
        return tiempoTotal
    }
}

class Falda {
    const material
    const property tiempoBase = 120

    method tiempo(){
        return material.adicionalDe(120)
    }
}

class Blusa {
    const material
    const property tiempoBase = 200
    const property cantidadBotones

    method tiempo(){
        const tiempoConBotones = 200 + cantidadBotones * 5
        return material.adicionalDe(tiempoConBotones)
    }

}

class Short {
    const tiempoNecesario
    
    method tiempo(){
        return material.adicionalDe(tiempoNecesario)
    }
}

object modal {

    method adicionalDe(tiempoBase) {
        return tiempoBase
    }
}

object lycra {

    method adicionalDe(tiempoBase) {
        return tiempoBase * 1,2
    }
}

object denim {

    method adicionalDe(tiempoBase) {
        return tiempoBase + 25
    }
}

