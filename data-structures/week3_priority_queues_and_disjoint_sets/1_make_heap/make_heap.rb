class Tree
  attr_reader :arr, :size
  def initialize(arr)
    @size = arr.size
    @arr = arr
  end

  def swap(i,j)
    @arr[i], @arr[j] = @arr[j], @arr[i]
  end

  def children_idxs(i)
    [2*i+1, 2*i+2].select { |el| el < size }
  end

  def parent_idx(i)
    (i-1)/2
  end

  def sift_down(i)
    while !(ch_idxs = children_idxs(i)).empty?
      min_val = arr[i]
      min_idx = i
      ch_idxs.each do |j|
        if arr[j] < min_val
          min_val = arr[j] 
          min_idx = j
        end
      end
      break if i == min_idx

      swap(i, min_idx)
      yield [i, min_idx] if block_given?

      i = min_idx
    end
  end
end

def make_heap(arr)
  tree = Tree.new(arr)
  ops = []
  (tree.size/2-1).downto(0) do |i|
    tree.sift_down(i) { |op| ops << op }
  end

  # puts arr.inspect
  ops
end

if $0 == __FILE__
  _n = gets.strip.to_i
  arr = gets.strip.split.map(&:to_i)

  operations = make_heap(arr)
  puts operations.size
  operations.each { |op| puts op.join(' ') }
end
