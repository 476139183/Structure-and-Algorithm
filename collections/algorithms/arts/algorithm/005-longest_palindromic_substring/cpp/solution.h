#include <string>

using namespace std;
class Solution {
 public:
  string longestPalindrome(string s) {
    const char* c = s.c_str();
    const char* start = NULL;
    int longest = 0;

    while (*c) {
      const char* l = c;
      while (*l == *(c++));
      const char* r = c;

      while (l >= s && *r != '\0' && *l == *r) {
        l--;
        r++;
      }

      if ((r - l - 1) > longest) {
        longest = r - l - 1;
        start = l + 1;
      }
    }

    // return s.substr(start - s, longest);
  }
};