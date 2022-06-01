require 'minitest/autorun'
require_relative './edit_distance.rb'

class SolutionTest < Minitest::Test
  SPECS = [
    { 'str1' => 'ab', 'str2' => 'ab', 'exp_distance' => 0, 'ops' => [:both, :both] },
    { 'str1' => 'bab', 'str2' => 'ab', 'exp_distance' => 1, 'ops' => [:one, :both, :both] },
    { 
      'str1' => 'short', 'str2' => 'ports',
      'exp_distance' => 3,
      'ops' => [:both, :one, :both, :both, :both, :two],
      'debug' => false 
    },
    { 
      'str1' => 'editing', 'str2' => 'distance',
      'exp_distance' => 5,
      'ops' => [:one, :both, :both, :two, :both, :both, :both, :both, :two],
      'debug' => false 
    },
  ]

  def test_num_operations
    SPECS.each do |spec|
      solver = Solver.new(spec['debug'])
      out = solver.edit_distance(spec['str1'], spec['str2'])
      assert_equal spec['exp_distance'], out, "str1=#{spec['str1']}, str2=#{spec['str2']}"
    end
  end

  def test_operations
    SPECS.each do |spec|
      solver = Solver.new(spec['debug'])
      out = solver.operations(spec['str1'], spec['str2'])
      assert_equal spec['ops'], out, "str1=#{spec['str1']}, str2=#{spec['str2']}"
    end
  end
end

