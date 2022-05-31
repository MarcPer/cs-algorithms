#!/usr/bin/env ruby

class Solver
  attr_reader :strategy

  def initialize
    @strategy = [0]
  end

  def num_operations(to)
    build_strategy(to)
    strategy[to]
  end

  def operations(to)
    build_strategy(to)
    # puts @strategy.inspect

    # Backtrack optimal operations
    coins = []
    while to > 0
      [4, 3, 1].each do |denom|
        if to >= denom && strategy[to] == strategy[to-denom]+1
          to -= denom
          coins << denom
          break
        end
      end
    end
    coins
  end

  def build_strategy(to)
    (1..to).each do |target|
      candidates = []
      candidates << strategy[target-4] if target >= 4
      candidates << strategy[target-3] if target >= 3
      candidates << strategy[target-1]
      @strategy[target] = candidates.min + 1
    end
  end
end

if $0 == __FILE__
  solver = Solver.new
  loop do
    to = gets().to_i
    return puts if to == 0
    puts solver.num_operations(to)
  end
end
