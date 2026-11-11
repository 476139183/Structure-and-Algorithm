# [装最多的水](https://leetcode.com/problems/container-with-most-water/solution/)
已知n个非负数，a1, a2, ..., an，每个数的坐标相当于(i, a[i])。类似于在坐标轴上画了几根垂直于x轴的线段，坐标为(i, a[i])和(i, 0)。拿出两根线，加上x轴当作一个容器，找到可以装最多水的那个容器。

**温馨提示**：不要试图把你的显示器歪过来哦，水只能平着装，即容量取决于最短的那根线。

![示意图](https://s3-lc-upload.s3.amazonaws.com/uploads/2018/07/17/question_11.jpg)
<span style="font-size:11px;color:gray">
看图，上面的垂直线相当于一个数组 [1,8,6,2,5,4,8,3,7]，最大面积就是蓝色区域那块，值是49
</span>

```
Example:
Input: [1,8,6,2,5,4,8,3,7]
Output: 49
```

## 我的思路
刚看这题就能立刻想出一种解决方案
> 遍历整个数据，取出数组中的两个值，并去除较小那一个(高)，乘以其索引差(宽)，就可以得到面积，再通过冒泡法就能找出最大面积了
```c
int maxArea(int* height, int heightSize) {
  int max = 0;
  for (int i = 0; i < heightSize; i++) {
    for (int j = i + 1; j < heightSize; j++) {
      int minHeight = height[i] < height[j] ? height[i] : height[j];
      int area = minHeight * (j - i);
      max = area > max ? area : max;
    }
  }

  return max;
}
```
这种思路是最简单的，但用屁股想都知道，O(n²)效率不要太低，所以肯定还有更好的办法，这道题难不倒我，因为我默默翻开了solution...😂

## 官方答案：双指针(Two Pointer Approach)
官方还有个粗暴的办法，就跟我的思路一样，所以就不翻译了，来看看高手是如何证明自己牛逼的！
> **新技能**: 双指针并不是C语言中的指针，而是索引，用于数组/链表遍历。常规遍历自然是for(i...)，双指针顾名思义是for(i,j...)不是嵌套，而是一个头针，一个尾针，同时向中间移动，两针相交，game over。

### 算法
很明确，区域的面积会被两根线中较短的那根限制，同时距离越远面积越大。

我们用两个指针，放在数组的首尾，底部就得到一根线。紧接着，我们固定住面积可能较大的那根线(较长那根)，然后移动另一根。以此类推，每一步都计算下面积然后冒泡更新，搞定！

这套方案是如何运作的？

刚开始我们考虑从最外部的许多线。现在，为了得到最大面积，需要考虑区域两边线的最大长度。如果我们移动较长的那根线，面积不可能增加，因为它被较短的那根线的长度限制住了。但移动较短那根线就可能不一样，尽管同样的参数下距离变短了。但如果接下来对面是一条比自己更长的线，就有可能获得更大的面积。
```java
public class Solution {
    public int maxArea(int[] height) {
        int maxarea = 0, l = 0, r = height.length - 1;
        while (l < r) {
            maxarea = Math.max(maxarea, Math.min(height[l], height[r]) * (r - l));
            if (height[l] < height[r])
                l++;
            else
                r--;
        }
        return maxarea;
    }
}
```
- 时间复杂度：O(n)
- 空间复杂度：O(1)