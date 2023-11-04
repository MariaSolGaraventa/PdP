
// https://docs.google.com/document/d/1WOK0p1qH-5LQxDQ1Jx3b39gSXpyqy4GuLIax11yjnoc/edit

/*
------------------------------------------------------------------------------------
------------------------------------- COMENSAL.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Comensal {
    const property nombre
    var property posicion
    const property elementosCercanos // lista
    var property criterioPedidos // wko
    var property criterioComida // wko
    const property comidasComidas // lista

    method pedirleA(otroComensal, unElemento) {
        if(!tiene(unElemento, otroComensal)) {
            throw new Exception (message = "No tiene ese elemento")
        }else{
             return criterioPedidos.pedirleAAlguien(self, otroComensal, elementoPedido)
        }
    }
        method tiene(unElemento, otroComensal) {
            return otroComensal.elementosCercanos().contains(unElemento)
        }

    method darElemento(unElemento) {
        self.elementosCercanos().remove(unElemento)
    }

    method recibirElemento(unElemento) {
        self.elementosCercanos().add(unElemento)
    }

    method comer(unaComida){
        // POLIMORFISMO
        if(criterioComida.puedoComer(unaComida)) {
            self.comidasComidas().add(unaComida)
        }
    }

    method estoyPipon() {
        return self.comidasComidas().any { comida => comida.tengoMasDe500Calorias() }
    }

    method laEstoyPasandoBien() {
        return self.comiAlgo() && nombre.estoyJoya()
    }

    method estoyJoya()
}

// HERENCIA
object osky inherits Comensal(...) {
    
    method estoyJoya() {
        return true
    }
}

object moni inherits Comensal(...) {

    method estoyJoya() {
        return self.posicion() == 1@1
    }
}

object facu inherits Comensal(...) {
    
    method estoyJoya() {
        return self.comidasComidas().any { comida => comida.esCarne() == true }
    }
}

object vero inherits Comensal(...) {
     
    method estoyJoya() {
        return self.elementosCercanos().size() =< 3
    }
}

/*
------------------------------------------------------------------------------------
------------------------------------- CRITERIOS_COMIDA.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

object vegetariano {
   
    method puedoComer(unaComida) {
        return unaComida.esCarne()
    }
}

object dietetico {

    method puedoComer(unaComida) {
        return unaComida.calorias() < oms.valorRecomendado()
    }
}

object alternado {
    var rechaceAntes = false

    method puedoComer(unaComida) {
        return rechaceAntes
        rechaceAntes = !rechaceAntes
    }
}

object soyComplicado {
    const property condiciones = #{}

// COMPOSICION
    method puedoComer(unaComida) {
        return self.condiciones().all { condicion => condicion.puedoComer(unaComida) }
    }    
}

/*
------------------------------------------------------------------------------------
------------------------------------- BANDEJA.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

class Bandeja {
    const property comidaAOfrecer
    const property calorias
    const property esCarne

    method tengoMasDe500Calorias() {
        return calorias > 500
    }
}

/*
------------------------------------------------------------------------------------
------------------------------------- OMS.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

object oms {
    var property valorRecomendado = 500
}


/*
------------------------------------------------------------------------------------
------------------------------------- CRITERIOS_PEDIDOS.wlk -------------------------------------
------------------------------------------------------------------------------------
*/

object sordo {

    method pedirleAAlguien(unComensal, otroComensal, _elementoPedido) {
         const elemento = unComensal.elementosCercanos().first
         unComensal.darElemento(elemento)
         otroComensal.recibirElemento(elemento)
    }
}

object chispita {

    method pedirleAAlguien(unComensal, otroComensal, _elementoPedido) {
        unComensal.elementosCercanos().forEach { 
            elemento => unComensal.darElemento(elemento)
                        otroComensal.recibirElemento(elemento) 
        }
    }
}

object inquieto {

    method pedirleAAlguien(unComensal, otroComensal, _elementoPedido) {
        const posicionUnComensal = unComensal.posicion()
        unComensal.posicion(otroComensal.posicion())
        otroComensal.posicion(posicionUnComensal)
    }
}

object correcto {

    method pedirleAAlguien(unComensal, otroComensal, elementoPedido) {
         unComensal.darElemento(elementoPedido)
         otroComensal.recibirElemento(elementoPedido)
    }
}

