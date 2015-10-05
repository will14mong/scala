#!/bin/sh
exec scala "$0" "$@"
!#

// print all arguments
def formatArgs(args:Array[String]) = args.mkString("\n")
println(formatArgs(args))

// print length of line on the left followed by pipe and then the line
// eg: 56 | def formatArgs(args:Array[String]) = args.mkString("\n")
// usage ./functional.sh filename
import scala.io.Source
def widthOfLength(s: String) = s.length.toString.length
if (args.length > 0) {
  val lines = Source.fromFile(args(0)).getLines().toList
  val longestLine = lines.reduceLeft(
    (a, b) => if (a.length > b.length) a else b
  )
  val maxWidth = widthOfLength(longestLine)
  for (line <- lines) {
    val numSpaces = maxWidth - widthOfLength(line)
    val padding = " " * numSpaces
    println(padding + line.length + " | " + line)
  }
}
else
  Console.err.println("Please enter filename")
