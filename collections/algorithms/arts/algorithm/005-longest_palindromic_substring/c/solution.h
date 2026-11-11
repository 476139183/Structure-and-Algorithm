#include <stdlib.h>
#include <string.h>

char* longestPalindrome(char* s) {
  char* c = s;
  char* start = NULL;
  int longest = 0;

  while (*c) {
    char* l = c;
    while (*l == *(++c));
    char* r = c - 1;

    while (l >= s && *r != '\0' && *l == *r) {
      l--;
      r++;
    }

    l++;
    if ((r - l) > longest) {
      longest = r - l;
      start = l;
    }
  }

  char* palindrome = (char*)calloc(longest + 1, sizeof(char));
  strncpy(palindrome, start, longest);
  return palindrome;
}