object Test {
  def main(args: Array[String]): Unit = {
    var l1 = listnum(Array[Int](7, 8, 9))
    var l2 = listnum(Array[Int](0, 9, 3))
    var sum = listnum(Array[Int](7, 7, 3, 1))
    assertEqual(Solution.addTwoNumbers(l1, l2), sum)

    l1 = listnum(Array[Int](1))
    l2 = listnum(Array[Int](9, 9, 9))
    sum = listnum(Array[Int](0, 0, 0, 1))
    assertEqual(Solution.addTwoNumbers(l1, l2), sum)
  }

  def listnum(nums: Array[Int]): ListNode = {
    val list = new ListNode(0)
    var node = list
    nums.foreach(x => { node.next = new ListNode(x); node = node.next })
    return list.next
  }

  def assertEqual(l1: ListNode, l2: ListNode): Unit = {
    var p = l1
    var q = l2
    while (p != null && q != null) {
      assert(p.x == q.x)
      p = p.next
      q = q.next
    }
    assert(p == null && q == null)
  }
}