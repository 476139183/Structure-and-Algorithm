import java.util.HashMap;
import java.util.Map;

class Solution {
  public int[] twoSum(int[] nums, int target) {
    Map<Integer, Integer> complements = new HashMap<>();
    for (int i = 0; i < nums.length; i++) {
      int c = target - nums[i];
      if (complements.containsKey(c)) {
        return new int[]{complements.get(c), i};
      } else {
        complements.put(nums[i], i);
      }
    }
    return new int[0];
  }
}