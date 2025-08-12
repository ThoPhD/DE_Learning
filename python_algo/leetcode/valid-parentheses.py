class Solution:
    def isValid(self, s: str) -> bool:
        if len(s) % 2 == 1:
            return False

        parentheses_map = {
            ")": "(",
            "]": "[",
            "}": "{",
        }
        stack_of_char = []
        for char in s:
            if char in ["(", "[", "{"]:
                stack_of_char.append(char)
            else:
                if len(stack_of_char) == 0:
                    return False
                top = stack_of_char.pop()
                if parentheses_map[char] != top:
                    return False

        return len(stack_of_char) == 0

if __name__ == "__main__":
    s = "()"
    obj = Solution()
    print(obj.isValid(s))
