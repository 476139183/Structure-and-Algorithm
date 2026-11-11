double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size) {
  int len = (nums1Size + nums2Size) / 2 + 1;
  int M[2] = {0}; // medians
  int i = 0;
  int j = 0;

  while (len--) {
    M[0] = M[1];
    if (i < nums1Size && j < nums2Size) {
      M[1] = nums1[i] < nums2[j] ? nums1[i++] : nums2[j++];
    } else {
      M[1] = i < nums1Size ? nums1[i++] : nums2[j++];
    }
  }

  // 判断合并数组长度值的奇偶，返回对应的中间值
  return (nums1Size ^ nums2Size) & 1 ? M[1] : (double)(M[0] + M[1]) / 2;
}