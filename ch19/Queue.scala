class Queue[T](
  private val leading: List[T],
  private val trailing: List[T]
) {
  private def mirror =
    if (leading.isEmpty)
      new Queue(trailing.reverse, Nil)
    else
      this
  def head = mirror.leading.head
  def tail = {
    val q = mirror
    new Queue(q.leading.tail, q.trailing)
  }
  def enqueue(x: T) =
    new Queue(leading, x :: trailing)
}

// efficient queue, but implementation is complex and exposed to client
// we can hide implementation by defining private
//
// class Queue[T] private (
//  private val leading: List[T],
//  private val trailing: List[T]
// )
//
// and then defining auxiliary constructor
// def this() = this(Nil, Nil)
// def this(elems: T*) = this(elems.toList,Nil)

// or we can do companion Object
object Queue {
  // constructs a queue with initial elements 'xs'
  def apply[T](xs: T*) = new Queue[T](xs.toList, Nil)
}

// by doing this client can create queues with
// Queue(1,2,3), and this will expands to Queue.apply(1,2,3)


