require 'minitest/autorun'
require_relative './majority_element.rb'

class AssignmentTest < Minitest::Test
  def test_solution
    inputs = [
      [[2, 3, 9, 2, 2], true],
      [[1, 2, 3, 2], false],
      [[1, 2, 3, 4, 4], false],
      [[1, 2, 3, 1, 1], true],
      [[1, 2, 1, 2, 1], true],
      [[1, 1, 1, 2, 2], true],
      [[1, 2, 2, 1, 1], true],
    ]

    inputs.each do |input|
      out = has_majority?(input[0])
      assert_equal input[1], out, input
    end
  end
end
