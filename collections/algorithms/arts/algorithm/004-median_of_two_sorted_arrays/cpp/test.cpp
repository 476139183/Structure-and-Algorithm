#include "solution.h"
#include <assert.h>
#include <iostream>
int main(int argc, char* argv[])
{
  Solution s;
  vector<int> nums1 = {};
  vector<int> nums2 = {2, 3};
  cerr << s.findMedianSortedArrays(nums1, nums2) << endl;
  assert(s.findMedianSortedArrays(nums1, nums2) == 2.5);

  nums1 = {1, 2, 3};
  nums2 = {8, 9};
  assert(s.findMedianSortedArrays(nums1, nums2) == 3);
  return 0;
}
