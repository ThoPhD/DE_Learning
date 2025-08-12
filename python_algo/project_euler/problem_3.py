from math import sqrt, floor

def largest_prime_factor(number: int) -> int:
    max_range = floor(sqrt(number))
    res = 2
    while number % 2 == 0:
        number /= 2

    for i in range(3, max_range, 2):
        if number % i == 0:
            number /= i
            res = i
    return res

if __name__ == "__main__":
    num_ = 600851475143
    a = largest_prime_factor(num_)
    print(a)
