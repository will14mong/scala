// An alternative: private class

trait Queue[T] {
  def head: T
  def tail: Queue[T]
  def enqueue(x: T): Queue[T]
}
object Queue {
  def apply[T](xs: T*): Queue[T] =
    new QueueImpl[T](xs.toList, Nil)

  private class QueueImpl[T](
    private val leading: List[T],
    private val trailing: List[T]
  ) extends Queue[T] {

    def mirror =
      if (leading.isEmpty)
        new QueueImpl(trailing.reverse, Nil)
      else
    this

    def head: T = mirror.leading.head

    def tail: QueueImpl[T] = {
      val q = mirror
      new QueueImpl(q.leading.tail, q.trailing)
    }

    def enqueue(x: T) =
      new QueueImpl(leading, x :: trailing)
  }
}

// Queue is a trait , not a type
// so we cannot use it as type
// def doesNotCompile(q: Queue) {}
// but trait allows us to specify parameterized types,
// def doesCompile(q: Queue[AnyRef]) {}
// hence Queue is trait, Queue[String] is a type

// Covariant, if S is a subtype of type T , then Queue[S] be considered a subtype of Queue[T]
// That is fine provided we change the definition of trait into:
// trait Queue[+T] { ... }
// or we can use - to say contravariant, if T is subtype of S, then Queue[S] is a subtype of Queue[T]

// Array is non-covariant in scala
// to cast we can use
// val a1=Array("abc")
// val a2: Array[Object] = a1.asInstanceOf[Array[Object]]
