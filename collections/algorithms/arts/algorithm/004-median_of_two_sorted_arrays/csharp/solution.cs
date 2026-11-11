public class Solution {
  public double FindMedianSortedArrays(int[] nums1, int[] nums2) {
    int len = (nums1.Length + nums2.Length) / 2 + 1;
    int[] M = {0, 0};
    int i = 0;
    int j = 0;

    while (0 < len--) {
      M[0] = M[1];
      if (i < nums1.Length && j < nums2.Length) {
        M[1] = nums1[i] < nums2[j] ? nums1[i++] : nums2[j++];
      } else {
        M[1] = i < nums1.Length ? nums1[i++] : nums2[j++];
      }
    }

    return (nums1.Length + nums2.Length) % 2 == 1 ? M[1] : (double)(M[0] + M[1]) / 2;
  }
}