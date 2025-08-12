def sum_of_fibonaci_sequence(max_elements: int) -> int:
    sum_of_values = 0
    prev_last, last = 1, 2
    while last <= max_elements:
        if last % 2 == 0:
            sum_of_values += last
        prev_last, last = last, prev_last + last

    return sum_of_values


# The limit is four million

if __name__ == "__main__":
    limit = 4000000
    # limit = 35
    # result = sum_even_fibonacci(limit)
    result = sum_of_fibonaci_sequence(limit)
    print(f"The sum of the even-valued terms in the Fibonacci sequence not exceeding {limit} is: {result}")
