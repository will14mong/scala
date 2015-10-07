#!/bin/sh
exec scala "$0" "$@"
!#

// using factory to create a new element.
// benefit is client need not use new to directly create the object and it also hide details
// one solution is to create a companion object of class Element and make this factory object for layout elements
// now ArrayElement, UniformElement, LineElement can be private inside Element object
//   in scala, we can define classes and singleton ojbects inside other classes and singleton objects

object Element {

  def elem(contents: Array[String]): Element =
    new ArrayElement(contents)

  def elem(chr: Char, width: Int, height: Int): Element =
    new UniformElement(chr, width, height)

  def elem(line: String): Element =
    new LineElement(line)

  private class ArrayElement(
    val contents: Array[String]
  ) extends Element

  private class UniformElement(
    ch: Char,
    override val width: Int,
    override val height: Int
  ) extends Element {
    private val line = ch.toString * width
    def contents = Array.fill(height)(line)
  }

  private class LineElement(s: String) extends Element {
    val contents = Array(s)
    override def width = s.length
    override def height = 1
  }

}

import Element.elem

abstract class Element {
  def contents: Array[String]
  def height = contents.length
  def width = if (height == 0) 0 else contents(0).length

  def above(that: Element): Element = {
    val this1 = this widen that.width
    val that1 = that widen this.width
    elem(this1.contents ++ that1.contents)
  }

  def beside(that: Element): Element = {
    val this1 = this heighten that.height
    val that1 = that heighten this.height
    elem(
      for (
        (line1, line2) <- this1.contents zip that1.contents
      ) yield line1 + line2
    )
  }

  override def toString = contents mkString "\n"

  def widen(w: Int): Element =
    if (w <= width) this
    else {
      val left = elem(' ',(w - width) / 2, height)
      val right = elem(' ', w  - width - left.width, height)
      left beside this beside right
    }

  def heighten(h: Int): Element =
    if (h <= height) this
    else {
      val top = elem(' ', width, (h - height) / 2)
      val bot = elem(' ', width, h - height - top.height)
      top above this above bot
    }
}

val a: Element = Element.elem(Array("hello"))
val b: Element = Element.elem(Array("world !"))
val c: Element = Element.elem(Array(" ---- "))

println(c beside (a above b))
