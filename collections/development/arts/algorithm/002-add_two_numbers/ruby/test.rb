#!/usr/bin/ruby

require 'test/unit'
require './solution'

class TestSolution < Test::Unit::TestCase
  def test
    assertEqual(addTwoNumbers(listnum([7, 8, 9]), listnum([0, 9, 3])), listnum([7, 7, 3, 1]))
    assertEqual(addTwoNumbers(listnum([1]), listnum([9, 9, 9])), listnum([0, 0, 0, 1]))
  end

  # @param {Integer[]} nums
  # @return {ListNode}
  def listnum(nums)
    list = ListNode(0)
    node = list
    nums.each { |x| node.next = ListNode(x); node = node.next }
    return list.next
  end

  # @param {ListNode} l1
  # @param {ListNode} l2
  def assertEqual(l1, l2)
    while l1 && l2
      if l1.val != l2.val
        break
      else
        l1 = l1.next
        l2 = l2.next
      end
    end

    assert l1.nil? && l2.nil?
  end
end
