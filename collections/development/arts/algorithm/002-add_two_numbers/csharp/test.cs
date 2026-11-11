using System;
using Xunit;

public class UnitTest {
  [Theory]
  [InlineData](new int[][]{{7, 8, 9}, {0, 9, 3}}, new int[]{7, 7, 3, 1})
  [InlineData](new int[][]{{1}, {9, 9, 9}}, new int[]{0, 0, 0, 1})
  public void Test(int[][] nums, int[] target) {
    Assert.Equal(new Solution().AddTwoNumbers())
  }

  public ListNode listnum(int[] nums) {
    
  }
}
