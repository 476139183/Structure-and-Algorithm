#include <stdlib.h>
int* twoSum(int* nums, int len, int target) {
  int max = nums[0];
  int min = nums[0];

  for (int i = 1; i < len; i++) {
    min = min > nums[i] ? nums[i] : min;
    max = max < nums[i] ? nums[i] : max;
  }

  int* map = (int*)calloc(max - min + 1, sizeof(int));
  for (int i = 0; i < len; i++) {
    int c = target - nums[i];
    if (min <= c && c <= max && map[max - c]) {
      static int indices[2] = {0};
      indices[0] = map[max - c] - 1;
      indices[1] = i;
      return indices;
    } else {
      map[max - nums[i]] = i + 1;
    }
  }

  return NULL;
}