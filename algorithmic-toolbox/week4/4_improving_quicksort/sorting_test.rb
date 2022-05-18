require 'minitest/autorun'
require_relative './sorting.rb'

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
      out = randomized_quick_sort(input[0].dup, 0, input[0].size-1)
      assert_equal input[1], out, input
    end
  end
end
