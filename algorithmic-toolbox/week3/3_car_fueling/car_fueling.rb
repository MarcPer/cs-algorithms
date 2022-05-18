def number_refills(dist, miles_per_tank, stops)
  refills = 0
  traversed = 0
  while traversed+miles_per_tank < dist
    reachable_stops = stops.select { |s| s <= traversed + miles_per_tank }
    stop = reachable_stops.max
    return -1 if stop.nil?

    traversed += stop - traversed
    stops -= reachable_stops
    refills += 1
  end

  refills
end


if __FILE__ == $0
  dist = gets.to_i
  miles_per_tank = gets.to_i
  _nstops = gets.to_i
  stops = gets.strip.split.map(&:to_i)
  puts number_refills(dist, miles_per_tank, stops)
end

