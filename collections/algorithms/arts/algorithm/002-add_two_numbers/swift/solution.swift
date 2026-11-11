public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var sum = ListNode(0)
        let head = sum
        var carry = 0
        
        var l1 = l1
        var l2 = l2
        while (l1 != nil) || (l2 != nil) || carry > 0 {
            if l1 != nil {
                sum.val += l1!.val
                l1 = l1!.next
            }
            
            if l2 != nil {
                sum.val += l2!.val
                l2 = l2!.next
            }
            
            sum.val += carry
            carry = sum.val / 10
            sum.val %= 10
            
            if l1 != nil || l2 != nil || carry > 0 {
                sum.next = ListNode(0)
                sum = sum.next!
            }
        }
        
        return head
    }
}