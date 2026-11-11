# [最长公共前缀](https://leetcode.com/problems/longest-common-prefix/solution/)
写一个函数，找出数组中每个字符串元素的最长公有前缀字串。如果不存在，就返回`""`

```
Example 1:
Input: ["flower","flow","flight"]
Output: "fl"

Example 2:
Input: ["dog","racecar","car"]
Output: ""
Explanation: 数组中不包含共有的字串.
```

**注意**：  
所有输入参数都是小写字母`a-z`。

## 我的思路
这道题确实够easy的，在字符串数组中找公共前缀，根本就不需要什么精湛的技巧(貌似也没有)，所谓思路就是顺着比较每个字符串的每个字符是否相同，毕竟只要`前缀`嘛，一旦发现法不同，立刻返回第一个字符串的起始到不同处即可。
```c
#include <string.h>
#include <stdlib.h>

char* longestCommonPrefix(char** strs, int strsSize) {
  int i = 0;
  int p = 0;

  if (strsSize == 1) {
    return strs[0];
  }

  while (strsSize) {
    if (++i == strsSize) {
      i = 1;
      p++;
    }

    if (strs[i][p] != strs[i - 1][p]) {
      char* common = calloc(p, sizeof(char));
      strncpy(common, strs[0], p);
      return common;
    }
  }

  return "";
}
```

## 官方方案一、水平扫描
为了便于说明，我们假设要从一个字符串集合中找出共享的前缀，这个集合写作LCP(S1..Sn)，然后我们通过下面这种方式来观察：  
`LCP(S1..Sn) = LCP(LCP(LCP(S1, S2), S3),..Sn)`

**算法**

该算法通过迭代数组[S1..Sn]的方式来找到最长公共前缀，正如前面的公式及下方的图，先找出LCP(S1, S2)的公共前缀，再将此前缀与S3作为新参数方式LCP(Snew, S3)查找，以此类推...

![](https://leetcode.com/media/original_images/14_basic.png)

```java
 public String longestCommonPrefix(String[] strs) {
    if (strs.length == 0) return "";
    String prefix = strs[0];
    for (int i = 1; i < strs.length; i++)
        while (strs[i].indexOf(prefix) != 0) {
            prefix = prefix.substring(0, prefix.length() - 1);
            if (prefix.isEmpty()) return "";
        }        
    return prefix;
}
```
- 时间复杂度：O(S)，S表示所有字符串的长度总和
- 空间复杂度：O(1)

官方还有4、5种解体方案，我觉得过于啰嗦，这道题没有太大难度，就不往下再研究了。