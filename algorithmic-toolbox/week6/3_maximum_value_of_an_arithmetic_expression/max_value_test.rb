require 'minitest/autorun'
require_relative './max_value.rb'

class SolutionTest < Minitest::Test
  SPECS = [
    {expr: '1+5', exp_out: 6},
    {expr: '5-8+7*4-8+9', exp_out: 200},
    {expr: '1-3*4', exp_out: -8},
  ]
  def test_max
    SPECS.each do |spec|
      solver = Solver.new(spec[:expr])
      out = solver.max
      assert_equal spec[:exp_out], out, "expr='#{spec[:expr]}'"
    end
  end
end

