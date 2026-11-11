#include <stdlib.h>

char* intToRoman(int num) {
  const char* roman[][10] = {
    {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"},
    {"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"},
    {"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"},
    {"", "M", "MM", "MMM"}
  };
  
  const char* carry[4] = {0};
  for (int i = 0; i < 4; i++) {
    carry[i] = roman[i][num % 10];
    num /= 10;
  }

  char* result = (char*)calloc(16, 1);
  char *p = result;
  for (int i = 3; i >= 0; i--) {
    for (int j = 0; carry[i][j]; j++) {
      *p = carry[i][j];
      p++;
    }
  }

  return result;
}