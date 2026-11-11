#include <stdio.h>
#include "solution.h"
#include <assert.h>
#include <string.h>

int main(int argc, char* argv[])
{
  assert(reserve(-100) == -1);
  fprintf(stderr, "rev = %lx\n", 9646324351);
  assert(reserve(1534236469) == 0);
  return 0;
}