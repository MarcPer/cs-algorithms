#!/usr/bin/env ruby

def intersections(segments, points)
  seg_starts = segments.map(&:first).sort
  seg_ends = segments.map(&:last).sort
  points.map do |point|
    intersections_single(seg_starts, seg_ends, point)
  end
end

def intersections_single(seg_starts, seg_ends, point)
  # filter out segments that start after point
  idx0 = find_last_seq(seg_starts, point, 0, seg_starts.size-1)
  return 0 if idx0 < 0

  # filter out segments that end before point
  # puts "seg_starts=#{seg_starts.inspect} seg_ends=#{seg_ends} idx0=#{idx0} filtered=#{seg_ends[0..idx0]}" if point == 2
  idx1 = find_first_geq(seg_ends[0..idx0], point, 0, idx0)
  return 0 if idx1 < 0

  idx0-idx1+1
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
  puts intersections(segs, points).join(" ")
end
