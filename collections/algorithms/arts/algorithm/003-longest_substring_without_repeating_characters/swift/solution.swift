class Solution {
  func lengthOfLongestSubstring(_ s: String) -> Int {
        var alphabet = [Character: Int]()
        var longest = 0
        var i = 0
        var j = 0
        
        for c in s {
            if alphabet[c] != nil {
                longest = max(longest, j - i)
                while i < alphabet[c]! {
                    alphabet[s[s.index(s.startIndex, offsetBy: i)]] = 0
                    i += 1
                }
            }
            j += 1
            alphabet[c] = j
        }
        
        return max(longest, j - i)
    }
}