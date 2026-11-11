object Test {
  def main(args: Array[String]): Unit = {
    val nums: Array[Int] = Array(8, 0, 11, 5, 11, -13, 99)
    assert(Solution.twoSum(nums, -8).deep == Array(3, 5).deep)
    //assert(Solution.twoSum(nums, 22).deep == Array(2, 4).deep)
    //assert(Solution.twoSum(nums, 99).deep == Array(1, 6).deep)
    
  }
}