# [Two Num](https://leetcode.com/problems/two-sum)

## 题目说明
输入一个数组nums，找出其中的两个元素，满足其值之和为输入的目标值，返回这两个元素的数组下标(索引)。
例如：
```
输入： nums = [8, 0, 11, 5, 11, -13, 99]
      target = -8
输出： [3, 5]
理由： 5 + (-13) = -8，而5和-13在nums数组对应下标为3和5
```

### 方案一：暴力破解！
就题目意思而言，完全可以理解为数学中从一个集合里取出两个不同元素的排列组合游戏，所以要实现这个排列组合最简单的方式就是用for循环遍历，找2个数就两层for，3个数就三层for...总有一款适合你，当然同样按照数学公式可知，这种排列组合的方式共有n!种，所以这个算法的效率嘛～～请看大屏幕：
```java
public int[] twoSum(int[] nums, int target) {
    for (int i = 0; i < nums.length; i++) {
        for (int j = i + 1; j < nums.length; j++) {
            if (nums[j] == target - nums[i]) {
                return new int[] { i, j };
            }
        }
    }
    throw new IllegalArgumentException("No two sum solution");
}
```
- 时间复杂度O(n²):  两个for循环嵌套执行，最差情况下执行n*(n-1)次
- 空间复杂度O(1):   很明显，没有动态分配变量空间

### 方案二：两步走，有房有车再谈恋爱
如果把这个题目当作一场大型相亲会的话，方案一无疑就是让每两个人都确认过眼神。呐！大家都很忙的，这种操作虽然简单易懂，但是浪费时间啊，要不这样，每个人先把自身的条件统一写到一张表里，然后各自根据这张表来看有没有中意的，觉得合适了再真的去确认眼神。

> 时间和空间是可以交换的 ——《程序员物理学》(差点就信了出版社)

这个时候相当于用方案二这张表的空间去交换方案一没有确认眼神的时间。说回算法本身，我们可以先遍历一遍数组nums，让每个元素把自身的(值，索引)以(键, 值)的方式统一存在一张哈希表里，其实相当于把数组nums的键值“反转”后在存到另一个数组map里，然后再遍历一遍数组nums，这次nums元素要计算与target之差是多少，如果这个“差值”为map中的一个“键”，即找到了对方。
```java
public int[] twoSum(int[] nums, int target) {
    Map<Integer, Integer> map = new HashMap<>();
    for (int i = 0; i < nums.length; i++) {
        map.put(nums[i], i);
    }
    for (int i = 0; i < nums.length; i++) {
        int complement = target - nums[i];
        if (map.containsKey(complement) && map.get(complement) != i) {
            return new int[] { i, map.get(complement) };
        }
    }
    throw new IllegalArgumentException("No two sum solution");
}
```
- 时间复杂度O(n):  两个for循环从“嵌套”变为了“顺序”执行，自然从指数级将为线性级啦
- 空间复杂度O(n):  这么明显的哈希map摆在眼前，而且存的数量刚好是nums数组长度

### 方案三：请你一步到位
都二十一世纪了，工业化都那么多年了，好歹是个现代化的人，就不能有点流水线的思维吗，况且还是个程序员，操作系统是怎么样CPU多任务处理的？所以如果完全理解了方案二，那这里就完全没什么技术含量，因为方案三只是在方案二的基础上，让大家把自己写完自身条件前，先检查一下表里有没有适合自己的，所以直接看代码吧：
```java
public int[] twoSum(int[] nums, int target) {
    Map<Integer, Integer> map = new HashMap<>();
    for (int i = 0; i < nums.length; i++) {
        int complement = target - nums[i];
        if (map.containsKey(complement)) {
            return new int[] { map.get(complement), i };
        }
        map.put(nums[i], i);
    }
    throw new IllegalArgumentException("No two sum solution");
}
```
- 时间复杂度O(n):  有for循环的地方，基本上就有n(别问我为什么方案二不是2n)
- 空间复杂度O(n):  map还是那个map，长度不一定是那个长度