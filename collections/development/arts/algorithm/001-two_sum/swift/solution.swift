class Solution {
  func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var complements = [Int: Int]()
    for i in 0...(nums.count - 1) {
      let c = target - nums[i]
      if (complements[c] != nil) {
        return [complements[c]!, i]
      } else {
        complements[nums[i]] = i
      }
    }
    return []
  }
}