from math import sqrt, floor


def is_prime_number(n):
    if n in [2, 3, 5, 7]:
        return True

    mid = floor(sqrt(n)) + 1
    for i in range(3, mid, 2):
        if n % i == 0:
            return False
    return True

def find_nth_prime(number):
    stt = 4
    prime = 7
    while stt < number:
        prime += 2
        if is_prime_number(prime):
            stt += 1


    return prime

if __name__ == "__main__":
    print(find_nth_prime(10001))
