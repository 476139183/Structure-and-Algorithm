#include <assert.h>
#include "solution.h"

#include <vector>

using namespace std;

ListNode* listnum(std::vector<int> nums) {
  ListNode* list = new ListNode(0);
  ListNode* node = list;

  for (int x : nums) {
    node->next = new ListNode(x);
    node = node->next;
  }
  node = list->next;
  delete list;

  return node;
}

void assertEqual(ListNode* l1, ListNode* l2) {
  while (l1 && l2) {
    if (l1->val != l2->val) {
      break;
    } else {
      l1 = l1->next;
      l2 = l2->next;
    }
  }

  assert(l1 == NULL && l2 == NULL);
}

int main(int argc, char* argv[]) {
  Solution s = Solution();
  assertEqual(s.addTwoNumbers(listnum(vector<int>{7, 8, 9}),
                              listnum(vector<int>{0, 9, 3})),
              listnum(vector<int>{7, 7, 3, 1}));
  assertEqual(
      s.addTwoNumbers(listnum(vector<int>{1}), listnum(vector<int>{9, 9, 9})),
      listnum(vector<int>{0, 0, 0, 1}));
  return 0;
}