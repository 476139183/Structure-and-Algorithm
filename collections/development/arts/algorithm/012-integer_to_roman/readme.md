# [12 整型转罗马数字](https://leetcode.com/problems/integer-to-roman/)
罗马数字通过7个不同的符号表示：I, V, X, L, C, D, M
```
Symbol       Value
I             1
V             5
X             10
L             50
C             100
D             500
M             1000
```
例如，2的罗马数字写成`II`，12则写成`XII`，就是简单的`X + II`。所以27写成`XXVII`，即`XX + V + II`。

罗马数字通常是从左往右从高位到低位的写法。但要注意`4不是IIII`，用`IV`代替。因为`5-1=4`，别问为什么。同样的道理，9要写成`IX`，总之适用于以下六种情况：
- `I`放在`V`和`X`之前，表示4和9
- `X`放在`L`和`C`之前，表示40和90
- `C`放在`D`和`M`之前，表示400和900

现在，给一个整型数字，将其转换为罗马数字，输入参数将在[1..3999]的范围。

```
Example 1:
Input: 3
Output: "III"

Example 2:
Input: 4
Output: "IV"

Example 3:
Input: 9
Output: "IX"

Example 4:
Input: 58
Output: "LVIII"
Explanation: L = 50, V = 5, III = 3.

Example 5:
Input: 1994
Output: "MCMXCIV"
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
```

## 我的思路一、穷举法
实在不知道这道题和算法有什么关系，如果注意读题目会发现，测试用例范围是[1..3999]，所以呢？
```c
char* intToRoman(int num) {
  const char* roman[] = {
    "",   // 0
    "I",  // 1
    "II", // 2
    ...
    "XVII", // 17
    "XVIII", //18
    ...
    "DXII", // 512
    ...
    "MMMCMXCVIII", // 3998
    "MMMCMXCIX" // 3999
    // 👆 高手，这是高手！这也太厉害了
  };

  return roman[num];
}
```
- 时间复杂度：O(1)
- 空间复杂度：O(1)

**还有谁！！！** 虽然我没跑单元测试，但我知道它最优秀！😂

## 我的思路二、穷举优化版
还是把目光放到`[1..3999]`这里，由于罗马数字的符号只有7种，而且遵循`仟+佰+拾+个`的规律，所以完全可以把阿拉伯数字的每个进位的值取出来，转换成对应进位上的罗马数字的字符串，再把字符串拼接起来。

换而言之，还是一样定义一个数组，但不用存每个数字，只需要把每个进位的数字存下来即可，总共4*10的数组。
```c
char* intToRoman(int num) {
  const char* roman[][10] = {
    {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"},
    {"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"},
    {"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"},
    {"", "M", "MM", "MMM"}
  };
  
  const char* carry[4] = {0};
  for (int i = 0; i < 4; i++) {
    carry[i] = roman[i][num % 10];
    num /= 10;
  }

  char* result = (char*)calloc(16, 1);
  char *p = result;
  for (int i = 3; i >= 0; i--) {
    for (int j = 0; carry[i][j]; j++) {
      *p = carry[i][j];
      p++;
    }
  }

  return result;
}
```
- 时间复杂度：O(1)
- 空间复杂度：O(1)，虽然用了内存分配，但最大不会超过16个字节

当然，如果非要钻牛角尖的话，还可以进一步“优化”，不用把每个进位的十个罗马数字列出来，以4、9和5为分界点，对罗马数字符号增加对应取模的数量。我觉得那个实现起来太繁琐，懒得做了。
