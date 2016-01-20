#!/bin/sh
exec scala "$0" "$@"
!#

def msort[T](less: (T, T) => Boolean)(xs: List[T]): List[T] = {
  def merge(xs: List[T], ys: List[T]): List[T] =
    (xs, ys) match {
      case (Nil, _) => ys
      case (_, Nil) => xs
      case (x :: xs1, y :: ys1) =>
        if (less(x, y)) x :: merge(xs1, ys)
        else y :: merge(xs, ys1)
    }
  val n = xs.length / 2
  if (n == 0) xs
  else {
    val (ys, zs) = xs splitAt n
    merge(msort(less)(ys), msort(less)(zs))
  }
}

println(msort((x:Int, y:Int) => x < y)(List(5,7,1,3)))
// or in a short form
msort[Char](_ > _)(List("a","d","b"))

// Currying, create a new specialized function
val intSort = msort((x: Int, y: Int) => x < y) _

