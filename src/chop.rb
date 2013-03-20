# http://codekata.pragprog.com/2007/01/kata_two_karate.html

require 'test/unit'

# data = (0...3037)
# needle = 3 #Random.rand(data)
# haystack = [] #Array[*data]

def chop(needle, haystack)
  return -1 if haystack.empty? or haystack.nil?
  
  chop_algo(needle, haystack, left=0, right=haystack.size-1)
end

def chop_algo(needle, haystack, left, right)
  # puts "chop_algo(#{needle}, #{haystack}, #{left}, #{right})"
  return -1 if left > right
  
  # robbed this magic from somewhere...
  pivot = left + ((right - left) / 2)

  if needle < haystack[pivot]
    chop_algo(needle, haystack, left, pivot-1)
  elsif needle > haystack[pivot]
    chop_algo(needle, haystack, pivot+1, right)
  else
    pivot
  end
end

# puts "looking for #{needle}"
# position = chop(needle, haystack)
# puts "found at: #{position}"

class TestChop < Test::Unit::TestCase
  def test_chop
    assert_equal(-1, chop(3, []))
    assert_equal(-1, chop(3, [1]))
    assert_equal(0,  chop(1, [1]))
    #
    assert_equal(0,  chop(1, [1, 3, 5]))
    assert_equal(1,  chop(3, [1, 3, 5]))
    assert_equal(2,  chop(5, [1, 3, 5]))
    assert_equal(-1, chop(0, [1, 3, 5]))
    assert_equal(-1, chop(2, [1, 3, 5]))
    assert_equal(-1, chop(4, [1, 3, 5]))
    assert_equal(-1, chop(6, [1, 3, 5]))
    #
    assert_equal(0,  chop(1, [1, 3, 5, 7]))
    assert_equal(1,  chop(3, [1, 3, 5, 7]))
    assert_equal(2,  chop(5, [1, 3, 5, 7]))
    assert_equal(3,  chop(7, [1, 3, 5, 7]))
    assert_equal(-1, chop(0, [1, 3, 5, 7]))
    assert_equal(-1, chop(2, [1, 3, 5, 7]))
    assert_equal(-1, chop(4, [1, 3, 5, 7]))
    assert_equal(-1, chop(6, [1, 3, 5, 7]))
    assert_equal(-1, chop(8, [1, 3, 5, 7]))
  end
end
