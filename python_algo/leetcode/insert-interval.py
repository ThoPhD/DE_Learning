from typing import List

class Solution:
    def insert(self, intervals: List[List[int]], newInterval: List[int]) -> List[List[int]]:
        if not intervals or not newInterval:
            return intervals if intervals else [newInterval]

        res = []
        new_start = newInterval[0]
        new_end = newInterval[1]
        for index, interval in enumerate(intervals):
            if new_start < interval[0] and interval[1] < new_end:
                continue
            if interval[0] < new_start and new_end < interval[1]:
                return intervals
            if interval[0] < new_start < interval[1] < new_end:
                res.append([interval[0], None])
            if new_start < interval[0] < new_end < interval[1]:
                res[-1][-1] = interval[1]
            if new_end < interval[0]:
                res.append(interval)
            if interval[1] < new_start:
                res.append(interval)

        return res

if __name__ == "__main__":
    sol = Solution()
    intervals = [[1, 5]]
    new = [2, 7]
    print(sol.insert(intervals, new))
