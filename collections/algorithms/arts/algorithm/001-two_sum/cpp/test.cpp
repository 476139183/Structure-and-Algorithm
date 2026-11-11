#include "solution.h"

#include <vector>
#include <assert.h>
using namespace std;
int main(int argc, char* argv[])
{
  Solution s;
  vector<int> nums = {8, 0, 11, 5, 11, -13, 99};

  assert((s.twoSum(nums, -8) == vector<int>{3, 5}));
  assert((s.twoSum(nums, 22) == vector<int>{2, 4}));
  assert((s.twoSum(nums, 99) == vector<int>{1, 6}));

  vector<int> a = {2, 7, 11, 5};
  assert((s.twoSum(a, 9) == vector<int>{0, 1}));

  return 0;
}