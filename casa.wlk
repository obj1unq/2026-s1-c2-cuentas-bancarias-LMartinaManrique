object casa {
   var gastosMensuales = 0
   var cuentaBancaria = cuentaConGastos
   var montoReparacion = 0
   var viveres = 0
   var estrategiasAhorro = full

   method saldo(){
    return cuentaBancaria.saldo()
   }

   method gastosMensuales(){
    return gastosMensuales
   }
    method gastar(cantidad){
        cuentaBancaria.extraer(cantidad)
        gastosMensuales = gastosMensuales + cantidad
    }

    method siguienteMes(){
        gastosMensuales = 0
        self.mantenimiento()
    }

    method CuentaBancaria(_cuentaBancaria){
        cuentaBancaria = _cuentaBancaria
    }
    
    method montoReparacion(){
        return montoReparacion
    }
 
    method romperAlgo(montoRotura) {
      montoReparacion = montoReparacion + montoRotura
    }

    method reparar(){
        self.gastar(montoReparacion)
        montoReparacion = 0
    }

    method comprarViveres(porcentajeAComprar, calidad){
        self.validarCompraViveres(porcentajeAComprar)
        self.gastar(porcentajeAComprar * calidad)
        viveres = viveres + porcentajeAComprar
  }
    method viveres() {
      return viveres
    }

    method viveres(_viveres){
        viveres = _viveres
    }

    method validarCompraViveres(porcentajeAComprar){
        if(not self.puedeComprarViveres(porcentajeAComprar)){
            self.error("no se puede realizar la compra")
        }
    }

    method puedeComprarViveres(porcentajeAComprar){
        return porcentajeAComprar + self.viveres() <= 100
    }

    method estaEnOrden(){
        return self.montoReparacion() == 0 && self.viveres() >= 50
    }

    method estrategiasAhorro(_estrategiasAhorro){
        estrategiasAhorro = _estrategiasAhorro
    }

    method estrategiasAhorro(){
        return estrategiasAhorro
    }

    method mantenimiento(){
        estrategiasAhorro.hacerMantenimiento()
    }

}

object full{

    method hacerMantenimiento() {
      if(casa.estaEnOrden() && casa.viveres()<100){
        self.comprarViveres()
      }
      else{
        self.comprarViveres()
        self.hacerReparaciones()
      }
    } 

    method comprarViveres(){
        if(casa.viveres()<40){
            casa.comprarViveres(40 - casa.viveres(), 5)
        }
        else{
            casa.comprarViveres(100 - casa.viveres(), 5)
        }
    }

    method hacerReparaciones(){
        if(self.puedoHacerReparaciones()){
        casa.reparar()
        }
    }
    
    method puedoHacerReparaciones() {
      return casa.saldo() >= casa.montoReparacion() && casa.montoReparacion() > 0
    }
}

object minimoEIndispensable{
    var calidadDeVivere = 2
    method hacerMantenimiento(){
        if(casa.viveres()< 50){
            casa.comprarViveres(40 - casa.viveres(), self.calidadDeVivere())
        }
    }

    method calidadDeVivere(_calidadDeVivere){
        calidadDeVivere = _calidadDeVivere
    }
    method calidadDeVivere() {
      return calidadDeVivere
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

object cuentaCombinada {

    var cuentaPrimaria = cuentaCorriente
    var cuentaSecundaria = cuentaConGastos
    
    method cuentaPrimaria(){
        return cuentaPrimaria
    }

    method cuentaSecundaria(){
        return cuentaSecundaria
    }

    method cuentaPrimaria(_cuentaPrimaria){
        cuentaPrimaria = _cuentaPrimaria
    }

    method cuentaSecundaria(_cuentaSecundaria){
        cuentaSecundaria = _cuentaSecundaria
    }

    method saldo(){
        return cuentaPrimaria.saldo().max(0) + cuentaSecundaria.saldo().max(0)
    }
    method depositar(cantidad){
        cuentaPrimaria.depositar(cantidad)
    }
    
  method extraer(cantidad){
    self.validarExtraer(cantidad)
    if(cantidad > cuentaPrimaria.saldo()){
        cuentaSecundaria.extraer(cantidad-cuentaPrimaria.saldo())
        cuentaPrimaria.extraer(cuentaConGastos.saldo())
    }
    else{
        cuentaPrimaria.extraer(cantidad)
    }
    
  }
  method validarExtraer(cantidad){
    if(not self.puedeExtraer(cantidad)){
        self.error("saldo insuficiente")
    }
  }

method puedeExtraer(cantidad){
   return cantidad <= self.saldo()
}
  
}
object cuentaCorriente{
var saldo = 0

method Saldo(){
    return saldo
}

method extraer(cantidad){
    saldo = saldo - cantidad
}

method Saldo(_saldo) {
  saldo = _saldo
}

method depositar(cantidad){
    saldo = saldo + cantidad
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
