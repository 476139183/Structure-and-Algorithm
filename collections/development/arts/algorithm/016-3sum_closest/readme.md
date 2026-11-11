# [最接近的3个数](https://leetcode.com/problems/3sum-closest/)
给一个长度为n的整型数组和一个整数，从数组中找出三个整数组合，其和要最接近目标值。返回这三个数的和。你可以假设每次输入的参数都肯定能找到答案。
```
Example:
输入一个数组nums = [-1, 2, 1, -4], 和目标值 target = 1.

最接近的目标值是 2. (-1 + 2 + 1 = 2).
```

## 我的思路：双指针
该题目紧接上一题：[3sum](../015-3sum/readme.md)，所以套路还是那个套路。

1. 首先需要对nums数组排序，便于后续做双指针遍历

> **题外话**  
> 无意中发现原来C标准库中有数组排序函数`qsort`，所以我原本那个蹩脚的冒泡排序就退休了。

2. 进行双指针查找

我们需要注意策略，本题题意是找出`最接近目标值的和`，而非所有可能的三个元素组合，所以返回值可以通过冒泡得出。

请脑补一个X轴，画出3个点`a、b、c`：
- b表示目标值所在点`target`
- a表示上次的最接近值`closest`
- c表示当前的三个元素之和`sum`

1. 双指针`left`和`right`移动规则很简单，当`sum > target`右指针动，反之左指针动
2. `ab`和`bc`就是两条线段，谁距离短谁赢(冒泡)，即比较绝对值
```c
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
```
- 时间复杂度：O(n²)，for里嵌套while，同时while次数递减
- 空间复杂度：O(1)