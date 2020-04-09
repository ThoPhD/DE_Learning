class Publisher(object):
    def __init__(self):
        pass

    def register(self):
        pass

    def unregister(self):
        pass

    def notify_all(self):
        pass


class TechForum(Publisher):
    def __init__(self) -> None:
        self._list_of_users = []
        self.post_name = None

    def register(self, user_obj) -> None:
        if user_obj not in self._list_of_users:
            self._list_of_users.append(user_obj)
        return

    def unregister(self, user_obj) -> None:
        self._list_of_users.remove(user_obj)
        return

    def notify_all(self) -> None:
        for objects in self._list_of_users:
            objects.notify(self.post_name)

        return

    def write_new_post(self, post_name) -> None:
        # User writes a post.
        self.post_name = post_name
        # When submits the post is published and notification is sent to all
        self.notify_all()

        return


class Subscriber(object):
    def __init__(self) -> None:
        pass

    def notify(self) -> None:
        pass


class User1(Subscriber):
    def notify(self, post_name) -> None:
        print('User_1 notified of a new post {}.'.format(post_name))
        return


class User2(Subscriber):
    def notify(self, post_name) -> None:
        print('User_2 notified of a new post {}.'.format(post_name))
        return


class SisterSites(Subscriber):
    def __init__(self) -> None:
        self._sister_websites = ["Site1", "Site2", "Site3"]

    def notify(self, post_name) -> None:
        for site in self._sister_websites:
            # Send updates by any means
            print("Sent notified to site: {}.".format(site))

        return


if __name__ == "__main__":
    tech_forum = TechForum()
    user1 = User1()
    user2 = User2()

    sites = SisterSites()
    tech_forum.register(user1)
    tech_forum.register(user2)
    tech_forum.register(sites)
    tech_forum.write_new_post("Observer Pattern in Python")
    tech_forum.unregister(user2)
    tech_forum.write_new_post("MVC Pattern in Python")
