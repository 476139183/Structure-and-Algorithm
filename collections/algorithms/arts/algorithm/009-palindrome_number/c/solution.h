bool isPalindrome(int x) {
  int forward = x;
  int backward = 0;

  if (x < 0) return 0; // false

  while (x) {
    backward = (backward * 10) + (x % 10);
    x /= 10;
  }

  return forward == backward;
}