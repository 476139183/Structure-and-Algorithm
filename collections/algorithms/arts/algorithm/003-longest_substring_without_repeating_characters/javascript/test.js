#!/usr/bin/env node

const lengthOfLongestSubstring = require('./solution')
const assert = require('assert')

assert(lengthOfLongestSubstring("helloworld") == 5)
assert(lengthOfLongestSubstring("dvdf") == 3)
assert(lengthOfLongestSubstring("abcabcbb") == 3)