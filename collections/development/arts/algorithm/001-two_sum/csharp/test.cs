using System;
using Xunit;

public class UnitTest {
  [Theory]
  [InlineData(new int[]{8, 0, 11, 5, 11, -13, 99}, -8, new int[2]{3, 5})]
  [InlineData(new int[]{8, 0, 11, 5, 11, -13, 99}, 22, new int[2]{2, 4})]
  [InlineData(new int[]{8, 0, 11, 5, 11, -13, 99}, 99, new int[2]{1, 6})]
  public void Test(int[] nums, int target, int[] indices) {
    Assert.Equal(new Solution().TwoSum(nums, target), indices);
  }
}
