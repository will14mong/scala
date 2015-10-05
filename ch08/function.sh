#!/bin/sh
exec scala "$0" "$@"
!#

// demonstration function as first-class object
// we could write function as literals and pass them around
var increase = (x:Int) => x + 1
println(increase(10))
increase = (x: Int) => x + 9999
println(increase(10))

// more than one statement, use curly braces
increase = (x: Int) => {
  println("hello")
  x+1
  }
println(increase(10))

// higher order function
val someNumbers = List(-11, -10, -5, 0, 5, 10)
someNumbers.foreach((x: Int) => println(x))
println(someNumbers.filter((x:Int) => x > 0))

// can also be written using placeholder syntax (using underscore)
println(someNumbers.filter( _ > 0))

// sometimes compiler will complaint for unknown type
// in that case type can be specified
val f = (_: Int) + (_: Int)
println(f(5,10))

// partially applied function
def sum(a: Int, b: Int, c: Int) = a + b + c
val a = sum _
val b = sum(1, _: Int, 3)
println(a(1,2,3))
println(b(4))

// closures
