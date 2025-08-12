def is_happy_number(n: int) -> bool:
    seen = set()

    while n != 1 and n not in seen:
        seen.add(n)
        n = sum(int(digit) ** 2 for digit in str(n))

    return n == 1


def next_num(n: int) -> int:
    return sum(int(digit) ** 2 for digit in str(n))


def is_happy_number_fast(n: int) -> bool:
    slow = n
    fast = next_num(n)

    while fast != 1 and slow != fast:
        slow = next_num(slow)
        fast = next_num(next_num(fast))

    return fast == 1


if __name__ == "__main__":
    # print(is_happy_number(19))  # True
    # print(is_happy_number(4))  # False
    print(is_happy_number_fast(19))
    print(is_happy_number_fast(4))
