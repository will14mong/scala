class Rational(n: Int, d: Int) extends Ordered[Rational] {

  // pre-condition of primary constructor
  require(d != 0)
  private val g = gcd(n.abs, d.abs)

  // exposing n & d
  val numer: Int = n/g
  val denom: Int = d/g

  // auxiliary constructor, has to call primary constructor eventually
  def this(n: Int) = this(n, 1)

  // overriding function using override keyword
  override def toString = numer + "/" + denom

  // private function to normalize n & d
  private def gcd(a: Int, b: Int): Int =
    if (b==0) a else gcd(b, a%b)

  def + (that: Rational): Rational =
    new Rational(
      numer * that.denom + that.numer * denom,
      denom * that.denom
    )
  def + (i: Int): Rational =
    new Rational(numer + i* denom, denom)

  def - (that: Rational): Rational =
    new Rational (
      numer * that.denom - that.numer * denom,
      denom * that.denom
    )
  def - (i: Int): Rational =
    new Rational(numer - i * denom, denom)

  def * (that: Rational): Rational =
    new Rational(numer * that.numer, denom * that.denom)
  def * (i: Int): Rational =
    new Rational(numer * i,denom)

  def / (that: Rational): Rational =
    new Rational(numer * that.denom, denom * that.numer)
  def / (i: Int): Rational =
    new Rational(numer, denom * i)

  def max(that: Rational) =
    if (this < that) that else this

  def compare(that: Rational) = (this.numer * that.denom) - (that.numer * this.denom)
}
