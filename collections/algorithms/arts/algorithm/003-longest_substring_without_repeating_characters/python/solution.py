class Solution(object):
    def lengthOfLongestSubstring(self, s):
        """
        :type s: str
        :rtype: int
        """
        alphabet = {}
        longest = 0
        i = 0
        j = 0

        for c in s:
            if c in alphabet:
                longest = max(longest, j - i)
                while i < alphabet[c]:
                    alphabet[s[i]] = 0
                    i += 1
            j += 1
            alphabet[c] = j

        return max(longest, j - i)