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
def makeIncreaser(more: Int) = (x: Int) => x + more
val inc1 = makeIncreaser(1)
val inc9999 = makeIncreaser(9999)
println(inc1(10))
println(inc9999(10))

// repeated parameters
def echo(args: String*) =
  for (arg <- args) println(arg)
echo("hello","world")

val arr = Array("What's","up","doc?")
// tells the compiler to pass each element of arr as its own argument to echo, rather than all of it as a single arg.
echo(arr: _*)

// named arguments
def speed(distance: Float, time: Float): Float = distance / time
// we can switch order with named arg
speed(time = 10, distance = 100)

// default parameter value
def printTime(out: java.io.PrintStream = Console.out, divisor: Int = 1) = 
  out.println("time = " + System.currentTimeMillis()/divisor)
printTime(out = Console.err)
printTime(divisor = 1000)
