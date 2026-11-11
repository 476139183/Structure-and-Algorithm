#ifndef bool
#define bool int
#endif

#ifndef true
#define true 1
#endif

#include "solution.h"
#include <assert.h>

int main(int argc, char* argv[])
{
  assert(isPalindrome(1234321) == true);
  assert(isPalindrome(8) == true);
  return 0;
}