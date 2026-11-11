#include <string>
using namespace std;
#include <iostream>
class Solution {
public:
  int lengthOfLongestSubstring(string s) {
    int map[127] = {0};
    int longest = 0;
    int i = 0;
    int j = 0;
    
    for (auto c : s) {
      if (map[c] > 0) {
        longest = max(longest, j - i);
        for (; i < map[c]; i++) {
          map[s[i]] = 0;
        }
      }
      map[c] = ++j;
    }

    return max(longest, j - i);
  }
};