#include "solution.h"
#include <assert.h>
#include <stdio.h>
int main(int argc, char* argv[])
{
  assert(strcmp(longestPalindrome("aaabaaaa"), "aaabaaa") == 0);
  assert(strcmp(longestPalindrome("abc"), "a") == 0);
  assert(strcmp(longestPalindrome(""), "") == 0);
  return 0;
}