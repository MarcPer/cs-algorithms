#!/usr/bin/env ruby

class Solver
  def initialize
    # Target number is indexed with target-1.
    # For example, @strategy[0] is the number of operations to reach 1
    # @strategy[5] to reach 6, and so on.
    @strategy = [0]
  end

  def strategy(target)
    @strategy[target-1]
  end

  def operations(to)
    build_strategy(to)
    # puts @strategy.inspect

    # Backtrack optimal operations
    ops = []
    while to > 1
      if to % 3 == 0 && strategy(to) == strategy(to/3)+1
        to = to/3
        ops << :mul3
      elsif to % 2 == 0 && strategy(to) == strategy(to/2)+1
        to = to/2
        ops << :mul2
      elsif strategy(to) == strategy(to-1)+1
        to = to-1
        ops << :add1
      end
    end
    ops.reverse
  end

  def build_strategy(to)
    (2..to).each do |target|
      candidates = []
      candidates << @strategy[target/3-1] if target % 3 == 0
      candidates << @strategy[target/2-1] if target % 2 == 0
      candidates << @strategy[target-2]
      @strategy[target-1] = candidates.min + 1
    end
  end
end

if $0 == __FILE__
  solver = Solver.new
  loop do
    print("Type positive target number: ")
    to = gets().to_i
    return puts if to == 0
    puts solver.operations(to).join(', ')
  end
end
