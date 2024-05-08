int removeDuplicates(int* nums, int numsSize) {
  unsigned int j, k, count;
  int          cur;

  if (!numsSize)
    return 0;

  cur   = nums[0];
  count = 1;
  for (j = 1, k = 1; j < numsSize; j++, k++) {
    if (cur == nums[j])
      count++;
    else {
      count = 1;
      cur   = nums[j];
    }
    if (count > 2)
      k--;
    else
      nums[k] = nums[j];
  }

  return k;
}

int main(void) {
  int nums[] = {1,1,1,2,2,3};
  int res    = removeDuplicates(nums, 6);

/*
  int nums[] = {0,0,1,1,1,1,2,3,3};
  int res    = removeDuplicates(nums, 9);
*/
  return 0;
}
