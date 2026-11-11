using System;
using Xunit;

public class UnitTest {
  [Theory]
  [InlineData(new int[0], new []{2, 3}, 2.5)]
  [InlineData(new []{1, 2, 3}, new []{8, 9}, 3)]
  public void Test(int[] nums1, int[] nums2, double median) {
    // Assert.Equal(s.FindMedianSortedArrays(new []{0}, new []{2, 3}), 2.5);
    Assert.Equal(new Solution().FindMedianSortedArrays(nums1, nums2), median);
  }
}
