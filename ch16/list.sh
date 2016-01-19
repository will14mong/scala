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
// - init       returns the list except the last element
// - last       returns the last element of a list

println("fruit = " + fruit)
println("diag3 = " + diag3)
println("empty = " + empty)
println("empty.isEmpty = " + empty.isEmpty)
println("fruit.isEmpty = " + fruit.isEmpty)
println("fruit.head = " + fruit.head)
println("fruit.tail.head = " + fruit.tail.head)
println("diag3.head = " + diag3.head)
println("fruit.init = " + fruit.init)
println("fruit.last = " + fruit.last)

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

// Using pattern matching to implement isort
def isort2(xs: List[Int]): List[Int] = xs match {
  case List()   => List()
  case x :: xs1 => insert2(x, isort2(xs1))
}

def insert2(x: Int, xs: List[Int]): List[Int] = xs match {
  case List()  => List(x)
  case y :: ys => if (x <= y) x :: xs
                  else y :: insert2(x, ys)
}

println(isort2(List(2,5,4,6,9,8,1,3,7)))

// concatenate two list use :::
val l1 = List(1, 2, 3)
val l2 = List(4, 5, 6)
val l3 = List(7, 8, 9)
val l4 = l1 ::: l2 ::: l3
println("l4 = " + l4)
// l4 is equivalent to l4 = l1 ::: (l2 ::: l3)

// assume we want to implement ::: ourselves
// element type T can be arbitrary and this is expressed by giving append a type parameter
//   more of this on ch19
def append[T](xs: List[T], ys: List[T]): List[T] =
  xs match {
    case List() => ys
    case x :: xs1 => x :: append(xs1, ys)
  }

println(append(List(1,2,3), List(4,5,6)))

// length is expensive operation in List because it needs to traverse the whole list.
// use isEmpty to check for length == 0 is better.

// reversing
fruitList.reverse

// Implemented reverse using concatenation (:::)
def rev[T](xs: List[T]): List[T] = xs match {
  case List() => xs
  case x :: xs1 => rev(xs1) ::: List(x)
}

// take - return the first n elements of the list
// drop - returns all elements of the list except the first n ones
// splitAt - splits the list at a given index, returning a pair of two lists.
// apply - get element at index
// indices - return indices starting from 0 as a Range
var abcde = List("a","b","c","d","e")
abcde take 2
abcde drop 2
abcde splitAt 2
abcde apply 2
abcde(2)
abcde.indices

// flatten - similar to raze in q
fruit.map(_.toCharArray).flatten

// zip - similar to ,' in q. but if it is different length, the unmatched elements are dropped.
abcde.indices zip abcde

// zipWithIndex - pairs every element of a list with the position where it appears in the liast
abcde.zipWithIndex

// unzip - reverse back the operation of zip
val zipped = abcde.indices zip abcde
zipped.unzip
