# [罗马数字转整型](https://leetcode.com/problems/roman-to-integer/)
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

现在，给一个罗马数字，将其转换为整型数字，输入参数将在[1..3999]的范围。
```
Example 1:
Input: "III"
Output: 3

Example 2:
Input: "IV"
Output: 4

Example 3:
Input: "IX"
Output: 9

Example 4:
Input: "LVIII"
Output: 58
Explanation: L = 50, V= 5, III = 3.

Example 5:
Input: "MCMXCIV"
Output: 1994
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
```

## 我的思路一、字符串switch
由于前一道题[整型转罗马数字](../012-integer_to_roman/readme.md)的思路还记忆犹新，思维惯性让我对这道题也采用了相同的套路。

遍历字符串中的每个字符，然后根据字符值获取对应的整型数字，同时只需要注意判断`C/X/I`等三个符号的下一个字符即可，虽然代码写得比较糙，但个人感觉效率应该不会差，结果submit之后懵逼了，`52ms——只击败了16.74%`。当时我就不乐意了😤，这段代码效率有那么低...
```c
int romanToInt(char* s) {
  char* p = s;
  int num = 0;

  do {
    switch (*p) {
    case 'M': num += 1000; break;
    case 'D': num += 500; break;
    case 'C':
      switch (p[1]) {
      case 'M': num += 500;
      case 'D': num += 300, p++;
      default:  num += 100;
      }
      break;
    case 'L': num += 50; break;
    case 'X':
      switch (p[1]) {
      case 'C': num += 50;
      case 'L': num += 30, p++;
      default:  num += 10;
      }
      break;
    case 'V': num += 5; break;
    case 'I':
      switch (p[1]) {
      case 'X': num += 5;
      case 'V': num += 3, p++;
      default:  num += 1;
      }
      break;
    }
  } while (*p++);

  return num;
}
```
- 时间复杂度：O(n)，取决于字符串长度
- 空间复杂度: O(1)

## 我的思路二、前后比较
基于思路一超低的效率，我灰常虔诚地打开了网友们的答案，确实get到了比较好的思想。

在思路一中，我主要是通过switch当前字符及下一个字符来判断整型数值，所以写得很长，而高手们主要通过判断当前字符的整型数值`a`和下一个数值`b`的大小，如果b比a大，这两个字符肯定是`一对`，沿着这个思路我把代码重写：
```c
int romanToInt(char* s) {
  int num = 0;
  int roman[] = {
    ['M'] = 1000,
    ['D'] = 500,
    ['C'] = 100,
    ['L'] = 50,
    ['X'] = 10,
    ['V'] = 5,
    ['I'] = 1,
    [0]   = 0,
  };

  while (*s) {
    int a = roman[*s];
    int b = roman[*++s];
    if (a < b) {
      num += b - a;
      s++;
    } else {
      num += a;
    }
  }

  return num;
}
```
- 时间复杂度：O(n)
- 空间复杂度：O(1)，roman是个伪HashMap，`X`的ASCII值为88，所以数组长度为89

信心满满地再次提交...还是52ms，妈勒个蛋，这样写得还不够快么！！

我刚最开始怀疑嵌套的switch会影响效率，然而并没有，后来又拿100%beats的答案来比较，其实差不多，见鬼了。后来我又提交一次——`60ms`，再试一次——`48ms`😂，最后看看第一名的成绩——`40ms`...I gave up