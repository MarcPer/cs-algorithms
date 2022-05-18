require 'minitest/autorun'
require_relative './max_prizes.rb'

class SignatureCollectionTest < Minitest::Test
  def test_max_profit
    inputs = [
      { 'num_candies' => 6, 'exp_num_places' => 3, 'exp_rew_distr' => [1, 2, 3] },
      { 'num_candies' => 8, 'exp_num_places' => 3, 'exp_rew_distr' => [1, 2, 5] },
      { 'num_candies' => 2, 'exp_num_places' => 1, 'exp_rew_distr' => [2] },
      { 'num_candies' => 4, 'exp_num_places' => 2, 'exp_rew_distr' => [1, 3] },
    ]

    inputs.each do |input|
      out = max_prizes(input['num_candies'])
      assert_equal input['exp_num_places'], out['num_places'], input.merge(out)
      assert_equal input['exp_rew_distr'], out['reward_distr'], input
    end
  end
end
