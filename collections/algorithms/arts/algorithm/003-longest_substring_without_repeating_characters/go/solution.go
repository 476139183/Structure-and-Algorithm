package solution

func max(n1 int, n2 int) int {
	if n1 > n2 {
		return n1
	}
	return n2
}

func lengthOfLongestSubstring(s string) int {
	var alphabet = [127]int{0}
	var longest = 0
	var i = 0
	var j = 0

	for j = 0; j < len(s); j++ {
		var c = s[j]
		if alphabet[c] > 0 {
			longest = max(longest, j-i)
			for ; i < alphabet[c]; i++ {
				alphabet[s[i]] = 0
			}
		}

		alphabet[c] = j + 1
	}

	return max(longest, j-i)
}
