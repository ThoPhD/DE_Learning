from collections import defaultdict

def make_charactor_count(string_: str) -> dict[str, int]:
    charactor_count = defaultdict(int)
    for char in string_:
        charactor_count[char] += 1

    return charactor_count

def num_of_subsequence_string(string: str, words: list[str]) -> int:
    charactor_count = make_charactor_count(string)
    res = 0

    for word in words:
        substring_count = make_charactor_count(word)
        for subsequence, sub_count in substring_count.items():
            char_count = charactor_count.get(subsequence, None)
            if not char_count or sub_count > char_count:
                break
        else:
            res += 1
    return res

if __name__ == "__main__":
    print(num_of_subsequence_string("abcde", ["a", "bb", "acd", "ace"]))
    print(num_of_subsequence_string("dsahjpjauf", ["ahjpjau", "aj", "ahbw", "tnm"]))
