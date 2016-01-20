#!/bin/sh
exec scala "$0" "$@"
!#

// Array
// Provide arbitrary position access
// 1. when we don't know yet the element values
val fiveInts = new Array[Int](5)
// 2. when we know the values
val fiveToOne = Array(5, 4, 3, 2, 1)

// List buffers
// List provides fast access to the head of the list but not the end.
// ListBuffer provides constant time append & prepend operations.
// append with +=
// prepend with +=:
import scala.collection.mutable.ListBuffer
val buf = new ListBuffer[Int]
buf += 1
buf += 2
3 +=: buf
println(buf.toList)

// Array buffers
// like an Array, except that can additionally add and remove elements from beginning and end of the seq
// Other array op are available but a little slower due to a layer of wrapping in implementation
// New addition and removal are constant time on average, but occasionally require linear time due to the
//   implementation needing to allocate a new array to hold the buffer's contents.
import scala.collection.mutable.ArrayBuffer
// need not specify length
val abuf = new ArrayBuffer[Int]()
abuf += 12
abuf += 15
println(abuf)

// Strings (via StringOps)
def hasUpperCase(s: String) = s.exists(_.isUpper)

// Sets and Maps
// Scala offers both mutable and immutable versions of sets and maps.
//             scala.collection
//                  Set/Map
//                <<trait>>
//                   ^
//     |-------------|-------------|
//  scala.collection.immutable    scala.collection.mutable
//     Set/Map                      Set/Map
//    <<trait>>                    <<trait>>
//      ^                            ^
//      |                            |
//  scala.collection.immutable    scala.collection.mutable
//   HashSet/HashMap               HashSet/HashMap
//
// to be able to continue to refer Set as immutable
import scala.collection.mutable
val mutSet = mutable.Set(1,2,3)
val immSet = Set(1,2,3)

val text = "See Spot run. Run, Spot. Run!"
val wordsArray = text.split("[ !,.]+")
val words = mutable.Set.empty[String]
for (word <- wordsArray)
  words += word.toLowerCase
println(words)

// common operations for sets.
// refer to pg. 384 (table 17.1) of Programming in Scala 2nd edition

val map = mutable.Map.empty[String, Int]
map("hello") = 1
map("there") = 2
println(map)

// count occurence of word
def countWords(text: String) = {
  val counts = mutable.Map.empty[String, Int]
  for (rawWord <- text.split("[ ,!.]+")) {
    val word = rawWord.toLowerCase
    val oldCount = if (counts.contains(word)) counts(word) else 0
    counts += (word -> (oldCount + 1))
  }
  counts
}
println(countWords("See Spot run! Run, Spot. Run!"))

// common operations for maps
// refer to pg. 386 (table 17.2) of Programming in Scala 2nd edition

// Ordered sets and maps
// SortedSet and SortedMap, these traists are implemented by classes TreeSet and TreeMap
import scala.collection.immutable.TreeSet
val ts = TreeSet(9, 3, 1, 8, 0, 2, 7, 4, 6, 5)
println(ts)
val cs = TreeSet('f', 'u', 'n')
println(cs)

import scala.collection.immutable.TreeMap
var tm = TreeMap(3 -> 'x', 1 -> 'x', 4 -> 'x')
println(tm)
tm += (2 -> 'x')
println(tm)

// immutable Set doesn't support +=
// but if we use var instead, it can be reassigned in terms of pointer.
// so this provide easy interop between mutable/immutable if we decide to switch in the code later on.

// specify type of collection
val stuff = mutable.Set[Any](42)
stuff += "abracadabra"
println(stuff)

// Initialize a collection with another collection
val colors = List("blue", "yellow", "red", "green")
import scala.collection.immutable.TreeSet
val treeSet = TreeSet[String]() ++ colors

// Converting between mutable and immutable set & maps
// Convert immutable TreeSet to mutable set and back again to an immutable one
val mutaSet = mutable.Set.empty ++= treeSet
val immutaSet = Set.empty ++ mutaSet

// Same technique for mutable and immutable maps
val muta = mutable.Map("i" -> 1, "ii" -> 2)
val immu = Map.empty ++ muta

// Tuples
def longestWord(words: Array[String]) = {
  var word = words(0)
  var idx = 0
  for (i <- 1 until words.length)
    if (words(i).length > word.length) {
      word = words(i)
      idx = i
    }
  (word, idx)
}

val longest = longestWord("The quick brown fox".split(" "))
println(longest)
// accessing using ._n start from index 1
val (word, idx) = longest
