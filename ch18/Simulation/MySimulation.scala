import org.stairwaybook.simulation._

object MySimulation extends CircuitSimulation {
  def InverterDelay = 1
  def AndGateDelay = 3
  def OrGateDelay = 5

  val input1, input2, sum, carry = new Wire

  def test = {
    probe("sum", sum)
    probe("carry", carry)
    halfAdder(input1, input2, sum, carry)
    input1 setSignal true
    run()
    input2 setSignal true
    run()
  }

  def main(args:Array[String]) {
    test
  }
}
