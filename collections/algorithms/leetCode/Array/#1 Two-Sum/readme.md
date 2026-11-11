# Two Sum（两数之和）

[原题 - 中文版](https://leetcode-cn.com/problems/two-sum/)


给定一个整数数组 nums 和 一个目标值 target，请你在该数组中找出 和为目标值的那 **两个** 整数，并返回他们的数组下标。

你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

**示例**

```
给定 nums = [2, 7, 11, 15], target = 9

因为 nums[0] + nums[1] = 2 + 7 = 9
所以返回 [0, 1]

```

## 思路 ##

#### 1. 暴力解决

<details>
<summary>暴力解决思路</summary>

我们可以通过遍历数组，两两相加 看等不等于目标值 这样就能找到对应的角标
时间复杂度 O(n^n)。
> 需要注意的是 题目要求不能重复利用数组的元素，所以还需要进行判断 保证对应的两个角标不一样。
</details>

代码如下：

```c
/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* twoSum(int* nums, int numsSize, int target, int* returnSize){
  //! 初始化数组
  int *result = (int *)malloc(sizeof(int) * 2);
  ///! 数组个数，初始化为0
  * returnSize = 0;
  for(int i = 0; i < numsSize-1; ++i) {
    for(int j = i + 1; j < numsSize; ++j) {
      if(nums[i] + nums [j] == target) {
        result[0] = i;
        result[1] = j;
        *returnSize = 2;
        return result;
      }
    }
  }
  return result;

}
```


#### 2. 哈希表法

<details>
<summary>哈希表法思路</summary>

使用散列表，缓存 访问过的元素为key和下标为value，遍历数组，查找缓存中是否存在元素和当前元素的和等于目标值。
时间复杂度 O(n)。
</details>

代码如下：

``` swift
  func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    ///! 声明一个字典，作为一个哈希表，
    var hashTable = Dictionary<Int,Int>()
    
    for (index,value) in nums.enumerated() {
      let targetNum = target - value
      if hashTable.keys.contains(targetNum) {
        return [hashTable[targetNum]!,index]
      }
      hashTable.updateValue(index, forKey: value)
    }
    return [];
  }
```

## 感想 ##

一开始都是拒绝使用 **暴力解决** 的，因为感觉并不优雅，这样反而陷入了僵局，迟迟无法解决问题，浪费了时间和热情。所以还是得先用 最简单的方法去解决问题，之后再考虑优化和改良。

在考虑到哈希表的时候，因为 c 实现起来比较麻烦，当初也考虑过怎么去用数组设计一个哈希表，比如 两两之和，我就想到了两个数相加，a+b=c, 那么 a 和 b 都不会大于 c，所以 可以设计一个 个数为 c 的数组，结果pass，原来我忽略了 题目要求的是整形，所以 可能有负数，那么我这样的理论就不支持了，因为正负两数相加，数值范围已经无法预控了。无奈使用swift去实现，当然 别人也给了我一个警醒，用什么语言不重要，重要的是算法思路，然后才是算法实现。