import java.util.Arrays;

fun main(args: Array<String>) {
  val s = Solution()
  val nums: IntArray = intArrayOf(8, 0, 11, 5, 11, -13, 99)

  assert(Arrays.equals(s.twoSum(nums, -8), intArrayOf(3, 5)))
  assert(Arrays.equals(s.twoSum(nums, 22), intArrayOf(2, 4)))
  assert(Arrays.equals(s.twoSum(nums, 99), intArrayOf(1, 6)))
}