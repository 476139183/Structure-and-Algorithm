package solution

func twoSum(nums []int, target int) []int {
	var complements = map[int]int{}
	for i := 0; i < len(nums); i++ {
		var c = target - nums[i]
		if complements[c] > 0 {
			return []int{complements[c] - 1, i}
		}
		complements[nums[i]] = i + 1
	}

	return []int{}
}
