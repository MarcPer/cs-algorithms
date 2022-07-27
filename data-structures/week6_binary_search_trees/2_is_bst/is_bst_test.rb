require_relative './is_bst.rb'
require 'minitest/autorun'

class TestSolution < Minitest::Test
  def test_solution
    specs = [
      {input: ["2 1 2", "1 -1 -1", "3 -1 -1"], want: true},
      {input: ["1 1 2", "2 -1 -1", "3 -1 -1"], want: false},
      {input: [], want: true},
      {input: ["1 -1 1", "2 -1 2", "3 -1 3", "4 -1 4", "5 -1 -1"], want: true},
      {input: ["4 1 2","2 3 4","6 5 6","1 -1 -1","3 -1 -1","5 -1 -1","7 -1 -1"], want: true},
      {input: ["4 1 -1","2 2 3","1 -1 -1","5 -1 -1"], want: false},
      {input: ["-887440904 -1 1","-887440903 -1 2","-13646870 -1 -1"], want: true},
    ]

    specs.each do |spec|
      root = build_tree(spec[:input].size, spec[:input].to_enum)
      out = bst?(root)
      assert_equal spec[:want], out, "input=#{spec[:input]}"
    end
  end
end
