require 'minitest/autorun'
require_relative './money_change.rb'

class SolutionTest < Minitest::Test
  SPECS = [
    { 'target' => 1, 'exp_ops' => [1] },
    { 'target' => 2, 'exp_ops' => [1, 1] },
    { 'target' => 3, 'exp_ops' => [3] },
    { 'target' => 4, 'exp_ops' => [4] },
    { 'target' => 6, 'exp_ops' => [3, 3] },
  ]

  def test_num_operations
    solver = Solver.new
    SPECS.each do |spec|
      out = solver.operations(spec['target'])
      assert_equal spec['exp_ops'], out, "Target number=#{spec['target']}"

      num_ops = solver.num_operations(spec['target'])
      assert_equal spec['exp_ops'].size, num_ops, "Target number=#{spec['target']}"
    end
  end
end

