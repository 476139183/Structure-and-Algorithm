# [3数之和](https://leetcode.com/problems/two-sum)
给一个整数构成的数组，其中有三个元素`a,b,c`的总和为0，即`a+b+c=0`？找出数组中唯一的和为零的三个数。

**注意**：答案中是一套集合且其中不能有重复。
```
Example:
数组定义 nums = [-1, 0, 1, 2, -1, -4],

结果集合:
[
  [-1, 0, 1],
  [-1, -1, 2]
]
```

## 我的思路：穷举
似乎所有算法题都可以用穷举这种笨办法，我刚开始却没什么好的思路，但由于题目本身的限制，即使用穷举也不简单，所以大概说一下思路，首先需要注意题意：
1. 要找出全部相加为0的组合，所以需要注意二维数组的分配
2. 全部组合中要“去重”，就是说`[0, -1, 1]`和`[-1, 0, 1]`这两个组合应该被看作一个

留意这两个限制之后，其实解题思路就不难了：
1. 三层for循环嵌套，遍历每种组合的和是否为0
2. 发现相加为0的组合后，做一次排序，并存到结果数组中
3. 遍历当前的结果数组，查看是否存在重复

下面的代码不全，因为我觉得意义不大，因为做得不够严谨，其次O(n³)的时间复杂度根本无法通过leetcode的时间限制，所以就算逻辑对了，提交也不通过。
```c
int** threeSum(int* nums, int numsSize, int* returnSize) {
  int** results = calloc(numsSize * 3, sizeof(int*));
  int len = 0;

  for (int i = 0; i < numsSize; i++) {
    for (int j = i + 1; j < numsSize; j++) {
      for (int k = j + 1; k < numsSize; k++) {
        // 检查是否符合三值和为零
        if (nums[i] + nums[j] + nums[k]) {
          continue;
        }

        // 将三个值排序
        int min = ...
        int mid = ...
        int max = ...
        
        // 去重
        int equal = 0;
        for (int l = 0; l < len; l++) {
          if (min == results[l][0] && max == results[l][2]) {
            equal = 1;
          }
        }
        if (equal) {
          continue;
        }

        // 赋值
        results[len] = calloc(3, sizeof(int));
        ...
        len++;
      }
    }
  }

  *returnSize = len;
  return results;
}
```
- 时间复杂度： O(n³)，三层for的悲剧
- 空间复杂度： O(n³)，最坏情况下

## 网友思路：双指针
由于没有官方的解答，我是参照论坛里C++的解析过程实现的该方式：
1. nums需要做一次升序，为了使用双指针即去重，用冒泡排序即可
2. 遍历升序后的数组，每次选取三个元素，分辨是当前索引`i`，`i+1`左指针，`len-1`右指针，然后，摁住i不动，双指针开始向中心移动，扫描`两个值+nums[i]`是否为0
3. 当发现有符合的组合之后，还需要在去重，即左右指针接着移动，直到与之前的数字不相同为止
4. 由于c语言没有比较好用的vector类型，又懒得再去实现用链表，所以我强制将可能的答案设定为nums长度的十倍。
```c
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
        while (nums[left] == nums[left + 1]) left++;
        while (nums[right] == nums[right - 1]) right--;
        left++, right--;
        n++;
      }
    }

    while (i + 1 < numsSize && nums[i + 1] == nums[i]) {
      i++;
    }
  }

  *returnSize = n;
  return results;
}
```
