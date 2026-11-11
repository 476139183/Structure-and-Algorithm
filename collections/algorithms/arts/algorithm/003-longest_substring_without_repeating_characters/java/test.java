class Test {
  public static void main(String[] args) {
    Solution s = new Solution();
    assert s.lengthOfLongestSubstring("helloworld") == 5;
    assert s.lengthOfLongestSubstring("dvdf") == 3;
    assert s.lengthOfLongestSubstring("abcabcbb") == 3;
  }
}