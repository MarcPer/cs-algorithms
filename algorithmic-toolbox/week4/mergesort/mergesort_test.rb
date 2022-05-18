require 'minitest/autorun'
require_relative './mergesort.rb'

class SortingTest < Minitest::Test
  def test_solution
    inputs = [
      [[1, 2, 3], [1, 2, 3]],
      [[3, 2, 1], [1, 2, 3]],
      [[1, 1, 1], [1, 1, 1]],
      [[3, 2, 1, 2, 3], [1, 2, 2, 3, 3]],
      [[1, 3, 1], [1, 1, 3]],
    ]

    inputs.each do |input|
      out = mergesort(input[0].dup)
      assert_equal input[1], out, input
    end
  end
end
