#include "solution.h"
#include <assert.h>
#include <stdio.h>
int main(int argc, char* argv[])
{
  int heights[] = {1,8,6,2,5,4,8,3,7};
  fprintf(stderr, "max = %d\n", maxArea(heights, sizeof(heights) / sizeof(int)));
  assert(maxArea(heights, sizeof(heights) / sizeof(int)) == 49);

  return 0;
}