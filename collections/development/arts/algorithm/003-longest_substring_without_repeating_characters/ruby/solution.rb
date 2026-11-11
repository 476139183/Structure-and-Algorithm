# @param {String} s
# @return {Integer}
def length_of_longest_substring(s)
    alphabet = {}
    longest = 0
    i = 0
    j = 0

    s.each_char{
      |c|
      if alphabet[c]
        longest = [longest, j - i].max
        while i < alphabet[c]
          alphabet[s[i]] = 0
          i += 1
        end
      end

      j += 1
      alphabet[c] = j
    }

    return [longest, j - i].max
end