class Tripulante {
   var property rolActual = "Libre"
   var property edad
   var property fuerza
 
   method mayorDeEdad() {
        return self.edad() >= 18
   } 
   	
   method prestigio() {
    return if (self.rolActual() == "Libre") 0 else                // type test horrible
     if (self.rolActual() == "Obrero") 50 else
     if (self.rolActual() == "MrFusión") 100 else -1
   }

   	
   method podesCambiarA(otroRol) {
        return otroRol == "Libre" || otroRol == "Obrero"              
         && self.condicionParaObrero() || otroRol == "MrFusión" 
         && self.condicionParaMrFusion()
   }

   		
   method condicionParaObrero() {
     return self.mayorDeEdad() && self.fuerza() > 5
   }

   	
   method condicionParaMrFusion() =
     self.mayorDeEdad() && self.conocimiento() >
        estacionEspacial.conocimientoPromedio() * 1.21
   	
   method rolActual(otroRol) {
     if (self.podesCambiarA(otroRol)) {
        rolActual = otroRol
        // Se requiere que solamente MrFusión
        // registre conocimientos
        if (self.rolActual() == "Libre" ||
            self.rolActual() == "Obrero") 
           conocimientos = 0
        return 0
      } else {
        return "Error: No se pudo cambiar rol, no cumple requisito!"
      }
   }
}

// Punto 1
/*
a. V. La herencia es una relación fuerte que no puede cambiar con el tiempo, por lo que no se podría cambiar de rol.
b. F. Al ser todo type test, habría que realizar muchas modificaciones, considerando en cada método que sea necesario, el caso de Capitán.
c. F. Ídem lo del type test.
d. V. Está mal informado el error. No debería ser un string, sino una excepción o un self.error()
*/

// Punto 2

class Tripulante {
    var property rolActual = libre // WKO libre ó obrero ó mrFusion ó capitan
    var property edad
    const property fuerza
    
    method mayorDeEdad() {
        return self.edad() >= 18
    } 
   	
    method prestigio() {
        return self.rolActual().prestigio()
    }
   	
    method podesCambiarA(otroRol) {
        return otroRol.puedoTenerloComoRol(self)
    }
	     
    method cambiarRolActual(otroRol) {
        if (!self.podesCambiarA(otroRol)) {
            throw new Exception(message = "No se pudo cambiar rol, no cumple requisito")
        }else{
            self.rolActual(otroRol)
      }
   }
}

class Rol {

    method prestigio()

    method puedoTenerloComoRol(unaPersona) {
        return unaPersona.mayorDeEdad() 
    }
}

object libre inherits Rol {

    override method prestigio() {
        return 0
    }

    override method puedoTenerloComoRol(_unaPersona) {
        return true
   }
}

object obrero inherits Rol {
    
    override method prestigio() {
        return 50
    }

    override method puedoTenerloComoRol(unaPersona) {
        return unaPersona.fuerza() > 50 && super(unaPersona)          
    }
}

class MrFusion inherits Rol {
   const property conocimiento

    override method prestigio() {
        return 100
    }

    override method puedoTenerloComoRol(unaPersona) {
        return self.conocimientoMayorAl21PorcientoDelPromedioDeLaEstacion() && super(unaPersona)
    }

    method conocimientoMayorAl21PorcientoDelPromedioDeLaEstacion() {
        return self.conocimiento() > estacionEspacial.conocimientoPromedio() * 1.21
   }
}

class Capitan inherits MrFusion {

    override method puedoTenerloComoRol(unaPersona) {
        return unaPersona.fuerza() > 73 && super(unaPersona)
   }
}

// Punto 3: Explicar conceptualmente los cambios realizados, indicando cómo se resuelven los problemas encontrados en el punto 1.
/*
Se crearon clases y objetos para los roles, que comparten interfaz "rol", que contiene los métodos prestigio() y puedoTenerloComoRol(unaPersona). 
En vez de usar herencia como se habia planteado en el 1a se usó composición, que es una relación debil que sí puede cambiar con el tiempo.
Con esto, se eliminaron los type test, delegando al rol correspondiente los mensajes.
Se reemplazó el texto de error en cambiarRolActual(otroRol) por una excepción.
*/