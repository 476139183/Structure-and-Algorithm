#include <stdio.h>
#include "solution.h"
#include <assert.h>

int main(int argc, char* argv[])
{
  fprintf(stderr, "atoi = %d\n", myAtoi("    -91283472332"));
  assert(myAtoi("    -91283472332") == 0X80000000);
  assert(myAtoi("0 123") == 0);
  return 0;
}