using System.Collections.Generic;
public class Solution {
    public int[] TwoSum(int[] nums, int target) {
      Dictionary<int, int> complements = new Dictionary<int, int>();
      for (int i = 0; i < nums.Length; i++) {
        int c = target - nums[i];
        if (complements.ContainsKey(c)) {
          return new int[]{complements[c], i};
        } else {
          complements[nums[i]] = i;
        }
      }
      return null;
    }
}