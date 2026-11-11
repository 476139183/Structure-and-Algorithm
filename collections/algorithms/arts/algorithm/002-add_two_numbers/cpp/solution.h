struct ListNode {
  int val;
  struct ListNode* next;
  ListNode(int x) : val(x), next(0) {}
};

class Solution {
 public:
  ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
    struct ListNode* sum = new ListNode(0);
    struct ListNode* head = sum;
    int carry = 0;

    while (l1 || l2 || carry) {
      if (l1) {
        sum->val += l1->val;
        l1 = l1->next;
      }

      if (l2) {
        sum->val += l2->val;
        l2 = l2->next;
      }

      sum->val += carry;
      carry = sum->val / 10;
      sum->val %= 10;

      if (l1 || l2 || carry) {
        sum->next = new ListNode(0);
        sum = sum->next;
      }
    }

    return head;
  }
};
