from typing import List


class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        cur_sum = 0
        max_sum = nums[0]

        for num in nums:
            cur_sum += num
            max_sum = max(cur_sum, max_sum)
            if cur_sum < 0:
                cur_sum = 0

        return max_sum
