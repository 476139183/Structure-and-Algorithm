/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
module.exports = (nums, target) => {
  let complements = []
  for (let i = 0; i < nums.length; i++) {
    let c = target - nums[i]
    if (complements[c] != undefined) {
      return [complements[c], i]
    } else {
      complements[nums[i]] = i
    }
  }
  return []
}
