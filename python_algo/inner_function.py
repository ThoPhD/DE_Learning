def factorial(number):
    # Error handling
    if not isinstance(number, int):
        raise TypeError("Sorry. 'number' must be an integer.")
    if not number >= 0:
        raise ValueError("Sorry. 'number' must be zero or positive.")

    inner_factorial = lambda x: 1 if x <= 1 else x * inner_factorial(x - 1)

    return inner_factorial(number)


def process(file_name):
    def do_stuff(file_process):
        wifi_locations = {}

        for line in file_process:
            values = line.split(',')
            # Build the dict and increment values.
            if len(values) >= 2:
                wifi_locations[values[1]] = wifi_locations.get(values[1], 0) + 1

        max_key = 0
        for name, key in wifi_locations.items():
            all_locations = sum(wifi_locations.values())
            if key > max_key:
                max_key = key
                business = name

        print(
            'There are {} WiFi hotspots in NYC, and {} has the most with {}.'.format(all_locations, business, max_key)
        )

    if isinstance(file_name, str):
        with open(file_name, 'r') as f:
            do_stuff(f)
    else:
        do_stuff(file_name)

def has_permission(page):
    def inner(username):
        if username == 'Admin':
            return "'{0}' does have access to {1}.".format(username, page)
        else:
            return "'{0}' does NOT have access to {1}.".format(username, page)

    return inner


if __name__ == "__main__":
    # Call the outer function.
    print(factorial(6))
    # Call the process function.
    process('data/NYC_Wi-Fi_Hotspot_Locations.csv')

    current_user = has_permission('Admin Area')
    print(current_user('Admin'))

    random_user = has_permission('Admin Area')
    print(random_user('Not Admin'))
