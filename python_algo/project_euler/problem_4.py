def is_palindromic_number(number):
    temp = number
    reverse_number = 0
    while temp != 0:
        reverse_number = reverse_number * 10 + temp % 10
        temp = temp // 10

    return number == reverse_number

if __name__ == "__main__":
    a = max([(x * y, x, y) for x in range(900, 1000) for y in range(900, 1000) if is_palindromic_number(x * y)])
    print(a)
