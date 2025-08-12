n = 2 ** 1000
digit_sum = 0

while n > 0:
    digit_sum += n % 10
    n //= 10

if __name__ == "__main__":
    print("Sum of digits:", digit_sum)
