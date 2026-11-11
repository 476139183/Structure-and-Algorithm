#include <stdlib.h>
#include <string.h>

/**
 * Return an array of size *returnSize.
 * Note: The returned array must be malloced, assume caller calls free().
 */
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
  char** combinations = (char**)calloc(*returnSize, sizeof(char*));
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