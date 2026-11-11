#!/usr/bin/ruby

require 'test/unit'
require './solution'

class TestSolution < Test::Unit::TestCase
  def test
    assert lengthOfLongestSubstring("helloworld") == 5
    assert lengthOfLongestSubstring("dvdf") == 3
    assert lengthOfLongestSubstring("abcabcbb") == 3
  end
end
