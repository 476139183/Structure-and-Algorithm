#include <stdlib.h>

struct ListNode {
  int val;
  struct ListNode* next;
};

struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2) {
  struct ListNode* sum = (struct ListNode*)calloc(1, sizeof(struct ListNode));
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
      sum->next = (struct ListNode*)calloc(1, sizeof(struct ListNode));
      sum = sum->next;
    }
  }

  return head;
}
