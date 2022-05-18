require 'minitest/autorun'
require_relative './max_ad_revenue.rb'

class AdRevenueTest < Minitest::Test
  def test_max_profit
    inputs = [
      { 'ad_profits' => [23], 'avg_clicks' => [39], 'expected' => 897 },
      { 'ad_profits' => [1, 3, -5], 'avg_clicks' => [-2, 4, 1], 'expected' => 23 },
    ]

    inputs.each do |input|
      out = max_revenue(input['ad_profits'], input['avg_clicks'])
      assert_equal input['expected'], out, input
    end
  end
end
