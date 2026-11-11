object Solution {
  def lengthOfLongestSubstring(s: String): Int = {
    val alphabet = new Array[Int](127)
    var longest = 0
    var i = 0
    var j = 0

    s.foreach( c => {
      if (alphabet(c) > 0) {
        longest = math.max(longest, j - i)
        while (i < alphabet(c)) {
          alphabet(s(i)) = 0
          i += 1
        }
      }

      j += 1
      alphabet(c) = j
    })

    return math.max(longest, j - i)
  }
}