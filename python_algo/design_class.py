import random

class Store:
    list_values = set()
    def insert_value(self, value: int):
        self.list_values.add(value)

    def remove_value(self, value: int):
        if value not in self.list_values:
            return 
        self.list_values.remove(value)

    def get_random_value(self):
        return random.choice(list(self.list_values))

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
