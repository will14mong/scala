#!/bin/sh
exec scala "$0" "$@"
!#

// This script supposed to returns error

abstract class Element {
  def demo() {
    println("Element's implementation invoked")
  }
}

// we could also say the class is final (cannot be sub-classed)
// by adding final class ArrayElement ...
class ArrayElement extends Element {
  final override def demo() {
    println("ArrayElement's implmentation invoked")
  }
}

// this class cannot override demo method
class LineElement extends ArrayElement {
  override def demo() {
    println("LineElement's implementation invoked")
  }
}

class UniformElement extends Element

def invokeDemo(e: Element) {
  e.demo()
}

invokeDemo(new ArrayElement)
invokeDemo(new LineElement)
invokeDemo(new UniformElement)
