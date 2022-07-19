require_relative './substring_equality.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      {
        text: "aaa",
        queries: [[0,0,3], [0,1,1]],
        want: [true, true],
      },
      {
        text: "trololo",
        queries: [[0,0,7],[2,4,3],[3,5,1],[1,3,2]],
        want: [true, true, true, false],
      },
    ]

    specs.each do |spec|
      out = []
      SubstrComparer.process_queries(spec[:text], spec[:queries]) { |v| out << v }
      assert_equal spec[:want], out, "text=#{spec[:text]} queries=#{spec[:queries]}"
    end
  end
end

