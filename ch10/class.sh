#!/bin/sh
exec scala "$0" "$@"
!#

abstract class Element {
  def contents: Array[String]
  // parameterless methods are written without () . eg: def height(): Int = ...
  // uniform access principle, client code should not be affected by a decision to implement attribute as a field
  //   or a methods, we could change below implementation to fields by simply changing def to val
  // also calling parameterless method Array(1,2,3).toString or "abc".length
  // if the method has side effects, please use () at the end
  // field access might be slighly faster than method invocations because they are pre-computed when class initialized
  //   but might required extra mem space in Element object
  def height = contents.length
  def width = if (height == 0) 0 else contents(0).length
}

// without extends, scala assume your class extends from scala.AnyRef
class ArrayElement(conts: Array[String]) extends Element {
  def contents: Array[String] = conts
}

// Inheritance
// - private members of super class are not inherited in a subclass
// - member of a superclass is not inherited if a member with the same name and parameters
//     is already implemented in the subclass
//   (for ex: contents method in ArrayElement overrides absctract method contents in class Element)

val ae = new ArrayElement(Array("hello", "world"))
println(ae.width)

// Subtyping means value of subclass can be used wherever a value of the superclas is required. eg:
val e: Element = new ArrayElement(Array("hello"))

// it is possible for a field to override a parameterless method.
class ArrayElementField(conts: Array[String]) extends Element {
  val contents: Array[String] = conts
}

// we CANNOT have method and field having a same name in scala as it can in java.
/*
class WontCompile {
  private var f = 0
  def f = 1
}
*/

// Java has 4 namepsaces => fields, methods, types and packages
// Scala has 2:
// - values (fields, methods, packages, and singleton objects)
// - types (class and trait names)

// repetitions of specifying conts can be solve by writing it as
// val means it is at the same time a parameter and field and not reassignable
class ArrayElementNew(
  val contents: Array[String]
) extends Element

// it is possible to add modifiers such as private, protected, or override to these parametric fields
// we can also prefix a class parameter with var
class Cat {
  val dangerous = false
}

class Tiger(
  override val dangerous: Boolean,
  private var age: Int
) extends Cat

/* the above definition is similar to
class Tiger(param1: Boolaen, param2: Int) extends Cat {
  override val dangerous = param1
  private var age = param2
}
*/
var tiger = new Tiger(true,10)
println("Tiger is " + tiger.dangerous)

// Invoking superclass constructors
// supose we want to implement LineElement, we can simply extend ArrayElement
// if width & height were implemented as val on Element , we should use override val otherwise it result in compile err
// val is considered stable value.
class LineElement(s: String) extends ArrayElementNew(Array(s)) {
  override val width = s.length
  override def height = 1
}

// override modifiers
// scala requires this for all members that override a concrete member in a parent class.
// the modifier is optional if a member implements an abstract member with the same name

// Polymorphism & Dynamic binding
class UniformElement(
  ch: Char,
  override val width: Int,
  override val height: Int
) extends Element {
  private val line = ch.toString * width
  def contents = Array.fill(height)(line)
}

// now we can define
val e1: Element = new ArrayElementNew(Array("hello","world"))
val aen: ArrayElementNew = new LineElement("hello")
val e2: Element = ae
val e3: Element = new UniformElement('x', 2, 3)
println(e3.height)
println(e3.width)
// take note that below will result in erro because ch is not defined as field
// println(e3.ch)

// call to method is determined at runtime in this case. take a look at dynamic.sh
// final modifier. take a look at final.sh

// When to use inheritance ?
// - whether it model an is-a relationship
// - whether clients will want to use the subclass type as a superclass type
// in the above case, it is better to define LineElement as direct subclass of Element
//                      Element << abstract >>
//                               ^
//                               |
//    +--------------------------+---------------------+
//    |                          |                     |
// ArrayElement            LineElement           UniformElement
// Take a look at inheritance.sh

