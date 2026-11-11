int reserve(int x) {
  const int INTMAX = 0X7FFFFFFF;
  const int INTMIN = 0X80000000;
  int y = 0;
  while (x != 0) {
    long int tmp = (long int)y * 10 + (x % 10);
    if ((tmp >= 0 && tmp > INTMAX) || (tmp < 0 && tmp < INTMIN)) {
      return 0;
    } else {
      x /= 10;
      y = tmp;
    }
  }

  return y;
}