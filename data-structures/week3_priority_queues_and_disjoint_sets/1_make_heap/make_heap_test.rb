require_relative './make_heap.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      {input: [5,4,3,2,1], want: [[1,4],[0,1],[1,3]]},
      {input: [1,2,3,4,5], want: []},
    ]

    specs.each do |spec|
      out = make_heap(spec[:input])
      assert_equal spec[:want], out, "input=#{spec[:input]}"
    end
  end
end
