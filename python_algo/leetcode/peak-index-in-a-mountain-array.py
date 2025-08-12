from typing import List


class Solution:
    def peakIndexInMountainArray(self, arr: List[int]) -> int:
        return arr.index(max(arr))

class SolutionV2:
    def peakIndexInMountainArray(self, arr: List[int]) -> int:
        left = 1
        right = len(arr) - 2
        res = 0
        while left <= right:
            mid_index = (left + right) // 2
            if arr[mid_index - 1] < arr[mid_index] > arr[mid_index + 1]:
                return mid_index
            if arr[mid_index - 1] > arr[mid_index]:
                right = mid_index - 1
            else:
                left = mid_index + 1

        return res

if __name__ == "__main__":
    obj = SolutionV2()
    arr_ = [0,10,5,2]
    print(obj.peakIndexInMountainArray(arr_))
