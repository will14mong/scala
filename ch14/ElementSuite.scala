import org.scalatest.Suite
import Element.elem

class ElementSuite extends Suite {
  def testUniformElement() {
    val ele = elem('x', 2, 3)
    assert(ele.width == 2)
  }
}

/*
* Download scalatest jar file from http://www.scalatest.org

* Compilations step:
scalac -cp scalatest_2.11-2.2.4.jar Element.scala ElementSuite.scala

* Running step:
scala -cp scalatest_2.11-2.2.4.jar org.scalatest.run ElementSuite
*/
