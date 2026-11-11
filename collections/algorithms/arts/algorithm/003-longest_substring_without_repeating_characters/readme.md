# [Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/solution/)

给定一个字符串，找出其中没有重复字符的最长一个字串，返回字串长度。
```
Example 1:
Input: "abcabcbb"
Output: 3 
解释: "abc"是不重复的字串, 长度为3. 

Example 2:
Input: "bbbbb"
Output: 1
解释: 只有一个"b"不重复, 长度为1.

Example 3:
Input: "pwwkew"
Output: 3
Explanation: "wke"没有重复字符, 长度为三3. 注意必须是字串, "pwke"不叫作字串.
```

## 我的思路
这是我的第三个算法题，基于前两道题目的过程经验，我必须记录第三题的思想转变。  
面对这道题我一开始是这么想的，先各种遍历几遍，把字符串中的不重复字串全部找出来，然后比较每个字串长度最长的那个。  
到这里，我自己心里都在打鼓，这他妈时间/空间复杂度会多高啊，一定还有更好的方式。  
想啊想，忽然想起TwoSum的逆向思维求解。  
于是乎，既然它要得只是长度，我这么想问题，从第一个字母开始找到下一个相同字母，找到后只存下长度，并和上一次的长度比较(冒泡)，通过冒泡法获取长度最长的那一个。   
我只需要遍历一遍，最大长度就出来了！！

**下面是官方解决方案，可能和我的思路很不一样**

## 方案一、简单粗暴
假设有一个函数`allUnique(substring)`，正如其名称一样，如果函数返回ture说明字符串里每一个字符是否都是唯一的，否则返回false。然后我们可以讲一个字符串所有可能的字串都丢到这个函数里检查，然后把所有返回true的情况都比较一遍，看看谁最大。
```java
public class Solution {
    public int lengthOfLongestSubstring(String s) {
        int n = s.length();
        int ans = 0;
        for (int i = 0; i < n; i++)
            for (int j = i + 1; j <= n; j++)
                if (allUnique(s, i, j)) ans = Math.max(ans, j - i);
        return ans;
    }

    public boolean allUnique(String s, int start, int end) {
        Set<Character> set = new HashSet<>();
        for (int i = start; i < end; i++) {
            Character ch = s.charAt(i);
            if (set.contains(ch)) return false;
            set.add(ch);
        }
        return true;
    }
}
```
- 时间复杂度：O(n³)，主函数两层for，allUnique函数里还有一层for
- 空间复杂度：O(min(n, m))，因为allUnique需要HashSet空间，n为字符串长度，m为字母表长度

## 方案二、滑窗算法
上面一种方案非常简单，但太慢了，它有一个很大的问题就是一个字符会重复检查很多遍，完全多余！如果字符串中s[i]～s[j-1]都确定没有重复字符了，对于s[j]只需要检查它有没有与之前的子串重复。  

用HashSet作为一个滑窗来检查字符重复问题，可以把复杂度降为O(1)  
滑窗是一个抽象的哲学概念，用于处理数组/字符串的问题。窗体范围通常是数组/字符串中某段的起止索引。比如[i,j)左闭右开区间。所谓"滑“窗即是通过边界来控制运动方向，例如[i,j)窗体右移就可以通过[i+1, j+1)的方式。

回到问题本身，我们可以通过哈希表来存储滑窗边界内的所有字符，然后每次只判断s[j]，如果不存在哈希表中，继续把j滑得更远，直到在哈希表中找到和s[j]有重复的情况，就开始滑动i边界，直到窗体内没有重复，每次滑动窗体(在没有重复的情况下)都通过冒泡来获得窗体最大长度，就能得到我们想要的答案：
```java
public class Solution {
    public int lengthOfLongestSubstring(String s) {
        int n = s.length();
        Set<Character> set = new HashSet<>();
        int ans = 0, i = 0, j = 0;
        while (i < n && j < n) {
            // try to extend the range [i, j]
            if (!set.contains(s.charAt(j))){
                set.add(s.charAt(j++));
                ans = Math.max(ans, j - i);
            }
            else {
                set.remove(s.charAt(i++));
            }
        }
        return ans;
    }
}
```
- 时间复杂度：O(2n)=O(n)，最差情况下所有字符都会被访问两次，因为i、j的移动
- 空间复杂度：O(min(n, m))，道理同方案一

## 方案三、滑窗优化版
基于方案二的想法(每次都要先滑动边界j，再滑动边界)，其实可以只滑动边界j的，当发现s[j]在窗体内有副本时，我们只需要把窗体的i边界跳转到那个副本的索引处不就行了吗。那么问题来了，如何跳转？  
其实根本不算个问题，用HashMap，每次滑动s[j]的时候都把该字符的索引当作哈希值存下来不就行了么。当发现s[j]有副本的时候，把i边界替换问副本的哈希值即索引。
```java
public class Solution {
    public int lengthOfLongestSubstring(String s) {
        int n = s.length(), ans = 0;
        Map<Character, Integer> map = new HashMap<>(); // current index of character
        // try to extend the range [i, j]
        for (int j = 0, i = 0; j < n; j++) {
            if (map.containsKey(s.charAt(j))) {
                i = Math.max(map.get(s.charAt(j)), i);
            }
            ans = Math.max(ans, j - i + 1);
            map.put(s.charAt(j), j + 1);
        }
        return ans;
    }
}
```
- 时间复杂度：O(n)，一个for循环
- 空间复杂度：O(min(n, m))，不解释

## ASCII字符降低空间复杂度
前面的方案中基本都没考虑过字符集的问题，都是各种Set、Map动态分配来搞定，但我们知道ASCII字符集其实很小：
- int[26]  'a' - 'z' or 'A' - 'Z'
- int[128] ASCII
- int[256] ASCII扩展

所以代码可以改为如下
```java
public class Solution {
    public int lengthOfLongestSubstring(String s) {
        int n = s.length(), ans = 0;
        int[] index = new int[128]; // current index of character
        // try to extend the range [i, j]
        for (int j = 0, i = 0; j < n; j++) {
            i = Math.max(index[s.charAt(j)], i);
            ans = Math.max(ans, j - i + 1);
            index[s.charAt(j)] = j + 1;
        }
        return ans;
    }
}
```
- 时间复杂度：O(n)，同方案三
- 空间复杂度：O(1)，不解释