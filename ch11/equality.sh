#!/bin/sh
exec scala "$0" "$@"
!#

// equality operation is designed to be transparent with respect to the type representation
def isEqual(x: Int, y: Int) = x == y
println("isEqual(421, 421) = " + isEqual(421, 421))

def isEqual(x: Any, y: Any) = x == y
println("isEqual(421, 421) = " + isEqual(421, 421))

val x = "abcd".substring(2)
val y = "abcd".substring(2)
println("x == y = " + x == y)

// if we want to compare reference equality instead, use eq
val a = new String("abc")
val b = new String("abc")
println("a eq b = " + a eq b)
println("a ne b = " + a ne b)
