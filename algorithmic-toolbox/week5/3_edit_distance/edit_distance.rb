#!/usr/bin/env ruby

class Solver
  def initialize(debug=false)
    # Double-indexed array. The first and second indexes refer to the first and
    # second string, respectively, with a 1 offset.
    # For example, @strategy[2][3] corresponds to string1[1], string2[2].
    @strategy = []
    @debug = debug || false
  end

  attr_accessor :debug

  def print(str)
    return unless debug
    puts str
  end

  def edit_distance(str1, str2)
    build_strategy(str1, str2)
    print @strategy.inspect

    @strategy[str1.size][str2.size]
  end

  def operations(str1, str2)
    build_strategy(str1, str2)
    idx1 = str1.size
    idx2 = str2.size

    ops = []
    while idx1 > 0 && idx2 > 0
      strat = @strategy[idx1][idx2]
      if strat == (x = @strategy[idx1-1][idx2]+1)
        idx1 -= 1
        ops << :one
      elsif strat == (x = @strategy[idx1][idx2-1]+1)
        idx2 -= 1
        ops << :two
      elsif strat == (x = @strategy[idx1-1][idx2-1]) || strat == x + 1
        ops << :both
        idx1 -= 1
        idx2 -= 1
      end
    end
    idx1.times { ops << :one }
    idx2.times { ops << :two }
    ops.reverse
  end

  def build_strategy(str1, str2)
    (0..str1.size).each do |idx1|
      @strategy[idx1] ||= []
      (0..str2.size).each do |idx2|
        same_ch = str1[idx1-1] == str2[idx2-1]
        # print "idx1=#{idx1}, idx2=#{idx2}, strat=#{@strategy.inspect}"
        candidates = []
        candidates << @strategy[idx1-1][idx2] + 1 if idx1 > 0
        candidates << @strategy[idx1][idx2-1] + 1 if idx2 > 0
        candidates << @strategy[idx1-1][idx2-1] + (same_ch ? 0 : 1) if idx1 > 0 && idx2 > 0
        @strategy[idx1][idx2] = candidates.min || 0
      end
    end
  end
end

if $0 == __FILE__
  solver = Solver.new
  str1 = gets().strip
  str2 = gets().strip
  puts solver.edit_distance(str1, str2)
end
