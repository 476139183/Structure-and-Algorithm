#!/usr/bin/ruby

require 'test/unit'
require './solution'

class TestSolution < Test::Unit::TestCase
  def test_1
    nums = [8, 0, 11, 5, 11, -13, 99]
    assert two_sum(nums, -8) == [3, 5]
    assert two_sum(nums, 22) == [2, 4]
    assert two_sum(nums, 99) == [1, 6]
  end
end
