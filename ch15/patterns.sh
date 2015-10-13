#!/bin/sh
exec scala "$0" "$@"
!#

abstract class Expr
case class Var(name: String) extends Expr
case class Number(num: Double) extends Expr
case class UnOp(operator: String, arg: Expr) extends Expr
case class BinOp(operator: String, left: Expr, right: Expr) extends Expr

// PATTERN GUARD
/*
We want to transform e + e into e * 2
BinOp("+", Var("x"), Var("x"))
BinOp("*", Var("x"), Number(2))

def simplifyAdd(e: Expr) = e match {
  case BinOp("+", x, x) => BinOp("*", x, Number(2))
  case _ => e
}

The above will result in error because we can't use x again the second tiem in a patern
We can reformulate with pattern guard
*/

def simplifyAdd(e: Expr) = e match {
  case BinOp("+", x, y) if x == y =>
    BinOp("*", x, Number(2))
  case _ => e
}

println(simplifyAdd(BinOp("+", Var("x"), Var("x"))))

/*
Other example

// match only positive integers
case n: Int if 0 < n => ...

// match only strings starting with the letter 'a'
case s: String if s(0) == 'a' => ...
*/

// PATTERN OVERLAPS
// Patterns are tried in the order in which they are written.
// Orders matter in the below cases

def simplifyAll(expr: Expr): Expr = expr match {
  case UnOp("-", UnOp("-", e)) => simplifyAll(e)        // '-' is its own inverse
  case BinOp("+", e, Number(0)) => simplifyAll(e)       // '0' is a neutral element for '+'
  case BinOp("*", e, Number(1)) => simplifyAll(e)       // '1' is a neutral element for '*'
  case UnOp(op, e) => UnOp(op, simplifyAll(e))
  case BinOp(op, l, r) => BinOp(op, simplifyAll(l), simplifyAll(r))
  case _ => expr
}
