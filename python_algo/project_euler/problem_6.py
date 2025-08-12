def sum_square_difference(number: int) -> int:
    sum_of_square = 0
    sum_ = 0
    for i in range(0, number + 1):
        sum_of_square += i ** 2
        sum_ += i

    return sum_ ** 2 - sum_of_square

if __name__ == "__main__":
    print(sum_square_difference(100))
