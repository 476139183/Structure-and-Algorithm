#include <stdlib.h>
#include <stdio.h>
/**
 * Return an array of arrays of size *returnSize.
 * Note: The returned array must be malloced, assume caller calls free().
 */
int** threeSum(int* nums, int numsSize, int* returnSize) {
  for (int i = 0; i < numsSize - 1; i++) {
    for (int j = 0; j < numsSize - i -1; j++) {
      if (nums[j] > nums[j + 1]) {
        int tmp = nums[j];
        nums[j] = nums[j + 1];
        nums[j + 1] = tmp;
      }
    }
  }

  int** results = (int**)calloc(numsSize * 10, sizeof(int*));
  int n = 0;
  for (int i = 0; i < numsSize; i++) {
    int left = i + 1;
    int right = numsSize - 1;
    while (left < right) {
      int sum = nums[i] + nums[left] + nums[right];
      if (sum < 0) {
        left++;
      } else if (sum > 0) {
        right--;
      } else {
        results[n] = (int*)calloc(3, sizeof(int));
        results[n][0] = nums[i];
        results[n][1] = nums[left];
        results[n][2] = nums[right];
        fprintf(stderr, "results[%d] = [%d, %d, %d]\n", n, results[n][0], results[n][1], results[n][2]);
        n++;
        while (nums[left] == nums[left + 1]) left++;
        while (nums[right] == nums[right - 1]) right--;
        left++, right--;
      }
    }

    while (i + 1 < numsSize && nums[i + 1] == nums[i]) {
      i++;
    }
  }

  *returnSize = n;
  return results;
}