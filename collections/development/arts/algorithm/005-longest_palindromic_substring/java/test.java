class Test {
  public static void main(String[] args) {
    Solution s = new Solution();
    assert s.longestPalindrome("aaabaaaa").equals("aaabaaa");
    assert s.longestPalindrome("abc").equals("a");
    assert s.longestPalindrome("").equals("");
  }
}