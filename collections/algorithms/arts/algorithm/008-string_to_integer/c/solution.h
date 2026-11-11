int myAtoi(char* str) {
  const int INTMAX = 0X7FFFFFFF;
  const int INTMIN = 0X80000000;
  char* p = str;
  int num = 0;
  char sign = 0; // +/-

  if (str == 0) {
    return 0;
  }

  do {
    if (*p >= '0' && *p <= '9') {
      long int tmp = (long int)num * 10;
      if (sign == '-') {
        tmp -= *p - '0';
      } else {
        tmp += *p - '0';
        sign = '+';
      }

      if (num > 0 && tmp > INTMAX) {
        num = INTMAX;
        break;
      } else if (num < 0 && tmp < INTMIN) {
        num = INTMIN;
        break;
      } else {
        num = tmp;
      }
    } else if (*p == '-' && sign == 0) {
      sign = '-';
    } else if (*p == '+' && sign == 0) {
      sign = '+';
    } else if (*p == ' ' && sign == 0) {
      // skip
    } else {
      break;
    }
  } while (*++p);

  return num;
}