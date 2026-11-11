package solution

import (
	"testing"
)

func TestSolution(t *testing.T) {
	if findMedianSortedArrays([]int{}, []int{2, 3}) != 2.5 {
		t.Error()
	}

	if findMedianSortedArrays([]int{1, 2, 3}, []int{8, 9}) != 3 {
		t.Error()
	}
}
