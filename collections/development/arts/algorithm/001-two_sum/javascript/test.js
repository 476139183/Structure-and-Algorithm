#!/usr/bin/env node

const twoSum = require('./solution')
const assert = require('assert')
const nums = [8, 0, 11, 5, 11, -13, 99]
assert.equal(twoSum(nums, -8).toString(), '3,5')
assert.equal(twoSum(nums, 22).toString(), '2,4')
assert.equal(twoSum(nums, 99).toString(), '1,6')
