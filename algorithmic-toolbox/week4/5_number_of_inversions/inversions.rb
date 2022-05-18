#!/usr/bin/env ruby

# The important insight is that, if we partition an array into a1 and a2, then:
# inversions2(a1, a2) = inversions2(a1.sort, a2.sort)
#
# where inversions2 counts the number of inversions when comparing only elements of a1 and a2,
# without considering inversions within either a1 or a2. The equation is true because indexes
# in the original array pointing to any element in a1 are always smaller than indexes pointing
# to elements in a2, and that remains true even if a1 and a2 are internally reordered.
#
# With this information, we can conclude that counting the total inversions obeys:
# inversions(a) = inversions2(a1.sort, a2.sort) + inversions(a1) + inversions(a2)
#
# That is, a divide-and-conquer approach is feasible, with recursive calls with partitions.
# The inversions2 component corresponds in mergesort to the merge part, i.e. the number
# of inversions is counted while merging two sorted arrays.

# Merges to arrays which are assumed sorted
def merge(a1, a2)
  inversions = 0
  out = []

  a1i = a2i = 0
  a1n = a1.size
  a2n = a2.size


  until a1.empty? || a2.empty?
    if a1[0] <= a2[0]
      out << a1.shift
    else
      out << a2.shift
      inversions += a1.size
    end
  end

  [out + a1 + a2, inversions]
end

def mergesort(arr)
  return [arr, 0] if arr.size < 2

  p1, inv1 = mergesort(arr[0..(arr.size-1)/2])
  p2, inv2 = mergesort(arr[(arr.size-1)/2+1..-1])
  arr, inv_merge = merge(p1, p2)

  [arr, inv1+inv2+inv_merge]
end


if __FILE__ == $0
  n, *a = STDIN.read.split().map(&:to_i)
  _a, invs = mergesort(a)
  puts invs
end
