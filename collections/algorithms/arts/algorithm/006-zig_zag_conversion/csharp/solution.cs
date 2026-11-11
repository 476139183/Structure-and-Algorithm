using System.Text;
public class Solution {
  public string Convert(string s, int numRows) {
    if (numRows == 1) {
      return s;
    }

    int slen = s.Length;
    int clen = 2 * numRows - 2;
    StringBuilder zigzag = new StringBuilder();

    for (int c = 0; c < slen; c += clen) {
      if (c < slen) zigzag.Append(s[c]);
    }

    for (int r = 1; r < numRows - 1; r++) {
      for (int c = 0; c < slen; c += clen) {
        int left = c + r;
        int right = c + clen - r;
        if (left < slen) zigzag.Append(s[left]);
        if (right < slen) zigzag.Append(s[right]);
      }
    }

    for (int c = 0; c < slen; c += clen) {
      int i = c + numRows - 1;
      if (i < slen) zigzag.Append(s[i]);
    }

    return zigzag.ToString();
  }
}