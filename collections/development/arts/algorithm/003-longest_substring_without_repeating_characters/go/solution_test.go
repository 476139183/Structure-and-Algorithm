package solution

import (
	"testing"
)

func TestSolution(t *testing.T) {
	if lengthOfLongestSubstring("helloworld") != 5 {
		t.Error()
	}
	if lengthOfLongestSubstring("dvdf") != 3 {
		t.Error()
	}
	if lengthOfLongestSubstring("abcabcbb") != 3 {
		t.Error()
	}
}
