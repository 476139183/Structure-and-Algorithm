# [Median of Two Sorted Arrays](https://leetcode.com/problems/median-of-two-sorted-arrays/description/)

## 题目说明
已知两个已经排序好的数组nums1和nums2，各自长度分别为m和n。  
找出这两个数组的中位数，总体上时间复杂度控制在O(log (m+n))。  
你可以假定nums1和nums2都不为空。
```
例子1:
nums1 = [1, 3]
nums2 = [2]
中位数是 2.0

例子2:
nums1 = [1, 2]
nums2 = [3, 4]
中位数是 (2 + 3)/2 = 2.5
```

## 我的哀伤
需要说明一下，这道题我作弊了，没想到第一个hard题目就把我干趴下了，真是对不起国家对不起党。当看到题目时是有思路的，不过时间空间复杂度都很高，基本上就是把两个数组边排序边合并一半，然后计算新数组最后一个或两个元素，即中位数。下面是我最开始的代码：
```c
  int len = (nums1Size + nums2Size) / 2;
  int* arr = (int*)calloc(len, sizeof(int));
  int* m = nums1;
  int* n = nums2;

  // 合并两个数组的前半部分
  for (int i = 0; i <= len; i++) {
    if (nums1 && nums2) {
      arr[i] = *nums1 < *nums2 ? *nums1++ : *nums2++;
    } else if (nums1) {
      arr[i] = *nums1++;
    } else if (nums2) {
      arr[i] = *nums2++;
    } else {
      break;
    }

    if (nums1 - m >= nums1Size) { nums1 = NULL; }
    if (nums2 - n >= nums2Size) { nums2 = NULL; }
  }

  int a = arr[len];
  int b = arr[len - 1];
  free(arr);

  // 根据两个数组总长的奇偶值，计算对应的中位数
  return (nums1Size ^ nums2Size) & 1 ? a : (double)(a + b) / 2;
```
不知道什么情况，这段代码在leetcode上运行会导致内存溢出，在我本机上是测试通过的，我估计是传入参数指针被我修改了（按道理不影响啊？），无奈之下我打开了官方Solution...

## 灵光一现
我也不知道为什么，官方文档读到一半的时候脑袋里突然冒出个想法，关于我之前自己实现的算法中，`其实中位数肯定是集合中的一个或两个元素，合并后的新集合不是我想要的，那两个元素才是，只需要两个整型的空间，通过冒泡的方式把max(左)和min(右)找出来就行了啊`，这样我一开始的算法空间复杂度直接从O(n)变成了O(1)，说干就干，还是原来的实现框架，仅仅把空间复杂度给优化一下，我把原本的代码改造如下：
```c
  int len = (nums1Size + nums2Size) / 2 + 1;
  int M[2] = {0}; // medians
  int i = 0;
  int j = 0;

  // 找出“合并”数组的最后两个元素
  while (len--) {
    M[0] = M[1];
    if (i < nums1Size && j < nums2Size) {
      M[1] = nums1[i] < nums2[j] ? nums1[i++] : nums2[j++];
    } else {
      M[1] = i < nums1Size ? nums1[i++] : nums2[j++];
    }
  }

  // 判断合并数组长度值的奇偶，返回对应的中间值
  return (nums1Size ^ nums2Size) & 1 ? M[1] : (double)(M[0] + M[1]) / 2;
```
- 时间复杂度：O(n)，因为while两个数组长度之和的一半
- 空间复杂度：O(1)，注意看那个大大的M[2]  

代码看似面目全非，其实思路和以前一样，完成后果断**submit**，我勒个去！！直接爆击率100%，我和我的小代码都惊呆了😳，看来我最初的实现思路没那么low，只是想得不够彻底，给自己朵小红花。

好啦言归正传，以下的官方Solution！

## 方案一：递归

> 注意：前方高能，官方的这套解题思路太绕了！！

要解决这个问题，首先你要了解“中位数”是干什么的。在统计学里，中位数主要用于: `把一个集合分割为两个等长的子集，且一个子集的元素始终大于另一个子集`。也就是说如果找到一个集合的中位数，你可以指着中位数对所以集合元素吼一声：比它小的站左边，比它大的站右边，如此这般。

理解了这句话，我们就看到了胜利的曙光男科医院，不信请往下看：  
随便来一个已排序好的集合A假定长度为m，因为排序好了，所以可以直接从中间一刀切成两半，你会得到两个A的子集：

|       A左子集      |       A右子集      |
|:-----------------:|:-----------------:|
|A[0], A[1]...A[i-1]|A[i], A[i+1]...A[m]|

同样再随便来一个已排序好的集合B假定长度为n，往中间这么一切，也可以得到两个B的子集：

|       B左子集      |       B右子集      |
|:-----------------:|:-----------------:|
|B[0], B[1]...B[j-1]|B[j], B[j+1]...B[n]|

接下来是见证奇迹的时刻，我们把这2*2个子集按“左左”和“右右”进行一次垂直合并，得到如下：

|       左子集       |        右子集      |
|:-----------------:|:-----------------:|
|A[0], A[1]...A[i-1]|A[i], A[i+1]...A[m]|
|B[0], B[1]...B[j-1]|B[j], B[j+1]...B[n]|

好了，我们先假定这左右两个子集就是某个集合被中位数分割的结果，那这个集合的中位数公式为`max(左) + min(右) / 2`，另外这两个子集肯定满足以下两个条件：
1. 左子集与右子集元素长度相等，即`len(左) == len(右)`
2. 左子集的最后一个元素肯定小于右子集的第一个元素，即`A[i-1]和B[j-1]同时小于A[i]和B[j]`

说码语就是：
```c
when
i + j == (m - i) + (n - j)
A[i-1] <= B[j] && B[j-1] <= A[i] // A[i-1] <= A[i]、B[j-1] <= B[j]显然成立

=> median = ((A[i-1] or B[j-1]) + (A[i] or B[i])) / 2
```

好了，为了满足上面两个假设，我们还需要接着保证`i+j=(m+n)/2`（因为两个小数组合到一起了，所以这个大数组的元素索引变成了i+j，而中位数肯定是(m+n)/2或(m+n+1)/2，取决的大数组长度的奇偶情况），这个时候推导出`j=(m+n+1)/2 - i`，好了，现在我们只需要做一件事：
```
把i作为索引从[0,m]中查找某个元素，满足如下条件：
B[j - 1] ≤ A[i] and A[i - 1] ≤ B[j]
当然，这个时候j可以替换为(m+n+1)/2 - i
```
基于这个思路，我们可以通过二分法找到这个元素（跟上我的节奏😂）：   
1. 设置imin = 0， imax = m
2. 设置i = m/2， j = (m+n+1)/2 - i
3. 因为左子集和右子集长度一样，所以我们会遇到3中情况如下：
  - B[j - 1] ≤ A[i] and A[i - 1] ≤ B[j]，此时说明找到了，停止查找
  - B[j - 1] ≥ A[i]，说明A[i]小了，需要i++使其满足B[j - 1] ≤ A[i]（因为i++意味着j会变小）
  - A[i - 1] ≥ B[j]，说明A[i - 1]大了，需要i--，理由同上

好了，基本思路就这样，接下来我们还需要考虑一下边界情况，即i=0,i=m,j=0,j=n的情况，其实非常简单(此处省略原文好几大段废话)，基本也是3种情况：
```
1.  (j=0 or i=m or B[j−1]≤A[i]) and
    (i=0 or j=n or A[i−1]≤B[j]) 
    说明i就是我们要的答案

2.  j>0 and i<m and B[j−1]>A[i]
    说明i小了，i++

3.  i>0 and j<n and A[i−1]>B[j]
    说明i大了，i--
```
下面是具体代码实现：
```java
class Solution {
    public double findMedianSortedArrays(int[] A, int[] B) {
        int m = A.length;
        int n = B.length;
        if (m > n) { // to ensure m<=n
            int[] temp = A; A = B; B = temp;
            int tmp = m; m = n; n = tmp;
        }
        int iMin = 0, iMax = m, halfLen = (m + n + 1) / 2;
        while (iMin <= iMax) {
            int i = (iMin + iMax) / 2;
            int j = halfLen - i;
            if (i < iMax && B[j-1] > A[i]){
                iMin = i + 1; // i is too small
            }
            else if (i > iMin && A[i-1] > B[j]) {
                iMax = i - 1; // i is too big
            }
            else { // i is perfect
                int maxLeft = 0;
                if (i == 0) { maxLeft = B[j-1]; }
                else if (j == 0) { maxLeft = A[i-1]; }
                else { maxLeft = Math.max(A[i-1], B[j-1]); }
                if ( (m + n) % 2 == 1 ) { return maxLeft; }

                int minRight = 0;
                if (i == m) { minRight = B[j]; }
                else if (j == n) { minRight = A[i]; }
                else { minRight = Math.min(B[j], A[i]); }

                return (maxLeft + minRight) / 2.0;
            }
        }
        return 0.0;
    }
}
```
- 时间复杂度： O(log(min(m, n)))，首先是最多遍历大数组的一半，其次i表示较小数组的索引
- 空间复杂度： O(1)

终于完了！！！