#!/usr/bin/env ruby

require_relative './rock_piles.rb'

if $0 == __FILE__
  ops = [[0,1], [0,2], [0,3], [1,0], [1,1], [1,2], [2,0], [2,1], [3,0]]
  solver = Solver.new(ops)
  loop do
    print "Type current state: "
    begin
      left_pile, right_pile = gets.strip.split.map(&:to_i)
    rescue NoMethodError
      puts ''
      return
    end
    op = solver.best_strategy(State.new([left_pile, right_pile]))
    if op
      puts "Best operation: #{op}"
    else
      puts "There are no operations. You lost already"
    end
  end
end

