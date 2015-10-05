// use trait, extends App
// need not write the main method, but we can't access the command-line arguments
import ChecksumAccumulator.calculate

object Seasons extends App {
  for (season <- List("fall", "winter", "spring"))
    println(season + ": " + calculate(season))
}
