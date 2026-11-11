#include <vector>

using namespace std;
class Solution {
 public:
  double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) {
    int len1 = nums1.size();
    int len2 = nums2.size();
    int len = (len1 + len2) / 2 + 1;
    int M[2] = {0};
    int i = 0;
    int j = 0;

    while (len--) {
      M[0] = M[1];
      if (i < len1 && j < len2) {
        M[1] = nums1[i] < nums2[j] ? nums1[i++] : nums2[j++];
      } else {
        M[1] = i < len1 ? nums1[i++] : nums2[j++];
      }
    }

    return (len1 ^ len2) & 1 ? M[1] : (double)(M[0] + M[1]) / 2;
  }
};