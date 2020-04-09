"""
Facade pattern example.
"""


# Complex computer parts
class CPU(object):
    """
    Simple CPU representation.
    """

    @staticmethod
    def freeze() -> None:
        print("Freezing processor.")
        return

    @staticmethod
    def jump(position) -> None:
        print("Jumping to:", position)
        return

    @staticmethod
    def execute() -> None:
        print("Executing.")
        return


class Memory(object):
    """
    Simple memory representation.
    """

    @staticmethod
    def load(position, data) -> None:
        print("Loading from {0} data: '{1}'.".format(position, data))
        return


class SolidStateDrive(object):
    """
    Simple solid state drive representation.
    """

    @staticmethod
    def read(lba, size):
        return "Some data from sector {0} with size {1}".format(lba, size)


class ComputerFacade(object):
    """
    Represents a facade for various computer parts.
    """

    def __init__(self) -> None:
        self.cpu = CPU()
        self.memory = Memory()
        self.ssd = SolidStateDrive()

    def start(self) -> None:
        self.cpu.freeze()
        self.memory.load("0x00", self.ssd.read("100", "1024"))
        self.cpu.jump("0x00")
        self.cpu.execute()


if __name__ == "__main__":
    # The client code.
    computer_facade = ComputerFacade()
    computer_facade.start()
