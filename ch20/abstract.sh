#!/bin/sh
exec scala "$0" "$@"
!#

// A member of a class or trait is abstract if the member does not have a complete definition in the class.
// Abstract members are intended to be implemented in subclasses of the class in which they are declared.

trait Abstract {
  type T
  def transform(x: T): T
  val initial: T
  var current: T
}

class Concrete extends Abstract {
  type T = String
  def transform(x: String) = x + x
  val initial = "hi"
  var current = initial
}

// 1. type
// type, define a short, descriptive alias for a type whose real name is more verbose.

// 2. Abstract vals
// val initial: String
// def initial: String

// in val it's field and obj.initial will always return the same value
// but in def, it's method and obj.initial will depends on the concrete implementation

// abstract class Fruit {
//   val v: String // ‘v’ for value
//   def m: String // ‘m’ for method
// }

// abstract class Apple extends Fruit {
//   val v: String
//   val m: String // OK to override a ‘def’ with a ‘val’
// }

// abstract class BadApple extends Fruit {
//    def v: String // ERROR: cannot override a ‘val’ with a ‘def’
//    def m: String
// }

// 3. Abstract vars

// trait AbstractTime {
//   var hour: Int
//   var minute: Int
// }

// we implicitly declaer and abstract getter method, hour
//   and an abstract setter method, hour_=
// got translated into:
//
// trait AbstractTime {
//   def hour: Int // getter for ‘hour’
//   def hour_=(x: Int) // setter for ‘hour’
//   def minute: Int // getter for ‘minute’
//   def minute_=(x: Int) // setter for ‘minute’
// }

// 4. Initializing abstract vals
// trait RationalTrait {
//   val numerArg = 1
//   val denomArg = 2
// }

// if we do
// new RationalTrait {
//   val numerArg = 1
//   val denomArg = 2
// }
// This will create instance of an anonymous class that mixes in the trait and is defined by the body
// Almost similar to -> new Rational(expr1, expr2)
// but on the second one, expr1 and expr2 are evaluated before class Rational is initialized.
// for traits however, it is opposite

// we can pre-initialized the fields using with keyword
// 4.1 pre-initialized fields in anonymous class
// new {
//   val numerArg = 1 * x
//   val denomArg = 2 * x
// } with RationalTrait

// 4.2 Pre-initialized fields in an object definition
// object thowThirds extends {
//   val numerArg = 2
//   val denomArg = 3  // here we are not allowed to access using this. eg: this.numerArg
// } with RationalTrait

// 4.3 Pre-initialized fields in a class definition
// class RationalClass(n: Int, d: Int) extends {
//   val numerArg = n
//   val denomArg = d
// } with RationalTrait {
//   def + (that: RationalClass) = new RationalClass(
//     numer * that.denom + that.numer * denom,
//    denom * that.denom
//   )
// }

// 5. Lazy vals
// object Demo {
//   lazy val x = { println("initializing x"); "done" }
// }

// x is lazy, the init of it will be done once on the first call.

// reformulate RationalTrait using lazy vals
trait LazyRationalTrait {
  val numerArg: Int
  val denomArg: Int
  lazy val numer = numerArg / g
  lazy val denom = denomArg / g
  override def toString = numer +"/"+ denom
  private lazy val g = {
    require(denomArg != 0)
    gcd(numerArg, denomArg)
  }
  private def gcd(a: Int, b: Int): Int = if (b == 0) a else gcd(b, a % b)
}

new LazyRationalTrait {
  val numerArg = 2
  val denomArg = 4
}

// note that the above is fine because it's using lazy eval, so we don't need with pre-init

// 6. Abstract types

// class Food
// abstract class Animal {
//   def eat(food: Food)
// }
// class Grass extends Food
// class Cow extends Animal {
//   override def eat(food: Grass) {} // This won't compile because func param is different for eat.
// }                               // but if it did, ...
// class Fish extends Food
// val bessy: Animal = new Cow
// bessy eat (new Fish)   // ... you could feed fish to cows

// instead, try using abstract types
class Food
abstract class Animal {
  type SuitableFood <: Food
  def eat(food: SuitableFood)
}
class Grass extends Food
class Cow extends Animal {
  type SuitableFood = Grass
  override def eat(food: Grass) {}
}

// now this will behave nicely

// 7. Path dependent types
class DogFood extends Food
class Dog extends Animal {
  type SuitableFood = DogFood
  override def eat(food: DogFood) {}
}
val bessy = new Cow
val lassie = new Dog
// bessy.SuitableFood is different than lassie.SuitableFood
val bootsie = new Dog
lassie eat(new bootsie.SuitableFood) // this is allowed

// 8. Structural Typing
// to define animal that eat grass
class Pasture {
  var animals: List[Animal { type SuitableFood = Grass }] = Nil
}

// another useful stuff that we want to do is to group together a number of classes
// that were written by someone else.
// let's try to generalize this:
// using(new PrintWriter("date.txt")) { writer =>
//   writer.println(new Date)
// }
// using(serverSocket.accept()) { socket =>
//   socket.getOutputStream().write("hello, world\n".getBytes)
// }

// Methods perform operation and then closes an object.
// takes 2 arguemnts: the operation and the object

def using[T <: { def close(): Unit }, S](obj: T)
    (operation: T => S) = {
  val result = operation(obj)
  obj.close()
  result
}

