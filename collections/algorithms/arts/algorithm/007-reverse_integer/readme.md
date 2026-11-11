# [Reverse Integer](https://leetcode.com/problems/reverse-integer/solution)

给一个32位的整型数字，反转它
```
Example 1:
Input: 123
Output: 321

Example 2:
Input: -123
Output: -321

Example 3:
Input: 120
Output: 21
```
注意:  
假定我们的环境仅能存储32位的无符号整型，其范围：[−231,  231 − 1]。当该函数反转后的整型值超出该范围时返回0。

## 我的思路
这道题貌似没什么特别的技巧，基本就是取出每一位，然后转换数字乘10再加它，但需要注意不要溢出。
```c
int reserve(int x) {
  const int INTMAX = 0X7FFFFFFF;
  const int INTMIN = 0X80000000;
  int y = 0;

  while (x != 0) {
    long int tmp = (long int)y * 10 + (x % 10);
    if ((tmp >= 0 && tmp > INTMAX) || (tmp < 0 && tmp < INTMIN)) {
      return 0;
    } else {
      x /= 10;
      y = tmp;
    }
  }

  return y;
}
```

## 方案一、Pop和Push数字并在溢出前检查
我们可以反复“pop”数字的最后以为，然后再“push”到另一个反转的数字后边。
```java
// pop操作
pop = x % 10
x = x / 10

// push操作
temp = rev * 10 + pop;
rev = temp;
```
注意，push这步比较坑，因为`rev * 10 + pop`有可能会溢出。可以在赋值之前检查是否溢出。

```java
class Solution {
    public int reverse(int x) {
        int rev = 0;
        while (x != 0) {
            int pop = x % 10;
            x /= 10;
            if (rev > Integer.MAX_VALUE/10 || (rev == Integer.MAX_VALUE / 10 && pop > 7)) return 0;
            if (rev < Integer.MIN_VALUE/10 || (rev == Integer.MIN_VALUE / 10 && pop < -8)) return 0;
            rev = rev * 10 + pop;
        }
        return rev;
    }
}
```
- 时间复杂度：O(n)，大概是x的位数
- 空间复杂度：O(1)