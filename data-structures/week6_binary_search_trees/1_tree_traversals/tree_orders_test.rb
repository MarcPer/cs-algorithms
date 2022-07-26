require_relative './tree_orders.rb'
require 'minitest/autorun'

class TestSolution < Minitest::Test
  def test_in_order
    specs = [
      {input: ["4 1 2", "2 3 4", "5 -1 -1", "1 -1 -1", "3 -1 -1"], want: [1,2,3,4,5]},
      {
        input: [
          "0 7 2", "10 -1 -1", "20 -1 6", "30 8 9", "40 3 -1",
          "50 -1 -1", "60 1 -1", "70 5 4", "80 -1 -1", "90 -1 -1",
        ],
        want: [50,70,80,30,90,40,0,20,10,60]
      },
      {input: ["0 -1 1", "1 -1 2", "2 -1 3", "3 -1 -1"], want: [0,1,2,3]},
      {
        input: Array.new(9){|i| "#{i} #{i+1} -1"}.push("9 -1 -1"),
        want: Array.new(10){_1}.reverse
      },
      {
        input: Array.new(99_999){|i| "#{i} #{i+1} -1"}.push("99999 -1 -1"),
        want: Array.new(100_000){99_999 - _1}
      },
    ]

    specs.each do |spec|
      root = build_tree(spec[:input].size, spec[:input].to_enum)
      out = []
      traverse_in_order(root) { |n| out << n.val }
      assert_equal spec[:want], out, "input=#{spec[:input]}"
    end
  end

  def test_pre_order
    specs = [
      {input: ["4 1 2", "2 3 4", "5 -1 -1", "1 -1 -1", "3 -1 -1"], want: [4,2,1,3,5]},
      {
        input: [
          "0 7 2", "10 -1 -1", "20 -1 6", "30 8 9", "40 3 -1",
          "50 -1 -1", "60 1 -1", "70 5 4", "80 -1 -1", "90 -1 -1",
        ],
        want: [0,70,50,40,30,80,90,20,60,10]
      },
      {
        input: Array.new(9){|i| "#{i} #{i+1} -1"}.push("9 -1 -1"),
        want: Array.new(10){_1}
      },
      {
        input: Array.new(99_999){|i| "#{i} #{i+1} -1"}.push("99999 -1 -1"),
        want: Array.new(100_000){_1}
      },
    ]

    specs.each do |spec|
      root = build_tree(spec[:input].size, spec[:input].to_enum)
      out = []
      traverse_pre_order(root) { |n| out << n.val }
      assert_equal spec[:want], out, "input=#{spec[:input]}"
    end
  end

  def test_post_order
    specs = [
      {input: ["4 1 2", "2 3 4", "5 -1 -1", "1 -1 -1", "3 -1 -1"], want: [1,3,2,5,4]},
      {
        input: [
          "0 7 2", "10 -1 -1", "20 -1 6", "30 8 9", "40 3 -1",
          "50 -1 -1", "60 1 -1", "70 5 4", "80 -1 -1", "90 -1 -1",
        ],
        want: [50,80,90,30,40,70,10,60,20,0]
      },
    ]


    specs.each do |spec|
      root = build_tree(spec[:input].size, spec[:input].to_enum)
      out = []
      traverse_post_order(root) { |n| out << n.val }
      assert_equal spec[:want], out, "input=#{spec[:input]}"
    end
  end
end
