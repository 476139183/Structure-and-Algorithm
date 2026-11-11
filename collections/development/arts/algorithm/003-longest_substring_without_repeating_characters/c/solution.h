#include <stdlib.h>
#include <stdio.h>
int lengthOfLongestSubstring(char* s) {
  char* p = s;
  char* map[255] = {0}; // the max-value of 'char'
  int longest = 0;
  while (*p) {
    if (map[*p]) {
        int len = p - s;
        longest = longest > len ? longest : len;
        while (s <= map[*p]) {
          map[*s++] = 0;
        }
    }

    map[*p] = p;
    p++;
  }

  return longest > (p - s) ? longest : (p - s);
}