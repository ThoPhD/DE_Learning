# Document Management Command Pattern.

from collections import deque


class DocumentInvoker(object):
    """The INVOKER class"""

    def __init__(self) -> None:
        self._undo_command = deque()
        self._redo_command = deque()
        self._document = Document()

    def undo(self) -> None:
        if not self._undo_command:
            cmd = self._undo_command.pop()
            cmd.undo()
            self._redo_command.append(cmd)
        else:
            print("Nothing to undo.")

        return

    def redo(self) -> None:
        if self._redo_command:
            cmd = self._redo_command.pop()
            cmd.redo()
            self._redo_command.append(cmd)
        else:
            print("Nothing to redo.")

        return

    def read(self) -> None:
        self._document.read_document()

        return

    def write(self, text):
        cmd = DocumentEditorCommand(text)
        self._undo_command.append(cmd)
        self._redo_command.clear()

        return


class Command(object):
    """The COMMAND interface"""

    def __init__(self, obj) -> None:
        self._obj = obj


class DocumentEditorCommand(Command):
    def __init__(self, text) -> None:
        self._text = text
        self._document = Document()
        self._document.write(self._text)

    def undo(self) -> None:
        self._document.erase_last()
        return

    def redo(self) -> None:
        self._document.write(self._text)
        return


class Document(object):
    """The RECEIVER class"""

    def __init__(self):
        self.lines = deque()

    def write(self, text) -> None:
        self.lines.append(text)

        return

    def erase_last(self) -> None:
        if self.lines:
            self.lines.pop()

        return

    def read_document(self) -> None:
        for line in self.lines:
            print(line)

        return


if __name__ == "__main__":
    instance = DocumentInvoker()
    instance.write("The 1st text.")
    instance.undo()
    instance.read()  # Empty

    # instance.redo()
    # instance.read()  # The 1st text.
    #
    # instance.write("The 2nd text.")
    # instance.write("The 3rd text.")
    # instance.read()  # The 1st text. The 2nd text. The 3rd text.
    # instance.undo()  # The 1st text. The 2nd text.
    # instance.undo()  # The 1st text.
    # instance.undo()  # EMPTY
    # instance.undo()  # Nothing to undo
