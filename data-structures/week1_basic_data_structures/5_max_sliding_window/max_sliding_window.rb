class MaxStack
  attr_reader :max_val

  def initialize
    @arr = []
    @max_stack = [] # keep a stack of the maximum values found
    @max_val = -1
  end

  def push(x)
    if x >= @max_val
      @max_val = x
      @max_stack << x
    end
    @arr << x
  end

  def pop
    x = @arr.pop
    if x == @max_val
      @max_stack.pop
      @max_val = @max_stack[-1] || -1
    end
    x
  end

  def empty?
    @arr.empty?
  end

  def max
    max_val > -1 ? max_val : nil
  end
end

# Name the class MyQueue, so it doesn't conflict with Ruby's Queue
class MyQueue
  def initialize
    @inbox = MaxStack.new
    @outbox = MaxStack.new
  end

  def enq(x)
    @inbox.push(x)
  end

  def deq
    out = @outbox.pop
    return out if out

    @outbox.push(@inbox.pop) until @inbox.empty?
    @outbox.pop
  end

  def max
    [@inbox.max_val, @outbox.max_val].max
  end
end

def max_window(arr, win_size)
  q = MyQueue.new
  arr[0...win_size].each { |el| q.enq(el) }
  out = [q.max]
  (win_size..(arr.size-1)).each do |i|
    q.enq(arr[i])
    q.deq
    out << q.max
  end

  out
end

if $0 == __FILE__
  _n = gets.strip.to_i
  arr = gets.strip.split.map(&:to_i)
  win_size = gets.strip.to_i

  max_window(arr, win_size).each { |i| puts i }
end

