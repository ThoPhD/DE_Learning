CHECK_LIST = [11, 13, 14, 16, 17, 18, 19, 20]

def smallest_multiple(step):
    for num in range(step, 999999999, step):
        if all(num % i == 0 for i in CHECK_LIST):
            return num
    return None

if __name__ == '__main__':
    solution = smallest_multiple(20)
    print(solution)
