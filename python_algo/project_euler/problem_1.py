# https://projecteuler.net/problem=1

def sum_of_multiples_of_3_or_5(max_number):
    res = 0
    for i in range(3, max_number):
        if i % 3 == 0 or i % 5 == 0:
            res += i
    return res

if __name__ == "__main__":
    a = sum_of_multiples_of_3_or_5(1000)
    print(a)
