# [最长回文子串](https://leetcode.com/problems/longest-palindromic-substring/solution/)

给一个字符窜，找出其中的最长回文。可以假定s的最大长度为1000.
```
Example 1:
Input: "babad"
Output: "bab"
注意: "aba" 也是正确答案.

Example 2:
Input: "cbbd"
Output: "bb"
```

## 方案一、最长公共子串

### 同一个世界，同一个坑
很多朋友能立刻想到这样一种解决方案，不过很可惜，这是个坑：
> 将字符串S镜像成S'，然后找出S和S'中的最长公共子串，这肯定就是最长的回文啦，棒棒哒～

这种思路当然能跑起来，但让我们看看下面的情况：  
例如： S = "caba"，那么S' = "abac"  
最长公共串是"aba"对不对？这也是正确答案 。  
现在再看一个例子： S = "abacdfgdcaba"，那么S' = "abacdgfdcaba"  
最长公共串是"abacd"对不对？很显然，它不是回文，因为中间是"gf"。

### 算法
我们已经看到**最长公共子串**的方法在S的两个镜像子串中没有回文的情况下是失效的。为了修复这个情况，每当我们发现一组最长公共子串的时候，都需要遍历其每个索引看值是否相同，如果相同继续比较下一个直到最后，如果不同，直接break寻找下一组公共子串。

这里给出了O(n²)Dynamic Programming解决方案，用到O(n²)的空间（也可以提高到O(n)），具体移步[Longest Common Substring](http://en.wikipedia.org/wiki/Longest_common_substring)。

## (插播)我的思路

和官方答案一样，我一开始真的是通过“反转”字符串的方式，找出公共字符串，结果失败了。。。  
后面思路基本锁定在遍历每一个字符，每个字符左右两边展开对比，逐步优化，直至求解✌️   
```c
char* longestPalindrome(char* s) {
  char* c = s;
  char* start = NULL;
  int longest = 0;

  while (*c) {
    char* l = c;
    while (*l == *(++c)); // 去重复字符
    char* r = c - 1;

    // 左右两边展开对比
    while (l >= s && *r != '\0' && *l == *r) {
      l--;
      r++;
    }

    l++;
    if ((r - l) > longest) {
      longest = r - l;
      start = l;
    }
  }

  char* palindrome = (char*)calloc(longest + 1, sizeof(char));
  strncpy(palindrome, start, longest);
  return palindrome;
}
```
- 时间复杂度： O(n²)，这是最差情况下
- 空间复杂度： O(n)，主要因为c语言没有substring😂

请允许我再自豪一波，因为我觉得我的代码比官方的清爽，而且暴击率100%  

## 方案二、暴力法
既然要采取暴力，自然是先找出所有可能的子串起止位置，然后一一检查看是不是回文。

- 时间复杂度： O(n³)，假设字符串长度为n，那一共可能又n(n-1)/2种子串的可能（符合回文），每个子串又需要核查一遍是否是回文，又用掉一个n
- 空间复杂度： O(1)

## 方案三、动态编程
为了改善上边的暴力方案，首先需要注意如何避免在检查是否是回文的重复计算。比如“ababa”，如果我们已经确定“bab”是一个回文，那显然只要它的左右两边字符一样“ababa”肯定也是回文。  
我们做如下定义：  
- P(i, j) = true，表示Si...Sj是回文
- P(i, j) = false ，表示不是回文  
因此：  
- P(i, j) = (P(i+1), (j-1) and Si == Sj)  
基于此可以得出, 当P(i, j) = true时  
P(i, (i+1)) = (Si == Si+1)

这就直接产生了DP解决方案，我们首先初始化一个或两个回文字符，然后沿着这条路找到所有三个、四个字符的回文，等等...

- 时间复杂度： O(n²)
- 空间复杂度： O(n²)，因为要存储P这张表

## 方案四、从中心展开
事实上，我们可以把空间复杂度O(n²)降到一个常数。

我们可以看到回文的镜像总围绕着它的中心，所以回文能够沿着它的中心展开，一个字符串最多有2n-1个“中心”。

为什么是2n-1，因为一个回文的中心两边总围绕着两个字符呀，如果回文有偶数个字符(比如“abba”)那它的中心就是两个字母“b”。

```java
public String longestPalindrome(String s) {
    if (s == null || s.length() < 1) return "";
    int start = 0, end = 0;
    for (int i = 0; i < s.length(); i++) {
        int len1 = expandAroundCenter(s, i, i);
        int len2 = expandAroundCenter(s, i, i + 1);
        int len = Math.max(len1, len2);
        if (len > end - start) {
            start = i - (len - 1) / 2;
            end = i + len / 2;
        }
    }
    return s.substring(start, end + 1);
}

private int expandAroundCenter(String s, int left, int right) {
    int L = left, R = right;
    while (L >= 0 && R < s.length() && s.charAt(L) == s.charAt(R)) {
        L--;
        R++;
    }
    return R - L - 1;
}
```
- 时间复杂度： O(n²)
- 空间复杂度： O(1)