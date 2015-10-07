#!/bin/sh
exec scala "$0" "$@"
!#

abstract class Element {
  def contents: Array[String]
  // parameterless methods are written without () . eg: def height(): Int = ...
  // uniform access principle, client code should not be affected by a decision to implement attribute as a field
  //   or a methods, we could change below implementation to fields by simply changing val to def
  // also calling parameterless method Array(1,2,3).toString or "abc".length
  // if the method has side effects, please use () at the end
  // field access might be slighly faster than method invocations because they are pre-computed when class initialized
  //   but might required extra mem space in Element object
  val height = contents.length
  val width = if (height == 0) 0 else contents(0).length
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

// overriding field needs keyword override
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
