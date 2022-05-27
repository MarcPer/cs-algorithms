#!/usr/bin/env ruby

# Returns distance, rounded to 4 decimals
def closest(points)
  Math.sqrt(closest_sq(points.sort_by(&:first))).round(4)
end

# Returns smallest squared distance among given 2-dimensional points
# Arg 'points' is assumed to be sorted by x coordinates
def closest_sq(points)
  return brute_force_closest(points) if points.size <= 3

  mid = points.size/2-1
  min_sq = [closest_sq(points[0..mid]), closest_sq(points[mid+1..-1])].min

  return min_sq if min_sq == 0

  closest_in_strip(points, min_sq)
end

def brute_force_closest(points)
  closest_sq = Float::INFINITY
  points.each_with_index do |pt1, i|
    points[i+1..-1].each do |pt2|
      closest_sq = [closest_sq, dist_sq(pt1, pt2)].min
    end
  end
  closest_sq
end

def dist_sq(p1, p2)
  (p1[0]-p2[0])**2 + (p1[1]-p2[1])**2
end

# Returns smallest distance among given points.
# Arg 'points' is assumed to be sorted by the elements' second coordinates (y)
def closest_in_strip(points, sq_d)
  mid = points.size/2-1
  split_x = points[mid][0]

  dist = Math.sqrt(sq_d)
  sorted_y = points.select { |pt| (pt[0]-split_x).abs < dist }.sort_by(&:last)
  sorted_y.each_with_index do |pt0, i|
    sorted_y[i+1..i+7].each do |pt1|
      sq_d = [sq_d, dist_sq(pt0, pt1)].min
    end
  end
  sq_d
end


if $0 == __FILE__
  num_points = gets.to_i
  points = num_points.times.map { gets.strip.split.map(&:to_i)[0..1] }
  puts closest(points)
end
