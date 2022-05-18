require 'minitest/autorun'
require_relative './min_appointments.rb'

class SignatureCollectionTest < Minitest::Test
  def test_max_profit
    inputs = [
      { 'timeslots' => [[1, 3], [2, 5], [3, 6]], 'exp_num_points' => 1, 'exp_coords' => [3] },
      { 'timeslots' => [[1, 2], [3, 4], [5, 6]], 'exp_num_points' => 3, 'exp_coords' => [2, 4, 6] },
      { 'timeslots' => [[1, 4], [3, 4], [5, 6]], 'exp_num_points' => 2, 'exp_coords' => [4, 6] },
      { 'timeslots' => [[4, 7], [1, 3], [2, 5], [5, 6]], 'exp_num_points' => 2, 'exp_coords' => [3, 6] },
    ]

    inputs.each do |input|
      out = min_appointments(input['timeslots'].dup)
      assert_equal input['exp_num_points'], out['num_points'], input.merge(out)
      assert_equal input['exp_coords'], out['coords'], input
    end
  end
end
