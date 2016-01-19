#!/bin/sh
exec scala "$0" "$@"
!#

abstract class Expr
case class Var(name: String) extends Expr
case class Number(num: Double) extends Expr
case class UnOp(operator: String, arg: Expr) extends Expr
case class BinOp(operator: String, left: Expr, right: Expr) extends Expr

// Benefit with case keyword:
// First, scala compiler add convenience to the class such as factory method with the name of the class.
// we can say Var("x") instead of new Var("x")
val v = Var("x")

// particularly nice if we nest them
val op = BinOp("+", Number(1), v)

// Second, all arguments in the param list of a case class implicitly get a val prefix
// so they are maintained as fields
println("v.name = " + v.name)
println("op.left = " + op.left)

// Third, it add natural implementation of toString, hasCode and equals to the class.
println("op is " + op)
println("op.right == Var(\"x\") => " + (op.right == Var("x")))

// Finally, the compiler adds a copy method to your class for making modified copies.
// This is useful for making a new instance of the class that is the same as another one
//   except that one or two attributes are different.
println("copied op is : " + op.copy(operator = "-"))
println("op is still  : " + op)

// The biggest advantange of case classes is that it supports Pattern Matching
def simplifyTop(expr: Expr): Expr = expr match {
  case UnOp("-", UnOp("-", e)) => e     // Double negation
  case BinOp("+", e, Number(0)) => e    // Adding zero
  case BinOp("*", e, Number(1)) => e    //Multiping by one
  case _ => expr
}

println("simplify UnOp(\"-\", UnOp(\"-\", Var(\"x\"))) => " + simplifyTop(UnOp("-", UnOp("-", Var("x")))))
println("simplify UnOp(\"-\",Var(\"y\")) => " + simplifyTop(UnOp("-",Var("y"))))
