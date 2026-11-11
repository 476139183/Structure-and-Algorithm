#include "solution.h"
#include <assert.h>

void assertEqual(int* n, int i1, int i2)
{
  assert(*n++ == i1);
  assert(*n++ == i2);
}

int main(int argc, char* argv[])
{
  int nums[] = {8, 0, 11, 5, 11, -13, 99};
  int len = sizeof(nums) / sizeof(int);
  
  assertEqual(twoSum(nums, len, -8), 3, 5);
  assertEqual(twoSum(nums, len, 22), 2, 4);
  assertEqual(twoSum(nums, len, 99), 1, 6);

  return 0;
}