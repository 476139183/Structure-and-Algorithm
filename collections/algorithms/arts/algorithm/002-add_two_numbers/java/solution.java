class ListNode {
  int val;
  ListNode next;
  ListNode(int x) { val = x; }
}

class Solution {
  public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
    ListNode sum = new ListNode(0);
    ListNode head = sum;
    int carry = 0;

    while (l1 != null || l2 != null || carry != 0) {
      if (l1 != null) {
        sum.val += l1.val;
        l1 = l1.next;
      }

      if (l2 != null) {
        sum.val += l2.val;
        l2 = l2.next;
      }

      sum.val += carry;
      carry = sum.val / 10;
      sum.val %= 10;

      if (l1 != null || l2 != null || carry != 0) {
        sum.next = new ListNode(0);
        sum = sum.next;
      }
    }

    return head;
  }
}