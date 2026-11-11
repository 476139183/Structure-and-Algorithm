class ListNode(var `val` : Int = 0) {
    var next: ListNode? = null
}

class Solution {
    fun addTwoNumbers(l1: ListNode?, l2: ListNode?): ListNode? {
        var sum : ListNode = ListNode(0)
        var head = sum
        var carry = 0

        var p = l1
        var q = l2
        while (p != null || q != null || carry > 0) {
            if (p != null) {
                sum.`val` += p.`val`
                p = p.next
            }

            if (q != null) {
                sum.`val` += q.`val`
                q = q.next
            }

            sum.`val` += carry
            carry = sum.`val` / 10
            sum .`val` %= 10

            if (p != null || q != null || carry > 0) {
                sum.next = ListNode(0)
                sum = sum.next!!
            }
        }

        return head
    }
}