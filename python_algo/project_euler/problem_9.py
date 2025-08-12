def solution_grid_search() -> int:
    for a in range(1, 1000):
        for b in range(a, 500 - a // 2):
            c = 1000 - a - b
            if a**2 + b**2 == c**2:
                return a * b * c

if __name__ == "__main__":
    print(solution_grid_search())
