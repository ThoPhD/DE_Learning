# https://datalemur.com/questions/python-longest-consecutive-sequence

def longest_consecutive(nums):
  if not nums:
    return 0
  bigest_number = max(nums)
  longest_consective_sequence = 1
  temp = 1
  for index, item in enumerate(nums):
    while item < bigest_number:
      if item + 1 in nums:
        temp += 1
        item += 1
        longest_consective_sequence = max(longest_consective_sequence, temp)
      else:
        temp = 1
        break
  return max(longest_consective_sequence, temp)

if __name__ == "__main__":
    nums_list = [100, 4, 200, 1, 3, 2]
    print(longest_consecutive(nums_list))
    