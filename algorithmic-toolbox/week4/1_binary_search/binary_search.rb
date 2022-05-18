#!/usr/bin/env ruby
# by Andronik Ordian

def binary_search(list, search_items)
  return Array.new(search_items.size) { -1 } if list.empty?

  output_idxs = []
  search_items.each do |item|
    output_idxs << find_one(list, item, 0, list.size-1)
  end
  output_idxs
end

def find_one(list, item, min, max)
  if max <= min
    return list[min] == item ? min : -1
  end

  pivot = min+(max-min)/2
  return pivot if (x=list[pivot]) == item
  if x > item
    find_one(list, item, min, pivot-1)
  else
    find_one(list, item, pivot+1, max)
  end
end

if __FILE__ == $0
  _ = gets
  list = gets.strip.split.map(&:to_i)
  _ = gets
  search_items = gets.strip.split.map(&:to_i)
  puts binary_search(list, search_items).join(' ')
end
