# [ZigZag Conversion](https://leetcode.com/problems/zigzag-conversion/solution)

将字符串“PAYPALISHIRING”通过指定行数进行倒“Z”形折线转换如下：
```
P   A   H   N
A P L S I I G
Y   I   R
```
此时连起来读成："PAHNAPLSIIGYIR"

实现下面的函数，将给定的字符串和行数作为参数进行转换：  
`string convert(string s, int numRows);`
```
Example 1:
Input: s = "PAYPALISHIRING", numRows = 3
Output: "PAHNAPLSIIGYIR"

Example 2:
Input: s = "PAYPALISHIRING", numRows = 4
Output: "PINALSIGYAHRPI"

解释（睡到的Z字形）:
P     I    N
A   L S  I G
Y A   H R
P     I
```

## 我的思路
其实和官方的方案二差不多，基本就是通过数学公式，计算转换后的每一行的每个字符应该属于原字符串s中的哪个索引。  
貌似没什么好说的😳
```c
if (numRows == 1) {
    return s;
  }

  int slen = strlen(s);
  int clen = 2 * numRows - 2; // cycle lenth
  char* zigzag = (char*)calloc(slen + 1, sizeof(char));
  char* z = zigzag;

  // first row
  for (int c = 0; c < slen; c += clen) {
    if (c < slen) *z++ = s[c];
  }

  // inner row & each cycle
  for (int r = 1; r < numRows - 1; r++) {
    for (int c = 0; c < slen; c += clen) {
      int left = c + r;
      int right = c + clen - r;
      if (left < slen) *z++ = s[left];
      if (right < slen) *z++ = s[right];
    }
  }

  // last row
  for (int c = 0; c < slen; c += clen) {
    int i = c + numRows - 1;
    if (i < slen) *z++ = s[i];
  }

  return zigzag;
```
- 时间复杂度：O(n)，虽然是3个for，但其实是分别遍历Z的每一行
- 空间复杂度：O(n)

## 方案一、老实排序法
**大意**  
通过字符串从左到右的遍历，我们可以比较容易的一个字符是属于Z字中的哪一行。总的来说就是先把Z图案给“画”出来，然后在一行行地生成要返回的字符串。

**算法**  
我们可以使用min(numRows,len(s))列表来表示Z折线的非空行。  
从左往右遍历字符串s，并把每个字符附加到对应行。对英航可以通过两个变量跟踪：当前行与当前方向。  
当前方向尽在我们已经移至最高或最低点是才会需要改变。
```java
class Solution {
    public String convert(String s, int numRows) {

        if (numRows == 1) return s;

        List<StringBuilder> rows = new ArrayList<>();
        for (int i = 0; i < Math.min(numRows, s.length()); i++)
            rows.add(new StringBuilder());

        int curRow = 0;
        boolean goingDown = false;

        for (char c : s.toCharArray()) {
            rows.get(curRow).append(c);
            if (curRow == 0 || curRow == numRows - 1) goingDown = !goingDown;
            curRow += goingDown ? 1 : -1;
        }

        StringBuilder ret = new StringBuilder();
        for (StringBuilder row : rows) ret.append(row);
        return ret.toString();
    }
}
```
- 时间复杂度：O(n)，3大个for在哪里，还好是并排站着，最大也就n == len(s)
- 空间复杂度：O(n)，因为return需要分配新的字符串内存嘛

## 方案二、确认眼神法
**大意**  
仔细看，每一个字符应该被分配到Z字中的哪行哪列是有规律的，可以找到它在原字符串的索引是多少。

**算法**  
现在纸上画个简单的Z图案出来，类似下方这种：  
```
0       8         16
1     7 9      15 17
2   6  10   14    18
3 5    11 13
4      12
```
如何得到这个公示？观察每个字符在第0行的首字符，然后是第1行，第2行...等等  
把这个字母Z进一步分为有点斜的字母V，表示一个轮回，每个轮回长度刚好是2*numRows - 2  
经过严密的推敲，我们可以得到以下公示：
- 字符在第一行，索引为k(2*numRows - 2)
- 字符在末尾行，索引为k(2*numRows - 2) + numRows - 1
- 字符在中间行，索引为k(2*numRows - 2) + i和(k+1)(2*numRows - 2) - i
```java
class Solution {
    public String convert(String s, int numRows) {

        if (numRows == 1) return s;

        StringBuilder ret = new StringBuilder();
        int n = s.length();
        int cycleLen = 2 * numRows - 2;

        for (int i = 0; i < numRows; i++) {
            for (int j = 0; j + i < n; j += cycleLen) {
                ret.append(s.charAt(j + i));
                if (i != 0 && i != numRows - 1 && j + cycleLen - i < n)
                    ret.append(s.charAt(j + cycleLen - i));
            }
        }
        return ret.toString();
    }
}
```
- 时间复杂度：O(n)，别看for嵌套，每个字符仅观察一次
- 空间复杂度：O(n)