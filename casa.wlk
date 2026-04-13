object casa {
   var gastosMensuales = 0
   
   var cuentaBancaria = cuentaConGastos
   
   method gastosMensuales(){
    return gastosMensuales
   }
    method gastar(cantidad){
        cuentaBancaria.extraer(cantidad)
        gastosMensuales = gastosMensuales + cantidad
    }

    method siguienteMes(){
        gastosMensuales = 0
    }

    method CuentaBancaria(_cuentaBancaria){
        cuentaBancaria = _cuentaBancaria
    }

}

object pepe{
    var cuentaBancaria = null
    
    method CuentaBancaria(_cuentaBancaria){
        cuentaBancaria = _cuentaBancaria
    }

    method saldoCuenta(cuenta){
        return cuenta.saldo()
    }

}

object julian{
    var cuentaBancaria = null

    method setCuentaBancaria(_cuentaBancaria){
        cuentaBancaria = _cuentaBancaria
    }
    method saldoCuenta(cuenta){
        return cuenta.saldo()
    }

}

object cuentaCorriente{
var saldo = 0

method saldo(){
    return saldo
}

method extraer(cantidad){
    saldo = saldo - cantidad
}

method Saldo(_saldo) {
  saldo = _saldo
}
}

object cuentaConGastos{
var saldo = 0
var costoPorOperacion = 20

method Saldo(_saldo) {
  saldo = _saldo
}

method costoPorOperacion(){
    return costoPorOperacion
}

method CostoPorOperacion(_costoPorOperacion){
    costoPorOperacion = _costoPorOperacion
}

method saldo(){
    return saldo
}

method extraer(cantidad){
    saldo = saldo - cantidad
}

method depositar(cantidad){
    self.validarMonto(cantidad)
    saldo = saldo + cantidad - costoPorOperacion
}

method validarMonto(cantidad){
    if(cantidad <= self.costoPorOperacion()){
        self.error("monto insuficiente")
    }
}
}