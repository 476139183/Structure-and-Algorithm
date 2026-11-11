package solution

import (
	"testing"
)

func listnum(nums []int) *ListNode {
	var list = &ListNode{0, nil}
	var node = list

	for _, x := range nums {
		node.Next = &ListNode{x, nil}
		node = node.Next
	}

	return list.Next
}

func assertEqual(l1 *ListNode, l2 *ListNode) bool {
	for l1 != nil && l2 != nil {
		if l1.Val != l2.Val {
			break
		} else {
			l1 = l1.Next
			l2 = l2.Next
		}
	}

	return l1 != nil || l2 != nil
}

func TestSolution(t *testing.T) {
	if assertEqual(addTwoNumbers(listnum([]int{7, 8, 9}), listnum([]int{0, 9, 3})), listnum([]int{7, 7, 3, 1})) {
		t.Error()
	}

	if assertEqual(addTwoNumbers(listnum([]int{1}), listnum([]int{9, 9, 9})), listnum([]int{0, 0, 0, 1})) {
		t.Error()
	}
}
