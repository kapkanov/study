#include <iostream>
#include <vector>

void printVector(const std::vector<int> &v) {
  for (int num : v) {
    std::cout << " " << num;
  }
  std::cout << std::endl << std::endl;
}

void merge(std::vector<int> &vec, int left, int mid, int right) {
  int lenLeft  = mid - left + 1;
  int lenRight = right - mid;

  std::vector<int> vleft(lenLeft);
  std::vector<int> vright(lenRight);

  int j, k, n;

  for (j = 0; j < lenLeft; j++) {
    vleft[j] = vec[left + j];
  }

  for (k = 0; k < lenRight; k++) {
    vright[k] = vec[mid + 1 + k];
  }

  for (j = 0, k = 0, n = left; j < lenLeft && k < lenRight; n++) {
    if (vleft[j] <= vright[k]) {
      vec[n] = vleft[j];
      j++;
    } else {
      vec[n] = vright[k];
      k++;
    }
  }

  for (; j < lenLeft; j++) {
    vec[n] = vleft[j];
    n++;
  }

  for (; k < lenRight; k++) {
    vec[n] = vright[k];
    n++;
  }
}

void mergeSort(std::vector<int> &vec, int left, std::size_t right) {
  if (left >= right) {
    return;
  }

  int mid = (right - left) / 2 + left;

  #ifdef MERGESORT_DEBUG
  std::cout << left << " " << mid << " " << right << std::endl;
  #endif

  mergeSort(vec, left, mid);
  mergeSort(vec, mid + 1, right);
  merge(vec, left, mid, right);
}

// std::vector<int> sortedUnion(const std::vector<int> &vector1, const std::vector<int> &vector2) {
// }

int main(void) {
  std::vector<int> vec = {9,8,7,6,5,4,3,2,1,0};
  printVector(vec);

  mergeSort(vec, 0, vec.size() - 1);
  printVector(vec);

  return 0;
}
