import persona.*

class Medico inherits Persona {
    const dosis

    override method contraerEnfermedad(unaEnfermedad) {
        super(unaEnfermedad)
        self.atenderA(self)
    }

    method atenderA(unaPersona) {
        unaPersona.medicateCon(dosis)
    }
}
