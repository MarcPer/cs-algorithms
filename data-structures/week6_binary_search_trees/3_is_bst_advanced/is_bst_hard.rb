Node = Struct.new(:val, :left, :right)

# Build tree and return root node
def build_tree(tree_size, input)
  nodes = Array.new(tree_size) { Node.new(nil, nil, nil) }

  tree_size.times do |i|
    line = input.next
    val, left, right = line.chomp.split.map(&:to_i)
    nodes[i].val = val
    nodes[i].left = nodes[left] unless left == -1
    nodes[i].right = nodes[right] unless right == -1
  end
  
  nodes.first
end

# Does the given tree satisfy the binary search tree property?
def bst?(node)
  min = -Float::INFINITY
  traverse_in_order(node) do |n, op|
    case op
    when :gt
      return false if n.val <= min
    when :geq
      return false if n.val < min
    end

    min = n.val
  end
  true
end

def traverse_in_order(node)
  stack = []

  # Besides the node being traversed, add either :gt or :geq
  # These indicate whether the value of the current node n should be
  # strictly greater (:gt) or greater or equal (:geq) to the last traversed
  # value.
  stack << [node, :gt]
  loop do
    n, op = stack.pop
    break unless n

    stack.push([n.right, :geq]) if n.right

    if n.left
      stack.push([Node.new(n.val, nil, nil), :gt])
      stack.push([n.left, :geq]) # :geq is important here. Explanation below.
      # Consider this example
      # 0
      #  \
      #   1
      #  /
      # 0
      # Even though the bottom node is a left child, when the tree is traversed,
      # it will be yielded after the root node, so it is part of the root's right
      # subtree. Therefore, it is allowed for its value to be equal that of the
      # last yielded node.
    else
      yield n, op
    end
  end
end

if $0 == __FILE__
  n_vertices = gets(chomp: true).to_i
  root = build_tree(n_vertices, STDIN.to_enum)

  puts(bst?(root) ? "CORRECT" : "INCORRECT")
end

