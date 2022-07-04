# The input makes it easier to build the tree from the leaf nodes up,
# than from the root down. Therefore, I've optimized the code to use the input
# more directly.
#
# The depth calculation iterates over all nodes, and adds 1 for each parent
# found. A 'depths' array stores depths indexed by the node index, so that if
# a node is reached more than once, there's no need to calculate the depth
# up from a node that had its depth already calculated.
#
# The stack is used to avoid recursion calls, allowing the algorithm to
# backtrack to the original iteration node while incrementing the depth.
class Stack
  def initialize
    @arr = []
  end

  def <<(x)
    @arr << x
  end

  def empty?
    @arr.empty?
  end

  def pop
    @arr.pop
  end
end


def depth(arr)
  depths = Array.new(arr.size)
  max_depth = 0
  stack = Stack.new

  arr.each_with_index do |el, i|
    x = el
    curr_depth = 1
    while x != -1
      break curr_depth = depths[x]+1 if depths[x]
      stack << x
      x = arr[x]
    end

    while (x=stack.pop)
      depths[x] ||= curr_depth
      curr_depth += 1
    end
    depths[i] = curr_depth

    max_depth = [max_depth, curr_depth].max
  end

  max_depth
end

if $0 == __FILE__
  _n = gets
  arr = gets.strip.split.map(&:to_i)
  puts depth(arr)
end

