require_relative './is_bst_hard.rb'
require 'minitest/autorun'

class TestSolution < Minitest::Test
  def test_solution
    specs = [
      {input: ["1 -1 1", "2 -1 2", "3 -1 3", "4 -1 4", "5 -1 -1"], want: true},
      {input: ["4 1 2","2 3 4","6 5 6","1 -1 -1","3 -1 -1","5 -1 -1","7 -1 -1"], want: true},
      {input: ["4 1 -1","2 2 3","1 -1 -1","5 -1 -1"], want: false},
      {input: Array.new(5){|i| "0 -1 #{i+1}"}.push("0 -1 -1"), want: true},
      {input: Array.new(5){|i| "0 #{i+1} -1"}.push("0 -1 -1"), want: false},
      {input: Array.new(9){|i| "#{i} -1 #{i+1}"}.push("9 -1 -1"), want: true},
      {input: ["3 1 -1","2 -1 2","2 3 -1","1 -1 -1"], want: false},
      {input: ["4 1 -1","1 -1 2","3 3 -1","2 -1 -1"], want: true},
      {input: ["2 1 -1","1 2 3","0 -1 -1","1 -1 -1"], want: true},
      {input: Array.new(5){|i| "#{5-i} #{i+1} -1"} + ["0 -1 6","0 -1 -1"], want: true},
      {input: ["0 -1 1", "1 2 -1", "0 -1 -1"], want: true},
      {input: ["0 -1 1", "1 2 -1", "0 -1 3", "1 -1 -1"], want: false},
      {input: ["0 -1 1", "1 2 -1", "0 -1 3", "0 -1 -1"], want: true},
    ]

    run_tests(specs)
  end

  def test_given_inputs
    specs = [
      {input: ["2 1 2", "1 -1 -1", "3 -1 -1"], want: true},
      {input: ["1 1 2", "2 -1 -1", "3 -1 -1"], want: false},
      {input: ["2 1 2","1 -1 -1","2 -1 -1"], want: true},
      {input: ["2 1 2","2 -1 -1","3 -1 -1"], want: false},
      {input: [], want: true},
      {input: ["2147483647 -1 -1"], want: true},
      {input: ["1 -1 1","2 -1 2","3 -1 3","4 -1 4","5 -1 -1"], want: true},
      {input: ["4 1 2","2 3 4","6 5 6","1 -1 -1","3 -1 -1","5 -1 -1","7 -1 -1"], want: true},
    ]

    run_tests(specs)
  end

  def test_big_inputs
    specs = [
      {input: ["-887440904 -1 1","-887440903 -1 2","-13646870 -1 -1"], want: true},
      {input: ["2147483647 1 -1", "2147483647 -1 -1"], want: false},
      {input: ["2147483647 -1 1", "2147483647 -1 -1"], want: true},
      {input: Array.new(5){|i| "-19999999999999999271792589930496 -1 #{i+1}"}.push("0 -1 -1"), want: true},
      {input: Array.new(99_999){|i| "#{i} -1 #{i+1}"}.push("99_999 -1 -1"), want: true},
      {input: Array.new(99_999){|i| "#{99_999-i} #{i+1} -1"}.push("0 -1 -1"), want: true},
      {input: Array.new(99_999){|i| "#{-2e31.to_i} -1 #{i+1}"}.push("#{-2e31.to_i} -1 -1"), want: true},
      {input: Array.new(99_999){|i| "#{(2e31.to_i)-1} -1 #{i+1}"}.push("#{(2e31.to_i)-1} -1 -1"), want: true},
    ]

    run_tests(specs)
  end

  def build_random_tree
    max_size = 3
    max_val = 5

    t = Tree.new(rand(max_val))
    rand(max_size).times do
      t.insert(rand(max_val))
    end

    t
  end

  def test_random_trees
    100.times do
      input = build_random_tree.to_input
      root = build_tree(input.size, input.to_enum)
      assert_equal true, bst?(root), "input=#{input.inspect}"
    end
  end

  def run_tests(specs)
    specs.each do |spec|
      root = build_tree(spec[:input].size, spec[:input].to_enum)
      out = bst?(root)
      assert_equal spec[:want], out, "input=#{spec[:input]}"
    end
  end
end

IndexedNode = Struct.new(:val, :left, :right, :idx)
class Tree
  attr_accessor :root
  def initialize(root_val)
    @root = IndexedNode.new(root_val, nil, nil, 0)
    @idx = 1
    @size = 1
  end

  def insert(val)
    n = find(root, val)
    if val < n.val
      n.left = IndexedNode.new(val, nil, nil, @idx)
    else
      n.right = IndexedNode.new(val, nil, nil, @idx)
    end
    @idx += 1
    @size += 1
  end

  def to_input
    nodes = Array.new(@size)
    traverse(root) do |n|
      nodes[n.idx] = "#{n.val} #{n.left&.idx || -1} #{n.right&.idx || -1}"
    end

    nodes
  end

  def to_s
    to_input.inspect
  end

  private

  def traverse(node, &block)
    traverse(node.left, &block) if node.left
    yield node
    traverse(node.right, &block) if node.right
  end

  def find(node, val)
    if val >= node.val
      return node unless node.right
      find(node.right, val)
    elsif val < node.val
      return node unless node.left
      find(node.left, val)
    end
  end
end
