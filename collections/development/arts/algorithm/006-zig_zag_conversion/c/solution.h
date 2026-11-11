#include <stdlib.h>
#include <string.h>

char* convert(char* s, int numRows) {
  if (numRows == 1) {
    return s;
  }

  int slen = strlen(s);
  int clen = 2 * numRows - 2; // cycle lenth
  char* zigzag = (char*)calloc(slen + 1, sizeof(char));
  char* z = zigzag;

  // first row
  for (int c = 0; c < slen; c += clen) {
    if (c < slen) *z++ = s[c];
  }

  // inner row & each cycle
  for (int r = 1; r < numRows - 1; r++) {
    for (int c = 0; c < slen; c += clen) {
      int left = c + r;
      int right = c + clen - r;
      if (left < slen) *z++ = s[left];
      if (right < slen) *z++ = s[right];
    }
  }

  // last row
  for (int c = 0; c < slen; c += clen) {
    int i = c + numRows - 1;
    if (i < slen) *z++ = s[i];
  }

  return zigzag;
}