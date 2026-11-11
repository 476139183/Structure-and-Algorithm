# [数字回文](https://leetcode.com/problems/palindrome-number/solution/)
检查一个整型数字是否为回文。如果一个数字正着读/反着读都一样，它就是回文。

```
Example 1:
Input: 121
Output: true

Example 2:
Input: -121
Output: false
解释: 从左到右读做-121，但从右到左就变成了121-，所以不是回文。

Example 3:
Input: 10
Output: false
解释: 从右到左读01(零一)，从左到右读10(十)所以不是回文。
```

**哥们儿看这里：**  
有种你别把它转换为字符串再做判断啊！

## 我的思路
这就是道送分题，和007、008两题的思路一样，都是整型反转，这道题无非就是反转后和输入参数比较是否相等。不过有个灰常微妙的地方，我提交后暴击率88%，仔细研究一番发现确实还有优化空间，即没必要全部反转完，每反转一步就检查下值是否大于输入参数。如果已经大了，就根本不可能是回文，提前结束判断。
```c
bool isPalindrome(int x) {
  int forward = x;
  int backward = 0;

  if (x < 0) return 0; // false

  while (x) { // 判断条件还可以优化
    backward = (backward * 10) + (x % 10);
    x /= 10;
  }

  return forward == backward;
}
```

## 方案一、反转一半数字
脑子里的第一反应是把数字转为字符串，然后判断字符串是否是回文，但需要创建额外的非常数空间来保存字符串，本题也说了不要这么干。

第二反应就是反转整个数字，然后和最初的数字比较，如果它们相同就说明是回文。总之，如果反转时数字超过INTMAX，你就悲剧了。

接下来是基于第二个想法，反转时避免INTMAX溢出问题，我们只反转一半怎么样？毕竟，对于一个数字来说，如果后半段和它的前半段相同，那肯定就是回文了。

比如`1221`，如果我们只反转了后半部分`12**21**`既从“21”变成“12”，拿着它和原来的数字前半部分比较，也是“12”，我滴个亲娘，这不就是回文吗。

来，跟着哥一起把刚才的想法转换成算法：

### 算法
首先需要干掉一些边缘情况。所有负数都不可能是回文，比如-123，这个'-'不可能和'3'相等，所以遇到负数果断返回false。

然后想想怎么反转数字的后半部分。对于数字`1221`，如果用`1221 % 10`可以得到最后一个数字`1`，为了得到倒数第二个数，我们需要先踢走`1221`的末尾，这不就是`1221 / 10 = 122`么。然后在用刚才的办法`122 % 10 = 2`取模即可。如果把末尾的数字乘以10再加上倒数第二个数字`1 * 10 + 2 = 12`，这不就反转了嘛，你要原意可以继续这样操作，把所有数都反转一遍。

现在这个问题变成，我他妈怎么知道什么时候反转了一半？

我们一直在对原始数除以10，反转数乘以10，当原始数小于反转数的那一刻，就意味着刚好反转了一半。
```csharp
public class Solution {
    public bool IsPalindrome(int x) {
        // Special cases:
        // As discussed above, when x < 0, x is not a palindrome.
        // Also if the last digit of the number is 0, in order to be a palindrome,
        // the first digit of the number also needs to be 0.
        // Only 0 satisfy this property.
        if(x < 0 || (x % 10 == 0 && x != 0)) {
            return false;
        }

        int revertedNumber = 0;
        while(x > revertedNumber) {
            revertedNumber = revertedNumber * 10 + x % 10;
            x /= 10;
        }

        // When the length is an odd number, we can get rid of the middle digit by revertedNumber/10
        // For example when the input is 12321, at the end of the while loop we get x = 12, revertedNumber = 123,
        // since the middle digit doesn't matter in palidrome(it will always equal to itself), we can simply get rid of it.
        return x == revertedNumber || x == revertedNumber/10;
    }
}
```
- 时间复杂度：O(log10(n))，因为每次除以10
- 空间复杂度：O(log10(n))