require 'minitest/autorun'
require_relative './knapsack.rb'

class KnapsackTest < Minitest::Test
  def test_loots
    test_instance = Struct.new(:inputs, :expected_output)
    tests = [
      test_instance.new([[3, 50], [60, 20], [100, 50], [120, 30]], 180),
      test_instance.new([[1, 10], [500, 30]], 166.6667)
    ]

    tests.each do |t|
      _nitems, capacity = t.inputs[0]

      items = t.inputs[1..].map { |x| Item.new(x[0], x[1]) }
      assert_equal t.expected_output, highest_loot(capacity, items)
    end
  end
end
