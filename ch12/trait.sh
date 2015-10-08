#!/bin/sh
exec scala "$0" "$@"
!#

// defined as similar to class instead use the keyword trait
// one class can mix in any number of traits
// it does not declare a superclass in below example, hence it has default superclass of AnyRef
// it defines one concrete method named philosophize
trait Philosophical {
  def philosophize() {
    println("I consume memory, therefore I am!")
  }
}

class Frog extends Philosophical {
  override def toString = "green"
}

val frog = new Frog
println(frog)
frog.philosophize()

// also define a type
val phil: Philosophical = frog

class Animal
trait HasLegs

class NewFrog extends Animal with Philosophical with HasLegs {
  override def toString = "green"
  override def philosophize() {
    println("It ain't easy being " + toString + "!")
  }
}

val phrog: Philosophical = new NewFrog
phrog.philosophize()

// trait cannot have "class" parameters
// class Point(x: Int, y: Int) is fine
// but trait NoPoint(x:Int, y: Int) is not okay

// traints calls to super are dynamically bound.
// a call to super.toString in a class is known prior to the call
// but on traits, it depends and it is undefined when we define the trait

class Point(val x: Int, val y: Int)

trait Rectangular {
  def topLeft: Point
  def bottomRight: Point
  def left = topLeft.x
  def right = bottomRight.x
  def width = right - left
  // other geometric methods ...
}

// class Component can mix in this trait to get all the geometric methods provided by Rectangular
abstract class Component extends Rectangular {
  // other methods ...
}

// Rectangle itself can mix in the trait as well
class Rectangle(val topLeft: Point, val bottomRight: Point) extends Rectangular {
  // other methods ...
}

val rect = new Rectangle(new Point(1, 1), new Point(10, 10))
println("rect.left = " + rect.left)
println("rect.right = " + rect.right)
