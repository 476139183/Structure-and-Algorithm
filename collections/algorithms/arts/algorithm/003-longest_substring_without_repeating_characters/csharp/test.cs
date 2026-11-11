using System;
using Xunit;

public class UnitTest {
  [Fact]
  public void Test() {
    Solution s = new Solution();
    Assert.Equal(s.lengthOfLongestSubstring("helloworld"), 5);
    Assert.Equal(s.lengthOfLongestSubstring("dvdf"), 3);
    Assert.Equal(s.lengthOfLongestSubstring("abcabcbb"), 3);
  }
}
