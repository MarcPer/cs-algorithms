require 'minitest/autorun'
require_relative './inversions.rb'

class SortingTest < Minitest::Test
  def test_solution
    inputs = [
      [[1, 2, 3], 0],
      [[3, 2, 1], 3],
      [[3, 1, 4, 2], 3],
      [[2, 3, 9, 2, 9], 2],
    ]

    inputs.each do |input|
      out = mergesort(input[0].dup)
      # assert_equal input[1], out[1], input
      assert_equal naive_count(input[0].dup), out[1], input
    end
  end
end

def naive_count(arr)
  count = 0
  arr.each_with_index do |x, xi|
    arr[xi+1..-1].each do |y|
      if x > y
        count += 1
      end
    end
  end
  count
end

