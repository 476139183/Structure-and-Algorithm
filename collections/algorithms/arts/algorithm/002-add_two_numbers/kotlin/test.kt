fun listnum(nums: IntArray): ListNode? {
    var list = ListNode(0)
    var node = list
    for (x in nums) {
        node.next = ListNode(x)
        node = node.next!!
    }

    return list.next
}

fun assertEqual(l1: ListNode?, l2: ListNode?) {
    var p = l1
    var q = l2

    while (p != null && q != null) {
        if (p.`val` != q.`val`) {
            break
        } else {
            p = p.next
            q = q.next
        }
    }

    assert(p == null && q == null)
}

fun main(args: Array<String>) {
    val s = Solution()
    var l1 = listnum(intArrayOf(7, 8, 9))
    var l2 = listnum(intArrayOf(0, 9, 3))
    var lsum = listnum(intArrayOf(7, 7, 3, 1))
    assertEqual(s.addTwoNumbers(l1, l2), lsum)

    l1 = listnum(intArrayOf(1))
    l2 = listnum(intArrayOf(9, 9, 9))
    lsum = listnum(intArrayOf(0, 0, 0, 1))
    assertEqual(s.addTwoNumbers(l1, l2), lsum)
}