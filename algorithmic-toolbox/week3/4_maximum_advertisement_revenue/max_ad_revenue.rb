def max_revenue(ad_profits, avg_clicks)
  profit = 0
  ad_profits.sort!.reverse!
  avg_clicks.sort!.reverse!
  ad_profits.each_index do |i|
    profit += ad_profits[i] * avg_clicks[i]
  end

  profit
end


if __FILE__ == $0
  n = gets.to_i
  ad_profits = gets.strip.split.map(&:to_i)
  avg_clicks = gets.strip.split.map(&:to_i)
  puts max_revenue(ad_profits, avg_clicks)
end

