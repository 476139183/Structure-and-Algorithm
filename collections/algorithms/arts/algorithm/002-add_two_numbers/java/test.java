class Test {
  public static void main(String[] args) {
    Solution s = new Solution();

    assertEqual(s.addTwoNumbers(listnum(new int[] { 7, 8, 9 }), listnum(new int[] { 0, 9, 3 })),
        listnum(new int[] { 7, 7, 3, 1 }));
    assertEqual(s.addTwoNumbers(listnum(new int[] { 1 }), listnum(new int[] { 9, 9, 9 })),
        listnum(new int[] { 0, 0, 0, 1 }));
  }

  private static ListNode listnum(int[] nums) {
    ListNode list = new ListNode(0);
    ListNode node = list;

    for (int x : nums) {
      node.next = new ListNode(x);
      node = node.next;
    }

    return list.next;
  }

  private static void assertEqual(ListNode l1, ListNode l2) {
    while (l1 != null && l2 != null) {
      if (l1.val != l2.val) {
        break;
      } else {
        l1 = l1.next;
        l2 = l2.next;
      }
    }

    assert l1 == null && l2 == null;
  }
}