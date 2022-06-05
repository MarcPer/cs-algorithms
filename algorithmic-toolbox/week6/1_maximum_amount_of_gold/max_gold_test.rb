require 'minitest/autorun'
require_relative './max_gold.rb'

class SolutionTest < Minitest::Test
  SPECS = [
    {capacity:3,  bar_weights:[1,4,8], exp_max:1},
    {capacity:10, bar_weights:[1,4,8], exp_max:9},
    {capacity:12, bar_weights:[1,4,8], exp_max:12},
    {capacity:14, bar_weights:[1,4,8], exp_max:13},
    {capacity:16, bar_weights:[1,4,8], exp_max:13},
  ]

  def test_max_gold
    SPECS.each do |spec|
      solver = Solver.new(spec[:capacity], spec[:bar_weights])
      out = solver.max_gold
      assert_equal spec[:exp_max], out, "capacity=#{spec[:capacity]}, bar_weights#{spec[:bar_weights]}"
    end
  end
end
