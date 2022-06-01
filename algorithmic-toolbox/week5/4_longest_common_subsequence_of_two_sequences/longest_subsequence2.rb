#!/usr/bin/env ruby

class Solver
  def initialize(debug=false)
    # Double-indexed array. The first and second indexes refer to the first and
    # second strings, respectively, with a 1 offset.
    # For example, @strategy[2][3] corresponds to string1[1], string2[2].
    @strategy = []
    @debug = debug || false
  end

  attr_accessor :debug

  def print(str)
    return unless debug
    puts str
  end

  def longest_subsequence(seq1, seq2)
    build_strategy(seq1, seq2)
    print @strategy.inspect

    @strategy[seq1.size][seq2.size]
  end

  def build_strategy(seq1, seq2)
    (0..seq1.size).each do |idx1|
      @strategy[idx1] ||= []
      (0..seq2.size).each do |idx2|
        same_ch = seq1[idx1-1] == seq2[idx2-1]
        print "idx1=#{idx1}, idx2=#{idx2}, strat=#{@strategy.inspect}"
        candidates = []
        candidates << @strategy[idx1-1][idx2] if idx1 > 0
        candidates << @strategy[idx1][idx2-1] if idx2 > 0
        candidates << @strategy[idx1-1][idx2-1] + (same_ch ? 1 : 0) if idx1 > 0 && idx2 > 0
        @strategy[idx1][idx2] = candidates.max || 0
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
  puts solver.longest_subsequence(seq1, seq2)
end

