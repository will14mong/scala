// Scala application, make use of ChecksumAccumulator
// compile this app using: scalac Summer.scala
// and then run: scala Summer hello world
import ChecksumAccumulator.calculate

object Summer {
  // we have to define main for scala app
  def main(args: Array[String]) {
    for (arg <- args)
      println(arg + ":" + calculate(arg))
  }
}
