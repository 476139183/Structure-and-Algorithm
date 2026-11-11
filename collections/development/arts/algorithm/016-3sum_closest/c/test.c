#include "solution.h"
#include <assert.h>

int main(int argc, char* argv[])
{
  int nums[] = {1,2,4,8,16,32,64,128};
  assert(threeSumClosest(nums, sizeof(nums) / sizeof(int), 82) == 82);
  return 0;
}