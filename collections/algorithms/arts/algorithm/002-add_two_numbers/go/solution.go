package solution

// ListNode singly-linked
type ListNode struct {
	Val  int
	Next *ListNode
}

func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
	sum := &ListNode{0, nil}
	head := sum
	carry := 0

	for l1 != nil || l2 != nil || carry > 0 {
		if l1 != nil {
			sum.Val += l1.Val
			l1 = l1.Next
		}

		if l2 != nil {
			sum.Val += l2.Val
			l2 = l2.Next
		}

		sum.Val += carry
		carry = sum.Val / 10
		sum.Val %= 10

		if l1 != nil || l2 != nil || carry > 0 {
			sum.Next = &ListNode{0, nil}
			sum = sum.Next
		}
	}

	return head
}
