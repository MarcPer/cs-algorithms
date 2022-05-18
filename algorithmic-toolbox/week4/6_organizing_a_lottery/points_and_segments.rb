#!/usr/bin/env ruby

def intersections(segments, points)
  # puts "intersections(#{segments.inspect}, #{points.inspect})"
  return [] if points.empty?
  return Array.new(points.size) { 0 } if segments.empty?

  if points.size == 1
    return [segments.count { |seg| seg[0] <= points[0] && seg[1] >= points[0] }]
  end

  sorted_seg_starts = segments.sort { |seg| seg[0] }
  sorted_seg_ends = segments.sort { |seg| seg[1] }

  mid_idx = (points.size-1)/2
  # puts "  Midpoints arr[#{mid_idx}]=#{points[mid_idx]}   arr[#{mid_idx+1}]=#{points[mid_idx+1]}"
  c1 = intersections(interval_to_max_start(sorted_seg_starts, points[mid_idx]), points[0..mid_idx])
  c2 = intersections(interval_from_min_end(sorted_seg_ends, points[mid_idx+1]), points[mid_idx+1..-1])
  c1+c2
end

# The algorithm needs points to be sorted, but to get the final answer, they should
# be ordered as they were in the beginning.
# indexed_points is used to bring each point's inversion count to its original position.
def sort_and_count(segments, points)
  indexed_points = []
  points.each_with_index { |pt, i| indexed_points << [i, pt] }
  indexed_points.sort_by!{ |ip| ip[1] }
  unsorted_counts = intersections(segments, indexed_points.map(&:last))
  output = []
  indexed_points.each_with_index do |ip, idx|
    output[ip[0]] = unsorted_counts[idx]
  end
  output
end

def interval_to_max_start(segments, target)
  idx = find_last_seq(segments.map(&:first), target, 0, segments.size-1)
  # puts "  last_idx=#{idx}, segs=#{segments.map(&:first)}, target=#{target}"
  idx < 0 ? [] : segments[0..idx]
end

def interval_from_min_end(segments, target)
  idx = find_first_geq(segments.map(&:last), target, 0, segments.size-1)
  # puts "  first_idx=#{idx}, segs=#{segments.map(&:last)}, target=#{target}"
  idx < 0 ? [] : segments[idx..-1]
end

# Find first element in list that is greater than or equal to item
def find_first_geq(list, item, min, max)
  # puts "list=#{list} item=#{item} min=#{min} max=#{max}"
  if max <= min
    return list[min] >= item ? min : -1
  end

  pivot = min+(max-min)/2
  if list[pivot] >= item
    find_first_geq(list, item, min, pivot)
  else
    find_first_geq(list, item, pivot+1, max)
  end
end

# Find last element in list that is smaller than or equal to item
def find_last_seq(list, item, min, max)
  # puts "list=#{list} item=#{item} min=#{min} max=#{max}"
  if max <= min
    return list[max] <= item ? max : -1
  end

  pivot = min+(max-min)/2+1
  if list[pivot] <= item
    find_last_seq(list, item, pivot, max)
  else
    find_last_seq(list, item, min, pivot-1)
  end
end

if $0 == __FILE__
  num_segs, num_points = gets.strip.split().map(&:to_i)

  segs = num_segs.times.map { gets.strip.split.map(&:to_i) }
  points = gets.strip.split.map(&:to_i)
  points = points[0..num_points-1]
  puts sort_and_count(segs, points).join(" ")
end
