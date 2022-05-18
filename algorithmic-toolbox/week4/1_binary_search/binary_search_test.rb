require 'minitest/autorun'
require_relative './binary_search.rb'

class AssignmentTest < Minitest::Test
  def test_solution
    inputs = [
      { 'list' => [1, 2, 3], 'search_items' => [3, 0, 3], 'exp_output' => [2, -1, 2] },
      { 'list' => [1, 5, 8, 12, 13], 'search_items' => [8, 1, 23, 1, 11], 'exp_output' => [2, 0, -1, 0, -1] },
    ]

    inputs.each do |input|
      out = binary_search(input['list'], input['search_items'])
      assert_equal input['exp_output'], out, input
    end
  end
end
