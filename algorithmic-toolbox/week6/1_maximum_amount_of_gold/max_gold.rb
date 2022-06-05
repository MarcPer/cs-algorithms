#!/usr/bin/env ruby

class Solver
  attr_reader :bar_weights, :capacity, :strategy

  def initialize(capacity, bar_weights)
    @capacity = capacity
    @bar_weights = bar_weights

    @strategy = Array.new(capacity+1) { Array.new(bar_weights.size) { 0 }}
  end

  def max_gold
    bar_weights.each_with_index do |w, idx|
      (1..capacity).each do |cap|
        strategy[cap][idx+1] = strategy[cap][idx]
        next if w > cap
        a = strategy[cap-w][idx]+w
        b = strategy[cap][idx]
        strategy[cap][idx+1] = [a, b].max
      end
    end

    # print_strategy
    strategy[capacity][bar_weights.size]
  end

  def print_strategy
    strategy.each_with_index do |row, cap|
      puts "cap=#{cap} #{row.inspect}" 
    end
  end
end

if $0 == __FILE__
  capacity, _num_bars = gets.split.map(&:to_i)
  bar_weights = gets.split.map(&:to_i)
  solver = Solver.new(capacity, bar_weights)
  puts solver.max_gold
end
