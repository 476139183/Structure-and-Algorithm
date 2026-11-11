package solution

func findMedianSortedArrays(nums1 []int, nums2 []int) float64 {
	var len1 = len(nums1)
	var len2 = len(nums2)
	var lensum = (len1+len2)/2 + 1
	var M = [2]int{0}
	var i = 0
	var j = 0

	for lensum = (len1+len2)/2 + 1; lensum > 0; lensum-- {
		M[0] = M[1]
		if i < len1 && j < len2 && nums1[i] > nums2[j] {
			M[1] = nums1[i]
			i++
		} else if i < len1 && j < len2 && nums1[i] <= nums2[j] {
			M[1] = nums2[j]
			j++
		} else if i < len1 && j >= len2 {
			M[1] = nums1[i]
			i++
		} else {
			M[1] = nums2[j]
			j++
		}
	}

	if (len1^len2)&1 == 1 {
		return float64(M[1])
	} else {
		return float64(M[0]+M[1]) / 2
	}
}
