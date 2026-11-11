#include "solution.h"
#include <assert.h>

int main(int argc, char* argv[])
{
  Solution s;
  assert(s.lengthOfLongestSubstring("helloworld") == 5);
  assert(s.lengthOfLongestSubstring("dvdf") == 3);
  assert(s.lengthOfLongestSubstring("abcabcbb") == 3);
  assert(s.lengthOfLongestSubstring("hijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789hijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789hijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789hijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789hijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789hijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") == 55);
  return 0;
}