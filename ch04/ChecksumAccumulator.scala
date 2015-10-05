class ChecksumAccumulator {
  // by default fields is public unless we specify private on it
  private var sum = 0
  // def add(b: Byte): Unit = sum+=b
  // the function above is executed for side effect, hence same as procedure, so
  // we can re-write as below
  def add(b: Byte) { sum+=b }
  def checksum(): Int = ~(sum & 0xFF) + 1
}


// Singleton, use object keyword
import scala.collection.mutable.Map

// Singleton share same name with class, this is called class's companion object
// vice-verasa, the class is called the companion class of the singleton object
object ChecksumAccumulator {
  private val cache = Map[String, Int]()
  def calculate(s: String): Int =
    if (cache.contains(s))
      cache(s)
    else {
      val acc = new ChecksumAccumulator
      for (c <- s)
        acc.add(c.toByte)
      val cs = acc.checksum()
      cache += (s -> cs)
      cs
    }
}
