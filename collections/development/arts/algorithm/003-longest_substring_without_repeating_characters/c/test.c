#include <assert.h>
#include <string.h>

#include "solution.h"


int main(int argc, char* argv[]) {
  assert(lengthOfLongestSubstring("helloworld") == 5);
  assert(lengthOfLongestSubstring("dvdf") == 3);
  assert(lengthOfLongestSubstring("abcabcbb") == 3);

  return 0;
}