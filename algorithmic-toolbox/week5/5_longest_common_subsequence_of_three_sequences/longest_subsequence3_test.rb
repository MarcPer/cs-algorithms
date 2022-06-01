require 'minitest/autorun'
require_relative './longest_subsequence3.rb'

class SolutionTest < Minitest::Test
  SPECS = [
    { 'seq1'=>[1,2,3], 'seq2'=>[2,1,3], 'seq3'=>[1,3,5], 'exp_out' => 2 },
    { 'seq1'=>[8,3,2,1,7], 'seq2'=>[8,2,1,3,8,10,7], 'seq3'=>[6,8,3,1,4,7], 'exp_out' => 3 },
    { 'seq1'=>[1,1,1], 'seq2'=>[1,1,1], 'seq3'=>[1,1,1], 'exp_out' => 3 },
    { 'seq1'=>[1,1,1], 'seq2'=>[1,1,1], 'seq3'=>[2,2,2], 'exp_out' => 0 },
    { 'seq1'=>[1,1,1], 'seq2'=>[1,1,1], 'seq3'=>[2,1,2], 'exp_out' => 1 },
    { 'seq1'=>[1,2], 'seq2'=>[2,3], 'seq3'=>[3,4], 'exp_out' => 0 },
  ]

  def test_longest_subsequence
    SPECS.each do |spec|
      solver = Solver.new(spec['debug'])
      out = solver.longest_subsequence(spec['seq1'], spec['seq2'], spec['seq3'])
      assert_equal spec['exp_out'], out, "seq1=#{spec['seq1']}, seq2=#{spec['seq2']}, seq3=#{spec['seq3']}"
    end
  end
end

