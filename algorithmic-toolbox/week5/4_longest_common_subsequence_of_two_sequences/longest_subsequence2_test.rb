require 'minitest/autorun'
require_relative './longest_subsequence2.rb'

class SolutionTest < Minitest::Test
  SPECS = [
    { 'seq1' => [2, 7, 5], 'seq2' => [2, 5], 'exp_out' => 2 },
    { 'seq1' => [7], 'seq2' => [1, 2, 3, 4], 'exp_out' => 0 },
  ]

  def test_longest_subsequence
    SPECS.each do |spec|
      solver = Solver.new(spec['debug'])
      out = solver.longest_subsequence(spec['seq1'], spec['seq2'])
      assert_equal spec['exp_out'], out, "seq1=#{spec['seq1']}, seq2=#{spec['seq2']}"
    end
  end
end

