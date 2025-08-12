from collections import defaultdict
import bisect


def num_matching_subseq(s: str, words: list[str]):
    s = s.lower()
    index_map = defaultdict(list)
    for idx, char in enumerate(s):
        index_map[char].append(idx)

    def is_subsequence(word_: str) -> bool:
        word_ = word_.lower()

        prev_pos = -1
        for ch in word_:
            if ch not in index_map:
                return False

            pos_ch_in_map = index_map[ch]
            next_idx = bisect.bisect_right(pos_ch_in_map, prev_pos)
            if next_idx == len(pos_ch_in_map):
                return False
            prev_pos = pos_ch_in_map[next_idx]
        return True

    count = 0
    for word in words:
        if is_subsequence(word):
            print(word)
            count += 1
    return count


if __name__ == "__main__":
    # Example usage:
    s = "abcde"
    words = ["a", "bb", "ace", "acd"]
    # print(num_matching_subseq(s, words))  # Output: 3  (a, ace, acd)
    print(num_matching_subseq("dsahjpjauf", ["ahjpjau", "aj", "ahbw", "tnm"]))
