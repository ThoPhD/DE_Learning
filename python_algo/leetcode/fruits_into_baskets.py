# https://leetcode.com/problems/fruits-into-baskets-iii/?envType=daily-question&envId=2025-08-06
from typing import List
class Solution:
    def numOfUnplacedFruits(self, fruits: List[int], baskets: List[int]) -> int:
        for quantity in fruits:
            for capacity in baskets:
                if quantity <= capacity:
                    baskets.remove(capacity)
                    break
        return len(baskets)
