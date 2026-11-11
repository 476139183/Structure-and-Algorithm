class Solution {
  public int lengthOfLongestSubstring(String s) {
    int[] map = new int[127];
    int longest = 0;
    int i = 0; // 滑窗左边界
    int j = 0; // 滑窗右边界

    for ( ; j < s.length(); j++) {
      char c = s.charAt(j);
      if (map[c] > 0) {
        longest = Math.max(longest, j - i);
        while (i < map[c.toInt()]) {
          map[s[i].toInt()] = 0
          i++
        }
      }

      map[c] = j + 1;
    }

    return Math.max(longest, j - i);
  }
}