object Test {
  def main(args: Array[String]): Unit = {
    assert(Solution.lengthOfLongestSubstring("helloworld") == 5)
    assert(Solution.lengthOfLongestSubstring("dvdf") == 3)
    assert(Solution.lengthOfLongestSubstring("abcabcbb") == 3)
  }
}