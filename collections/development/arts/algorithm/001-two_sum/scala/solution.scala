import scala.collection.immutable.HashMap

object Solution {
  def twoSum(nums: Array[Int], target: Int): Array[Int] = {
    var complements = HashMap.empty[Int, Int]
    var i = 0
    while (!complements.contains(target - nums(i))) {
      complements += (nums(i) -> i)
      i += 1
    }

    Array(complements(i), i)
  }
}