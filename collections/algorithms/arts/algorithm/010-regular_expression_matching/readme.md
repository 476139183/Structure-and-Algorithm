# [正则表达式匹配](https://leetcode.com/problems/regular-expression-matching/solution/)
给一个字符串(`s`)和模式(`p`)，实现支持`'.'`和`'*'`的正则表达式匹配。
```
'.' 匹配任何单个字符
'*' 匹配0次或多次前面的元素
```
注意是整个字符串完全匹配(不是部分匹配)。

**注意：**  
- `s`可以为空或只包含小写字母的`a-z`
- `p`可以为空或只包含小写字母的`a-z`以及字符`'.'`或`'*'`

```
Example 1:
Input:
s = "aa"
p = "a"
Output: false
Explanation: "a"无法匹配整个字符串"aa".

Example 2:
Input:
s = "aa"
p = "a*"
Output: true
Explanation: '*'意味着匹配0次或多次前面的字符'a'，'a'重复一次就变成了"aa".

Example 3:
Input:
s = "ab"
p = ".*"
Output: true
Explanation: ".*"代表"0次或多次(*) 任意字符(.)".

Example 4:
Input:
s = "aab"
p = "c*a*b"
Output: true
Explanation: c可以重复0次 a刻意重复1次。所以能够匹配"aab".

Example 5:
Input:
s = "mississippi"
p = "mis*is*p*."
Output: false
```

## 方案一、递归
要是没有这该死的星星(表达式里的`*`通配符)，这道题本来是so easy的，我们可以愉快地从左到右遍历一遍字符串是否匹配规则。

但有了星号之后吗，我们需要确认剩下的text是否匹配剩下的pattern。递归就是表达这种关系的最直接方案。

### 算法
在没有星号的情况下，我们的算法会是这样的：
```python
def match(text, pattern):
    if not pattern: return not text
    first_match = bool(text) and pattern[0] in {text[0], '.'}
    return first_match and match(text[1:], pattern[1:])
```

在有星号的情况下，我们需要定位`pattern[1]`的情况。我们可以忽略或删除已经匹配过的text，把剩下的部分当作下次匹配操作的初始化参数。
```java
class Solution {
    public boolean isMatch(String text, String pattern) {
        if (pattern.isEmpty()) return text.isEmpty();
        boolean first_match = (!text.isEmpty() &&
                               (pattern.charAt(0) == text.charAt(0) || pattern.charAt(0) == '.'));

        if (pattern.length() >= 2 && pattern.charAt(1) == '*'){
            return (isMatch(text, pattern.substring(2)) ||
                    (first_match && isMatch(text.substring(1), pattern)));
        } else {
            return first_match && isMatch(text.substring(1), pattern.substring(1));
        }
    }
```
- 时间复杂度：T、P分别表示输入参数`text`和`pattern`的长度(...公式太多markdown不好写，看原文吧)
- 空间复杂度：为了每次递归调用`match`方法，都需要分配输入参数的空间。如果内存不释放，那总的空间会有O((T+P) * 2的(T + P/2)次方)

## 方案二、动态规划
把该问题当作一个**最优字结构**，它可以自然地缓存中间结果。我们可以设想db(i,j)的问题：每次匹配`text[i:]`和`pattern[j:]`行吗？我们可以通过更少的字符串来解答该问题。

### 算法
我们采用与方案一相同的递归方案来处理，然后把其中匹配调用`match(text[i:], parttern[j:])`用`dp(i, j)`替换掉，保存下这些string-building操作，并缓存途中的结果。

*自上而下*
```java
enum Result {
    TRUE, FALSE
}

class Solution {
    Result[][] memo;

    public boolean isMatch(String text, String pattern) {
        memo = new Result[text.length() + 1][pattern.length() + 1];
        return dp(0, 0, text, pattern);
    }

    public boolean dp(int i, int j, String text, String pattern) {
        if (memo[i][j] != null) {
            return memo[i][j] == Result.TRUE;
        }
        boolean ans;
        if (j == pattern.length()){
            ans = i == text.length();
        } else{
            boolean first_match = (i < text.length() &&
                                   (pattern.charAt(j) == text.charAt(i) ||
                                    pattern.charAt(j) == '.'));

            if (j + 1 < pattern.length() && pattern.charAt(j+1) == '*'){
                ans = (dp(i, j+2, text, pattern) ||
                       first_match && dp(i+1, j, text, pattern));
            } else {
                ans = first_match && dp(i+1, j+1, text, pattern);
            }
        }
        memo[i][j] = ans ? Result.TRUE : Result.FALSE;
        return ans;
    }
}
```

*自下而上*
```java
class Solution {
    public boolean isMatch(String text, String pattern) {
        boolean[][] dp = new boolean[text.length() + 1][pattern.length() + 1];
        dp[text.length()][pattern.length()] = true;

        for (int i = text.length(); i >= 0; i--){
            for (int j = pattern.length() - 1; j >= 0; j--){
                boolean first_match = (i < text.length() &&
                                       (pattern.charAt(j) == text.charAt(i) ||
                                        pattern.charAt(j) == '.'));
                if (j + 1 < pattern.length() && pattern.charAt(j+1) == '*'){
                    dp[i][j] = dp[i][j+2] || first_match && dp[i+1][j];
                } else {
                    dp[i][j] = first_match && dp[i+1][j+1];
                }
            }
        }
        return dp[0][0];
    }
}
```
时间复杂度：T、P表示text和pattern的长度，dp(i,j)需要被调用i和j次，所以是O(TP) => O(n²)
空间复杂度：每次dp操作都需要缓存字符串，所以也是O(TP)