# https://datalemur.com/questions/python-looping-number

def calculate_sum_of_squares_of_digits(n):
    sum_of_squares = 0

    while n / 10 > 0:
        sum_of_squares += (n % 10) ** 2
        n = n // 10

    return sum_of_squares


def is_looping(n):
    start_number = n
    sum_of_squares = calculate_sum_of_squares_of_digits(n)
    while sum_of_squares != start_number:
        sum_of_squares = calculate_sum_of_squares_of_digits(sum_of_squares)
        if sum_of_squares == 1:
            return False
    return True


if __name__ == "__main__":
    print(is_looping(19))
