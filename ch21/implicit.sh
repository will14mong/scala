#!/bin/sh
exec scala "$0" "$@"
!#

// 1. implicit function conversion
implicit def doubleToInt(x: Double) = x.toInt
val i: Int = 3.5
// done by compiler
// there's already predefined implicit conversion in scala.Predef

// on earlier Rational example
// val oneHalf = new Rational(1,2)
// 1 + oneHalf is not allowed because 1 doesn't have the implicit conversion function
// if we define:
// implicit def intToRational(x: Int) = new Rational(x, 1)
// then 1 + oneHalf will work.

// 2. implicit parameter
class PreferredPrompt(val preference: String)
class PreferredDrink(val preference: String)

object Greeter {
  def greet(name: String)(implicit prompt: PreferredPrompt,
      drink: PreferredDrink) {
    println("Welcome, "+ name +". The system is ready.")
    print("But while you work, ")
    println("why not enjoy a cup of "+ drink.preference +"?")
    println(prompt.preference)
  } 
}
object JoesPrefs {
  implicit val prompt = new PreferredPrompt("Yes, master> ")
  implicit val drink = new PreferredDrink("tea")
}
  
// must do this
import JoesPrefs._
Greeter.greet("Joe")

// function to get max in the list
def maxListImpParam[T](elements: List[T])(implicit orderer: T => Ordered[T]): T =
  elements match {
    case List() =>
      throw new IllegalArgumentException("empty list!")
    case List(x) => x
    case x :: rest =>
      val maxRest = maxListImpParam(rest)(orderer)
      if (orderer(x) > maxRest) x
      else maxRest
  }

// Scala library provides implicit "orderer" methods for many common types.
// Hence we can use this maxListImpParm with variety of types:
println(maxListImpParam(List(1,5,10,3)))
println(maxListImpParam(List(1.5,5.2,10.7,3.14159)))
println(maxListImpParam(List("one","two","three")))

// shorter
def maxList[T](elements: List[T])(implicit orderer: T => Ordered[T]): T =
  elements match {
    case List() =>
      throw new IllegalArgumentException("empty list!")
    case List(x) => x
    case x :: rest =>
      val maxRest = maxList(rest)  // (orderer) is implicit
      if (x > maxRest) x           // orderer(x) is implicit
      else maxRest
  }

// using view bounds
def maxList[T <% Ordered[T]](elements: List[T]): T = 
  elements match {
    case List() =>
      throw new IllegalArgumentException("empty list!")
    case List(x) => x
    case x :: rest =>
      val maxRest = maxList(rest)  // (orderer) is implicit
      if (x > maxRest) x           // orderer(x) is implicit
      else maxRest
}

// You can think of “T <% Ordered[T]” as saying, “I can use any T, so long as T can be treated as an Ordered[T].” 
//  This is different from saying that T is an Ordered[T], which is what an upper bound, “T <: Ordered[T]”, would say
//  For example, even though class Int is not a subtype of Ordered[Int], you could still pass a List[Int] to maxList so long as an implicit conver- sion from Int to Ordered[Int] is available
//  if type T happens to already be an Ordered[T], you can still pass a List[T] to maxList

// Multiple conversions 
def printLength(seq: Seq[Int]) = println(seq.length)
implicit def intToRange(i: Int) = 1 to i
implicit def intToDigits(i: Int) = i.toString.toList.map(_.toInt)

// We couldn't use printLength(12) as it is ambiguous

object Mocha extends Application {
  class PreferredDrink(val preference: String)
  implicit val pref = new PreferredDrink("mocha")
  def enjoy(name: String)(implicit drink: PreferredDrink) {
    print("Welcome, "+ name)
    print(". Enjoy a ")
    print(drink.preference)
    println("!")
  }
  enjoy("reader")
}

// Assuming the above Mocha code is saved as mocha.scala, we can see the converted code by using
// scalac -Xprint:typer mocha.scala
