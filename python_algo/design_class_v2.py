"""
Design a Class:
1. Inserting a value (No duplicate)
2. Removing a value
3. Get random a value that is already inserted (with equal probability)
"""

import random
from collections import defaultdict

class Store:
    list_values = []
    hash_map = defaultdict(int)

    def insert_value(self, value: int):
        if value in self.hash_map:
            return

        self.list_values.append(value)
        self.hash_map[value] = len(self.list_values) - 1


    def remove_value(self, value: int):
        if value not in self.hash_map:
            return

        value_index = self.hash_map[value]
        last_value = self.list_values[-1]
        # Swapping values
        self.list_values[value_index] = last_value
        self.list_values.pop()

        del self.hash_map[value]


    def get_random_value(self):
        return random.choice(self.list_values)

if __name__ == "__main__":
    obj = Store()
    obj.insert_value(1)
    obj.insert_value(2)
    obj.insert_value(10)
    obj.insert_value(5)
    obj.insert_value(5)
    print(obj.list_values)

    print(obj.get_random_value())
    obj.remove_value(2)
    obj.remove_value(11)
    print(obj.list_values)
