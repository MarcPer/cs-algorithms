def min_appointments(timeslots)
  num_points = 0
  coords = []
  return { 'num_points' => 0, 'coords' => coords } if timeslots.empty?

  timeslots.sort_by! { |ts| ts[0] }
  until timeslots.empty?
    min_end = timeslots.shift[1]
    while (next_slot = timeslots[0]) && next_slot[0] <= min_end
      min_end = [min_end, next_slot[1]].min
      timeslots.shift
    end
    coords << min_end
  end


  { 'num_points' => coords.size, 'coords' => coords }
end


if __FILE__ == $0
  n = gets.to_i
  timeslots = []
  n.times do
    timeslots << gets.strip.split.map(&:to_i)
  end
  result = min_appointments(timeslots)
  puts result['num_points']
  puts result['coords'].join(' ')
end

