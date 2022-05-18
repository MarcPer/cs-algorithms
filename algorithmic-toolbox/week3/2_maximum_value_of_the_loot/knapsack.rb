def highest_loot(capacity, items)
  loot = 0
  loop do
    break if items.empty? || capacity <= 0

    best_item = items.max_by { |i| i.price }
    weight = [capacity, best_item.weight].min
    capacity -= weight
    loot += weight * best_item.price
    best_item.weight -= weight
    items.select! { |i| i.weight > 0 }
  end
  loot.round(4)
end

class Item
  attr_accessor :tot_value, :weight, :price
  def initialize(val, weight)
    @tot_value = val
    @weight = weight
    @price = val.to_f/weight
  end

  def to_s
    "Item<val=#{tot_value}, weight=#{weight}>"
  end
end

if __FILE__ == $0
  nitems, capacity = gets.strip.split.map(&:to_i)
  items = []
  nitems.times do
    value, weight = gets.strip.split.map(&:to_i)
    items << Item.new(value, weight)
  end
  puts highest_loot(capacity, items)
end
