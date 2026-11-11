int maxArea(int* height, int heightSize) {
  int left = 0;
  int right = heightSize - 1;
  int max = 0;

  while (left != right) {
    int area = 0;
    if (height[left] < height[right]) {
      area = height[left] * (right - left);
      left++;
    } else {
      area = height[right] * (right - left);
      right--;
    }
    
    max = max > area ? max : area;
  }

  return max;
}