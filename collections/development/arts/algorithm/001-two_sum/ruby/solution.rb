# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  complements = {}
  nums.each_with_index {
    |n, i|
    c = target - n
    complements[c] ? (return [complements[c], i]) : complements[n] = i
  }
end