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

/*
OTHER WAYS

If there's error in the above code, we wouldn't know what's the value, there's another way

assert(ele.width === 2)
with triple =, when it's failing we would see a message such as "3 did not equal 2" in the failure report

expect(2) {
  ele.width
}
with this expression we indicate that we expect the code between the curly braces to result in 2. so we'll see msg like
  "Expected 2, but got 3"
  
intercept[IllegalArgumentException] {
  elem('x', -2, 3)
}
if we want to check that a method throws an expected exception, we can use the above.
We'll get something like
Expected IllegalArgumentException to be thrown,
   but NegativeArraySizeException was thrown.
   
*/
