int romanToInt(char* s) {
  int num = 0;
  int roman[] = {
    ['M'] = 1000,
    ['D'] = 500,
    ['C'] = 100,
    ['L'] = 50,
    ['X'] = 10,
    ['V'] = 5,
    ['I'] = 1,
    [0]   = 0,
  };

  while (*s) {
    int a = roman[*s];
    int b = roman[*++s];
    if (a < b) {
      num += b - a;
      s++;
    } else {
      num += a;
    }
  }

  return num;
}