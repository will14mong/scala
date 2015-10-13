#!/bin/sh
exec scala "$0" "$@"
!#

// list are homogeneous. the type of element in the list T is written as List[T]
// if S is subtype of T then List[S] is subtype of List[T]

val fruit: List[String] = List("apples","oranges","pears")
val nums: List[Int] = List(1, 2, 3, 4)
val diag3: List[List[Int]] =
  List(
    List(1,0,0),
    List(0,1,0),
    List(0,0,1)
  )
val empty: List[Nothing] = List()

// All lists are built from 2 fundamental building blocks, Nil and :: (pronounced "cons")
// - Nil represents empty list
// - The infix operator, ::, expresses list extension at the front.
// The previous sample can be written as well as

val fruitList = "apples" :: ("oranges" :: ("pears" :: Nil))
val numsList = 1 :: (2 :: (3 :: (4 :: Nil)))
// or can be written as val nums = 1 :: 2 :: 3 :: 4 :: Nil
val diag3List = (1 :: (0 :: (0 :: Nil))) ::
                (0 :: (1 :: (0 :: Nil))) ::
                (0 :: (0 :: (1 :: Nil))) :: Nil
val emptyList = Nil

// Basic operations on lists
// - head       returns the first element of a list
// - tail       returns a list consisting of all elements except the first
// - isEmpty    returns true if the list is empty

println(empty.isEmpty)
println(fruit.isEmpty)
println(fruit.head)
println(fruit.tail.head)
println(diag3.head)

// insertion sort
def isort(xs: List[Int]): List[Int] =
  if (xs.isEmpty) Nil
  else insert(xs.head, isort(xs.tail))

def insert(x: Int, xs: List[Int]): List[Int] =
  if (xs.isEmpty || x <= xs.head) x :: xs
  else xs.head :: insert(x, xs.tail)


println(isort(List(9,3,6,4,7,2,1,5,8)))

// Pattern
val List(a, b, c) = fruit
println("a = " + a)
println("b = " + b)
println("c = " + c)

val a1 :: b1 :: rest = List(1,2,3,4,5,6)
println("a1 = " + a1)
println("b1 = " + b1)
println("rest = " + rest)
