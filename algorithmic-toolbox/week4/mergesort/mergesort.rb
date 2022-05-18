#!/usr/bin/env ruby

# Merges to arrays which are assumed sorted
def merge(a1, a2)
  out = []
  until a1.empty? || a2.empty?
    if a1[0] < a2[0]
      out << a1.shift
    else
      out << a2.shift
    end
  end

  out + a1 + a2
end

def mergesort(arr)
  return arr if arr.size < 2

  p1 = mergesort(arr[0..(arr.size-1)/2])
  p2 = mergesort(arr[(arr.size-1)/2+1..-1])
  merge(p1, p2)
end

if __FILE__ == $0
  n, *a = STDIN.read.split().map(&:to_i)
  a = mergesort(a)
  puts "#{a.join(' ')}"
end
