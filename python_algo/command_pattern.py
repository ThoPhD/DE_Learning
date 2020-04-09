from collections import deque


class Switch(object):
    """The INVOKER class"""

    def __init__(self) -> None:
        self._history = deque()

    @property
    def history(self):
        return self._history

    def execute(self, command) -> None:
        self._history.appendleft(command)
        command.execute()
        return


class Command(object):
    """The COMMAND interface"""

    def __init__(self, obj) -> None:
        self._obj = obj

    def execute(self):
        raise NotImplementedError


class TurnOnCommand(Command):
    """The COMMAND for turning on the light"""

    def execute(self) -> None:
        self._obj.turn_on()
        return


class TurnOffCommand(Command):
    """The COMMAND for turning off the light"""

    def execute(self) -> None:
        self._obj.turn_off()
        return


class Light(object):
    """The RECEIVER class"""

    def turn_on(self) -> None:
        print("The light is on")
        return

    def turn_off(self) -> None:
        print("The light is off")
        return


class LightSwitchClient(object):
    """The CLIENT class"""

    def __init__(self) -> None:
        self._lamp = Light()
        self._switch = Switch()

    @property
    def switch(self):
        return self._switch

    def press(self, cmd: str) -> None:
        cmd = cmd.strip().upper()
        if cmd == "ON":
            self._switch.execute(TurnOnCommand(self._lamp))
        elif cmd == "OFF":
            self._switch.execute(TurnOffCommand(self._lamp))
        else:
            print("Argument 'ON' or 'OFF' is required.")

        return


# Execute if this file is run as a script and not imported as a module
if __name__ == "__main__":
    light_switch = LightSwitchClient()
    print("Switch ON test.")
    light_switch.press("ON")
    print("Switch OFF test.")
    light_switch.press("OFF")
    print("Invalid Command test.")
    light_switch.press("****")

    print("Command history:")
    print(light_switch.switch.history)
