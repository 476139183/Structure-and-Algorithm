# [String to Integer (atoi)](https://leetcode.com/problems/string-to-integer-atoi)
实现`atoi`将一个字符串转换为整型数字。

该函数需要滤过很多空白字符直到发现，第一个非空白字符。然后从该字符开始将可能包含`+/-`符号的数字字符逐个转换为数值。

字符串可以包含一些非数字字符到那些数字字符的后边，它们应该被忽略掉，不会对函数执行造成影响。

如果字符串第一个非空白字符不是有效数字字符、str为空字符串又或者只有一堆空白符，就没必要转换了。

如果认为没必要转换的，直接返回0。

注意：
- 只有空格' '代表空白符
- 假定我们的环境只能存储32位的整型数字，范围 [−2(的32次方),  2(的31次方 − 1)]，如果数值超出返回，返回INT_MAX或INT_MIN。

```
Example 1:
Input: "42"
Output: 42

Example 2:
Input: "   -42"
Output: -42
解释: 第一个非空白符为'-'，是一个减号，把它当作负数。

Example 3:
Input: "4193 with words"
Output: 4193
解释: 转换到'3'为止，后边的字符不是数字字符(空白符也不是数字字符)。

Example 4:
Input: "words and 987"
Output: 0
解释: 第一个非空白符是'w'，它不是一个数字字符或+/-符号，没有转换的必要。

Example 5:
Input: "-91283472332"
Output: -2147483648
解释: 数字"-91283472332"已经超出-2的31次方了，直接返回int的最小值。
```

## 我的思路
本题没有官方solution，估计是太简单了，没人打算写吧。如果做过[007-整型反转](https://leetcode.com/problems/reverse-integer/solution)这道题的话，其实本题基本没什么难度，因为道理完全一样！

我们先定义num为返回值，初始为0，正常情况下：  
1. Pop出每个字符，检查是否为数字字符
2. 如果是数字字符，把num乘等10，然后在将当前字符转成数字，加到num中即可

如果不知道怎么把单个字符转为数字，千万别说自己是程序员！

不过这道题一定要注意反复读题目，把里边的坑找出来。
1. 最初的空白符一定要略过
2. 中间的空白符不能略过，应该直接跳出，比如`0 123`答案应该是0
3. +/-符号虽然是正负的意思，但要防止第二次出现

```c
int myAtoi(char* str) {
  const int INTMAX = 0X7FFFFFFF;
  const int INTMIN = 0X80000000;
  char* p = str;
  int num = 0;
  char sign = 0; // +/-

  if (str == 0) {
    return 0;
  }

  do {
    if (*p >= '0' && *p <= '9') {
      long int tmp = (long int)num * 10;
      if (sign == '-') {
        tmp -= *p - '0';
      } else {
        tmp += *p - '0';
        sign = '+';
      }

      if (num > 0 && tmp > INTMAX) {
        num = INTMAX;
        break;
      } else if (num < 0 && tmp < INTMIN) {
        num = INTMIN;
        break;
      } else {
        num = tmp;
      }
    } else if (*p == '-' && sign == 0) {
      sign = '-';
    } else if (*p == '+' && sign == 0) {
      sign = '+';
    } else if (*p == ' ' && sign == 0) {
      // skip
    } else {
      break;
    }
  } while (*++p);

  return num;
}
```
- 时间复杂度： O(n)，最坏情况下，我们也仅遍历了一遍字符串
- 空间复杂度： O(1)