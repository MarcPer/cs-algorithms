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

  # Takes an Enumerator of commands
  def run(cmds)
    return enum_for(:run, cmds) unless block_given?

    cmds.each do |cmd|
      op, arg = cmd.split
      case op
      when 'push' then self.push(arg.to_i)
      when 'max'
        yield(max_val > -1 ? max_val : nil)
      when 'pop'
        self.pop
      end
    end
  end
end

if $0 == __FILE__
  n_cmds = gets.strip.to_i
  cmds = []
  n_cmds.times do
    cmds << gets.strip
  end

  s = MaxStack.new
  s.run(cmds.to_enum).each { |out| puts out }
end

