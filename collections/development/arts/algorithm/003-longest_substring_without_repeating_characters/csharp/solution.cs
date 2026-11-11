using System;

public class Solution {
    public int lengthOfLongestSubstring(string s) {
        int[] map = new int[127];
        int longest = 0;
        int i = 0; // 滑窗左边界
        int j = 0; // 滑窗右边界

        for ( ; j < s.Length; j++) {
            char c = s[j];
            if (map[c] > 0) {
                longest = Math.Max(longest, j - i);
                while (i < map[c]) {
                    map[s[i]] = 0;
                    i++;
                }
            }

            map[c] = j + 1;
        }

        return Math.Max(longest, j - i);
    }
}