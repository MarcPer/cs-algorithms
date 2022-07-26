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

def traverse_in_order(node, &block)
  traverse_in_order(node.left, &block) if node.left
  yield node
  traverse_in_order(node.right, &block) if node.right
end

def traverse_pre_order(node, &block)
  yield node
  traverse_pre_order(node.left, &block) if node.left
  traverse_pre_order(node.right, &block) if node.right
end

def traverse_post_order(node, &block)
  traverse_post_order(node.left, &block) if node.left
  traverse_post_order(node.right, &block) if node.right
  yield node
end

if $0 == __FILE__
  n_vertices = gets(chomp: true).to_i
  root = build_tree(n_vertices, STDIN.to_enum)

  traverse_in_order(root) { |n| print "#{n.val} " }
  puts
  traverse_pre_order(root) { |n| print "#{n.val} " }
  puts
  traverse_post_order(root) { |n| print "#{n.val} " }
  puts
end
