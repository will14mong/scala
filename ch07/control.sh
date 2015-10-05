#!/bin/sh
exec scala "$0" "$@"
!#

// if else block
println("if else example")
println(if (!args.isEmpty) args(0) else "default.txt")

// while loop
def gcdLoop(x: Long, y: Long): Long = {
  var a = x
  var b = y
  while (a != 0) {
    val temp = a
    a = b % a
    b = temp
  }
  b
}
println("while loop example: gcdLoop(60,24) = " + gcdLoop(60,24).toString)

// do-while
var line = ""
do {
  println("type something to echo back, empty enter to end")
  line = readLine()
  println("read: "+ line)
} while (line != "")

// procedure always return Unit which is same as ()
def greet() { println("hi") }
println("compare result of greet() == () is : " + (greet() == ()).toString())

// gcd using recursion
def gcd(x: Long, y: Long): Long = if (y==0) x else gcd(y, x % y)
println("recursion example: gcd(60,24) = " + gcd(60,24).toString)

// for expression
println("for expression example")
println("- using to: 1 to 5")
for (i <- 1 to 5)
  println(i)
println("- using until: 1 until 5")
for (i <- 1 until 5)
  println(i)

// for with condition
// include more filters by adding more if clauses
println("for expression with multiple if condition example")
for (
  i <- 1 to 30
  if i%2 == 0
  if i%3 == 0
  ) println(i)

// for with nested iteration
// notice the ; in the end of the first if clauses
for (
  i <- 1 to 20
  if i%2 == 0;
  x <- i to i+5
  if x%5 == 0
  ) println(i + " : " + x)

// for yield
// for clauses yield body
val res = for (
  i <- 1 to 20
  if i%2 == 0;
  x <- i to i+5
  if x%5 == 0
  ) yield x
println(res)

// throw error, exception throw has type Nothing
// the type of the whole if expression is then the type of branch which does compute something
val n = 10
val half =
  if (n % 2 == 0)
    n / 2
  else
    throw new RuntimeException("n must be even")

// try-catch-finally
/*
import java.io.FileReader
import java.io.FileNotFoundException
import java.io.IOException

try {
  val f = new FileReader("input.txt")
} catch {
  case ex: FileNotFoundException => // Handle missing file
  case ex: IOException => // Handle other I/O error
} finally {
  f.close()  // close the file
}
*/

// scala try-catch-finally block returns value
// try NOT to use return
def f(): Int = try { return 1 } finally { return 2 }
println("Calling f() will return 2 : " + f())
def g(): Int = try { 1 } finally { 2 }
println("Calling g() will return 1 : " + g())

// match expression
val test = "salt"
val friend =
  test match {
    case "salt" => "pepper"
    case "chips" => "salsa"
    case "eggs" => "bacon"
    case _ => "huh?"
  }
println(friend)

// variable scope
println("variable scope example")
val a = 1;
{
  val a = 2  // compiles just fine
  println(a)
}
println(a)
