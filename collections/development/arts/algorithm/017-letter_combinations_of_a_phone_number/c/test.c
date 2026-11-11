#include "solution.h"
#include <assert.h>
#include <stdarg.h>
#include <string.h>
#include <stdio.h>

void assertSolution(char* digits, ...) {
  int returnSize = 0;
  char** result = letterCombinations(digits, &returnSize);
  int count = 0;

  va_list ap;
  va_start(ap, digits);
  // 返回数组可能是无序的，需要全部比较
  for (int i = 0; i < returnSize; i++) {
    char* item = va_arg(ap, char*);
    int hasMatch = 0;
    for (int j = 0; j < returnSize; j++) {
      if (strcmp(item, result[i]) == 0) {
        // “清空”已匹配的答案，确保无重复
        result[i] = "";
        hasMatch = 1;
        break;
      };
    }

    // 断言一定能找到匹配
    if (hasMatch) {
      count++;
    } else {
      fprintf(stderr, "can not found %s from result\n", item);
      assert(0);
    }
  }

  // 断言所有的变参都匹配上了
  assert(va_arg(ap, char*) == NULL);
  va_end(ap);
}

int main(int argc, char* argv[])
{
  assertSolution("23", "ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf");
  assertSolution("22", "aa", "ab", "ac", "ba", "bb", "bc", "ca", "cb", "cc");
  return 0;
}