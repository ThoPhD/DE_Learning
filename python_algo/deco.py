def generate_power(exponent):
    def decorator(f):
        def inner(*args):
            result = f(*args)
            return exponent ** result

        return inner

    return decorator


@generate_power(2)
def raise_two(n):
    return n


@generate_power(3)
def raise_three(n):
    return n


if __name__ == "__main__":
    print(raise_two(7))

    print(raise_two(5))
