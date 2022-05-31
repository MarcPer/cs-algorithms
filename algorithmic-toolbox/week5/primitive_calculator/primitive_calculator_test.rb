require 'minitest/autorun'
require_relative './primitive_calculator.rb'

class SolutionTest < Minitest::Test
  SPECS = [
    { 'target' => 6, 'exp_ops' => [:mul3, :mul2] },
    { 'target' => 8, 'exp_ops' => [:mul2, :mul2, :mul2] },
  ]

  def test_num_operations()
    solver = Solver.new
    SPECS.each do |spec|
      out = solver.operations(spec['target'])
      assert_equal spec['exp_ops'], out, "Target number=#{spec['target']}"
    end
  end
end

