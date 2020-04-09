def insertion_sort(the_list):
    if not the_list:
        return "Empty list!"

    elif len(the_list) == 1:
        return the_list

    for index in range(1, len(the_list)):
        key = the_list[index]
        position = index - 1
        while position >= 0 and the_list[position] >= key:
            the_list[position + 1] = the_list[position]
            position = position - 1
        the_list[position + 1] = key

        return the_list


def kwd_only_arg(*, arg):
    print(arg)


def combined_example(pos_only, standard, *, kwd_only):
    print(pos_only, standard, kwd_only)


kwd_only_arg(arg=3)
combined_example(1, 2, kwd_only=3)
combined_example(1, standard=2, kwd_only=3)
