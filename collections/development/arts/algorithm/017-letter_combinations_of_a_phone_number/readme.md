# [电话数字键盘的字母组合](https://leetcode.com/problems/letter-combinations-of-a-phone-number/)

给一个包含`2-9`的字符串，返回所有可能的由数字表示的字母组合。

数字字母表(就像电话上那种数字键盘)如下图所示，注意数字1不包含任何字母

![电话键盘示意图](http://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Telephone-keypad2.svg/200px-Telephone-keypad2.svg.png)

```
Example:
Input: "23"
Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
```

**注意**：  
上边的答案是按照字典编纂的顺序排列的，你的答案可以随心所欲排序，你开心就好😊

## 我的思路：计数法
由于没有官方解答，而且我没有一个比较专业的叫法，所以把我的思路称为`计数法`——就像数数一样，从末尾开始字母一个个的翻牌。

先来看题意，看似简单，就是随机按下几个数字键，找出每个键映射的字母组合，大概可以get到以下几点：
1. 字母组合的长度一定等于输入数字字符串的长度
2. 字母组合的总数一定等于输入的每个数字对应字母数量的乘积
3. 题目没有说明输入数字是否有重复，所以假定会有
4. 输入的数字字符有8种，所以一定要定义8张字母表

其实这几条分析都不难实现，对我而言难的是`字母组合`的策略，说白了，假如输入了6个数字字符，那对应6长字母表，你是从左往右，还是从右往左排列的问题。说起来简单，我一开始想过`链表`、`双指针`等方式，都无功而返。

最后觉得可能自己把问题想复杂了，换了中思路，就像小孩数数一样:`0001 0002 0003 ... 0098 0099 0100`，即输入数字`digits`的每个字符对应一张字母表，每张字母表都在做`累加`，直到累加到字符串末尾`\0`的时候触发`进位`。
```c
char** letterCombinations(char* digits, int* returnSize) {
  const char* map[] = {"abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
  int len = strlen(digits);
  struct letter {
    const char* p;
    const char* map;
  } *letters = (struct letter*)calloc(len, sizeof(struct letter));

  // 把digits每个字符对应的字母表找出并存下
  *returnSize = len == 0 ? 0 : 1;
  for (int i = 0; i < len; i++) {
    int k = digits[i] - '2';
    letters[i].map = map[k];
    letters[i].p = map[k];
    *returnSize *= (digits[i] == '7' || digits[i] == '9') ? 4 : 3;
  }

  // 将所有字母表完全遍历混合
  char** combinations = calloc(*returnSize, sizeof(char*));
  for (int i = 0; i < *returnSize; i++) {
    combinations[i] = (char*)calloc(len + 1, sizeof(char));
    for (int j = 0; j < len; j++) {
      combinations[i][j] = letters[j].p[0];
    }
    combinations[i][len] = '\0';

    struct letter* node = &letters[len - 1];
    while (*(++(node->p)) == '\0') {
      node->p = node->map;
      if (--node < letters) break;
    }
  }

  free(letters);
  return combinations;
}
```
- 时间复杂度：O(n²)两层循环嵌套，`returnSize * len(digits)`
- 空间复杂度：O(n)最大`4 * len(digits)`