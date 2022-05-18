#!/usr/bin/env ruby

def has_majority?(list)
  return false if list.size < 2
  maj_elements = majority_element(list)
  n = list.size/2
  return false if maj_elements.empty?

  maj_elements.each do |elem|
    count = 0
    list.each do |list_elem|
      count += 1 if list_elem == elem
      return true if count > n
    end
  end
  false
end

def majority_element(list)
  if list.size <= 3
    h = Hash.new { 0 }
    list.each do |v|
      h[v] += 1
      return [v] if h[v] >= 2
    end
    return []
  end

  m1 = majority_element(list[0..list.size/2])
  m2 = majority_element(list[list.size/2+1..-1])

  if m1.empty? && m2.empty?
    []
  elsif m1.empty?
    m2
  elsif m2.empty?
    m1
  else
    m1 | m2
  end
end

if __FILE__ == $0
  _ = gets
  list = gets.strip.split.map(&:to_i)
  puts has_majority?(list) ? 1 : 0
end
