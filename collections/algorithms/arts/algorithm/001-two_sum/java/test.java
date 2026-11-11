import java.util.Arrays;
class Test {
  public static void main(String[] args) {
    Solution s = new Solution();
    int[] nums = {8, 0, 11, 5, 11, -13, 99};
    assert Arrays.equals(s.twoSum(nums, -1), new int[]{3, 5});
    assert Arrays.equals(s.twoSum(nums, 22), new int[]{2, 4});
    assert Arrays.equals(s.twoSum(nums, 99), new int[]{1, 6});
  }
}