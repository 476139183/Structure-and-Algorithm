#!/usr/bin/env node

const {ListNode, addTwoNumbers} = require('./solution')
const assert = require('assert')

/**
 * convert Array to ListNode
 * @param {number[]} nums 
 * @returns {ListNode}
 */
function listnum(nums) {
  let list = new ListNode(0)
  let node = list
  nums.forEach(x => { node.next = new ListNode(x); node = node.next })
  return list.next
}

/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @throws {Error}
 */
function assertEqual(l1, l2) {
  while (l1 !== null && l2 !== null) {
    if (l1.val !== l2.val) {
      break
    } else {
      l1 = l1.next
      l2 = l2.next
    }
  }

  assert(l1 === null && l2 === null)
}

assertEqual(addTwoNumbers(listnum([7, 8, 9]), listnum([0, 9, 3])), listnum([7, 7, 3, 1]))
assertEqual(addTwoNumbers(listnum([1]), listnum([9, 9, 9])), listnum([0, 0, 0, 1]))
