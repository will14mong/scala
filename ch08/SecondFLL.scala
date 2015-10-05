// second iteration
// we can define local function instead of private function for processLine
// once compiled, run
// scala FindLongLines 40 SecondFLL.scala
// this will only output those lines > 40 chars
import scala.io.Source

object LongLines {
  def processFile(filename: String, width: Int) {

    def processLine(line: String) {
      if (line.length > width)
        println(filename + ": " + line)
    }

    val source = Source.fromFile(filename)
    for (line <- source.getLines())
      processLine(filename, width, line)
  }

}

object FindLongLines {
  def main(args: Array[String]) {
    val width = args(0).toInt
    for (arg <- args.drop(1))
      LongLines.processFile(arg,width)
  }
}
