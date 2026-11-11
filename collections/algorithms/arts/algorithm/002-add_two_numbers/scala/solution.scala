class ListNode(var _x: Int = 0) {
  var next: ListNode = null
  var x: Int = _x
}

object Solution {
  def addTwoNumbers(l1: ListNode, l2: ListNode): ListNode = {
    var sum = new ListNode(0)
    val head = sum
    var carry = 0

    var p = l1
    var q = l2
    while (p != null || q != null || carry > 0) {
      if (p != null) {
        sum.x += p.x
        p = p.next
      }

      if (q != null) {
        sum.x += q.x
        q = q.next
      }

      sum.x += carry
      carry = sum.x / 10
      sum.x %= 10

      if (p != null || q != null || carry > 0) {
        sum.next = new ListNode(0)
        sum = sum.next
      }
    }

    return head
  }
}
