#include <string.h>
#include <stdlib.h>

char* longestCommonPrefix(char** strs, int strsSize) {
  int i = 0;
  int p = 0;

  if (strsSize == 1) {
    return strs[0];
  }

  while (strsSize) {
    if (++i == strsSize) {
      i = 1;
      p++;
    }

    if (strs[i][p] != strs[i - 1][p]) {
      char* common = calloc(p, sizeof(char));
      strncpy(common, strs[0], p);
      return common;
    }
  }

  return "";
}