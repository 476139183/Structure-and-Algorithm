#include <string.h>

#ifndef bool
#define bool int
#endif

bool isMatch(char* s, char* p) {
  int slen = strlen(s);
  int plen = strlen(p);
  int dp[slen+1][plen+1];

  dp[slen][plen] = 1;
  for (int i = slen; i >= 0; i--) {
    for (int j = plen - 1; j >= 0; j--) {
      int match = i < slen && (s[i] == p[j] || p[j] == '.');
      if (j + 1 < plen && p[j + 1] == '*') {
        dp[i][j] = dp[i][j+2] || (match && dp[i+1][j]);
      } else {
        dp[i][j] = match && dp[i+1][j+1];
      }
    }
  }

  return dp[0][0];
}