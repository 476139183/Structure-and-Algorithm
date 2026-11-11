using System;
using Xunit;

public class UnitTest {
  [Theory]
  [InlineData("PAYPALISHIRING", 4, "PINALSIGYAHRPI")]
  public void Test(string s, int numRows, string converted) {
    Assert.Equal(new Solution().Convert(s, numRows), converted);
  }
}
