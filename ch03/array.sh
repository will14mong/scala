#!/bin/sh
exec scala "$0" "$@"
!#

// 1. Array
val greetStrings = new Array[String](3)
greetStrings(0) = "Hello"
greetStrings(1) = ", "
greetStrings(2) = "world!\n"

for (i <- 0 to 2)
  println(greetStrings(i))

// another way to update array value
greetStrings.update(1," - ")

// another way to get value from array
// take note of the .to function applied to the int
for (i <- 0.to(2)) 
  println(greetStrings.apply(i))

// another way to initialize array
val numNames = Array("zero", "one", "two")
val numNames2 = Array.apply("zero", "one", "two")

// 2. List
// Array is mutable, List is immutable
val first = List(1,2,3)
val second = List(4, 5)
// ':::' method is used for list concatenation
val third = first ::: second
// first ::: second is actually second.:::(first)
println(first  + " and " + second + " were not mutated.")
println("Thus, " + third + " is a new list.")

// method '::' used to prepend list
val twoThree = List(2, 3)
// 1 :: twoThree is actually twoThree.::(1)
val oneTwoThree = 1 :: twoThree
println(oneTwoThree)

val list = 1 :: 2 :: 3 :: Nil
println(list)

// please refer to book programming in scala 2nd edition. pg 88 for more List related method.

// 3. Tuples
val pair = (99, "Luftballons")
println(pair._1)
println(pair._2)

// 4. Set and HashSet
var jetSet = Set("Boeing", "Airbus")
jetSet += "Lear"
println(jetSet.contains("Cessna"))

// by default it is immutable, if we want to be mutable
import scala.collection.mutable.Set
val movieSet = Set("Hitch", "Poltergeist")
movieSet += "Shrek"
println(movieSet)

import scala.collection.immutable.HashSet
val hashSet = HashSet("Tomatoes", "Chilies")
println(hashSet + "Coriander")

// 5. Map and HashMap
val romanNumeral = Map(
  1 -> "I", 2 -> "II", 3 -> "III"
)
println(romanNumeral(2))

// default is immutable, 
import scala.collection.mutable.Map

val treasureMap = Map[Int, String]()
treasureMap += (1 -> "Go to island.")
treasureMap += (2 -> "Find big X on ground.")
treasureMap += (3 -> "Dig.")
println(treasureMap(2))
