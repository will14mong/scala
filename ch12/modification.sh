#!/bin/sh
exec scala "$0" "$@"
!#

// Traits can modify the methods of a class and allow us to stack those modifications with each other
// Consider stacking modifications to queue of integers.
// Given a class that implement  put & get, we could define traits to perform modifications such as these:
// - Doubling : double all integers that are put in the queue
// - Incrementing : increment all integers that are put in the queue
// - Filtering : filter out negative integers from a queue

abstract class IntQueue {
  def get(): Int
  def put(x: Int)
}

import scala.collection.mutable.ArrayBuffer

class BasicIntQueue extends IntQueue {
  private val buf = new ArrayBuffer[Int]
  def get() = buf.remove(0)
  def put(x: Int) { buf += x }
  override def toString = buf.toString()
}

val queue = new BasicIntQueue
println("Insert 10 into queue")
queue.put(10)
println("Insert 20 into queue")
queue.put(20)
println("Now queue contains")
println(queue)
println("Get the first in the queue")
println(queue.get())
println("Now queue contains")
println(queue)

// define trait Doubling
// it extends IntQueue which means that the trait can only be mixed into a class that also extends IntQueue
// why use abstract on method? because it override abstract class which means the class that use Doubling trait has to implement the put method
trait Doubling extends IntQueue {
  abstract override def put(x: Int) { super.put(2 * x) }
}

println("Define doubleq with Doubling trait")
class MyQueue extends BasicIntQueue with Doubling
val doubleq = new MyQueue
println("Insert 10 into doubleq")
doubleq.put(10)
println("Now doubleq contains")
println(doubleq)

// We can also say
println("Define doubleq2 with Doubling trait")
val doubleq2 = new BasicIntQueue with Doubling
println("Insert 10 into doubleq2")
doubleq2.put(10)
println("Now doubleq2 contains")
println(doubleq2)

// Let define another trait Incrementing and Filtering
trait Incrementing extends IntQueue {
  abstract override def put(x: Int) { super.put(x + 1) }
}

trait Filtering extends IntQueue {
  abstract override def put(x: Int) {
    if (x >= 0) super.put(x)
  }
}

println("Define newqueue with Incrementing and Filtering traits")
val newqueue = new BasicIntQueue with Incrementing with Filtering
println("Insert -1 into newqueue")
newqueue.put(-1)
println("Insert 0 into newqueue")
newqueue.put(0)
println("Insert 1 into newqueue")
newqueue.put(1)
println("Now newqueue contains")
println(newqueue)

// The rule is:
// - the method in the trait furthest to the right is called first
// - if that method calls super, it invokes the method in the next trait to it left and so on
