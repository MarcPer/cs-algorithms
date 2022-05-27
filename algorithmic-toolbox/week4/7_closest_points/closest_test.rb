require 'minitest/autorun'
require_relative './closest.rb'

class SolutionTest < Minitest::Test
  INPUTS = [
    {'points'=>[[0,0],[0,0]], 'exp_output' => 0.0},
    {'points'=>[[1,1],[1,1]], 'exp_output' => 0.0},
    {'points'=>[[1e-9, 0],[1e-9, 1e9]], 'exp_output' => 1e9},
    {'points'=>[[1e9, 0],[1e8, 0]], 'exp_output' => 9e8},
    {'points'=>[[1e9, 0],[-1e9, 0]], 'exp_output' => 2e9},
    {'points'=> Array.new(99_999) { |i| [i,i] }, 'exp_output' => 1.4142, 'skip_naive' => true},
    {'points'=>[[-1, 3], [-1, -3], [0, 1], [0,-1], [1, 3], [1, -3]], 'exp_output' => 2},
    {'points'=>[[0, 1], [0, 0], [0, -1], [0.5, 0]], 'exp_output' => 0.5},
    {'points'=>[[1,1], [1,1], [0,0], [0,0]], 'exp_output' => 0.0},
    {'points'=>[[0,0],[3,4]], 'exp_output' => 5.0},
    {'points'=>[[-1,-1], [-1,1], [1, 1], [1, -1]], 'exp_output' => 2.0},
    {'points'=>[[-1,-2], [-1,2], [1, -2], [1, 2]], 'exp_output' => 2.0},
    {'points'=>[[-10,0], [10,0], [-10, 1], [10, 2]], 'exp_output' => 1.0},
    {'points'=>[[-1,0], [0,0], [1,0]], 'exp_output' => 1.0},
    {'points'=>[[0,-1], [0,0], [0,1]], 'exp_output' => 1.0},
    {'points'=>[[-100,0], [0,0], [10,0]], 'exp_output' => 10.0},
    {'points'=>[[10,0], [0,0], [-100,0], [10, 1]], 'exp_output' => 1.0},
    {'points'=>[[7, 7], [1, 100], [4, 8], [7, 7]], 'exp_output' => 0},
    {'points'=>[[-1, 64], [-1, 32], [-1, 16], [-1, 8], [8, 8]], 'exp_output' => 8},
    {'points'=>[[0, 2], [-2, 0], [2, 2], [2, 2], [1, 0], [-2, 2], [2, 1]], 'exp_output' => 0},
    {'points'=>
     [
       [4,4], [-2,-2], [-3,-4], [-1,3], [2,3], [-4,0], [1,1],
       [-1,-1],[3,-1],[-4,2],[-2,4]
     ],
     'exp_output' => 1.4142},
  ]

  def test_solution
    INPUTS.each do |input|
      out = closest(input['points'].dup)
      assert_equal input['exp_output'], out, input
    end
  end

  NUM_RAND_POINTS = 7
  MAX_POINT_VAL = 2
  def test_solution_random_input
    1000.times do
      num_points = rand(NUM_RAND_POINTS-1)+2
      inputs = []
      num_points.times do
        inputs << [rand(2*MAX_POINT_VAL+1)-MAX_POINT_VAL, rand(2*MAX_POINT_VAL+1)-MAX_POINT_VAL]
      end
      expected_out, closest_points = naive_closest(inputs)
      out = closest(inputs.dup)
      assert_equal expected_out, out, "input=#{inputs}, closest_points=#{closest_points}"
    end
  end

  def test_naive_solution
    INPUTS.each do |input|
      next if input['skip_naive']
      out, _ = naive_closest(input['points'].dup)
      assert_equal input['exp_output'], out, input
    end
  end
end

def naive_closest(points)
  closest_sq = Float::INFINITY
  closest_points = []
  points.each_with_index do |pt1, i|
    points[i+1..-1].each do |pt2|
      dist_sq = (pt1[0]-pt2[0])**2 + (pt1[1]-pt2[1])**2
      if dist_sq < closest_sq
        closest_sq = dist_sq
        closest_points = [pt1, pt2]
      end
    end
  end
  [Math.sqrt(closest_sq).round(4), closest_points]
end
