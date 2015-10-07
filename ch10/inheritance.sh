#!/bin/sh
exec scala "$0" "$@"
!#

//                   Element << abstract >>
//                            ^
//                            |
//    +-----------------------+---------------------+
//    |                       |                     |
// ArrayElement         LineElement        UniformElement

abstract class Element {
  def contents: Array[String]
  def height = contents.length
  def width = if (height == 0) 0 else contents(0).length

  // assume element of same length placed on top
  def above(that: Element): Element =
    new ArrayElement(this.contents ++ that.contents)

  // assume element of same width
  def beside(that: Element): Element = {
    new ArrayElement(
      for (
        (line1, line2) <- this.contents zip that.contents
      ) yield line1 + line2
    )
  }

  override def toString = contents mkString "\n"

}

class ArrayElement(
  val contents: Array[String]
) extends Element

class UniformElement(
  ch: Char,
  override val width: Int,
  override val height: Int
) extends Element {
  private val line = ch.toString * width
  def contents = Array.fill(height)(line)
}

class LineElement(s: String) extends Element {
  val contents = Array(s)
  override def width = s.length
  override def height = 1
}

/* method implementation of Element

// assume element of same length placed on top
def above(that: Element): Element =
  new ArrayElement(this.contents ++ that.contents)

// assume element of same width
def beside(that: Element): Element = {
  val contents = new Array[String](this.contents.length)
  for (i <- 0 until this.contents.length)
    contents(i) = this.contents(i) + that.contents(i)
  new ArrayElement(contents)
}

// beside can be implemented better
// zip transform two array into array of pairs (1,2,3) zip (4,5,6) -> ((1,4),(2,5),(3,6))
// line1 + line2 simply adding up the string
def besideNew(that: Element): Element = {
  new ArrayElement(
    for (
      (line1, line2) <- this.contents zip that.contents
    ) yield line1 + line2
  )
}

*/

val a: Element = new ArrayElement(Array("hello","world"))
println(a)
val b: Element = new UniformElement('-',5,1)
println(b)

println("testing above")
println(b.above(a))
println("testing beside")
println(b beside a)
