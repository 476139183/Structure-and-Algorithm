func listnum(nums: [Int]) -> ListNode {
    let list = ListNode(0)
    var node = list
    for x in nums { node.next = ListNode(x); node = node.next! }
    return list.next!
}

func assertEqual(l1: ListNode?, l2: ListNode?) -> Void {
    var l1 = l1
    var l2 = l2
    while l1 != nil && l2 != nil {
        if l1!.val != l2!.val {
            break
        } else {
            l1 = l1!.next
            l2 = l2!.next
        }
    }
    
    assert(l1 == nil && l2 == nil)
}

let s = Solution()
assertEqual(l1: s.addTwoNumbers(listnum(nums: [7, 8, 9]), listnum(nums: [0, 9, 3])),
            l2: listnum(nums: [7, 7, 3, 1]))
assertEqual(l1: s.addTwoNumbers(listnum(nums: [1]), listnum(nums: [9, 9, 9])),
            l2: listnum(nums: [0, 0, 0, 1]))
