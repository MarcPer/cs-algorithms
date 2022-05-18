def max_prizes(num_candies)
  return { 'num_places' => 0, 'reward_distr' => [] } if num_candies == 0

  # derived from the formula:
  # S <= num_candies
  # S = (an-a1)*n/2
  #
  # if we assume the terms start from 1 with 1 increments (i.e. a1=1, a2=2, ...)
  # S = (n+1)*n/2
  # Solving, we get n below
  num_places = ((-1 + Math.sqrt(8*num_candies+1))/2).floor

  # after distributing the candies as 1, 2, 3, some candies might remain.
  # the strategy is to give all that remains to the first place
  tot = ((num_places+1)*num_places)/2
  remainder = num_candies - tot
  { 'num_places' => num_places, 'reward_distr' => (1..num_places-1).to_a + [num_places+remainder] }
end


if __FILE__ == $0
  num_candies = gets.to_i
  result = max_prizes(num_candies)
  puts result['num_places']
  puts result['reward_distr'].join(' ')
end

