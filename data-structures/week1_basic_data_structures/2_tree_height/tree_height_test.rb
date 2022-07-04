require_relative './tree_height.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      {input: [-1], want: 1},
      {input: [-1, 0], want: 2},
      {input: [4, -1, 4, 1, 1], want: 3},
      {input: [-1, 0, 4, 0, 3], want: 4},
      {input: Array.new(20){ |i| i == 0 ? -1 : 0 }, want: 2},
      {input: Array.new(20){ |i| i-1 }, want: 20},
      {input: Array.new(5){ |i| i+1 }.tap { |arr| arr[-1] = -1 }, want: 5},
    ]

    specs.each do |spec|
      out = depth(spec[:input])
      assert_equal spec[:want], out, "input=#{spec[:input]}"
    end
  end
end
