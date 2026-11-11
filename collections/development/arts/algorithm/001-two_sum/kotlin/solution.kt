class Solution {
  fun twoSum(nums: IntArray, target: Int): IntArray {
    val complements = HashMap<Int, Int>()
    for (i in nums.indices) {
      var c : Int = target - nums[i]
      if (complements.containsKey(c)) {
        return intArrayOf(complements[c]!!, i)
      } else {
        complements.put(nums[i], i)
      }
    }

    return intArrayOf()
  }
}