
class Solver
  attr_reader :maxs, :mins, :nums, :ops

  def initialize(expr_str)
    n = expr_str.size
    @nums = []
    @ops = []
    (0..n-1).each do |i|
      if i.even?
        @nums << expr_str[i].to_i
      else
        @ops << expr_str[i].to_sym
      end
    end
    @nums.freeze
    @ops.freeze

    @mins = Array.new(n/2+1) { Array.new(n/2+1) }
    @maxs = Array.new(n/2+1) { Array.new(n/2+1) }

    @nums.size.times do |i|
      @mins[i][i] = @nums[i]
      @maxs[i][i] = @nums[i]
    end
  end

  def max
    n = @nums.size

    (1..n-1).each do |s|
      (0..n-1-s).each do |i|
        j = i+s
        min_val, max_val = min_max(i, j)
        mins[i][j] = min_val
        maxs[i][j] = max_val
      end
    end

    maxs[0][@nums.size-1]
  end

  def min_max(i, j)
    min_val = Float::INFINITY
    max_val = -Float::INFINITY

    (i..j-1).each do |k|
      a = apply(ops[k], mins[i][k], mins[k+1][j])
      b = apply(ops[k], mins[i][k], maxs[k+1][j])
      c = apply(ops[k], maxs[i][k], mins[k+1][j])
      d = apply(ops[k], maxs[i][k], maxs[k+1][j])

      min_val = [min_val, a, b, c, d].min
      max_val = [max_val, a, b, c, d].max
    end

    [min_val, max_val]
  end

  def apply(op, v1, v2)
    case op
    when :+ then v1+v2
    when :- then v1-v2
    when :* then v1*v2
    else raise ArgumentError.new("invalid operator #{op}")
    end
  end
end

if $0 == __FILE__
  expr_str = gets.strip
  solver = Solver.new(expr_str)
  puts solver.max
end

