import math

def is_prime(num):
    if num == 2:
        return True
    return num >= 3 and all(num % i != 0 for i in range(3, int(math.sqrt(num)) + 1, 2))

def summation_of_primes(maximum):
    res = 2
    for num in range(3, maximum, 2):
        if is_prime(num):
            res += num

    return res

if __name__ == "__main__":
    print(summation_of_primes(2000000))
