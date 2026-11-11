/**
 * @param {string} s
 * @returns {number}
 */
module.exports = (s) => {
  let map = []
  let longest = 0
  let i = 0
  let j = 0

  for (; j < s.length; j++) {
    let c = s[j]
    if (map[c] > 0) {
      longest = Math.max(longest, j - i)
      for (; i < map[c]; i++) {
        map[s[i]] = 0
      }
    }

    map[c] = j + 1
  }

  return Math.max(longest, j - i)
}
