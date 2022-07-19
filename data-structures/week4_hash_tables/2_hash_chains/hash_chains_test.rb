require_relative './hash_chains.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      {
        cardinality: 5,
        queries: [
          "add world",
          "add HellO",
          "check 4",
          "find World",
          "find world",
          "del world",
          "check 4",
          "del HellO",
          "add luck",
          "add GooD",
          "check 2",
          "del good",
        ],
        want: [
          "HellO world",
          "no",
          "yes",
          "HellO",
          "GooD luck",
        ]
      },
      {
        cardinality: 4,
        queries: [
          "add test",
          "add test",
          "find test",
          "del test",
          "find test",
          "find Test",
          "add Test",
          "find Test",
        ],
        want: [
          "yes",
          "no",
          "no",
          "yes",
        ]
      },
      {
        cardinality: 3,
        queries: [
          "check 0",
          "find help",
          "add help",
          "add del",
          "add add",
          "find add",
          "find del",
          "del del",
          "find del",
          "check 0",
          "check 1",
          "check 2",
        ],
        want: [
          "",
          "no",
          "yes",
          "yes",
          "no",
          "",
          "add help",
          "",
        ]
      },
    ]

    specs.each do |spec|
      out = []
      MyHash.new(spec[:cardinality]).process(spec[:queries]) { |val| out << val }
      assert_equal spec[:want], out, "card=#{spec[:cardinality]} queries=#{spec[:queries]}"
    end
  end
end

