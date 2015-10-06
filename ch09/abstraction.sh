#!/bin/sh
exec scala "$0" "$@"
!#

// higher order function exist
def containsNeg(nums:List[Int]) = nums.exists(_ < 0)
println("containsNeg(Nil) = " + containsNeg(Nil))
println("containsNeg(List(0, -1, -2)) = " + containsNeg(List(0, -1, -2)))

// how about contains odd number?
def containsOdd(nums:List[Int]) = nums.exists(_ % 2 == 1)
println("containsOdd(List(0,2,3)) = " + containsOdd(List(0,2,3)));
println("containsOdd(List(0,2,4) = " + containsOdd(List(0,2,4)));

// currying
def curriedSum(x: Int)(y: Int) = x + y
println("curriedSum(1)(2) = " + curriedSum(1)(2))
// we actually get 2 traditional function invocations back to back as below
def first(x: Int) = (y: Int) => x + y
val second = first(1)
second(2)

// we can use placeholder to partially apply the param
val onePlus = curriedSum(1)_
println("onePlus(5) = " + onePlus(5))

// control structures
def twice(op: Double => Double, x: Double) = op(op(x))
println(twice(_ + 1, 5))

println("Hello, world!")
println { "Hello, world!" }

import java.io._

// loan pattern
def withPrintWriter(file: File)(op: PrintWriter => Unit) {
  val writer = new PrintWriter(file)
  try {
    op(writer)
  } finally {
    writer.close()
  }
}

val file = new File("date.txt")
withPrintWriter(file) {
  writer => writer.println(new java.util.Date)
}

// by name parameter
var assertionsEnabled = true
def myAssert(predicate: () => Boolean) = 
  if (assertionsEnabled && !predicate()) 
    throw new AssertionError

myAssert(() => 5 > 3)

// we would want to write it this way myAssert(5 > 3)

// byName parameter start with => instead of () =>
// when calling predicate, omit ()
def byNameAssert(predicate: => Boolean) =
  if (assertionsEnabled && !predicate)
    throw new AssertionError

byNameAssert(5 > 3)
byNameAssert(3 > 5)
