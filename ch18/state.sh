#!/bin/sh
exec scala "$0" "$@"
!#

class Time {
  var hour = 12
  var minute = 0
}

// above is actually implemented as
// class Time {
//   private[this] var h = 12
//   private[this] var m = 0
//   def hour: Int = h
//   def hour_=(x: Int) { h = x }
//   def minute: Int = m
//   def minute_=(x: Int) { m = x }
// }


// another implementation that catch invalid value
class TimeA {
  private[this] var h = 12
  private[this] var m = 0
  def hour: Int = h
  def hour_= (x: Int) {
    require(0 <= x && x < 24)
    h = x
  }
  def minute = m
  def minute_= (x: Int) {
    require(0 <= x && x < 60)
    m = x
  }
}


// use = _ to indicate uninitialized value.
class Thermometer {
  var celsius: Float = _

  def fahrenheit = celsius * 9 / 5 + 32
  def fahrenheit_= (f: Float) {
    celsius = (f - 32) * 5 / 9
  }
  override def toString = fahrenheit +"F/"+ celsius +"C"
}

val t = new Thermometer
println(t)
t.celsius = 100
println(t)
t.fahrenheit = -40
println(t)
