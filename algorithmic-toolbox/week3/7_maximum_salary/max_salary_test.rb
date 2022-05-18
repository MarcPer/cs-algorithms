require 'minitest/autorun'
require_relative './max_salary.rb'

class SignatureCollectionTest < Minitest::Test
  def test_max_salary
    inputs = [
      { 'nums' => [1, 2], 'exp_output' => 21 },
      { 'nums' => [2, 21], 'exp_output' => 221 },
      { 'nums' => [9, 4, 6, 1, 9], 'exp_output' => 99641 },
      { 'nums' => [23, 39, 92], 'exp_output' => 923923 },
      { 'nums' => [2, 22, 23], 'exp_output' => 23222 },
      { 'nums' => [125, 12], 'exp_output' => 12512 },
      { 'nums' => [1], 'exp_output' => 1 },
      { 'nums' => [987, 99], 'exp_output' => 99987 },
      { 'nums' => [100, 10], 'exp_output' => 10100 },
      { 'nums' => [1003, 10], 'exp_output' => 101003 },
      { 'nums' => [1009, 10], 'exp_output' => 101009 },
    ]

    inputs.each do |input|
      out = max_salary(input['nums'].dup)
      assert_equal input['exp_output'], out, input
    end
  end
end
