#!/usr/bin/env ruby

class Solver
  def initialize(debug=false)
    # Triple-indexed array. The first and second, and third indexes refer to
    # the first, second, and third strings, respectively, with a 1 offset.
    # For example, @strategy[2][3][1] corresponds to string1[1], string2[2],
    # string3[0].
    @strategy = []
    @debug = debug || false
  end

  attr_accessor :debug

  def print(str)
    return unless debug
    puts str
  end

  def longest_subsequence(seq1, seq2, seq3)
    build_strategy(seq1, seq2, seq3)
    print @strategy.inspect

    @strategy[seq1.size][seq2.size][seq3.size]
  end

  def build_strategy(seq1, seq2, seq3)
    (0..seq1.size).each do |idx1|
      @strategy[idx1] ||= []
      (0..seq2.size).each do |idx2|
        @strategy[idx1][idx2] ||= []
        (0..seq3.size).each do |idx3|
          same_num = (seq1[idx1-1] == seq2[idx2-1]) && (seq2[idx2-1] == seq3[idx3-1])
          print "idx1=#{idx1}, idx2=#{idx2}, idx3=#{idx3}, strat=#{@strategy.inspect}"
          candidates = []
          candidates << @strategy[idx1-1][idx2][idx3] if idx1 > 0
          candidates << @strategy[idx1][idx2-1][idx3] if idx2 > 0
          candidates << @strategy[idx1][idx2][idx3-1] if idx3 > 0

          candidates << @strategy[idx1-1][idx2-1][idx3] if idx1 > 0 && idx2 > 0
          candidates << @strategy[idx1-1][idx2][idx3-1] if idx1 > 0 && idx3 > 0
          candidates << @strategy[idx1][idx2-1][idx3-1] if idx2 > 0 && idx3 > 0

          candidates << @strategy[idx1-1][idx2-1][idx3-1] + (same_num ? 1 : 0) if [idx1,idx2,idx3].all?(&:positive?)
          @strategy[idx1][idx2][idx3] = candidates.max || 0
        end
      end
    end
  end
end

if $0 == __FILE__
  solver = Solver.new
  _num_seq1 = gets
  seq1 = gets().strip.split(' ').map(&:to_i)
  _num_seq2 = gets
  seq2 = gets().strip.split(' ').map(&:to_i)
  _num_seq3 = gets
  seq3 = gets().strip.split(' ').map(&:to_i)
  puts solver.longest_subsequence(seq1, seq2, seq3)
end
