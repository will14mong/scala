import org.scalatest.FunSuite
import Element.elem

class ElementSuiteFun extends FunSuite {
  test("elem result should have passed width") {
    val ele = elem('x', 2, 3)
    assert(ele.width == 2)
  }

  test("something else") {
    assert(1 == 1)
  }
}

/*
* Compile with:
scalac -cp scalatest_2.11-2.2.4.jar Element.scala ElementSuiteFun.scala

* Run with:
scala -cp scalatest_2.11-2.2.4.jar org.scalatest.run ElementSuiteFun
Run starting. Expected test count is: 2
ElementSuiteFun:
- elem result should have passed width
- something else
Run completed in 146 milliseconds.
Total number of tests run: 2
Suites: completed 1, aborted 0
Tests: succeeded 2, failed 0, canceled 0, ignored 0, pending 0
All tests passed.
*/
