#include "solution.h"
#include <assert.h>

int main(int argc, char* argv[])
{
  Solution s;
  assert(s.convert("PAYPALISHIRING", 4) == "PINALSIGYAHRPI");
  return 0;
}