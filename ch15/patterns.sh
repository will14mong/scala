#!/bin/sh
exec scala "$0" "$@"
!#

abstract class Expr
case class Var(name: String) extends Expr
case class Number(num: Double) extends Expr
case class UnOp(operator: String, arg: Expr) extends Expr
case class BinOp(operator: String, left: Expr, right: Expr) extends Expr

// PATTERN GUARD
/*
We want to transform e + e into e * 2
BinOp("+", Var("x"), Var("x"))
BinOp("*", Var("x"), Number(2))

def simplifyAdd(e: Expr) = e match {
  case BinOp("+", x, x) => BinOp("*", x, Number(2))
  case _ => e
}

The above will result in error because we can't use x again the second tiem in a patern
We can reformulate with pattern guard
*/

def simplifyAdd(e: Expr) = e match {
  case BinOp("+", x, y) if x == y =>
    BinOp("*", x, Number(2))
  case _ => e
}

println(simplifyAdd(BinOp("+", Var("x"), Var("x"))))

/*
Other example

// match only positive integers
case n: Int if 0 < n => ...

// match only strings starting with the letter 'a'
case s: String if s(0) == 'a' => ...
*/

// PATTERN OVERLAPS
// Patterns are tried in the order in which they are written.
// Orders matter in the below cases

def simplifyAll(expr: Expr): Expr = expr match {
  case UnOp("-", UnOp("-", e)) => simplifyAll(e)        // '-' is its own inverse
  case BinOp("+", e, Number(0)) => simplifyAll(e)       // '0' is a neutral element for '+'
  case BinOp("*", e, Number(1)) => simplifyAll(e)       // '1' is a neutral element for '*'
  case UnOp(op, e) => UnOp(op, simplifyAll(e))
  case BinOp(op, l, r) => BinOp(op, simplifyAll(l), simplifyAll(r))
  case _ => expr
}

println("""simplify ---> BinOp("+",UnOp("-", UnOp("-",Var("x"))),BinOp("*",Var("y"), Number(1)))""")
println(simplifyAll(BinOp("+",UnOp("-", UnOp("-",Var("x"))),BinOp("*",Var("y"), Number(1)))))

// PATTERNS IN VARIABLE DEFINITIONS

val myTuple = (123, "abc")
val (number, string) = myTuple
println("my Tuple number = " + number)
println("my Tuple string = " + string)

// CASE SEQUENCES as PARTIAL FUNCTIONS
/*
a case seq is a function literal, only more general.
Instead having a single entry point and list of parameters, a case seq has multiple entry points,
  each with their own list of parameters.
Each case is an entry point to the function and the parameters are specified with the pattern.

This is quite useful for actors library. some typical code ex:
react {
  case (name: String, actor: Actor) => {
    actor ! getip(name)
    act()
  }
  case msg => {
    println("Unhandled message: " + msg)
    act()
  }
}
*/

val withDefault: Option[Int] => Int = {
  case Some(x) => x
  case None => 0
}
println("withDefault(Some(10)) = " + withDefault(Some(10)))
println("withDefault(None)     = " + withDefault(None))

val second: PartialFunction[List[Int], Int] = {
  case x :: y :: _ => y
}
println("second(List(5, 6, 7)) = " + second(List(5, 6, 7)) )

// this one fail below
// println("second(List())        = " + second(List()) )

// Partial function has a method isDefinedAt which can be used to test whether the function is defined at a particular value.
//  this is done using pattern matching.

// this will return true
println(second.isDefinedAt(List(5,6,7)))

// this will return false
println(second.isDefinedAt(List()))

/* The above partial function gets translated into
new PartialFunction[List[Int], Int] {
  def apply(xs: List[Int]) = xs match {
    case x :: y :: _ => y
  }
  def isDefinedAt(xs: List[Int]) = xs match {
    case x :: y :: _ => true
    case _ => false
  }
}
*/

// PATTERNS IN FOR EXPRESSION

val capitals = Map("France" -> "Paris", "Japan" -> "Tokyo")

for ((country, city) <- capitals)
  println("The capital of " + country + " is " + city)

// There could be cases where it doesn't match against pattern. in that case it will be drop.
// example the second element of the below example is discarded
val results = List(Some("apple"), None, Some("orange"))
for (Some(fruit) <- results) println(fruit)
