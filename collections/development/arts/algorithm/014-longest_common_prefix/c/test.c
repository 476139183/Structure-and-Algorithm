#include "solution.h"
#include <assert.h>
#include <string.h>

int main(int argc, char* argv[])
{
  char* strs[] = {"abcd", "abc", "ab"};
  assert(strcmp(longestCommonPrefix((char**)strs, 3), "ab") == 0);
  return 0;
}