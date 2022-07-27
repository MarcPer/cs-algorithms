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
  traverse_in_order(node) do |n|
    return false if n.val < min

    min = n.val
  end
  true
end

def traverse_in_order(node)
  stack = []
  stack << node
  while (n = stack.pop)
    stack.push(n.right) if n.right

    if n.left
      stack.push(Node.new(n.val, nil, nil))
      stack.push(n.left)
    else
      yield n
    end
  end
end

if $0 == __FILE__
  n_vertices = gets(chomp: true).to_i
  root = build_tree(n_vertices, STDIN.to_enum)

  puts(bst?(root) ? "CORRECT" : "INCORRECT")
end

