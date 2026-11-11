class Solution {
  public String longestPalindrome(String s) {
    int length = s.length();
    int start = 0;
    int end = 0;
    for (int i = 0; i < length; ) {
      int l = i;
      while (++i < length && s.charAt(l) == s.charAt(i));
      int r = i - 1;

      while (l >= 0 && r < length && s.charAt(l) == s.charAt(r)) {
        l--;
        r++;
      }

      l++;
      if ((r - l) > (end - start)) {
        start = l;
        end = r;
      }
    }

    return s.substring(start, end);
  }
}