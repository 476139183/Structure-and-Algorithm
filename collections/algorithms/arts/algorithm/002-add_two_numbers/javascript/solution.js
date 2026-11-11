/**
 * Definition for singly-linked list.
 * @param {Number} val
 */
function ListNode(val) {
  this.val = val
  this.next = null
}

/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @returns {ListNode}
 */
function addTwoNumbers(l1, l2) {
  let sum = new ListNode(0)
  let head = sum
  let carry = 0

  while (l1 !== null || l2 !== null || carry > 0) {
    if (l1 !== null) {
      sum.val += l1.val
      l1 = l1.next
    }

    if (l2 !== null) {
      sum.val += l2.val
      l2 = l2.next
    }

    sum.val += carry
    carry = parseInt(sum.val / 10)
    sum.val %= 10

    if (l1 !== null || l2 !== null || carry > 0) {
      sum.next = new ListNode(0)
      sum = sum.next
    }
  }

  return head
}

module.exports = {
  ListNode: ListNode,
  addTwoNumbers: addTwoNumbers
}
