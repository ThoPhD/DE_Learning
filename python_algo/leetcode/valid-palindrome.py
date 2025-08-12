import re

class Solution:
    def isPalindrome(self, s: str) -> bool:
        s = s.lower()
        s = re.sub(r'[^a-z0-9]', '', s)
        return s == s[::-1]
        # s = [c.lower() for c in s if c.isalnum()]
        # return all (s[i] == s[~i] for i in range(len(s)//2))

if __name__ == "__main__":
    sol = Solution()
    s = "A man, a plan, a canal: Panama"
    print(sol.isPalindrome(s))
    s = "race a car"
    print(sol.isPalindrome(s))
