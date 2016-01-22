class Publication(val title: String)
class Book(title: String) extends Publication(title)

object Library {
  val books: Set[Book] =
    Set(
      new Book("Programming in Scala"),
      new Book("Walden")
    )
  def printBookList(info: Book => AnyRef) {
    for (book <- books) println(info(book))
  }
}

object Customer extends App {
  def getTitle(p: Publication): String = p.title
  Library.printBookList(getTitle)
}

/*
Whenever we write function type A => B, scala expands this to Function1[A, B]
This is a definition in the standard library

trait Function1[-S,+T] {
  def apply(x: S): T
}

contravariant in function argument type S
covariant in the result type T

arg type                                result type
 Book           Book => AnyRef            AnyRef
  |                   ^                     ^
  V                   |                     |
Publication   Publication => String      String

*/
