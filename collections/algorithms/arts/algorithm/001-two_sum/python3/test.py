from solution import Solution

s = Solution()
nums = [8, 0, 11, 5, 11, -13, 99]
assert s.twoSum(nums, -8) == [3, 5]
assert s.twoSum(nums, 22) == [2, 4]
assert s.twoSum(nums, 99) == [1, 6]
