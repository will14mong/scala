#!/bin/sh
exec scala "$0" "$@"
!#

// LOWER BOUNDS

class Queue[+T](
  private val leading: List[T],
  private val trailing: List[T]
) {
  private def mirror =
    if (leading.isEmpty)
      new Queue(trailing.reverse, Nil)
    else
      this
  def head = mirror.leading.head
  def tail = {
    val q = mirror
    new Queue(q.leading.tail, q.trailing)
  }
  def enqueue[U >: T](x: U) =
    new Queue[U](leading, x :: trailing)
}

// U >: T defines T as the lower bound for U

class Fruit(var calories: Int) { }

class Apple(var color: String,cal:Int)extends Fruit(cal) {
  def this(color: String) = this(color,100)
}

class Orange(cal: Int) extends Fruit(cal) { var color: String = "orange" }

val q1 = new Queue[Apple](List(new Apple("green")),Nil)
// q1 is Queue of type Apple
val q2 = q1.enqueue(new Orange(200))
// q2 is Queue of type Fruit
val q3 = q2.enqueue(new Fruit(100))
// q3 is Queue of type Fruit

// UPPER BOUNDS

// A Person class that mixes in the Ordered Trait
class Person(val firstName: String, val lastName: String) extends Ordered[Person] {
  def compare(that: Person) = {
    val lastNameComparison =
      lastName.compareToIgnoreCase(that.lastName)
    if (lastNameComparison != 0)
      lastNameComparison
    else
      firstName.compareToIgnoreCase(that.firstName)
  }
  override def toString = firstName +" "+ lastName
}

def orderedMergeSort[T <: Ordered[T]](xs: List[T]): List[T] = {
  def merge(xs: List[T], ys: List[T]): List[T] =
    (xs, ys) match {
      case (Nil, _) => ys
      case (_, Nil) => xs
      case (x :: xs1, y :: ys1) =>
        if (x < y) x :: merge(xs1, ys)
        else y :: merge(xs, ys1)
    }
  val n = xs.length / 2
  if (n == 0) xs
  else {
    val (ys, zs) = xs splitAt n
    merge(orderedMergeSort(ys), orderedMergeSort(zs))
  }
}

// Upper bound is specified with <: instead of >:
// With "T <: Ordered[T]" syntax, it means
// type parameter, T, has an upper bound, Ordered[T].
//  element type of the list passed to orderedMergeSort must be a subtype of Ordered.

val people = List(
new Person("Larry", "Wall"),
new Person("Anders", "Hejlsberg"),
new Person("Guido", "van Rossum"),
new Person("Alan", "Kay"),
new Person("Yukihiro", "Matsumoto")
)

val sortedPeople = orderedMergeSort(people)
for (i <- sortedPeople) println(i)

// val wontCompile = orderedMergeSort(List(3, 2, 1))
