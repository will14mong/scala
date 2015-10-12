/*
BDD (Behavior-Driven Development)
The emphasis is on writing human readable specs of the expected code behavior
ScalaTest include several Traits - Spec, WordSpec, FlatSpec and FeatureSpec
In FlatSpec, we write tests as specifier clauses
*/

import org.scalatest.FlatSpec
import org.scalatest.matchers.ShouldMatchers
import Element.elem

class ElementSpec extends FlatSpec with ShouldMatchers {

  "A Uniform Element" should "have a width equal to the passed value" in {
    val ele = elem('x', 2, 3)
    ele.width should be (2)
  }

  it should "have a height equal to the passed value" in {
    val ele = elem('x', 2, 3)
    ele.height should be (3)
  }

  it should "throw an IAE if passed a negative width" in {
    an [IllegalArgumentException] should be thrownBy {
      elem('x', -2, 3)
    }
  }
}

/*
* Compile with:
scalac -cp scalatest_2.11-2.2.4.jar Element.scala ElementSpec.scala

* Run with:
bash-4.1$ scala -cp scalatest_2.11-2.2.4.jar org.scalatest.run ElementSpec
Run starting. Expected test count is: 3
ElementSpec:
A Uniform Element
- should have a width equal to the passed value
- should have a height equal to the passed value
- should throw an IAE if passed a negative width *** FAILED ***
  Expected exception java.lang.IllegalArgumentException to be thrown, but no exception was thrown. (ElementSpec.scala:25)
Run completed in 188 milliseconds.
Total number of tests run: 3
Suites: completed 1, aborted 0
Tests: succeeded 2, failed 1, canceled 0, ignored 0, pending 0
*** 1 TEST FAILED ***
*/
