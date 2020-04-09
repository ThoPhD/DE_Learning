# Bank Account Command Pattern.

class BankApp(object):
    """The INVOKER class"""

    @staticmethod
    def click_open_account(command) -> None:
        print("User click open an account.")
        command.execute()
        return

    @staticmethod
    def click_close_account(command) -> None:
        print("User click close an account.")
        command.execute()
        return


class Command(object):
    """The COMMAND interface"""

    def __init__(self, obj) -> None:
        self._obj = obj

    def execute(self):
        raise NotImplementedError


class OpenAccountCommand(Command):
    """The COMMAND for open Account."""

    def execute(self) -> None:
        self._obj.open()
        return


class CloseAccountCommand(Command):
    """The COMMAND for close Account."""

    def execute(self) -> None:
        self._obj.close()
        return


class Account(object):
    """The RECEIVER class"""

    def __init__(self, user_name) -> None:
        self.__user_name = user_name

    @property
    def get_user_name(self):
        return self.__user_name

    def open(self):
        print("Account [ {name} ] Opened.\n".format(name=self.get_user_name))

    def close(self):
        print("Account [ {name} ] Closed.\n".format(name=self.get_user_name))


class Client(object):
    """The CLIENT class"""

    def __init__(self, account) -> None:
        self._user = Account(account)
        self._click = BankApp()

    def press(self) -> None:
        self._click.click_open_account(OpenAccountCommand(self._user))
        self._click.click_close_account(CloseAccountCommand(self._user))

        return


if __name__ == "__main__":
    user = "Command Pattern"
    cl = Client(user)
    cl.press()
