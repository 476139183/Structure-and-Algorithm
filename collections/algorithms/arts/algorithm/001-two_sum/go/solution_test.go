package solution

import (
	"reflect"
	"testing"
)

func TestSolution(t *testing.T) {
	nums := []int{8, 0, 11, 5, 11, -13, 99}
	if !reflect.DeepEqual(twoSum(nums, -8), []int{3, 5}) {
		t.Error()
	}
	if !reflect.DeepEqual(twoSum(nums, 22), []int{2, 4}) {
		t.Error()
	}
	if !reflect.DeepEqual(twoSum(nums, 99), []int{1, 6}) {
		t.Error()
	}
}
