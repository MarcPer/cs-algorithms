require 'minitest/autorun'
require_relative './rock_piles.rb'

class SolutionTest < Minitest::Test
  def test_two_piles
    ops = [[0,1], [1,0], [1,1]]
    specs = [
      {'state' => [0,1], 'exp_op' => [0,1]},
      {'state' => [1,0], 'exp_op' => [1,0]},
      {'state' => [1,1], 'exp_op' => [1,1]},
      {'state' => [2,1], 'exp_op' => [0,1]},
      {'state' => [2,2], 'exp_op' => nil},
      {'state' => [10,9], 'exp_op' => [0,1]},
    ]

    solver = Solver.new(ops)
    specs.each do |spec|
      solver.debug = spec['debug']
      out = solver.best_strategy(State.new(spec['state']))
      assert_equal spec['exp_op'], out, "Input state: #{spec['state']}"
    end
  end
end

