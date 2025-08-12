from typing import List


class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        hash_map = {num: index for index, num in enumerate(nums)}

        for index, num in enumerate(nums):
            if (target - num) in hash_map:
                if index == hash_map[target - num]:
                    continue
                return [index, hash_map[target - num]]
            else:
                continue

        return [0]
