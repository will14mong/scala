#!/bin/sh
exec scala "$0" "$@"
!#

// function of type (x: Int, y: Int)Int
def max(x: Int, y: Int): Int = {
  if (x > y) x
  else y
}

// or we could define it shorter
def max2(x: Int, y: Int) = if (x>y) x else y

// we have to put parentheses for println
println(max(10,12))
println(max2(12,35))

// function without parameter
def greet() = println("Hello, World from greet")
def greet2 = println("Hello, World from greet2")
greet
greet2

// printing argument, note the use of parentheses (0) instead of sq bracket [0]
println("Hello, " + args(0) + "!")

// printing list of arguments 
// args.foreach((arg: String) => println(arg))
// args.foreach(arg => println(arg))
// args.foreach(println _)
println("Printing using foreach")
args.foreach(println)

println("Printing using for")
for (arg <- args) 
  println(arg)


