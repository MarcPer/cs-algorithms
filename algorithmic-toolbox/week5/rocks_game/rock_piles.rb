#!/usr/bin/env ruby

class Op
  def initialize(arr)
    @arr = arr.freeze
    self.freeze
  end

  def to_s
    @arr.join(',')
  end
end

class State
  def initialize(arr)
    @arr = arr
  end

  def [](i)
    @arr[i]
  end

  def to_s
    "State([#{@arr.join(',')}])"
  end

  def to_a
    @arr
  end

  def pile_size
    @arr.sum
  end

  def apply(op)
    new_state_arr = []
    @arr.size.times do |i|
      new_state_arr << @arr[i] - op[i]
    end
    State.new(new_state_arr)
  end

  def valid?
    @arr.all? { |i| i >= 0 }
  end

  def op_to(target_state, ops)
    ops.each do |op|
      return op if apply(op).equal?(target_state)
    end
    nil
  end

  def equal?(other_state)
    @arr.each_with_index do |el, i|
      return false if el != other_state[i]
    end
    true
  end
end

class Solver
  # best strategy look up table. Good states are ones you'd
  # want your opponent to be in. In other words, you want to
  # apply an operation such that the resulting state is in @good_states.
  @good_states = {} 

  attr_reader :ops

  attr_accessor :debug

  OPS = [[1,0], [0,1], [1,1]].each(&:freeze).freeze

  def initialize(ops)
    @debug = false
    @good_states = {0 => [[0, 0]]}
    @ops = ops.freeze
    @max_rocks_removed = ops.map(&:sum).max.freeze
  end

  def puts(str)
    return unless debug
    puts(str)
  end

  def build_best(max_pile_size)
    (0..max_pile_size).each do |l|
      (0..max_pile_size-l).each do |r|
        next if l == 0 && r == 0
        @good_states[l+r] ||= []
        target_states = targets(l+r)
        puts "l=#{l}, r=#{r}, target_states=#{target_states.inspect}"
        state = State.new([l,r])

        # States the opponent can lead into after applying an operation
        interm_states = ops.map { |op| state.apply(op) }.select(&:valid?)

        puts "base_state=#{state} interm_states=#{interm_states.map(&:to_s)}"
        # Check if, for every intermediate state, there's always an operation
        # that leads to a known good state.
        maps_to_good_state = interm_states.all? do |int_state|
          target_states = targets(int_state.pile_size)
          puts "int_state=#{int_state}, target states in build_best=#{target_states}"
          !target_states.find { |tg_st| !int_state.op_to(tg_st, self.ops).nil? }.nil?
        end
        @good_states[l+r] << state.to_a if maps_to_good_state
      end
    end
  end

  # Returns an operation that leads the current state to a known good state
  def best_strategy(state)
    build_best(state.pile_size)
    puts "Good states=#{@good_states}"
    tgts = targets(state.pile_size)
    tgts.each do |tg|
      op = state.op_to(tg, @ops) 
      return op if op
    end
    nil
  end

  # Possible targets given the current pile size and available operations
  def targets(current_pile_size)
    (1..@max_rocks_removed).reduce([]) do |out, i|
      next out if @good_states[current_pile_size-i].nil?
      out | @good_states[current_pile_size-i]
    end
  end
end


if $0 == __FILE__
  solver = Solver.new
  loop do
    left_pile, right_pile = gets.strip.split.map(&:to_i)
    solver.best_strategy([left_pile, right_pile])
  end
end
