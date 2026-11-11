class Solution {
  fun lengthOfLongestSubstring(s: String): Int {
        val map = Array<Int>(127, {0})
        var longest = 0
        var i = 0 // 重复起始字符索引
        var j = 0

        for (c in s) {
            if (map[c.toInt()] > 0) {
                longest = Math.max(longest, j - i)
                while (i < map[c.toInt()]) {
                    map[s[i].toInt()] = 0
                    i++
                }
            }

            map[c.toInt()] = j + 1
            j++
        }

        return Math.max(longest, j - i)
    }
}