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

abcde.mkString","  // will get a,b,c,d,e
abcde.mkString("[",",","]")  // will get [a,b,c,d,e]

// Using StringBuilder
val buf = new StringBuilder
abcde addString(buf,"(",";",")")

// Converting List to and from Array
// toArray
// toList
val arr = abcde.toArray
arr.toList

// copyToArray - copies list elements to successive array positions within some destination array.
val arr2 = new Array[Int](10)
List(1,2,3) copyToArray(arr2,3)
// arr2 is Array(0, 0, 0, 1, 2, 3, 0, 0, 0, 0)

// iterator - return iterator to access element
val it = abcde.iterator
it.next 

// map vs flatMap
val words = List("the", "quick", "brown", "fox")
words map (_.toList) // List(List(t, h, e), List(q, u, i, c, k), List(b, r, o, w, n), List(f, o, x))
words flatMap (_.toList) // List(t, h, e, q, u, i, c, k, b, r, o, w, n, f, o, x)

// another use of flatMap
List.range(1,5) flatMap ( i => List.range(1,i) map (j => (i,j)))
// that will produce  List((2,1), (3,1), (3,2), (4,1), (4,2), (4,3))

// foreach
var sum = 0
List(1,2,3,4,5) foreach (sum+= _)

// filter
List(1,2,3,4,5) filter (_ % 2 == 0)  // even number only

// partition
// xs partition p equals (xs filter p, xs filter (!p(_)))
List(1,2,3,4,5) partition (_% 2 == 0)

// find - return the first element satisfying the given predicate.
// It returns optional value, if found Some(x) otherwise None
List(1,2,3,4,5) find (_ % 2 == 0)
List(1,2,3,4,5) find (_ <= 0)

// takeWhile - takes the longest prefix of list xs such that every element in the prefix satisfies p
List(1,2,3,-4,5) takeWhile (_ > 0)  // will return List(1,2,3)
// dropWhile - removes the longest prefix from list xs such that every element in the prefix satisfies p
words dropWhile (_ startsWith "t")

// span - combines takeWhile & dropWhile in one operation
// xs span p equals (xs takeWhile p, xs dropWhile p)
List(1,2,3,-4,5) span (_ > 0)

// forall - takes as arguments a list xs and a predicate p, result true if all element in the list satisfy p
// exists - converse, return true if any element satisfy predicate p
List(1, 2, 3, 4) forall (_ < 5) // return true
List(1, 2, 3, 4) exists (_ == 1) // return true

// fold list /: and \:
// (z /: List(a, b, c)) (op) equals op(op(op(z, a), b), c)
// (List(a, b, c) :\ z) (op) equals op(a, op(b, op(c, z)))
(0 /: List(1,2,3)) (_ + _)

// reverse list 
def reverseLeft[T](xs: List[T]) = (List[T]() /: xs) {(ys, y) => y :: ys}

// sorting
// sortWith - xs sortWith before
List(1,-3,4,2,6) sortWith (_ < _)

// List method
List.apply(1,2,3)   // creating List
List.range(1,5)     // creating List of range
List.fill(5)('a')   // creating List of 5 'a' s
List.fill(2,3)('b') // List(List(b, b, b), List(b, b, b)), creating 2 Lists of 3 items 'b'
List.tabulate(5)(n => n*n) // produce List(0,1,4,9,16)
List.tabulate(5,5)(_ * _)  // produce multiplication table
List.concat(List(),List('b'), List('c')) // produce List(b,c)

// zipped - generalizes several common operations to work on multiple lists instead of just one
(List(10, 20), List(3, 4, 5)).zipped.map(_ * _) // produce List(30,80)
(List("abc", "de"), List(3, 2)).zipped.forall(_.length == _)  // produce true
