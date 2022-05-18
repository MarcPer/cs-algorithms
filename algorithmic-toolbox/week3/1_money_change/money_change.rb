def change(val, den)
  coins = 0
  den.sort!
  while val > 0 do
    max_den_idx = den.index { |x| x > val }
    max_den = max_den_idx ? den[max_den_idx-1] : den[-1]
    coins += 1
    val -= max_den
  end

  coins 
end

if __FILE__ == $0
  val = gets.to_i
  denoms = [1, 5, 10]
  puts change(val, denoms)
end
