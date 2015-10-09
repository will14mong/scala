package printmenu
import bobsdelights.Fruits
import bobsdelights.showFruit

object PrintMenu {
  def main(args: Array[String]) {
    for (fruit <- Fruits.menu) {
      showFruit(fruit)
    }
  }
}

// Run it after compile with scala printmenu.PrintMenu
