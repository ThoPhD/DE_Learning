from collections import defaultdict

class Solution:
    def isAnagram(self, s: str, t: str) -> bool:

        s_map = defaultdict(int)
        t_map = defaultdict(int)
        for char in s:
            s_map[char] += 1
        for char in t:
            t_map[char] += 1

        return s_map == t_map
