#include <assert.h>
#include "solution.h"

#include <stdarg.h>
#include <stdlib.h>

struct ListNode* listnum(size_t len, ...) {
  struct ListNode* list = (struct ListNode*)calloc(1, sizeof(struct ListNode));
  struct ListNode* node = list;
  va_list ap;

  va_start(ap, len);
  for (int i = 0; i < len;) {
    node->val = va_arg(ap, int);
    if (++i < len) {
      node->next = (struct ListNode*)calloc(1, sizeof(struct ListNode));
      node = node->next;
    }
  }
  va_end(ap);

  return list;
}

#include <stdio.h>
void assertEqual(struct ListNode* l1, struct ListNode* l2) {
  while (l1 && l2) {
    if (l1->val != l2->val) {
      break;
    } else {
      l1 = l1 ? l1->next : NULL;
      l2 = l2 ? l2->next : NULL;
    }
  }

  assert(l1 == NULL && l2 == NULL);
}

int main(int argc, char* argv[]) {
  assertEqual(addTwoNumbers(listnum(3, 7, 8, 9), listnum(3, 0, 9, 3)),
              listnum(4, 7, 7, 3, 1));
  assertEqual(addTwoNumbers(listnum(1, 1), listnum(3, 9, 9, 9)),
              listnum(4, 0, 0, 0, 1));

  return 0;
}
