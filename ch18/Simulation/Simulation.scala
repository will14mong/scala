package org.stairwaybook.simulation

abstract class Simulation {
  // alias Action to be type of procedure that takes an empty parameter list and returns  Unit
  type Action = () => Unit
  case class WorkItem(time: Int, action: Action)
  private var curtime = 0

  def currentTime: Int = curtime

  private var agenda: List[WorkItem] = List()

  private def insert(ag: List[WorkItem], item: WorkItem): List[WorkItem] = {
    if (ag.isEmpty || item.time < ag.head.time) item :: ag
    else ag.head :: insert(ag.tail, item)
  }

  def afterDelay(delay: Int)(block: => Unit) {
    val item = WorkItem(currentTime + delay, () => block)
    agenda = insert(agenda, item)
  }

  // notice that we never handle case where agenda is empty
  // because that is handled by the run method
  // compiler will warn but since we have @unchecked, we are good
  private def next() {
    (agenda: @unchecked) match {
      case item :: rest =>
        agenda = rest
        curtime = item.time
        item.action()
    }
  }

  def run() {
    afterDelay(0) {
      println("*** simulation started, time = "+ currentTime +" ***")
    }
    while (!agenda.isEmpty) next()
  }
}
