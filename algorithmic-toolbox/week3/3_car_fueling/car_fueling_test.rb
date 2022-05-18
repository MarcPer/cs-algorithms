require 'minitest/autorun'
require_relative './car_fueling.rb'

class FuelingTest < Minitest::Test
  def test_refills
    inputs = [
      { 'distance' => 950, 'miles_per_tank' => 400, 'stops' => [200, 375, 550, 750], 'expected' => 2 },
      { 'distance' => 950, 'miles_per_tank' => 400, 'stops' => [550, 750], 'expected' => -1 },
      { 'distance' => 100, 'miles_per_tank' => 30, 'stops' => [10, 40, 80], 'expected' => -1 },
      { 'distance' => 100, 'miles_per_tank' => 30, 'stops' => [10, 40, 70], 'expected' => 3 },
      { 'distance' => 100, 'miles_per_tank' => 30, 'stops' => [10, 40, 70, 100], 'expected' => 3 },
      { 'distance' => 100, 'miles_per_tank' => 30, 'stops' => [10, 40, 70, 100, 120], 'expected' => 3 },
    ]


    inputs.each do |input|
      out = number_refills(input['distance'], input['miles_per_tank'], input['stops'])
      assert_equal input['expected'], out, input
    end
  end
end
