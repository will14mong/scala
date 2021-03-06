* Two ways to create package:

```scala
package bobsrockets.navigation
class Navigator
```
or
```scala
package bobsrockets.navigation {
  class Navigator
}
```

* Multiple packages in the same file
```scala
package bobsrockets {
  package navigation {
    // In package bobsrockets.navigation
    class Navigator
    package tests {
      // In package bobsrockets.navigation.tests
      class NavigatorSuite
    }
  }
}
```

* Concise access to classes and packages
```scala
package bobsrockets {
  package navigation {
    class Navigator {
    // No need to say bobsrockets.navigation.StarMap
    val map = new StarMap
    }
    class StarMap
  }

  class Ship {
    // No need to say bobsrockets.navigation.Navigator
    val nav = new navigation.Navigator
  }

  package fleets {
    class Fleet {
      // No need to say bobsrockets.Ship
      def addShip() { new Ship }
    }
  }
}
```

* Symbols in enclosing packages not automatically available
```scala
package bobsrockets {
  class Ship
}

package bobsrockets.fleets {
  class Fleet {
    // Doesn't compile! Ship is not in scope.
    def addShip() { new Ship }
  }
}
```

* Accessing hidden package names
```scala
// In file launch.scala
package launch {
  class Booster3
}

// In file bobsrockets.scala
package bobsrockets {
  package navigation {
    package launch {
     class Booster1
    }
    class MissionControl {
      val booster1 = new launch.Booster1
      val booster2 = new bobsrockets.launch.Booster2
      val booster3 = new _root_.launch.Booster3
    }
  }
  package launch {
    class Booster2
  }
}
```

