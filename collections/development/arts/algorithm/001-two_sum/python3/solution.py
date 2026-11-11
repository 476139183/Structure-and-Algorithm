class Solution(object):
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        complements = {}
        for i in range(len(nums)):
            c = target - nums[i]
            if c in complements:
                return [complements[c], i]
            complements[nums[i]] = i
        return []