require 'minitest/autorun'
require_relative './points_and_segments.rb'

class SolutionTest < Minitest::Test
  INPUTS = [
      # {'segments' => [[0, 5], [7, 10]], 'points' => [1, 6, 11], 'exp_output' => [1, 0, 0]},
      # {'segments' => [[0, 1], [0, 2]], 'points' => [1, 2, 3], 'exp_output' => [2, 1, 0]},
      # {'segments' => [[0, 10], [0, 20]], 'points' => [1, 2, 3], 'exp_output' => [2, 2, 2]},
      # {'segments' => [[0, 1], [5, 6]], 'points' => [2, 3], 'exp_output' => [0, 0]},
      {'segments' => [[-10, 10]], 'points' => [-100, 100, 0], 'exp_output' => [0, 0, 1]},
  ]
  def test_solution
    INPUTS.each do |input|
      out = sort_and_count(input['segments'].dup, input['points'].dup)
      assert_equal input['exp_output'], out, input
    end
  end

  def test_naive_solution
    INPUTS.each do |input|
      out = naive_intersections(input['segments'].dup, input['points'].dup)
      assert_equal input['exp_output'], out, input
    end
  end

  def test_find_last_seq
    # always search for element 1
    inputs = [
      [[1, 1, 1], 2],
      [[1, 1, 2], 1],
      [[2, 2, 2], -1],
      [[1, 2, 2, 3], 0],
      [[-1, 0, 0, 1, 1, 2], 4],
      [[0, 2, 2], 0],
    ]
    inputs.each do |input|
      out = find_last_seq(input[0].dup, 1, 0, input[0].size-1)
      assert_equal input[1], out, input
    end
  end
end

def naive_intersections(segs, points)
  points.map do |point|
    segs.count { |seg| seg[0] <= point && seg[1] >= point }
  end
end
