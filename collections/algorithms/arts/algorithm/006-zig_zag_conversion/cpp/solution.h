#include <string>

using namespace std;
class Solution {
public:
  string convert(string s, int numRows) {
    if (numRows == 1) {
      return s;
    }

    int slen = s.size();
    int clen = 2 * numRows - 2;
    string zigzag;

    for (int c = 0; c < slen; c += clen) {
      if (c < slen) zigzag += s[c];
    }

    for (int r = 1; r < numRows - 1; r++) {
      for (int c = 0; c < slen; c += clen) {
        int left = c + r;
        int right = c + clen - r;
        if (left < slen) zigzag += s[left];
        if (right < slen) zigzag += s[right];
      }
    }

    for (int c = 0; c < slen; c += clen) {
      int i = c + numRows - 1;
      if (i < slen) zigzag += s[i];
    }

    return zigzag;
  }
};