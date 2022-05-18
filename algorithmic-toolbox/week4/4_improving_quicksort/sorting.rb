#!/usr/bin/env ruby

# partition3(arr, idx, l, r)
# returns two indexes, k_less+1 and k_eq.
# k_less+1 is the first index with an element equal to the given pivot
# k_eq is the index of last element equal to pivot
def partition3(arr, idx, l, r)
  pivot_el = arr[idx]
  k_less = l-1
  k_eq = l-1

  # puts "BEFORE: arr=#{arr.inspect} piv_idx=#{idx}, l=#{l}, r=#{r}"

  # First pass; put less than or equal elements to the left
  (l..r).each do |i|
    if arr[i] <= pivot_el
      k_eq += 1
      arr[k_eq], arr[i] = arr[i], arr[k_eq]
    end
  end

  # puts "MIDDLE: arr=#{arr.inspect} piv_idx=#{idx}, l=#{l}, r=#{r}, k_less=#{k_less}"

  # Second pass; put strictly smaller elements to the left
  (l..k_eq).each do |i|
    if arr[i] < pivot_el
      k_less += 1
      arr[k_less], arr[i] = arr[i], arr[k_less]
    end
  end

  # puts "AFTER: arr=#{arr.inspect} piv_idx=#{idx}, l=#{l}, r=#{r}"
  [k_less+1, k_eq]
end

# partition2(arr, idx, l, r)
# arr: array being sorted
# idx: idx of pivot element; element being compared to all others to partition the array
# l: leftmost index of array to consider
# r: rightmost index of array to consider
def partition2(arr, idx, l, r)
  pivot_el = arr[idx]
  region1_idx = l-1 # index of last element that satisfies <= arr[idx]

  # puts "BEFORE: arr=#{arr.inspect} piv_idx=#{idx}, l=#{l}, r=#{r}"

  (l..r).each do |i|
    if arr[i] <= pivot_el && i != idx
      region1_idx += 1
      arr[region1_idx], arr[i] = arr[i], arr[region1_idx]
    end
  end

  region1_idx += 1
  arr[region1_idx], arr[idx] = arr[idx], arr[region1_idx]
  # puts "AFTER: arr=#{arr.inspect} piv_idx=#{idx}, l=#{l}, r=#{r}"
  region1_idx
end

def randomized_quick_sort(arr, l, r)
  return nil if l >= r

  k = rand(l..r)
  # pivot = partition2(arr, k, l, r)
  # randomized_quick_sort(arr, l, pivot-1)
  # randomized_quick_sort(arr, pivot+1, r)
  #
  k_less, k_eq = partition3(arr, k, l, r)
  randomized_quick_sort(arr, l, k_less-1)
  randomized_quick_sort(arr, k_eq+1, r)
  arr
end

if __FILE__ == $0
  n, *a = STDIN.read.split().map(&:to_i)
  randomized_quick_sort(a, 0, n - 1)
  puts "#{a.join(' ')}"
end
