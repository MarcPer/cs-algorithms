require_relative './stack_max.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      {cmds: ["push 2", "push 1", "max", "pop", "max"], want: [2, 2]},
      {cmds: ["push 1", "push 2", "max", "pop", "max"], want: [2, 1]},
      {
        cmds: ["push 2","push 3","push 9","push 7","push 2","max","max","max","pop","max"],
        want: [9, 9, 9, 9]
      },
      {cmds: ["push 1", "push 7", "pop"], want: []},
      {cmds: ["push 7", "push 1", "push 7", "max", "pop", "max"], want: [7, 7]},
    ]

    specs.each do |spec|
      out = []
      s = Stack.new
      s.run(spec[:cmds].to_enum).each { |i| out << i }
      assert_equal spec[:want], out, "cmds=#{spec[:cmds]}"
    end
  end
end
