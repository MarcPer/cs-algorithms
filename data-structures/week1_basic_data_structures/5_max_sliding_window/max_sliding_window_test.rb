require_relative './max_sliding_window.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      {input: [2,7,3,1,5,2,6,2], win_size: 4, want: [7,7,5,6,6]}
    ]

    specs.each do |spec|
      out = max_window(spec[:input], spec[:win_size])
      assert_equal spec[:want], out, "input=#{spec[:input]}, win_size=#{spec[:win_size]}"
    end
  end
end
