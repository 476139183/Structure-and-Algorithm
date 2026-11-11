#include <stdlib.h>

int compartion(const void* a, const void* b) {
  return *(int*)a - *(int*)b;
}

int threeSumClosest(int* nums, int numsSize, int target) {
  qsort(nums, numsSize, sizeof(int), compartion);

  // 双指针遍历
  int closest = nums[0] + nums[1] + nums[2];
  for (int i = 0; i < numsSize; i++) {
    int left = i + 1;
    int right = numsSize - 1;

    while (left < right) {
      int sum = nums[i] + nums[left] + nums[right];
      int distance = target > closest ? target - closest : closest - target;

      if (sum > target) {
        closest = (sum - target) < distance ? sum : closest;
        right--;
      } else if (sum < target) {
        closest = (target - sum) < distance ? sum : closest;
        left++;
      } else {
        return sum;
      }
    }
  }

  return closest;
}