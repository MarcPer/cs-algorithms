require_relative './longest_common_substring.rb'
require 'benchmark/ips'

puts "--- COMPLETE MISMATCH ---"
Benchmark.ips do |x|
  s1 = "a"*100
  s2 = "b"*100

  x.report("initialize") { SubstrComparer.new(s1, s2) }

  comp = SubstrComparer.new(s1, s2)
  x.report("max_substr") { comp.max_substr }

  x.compare!
end

puts "--- COMPLETE MATCH ---"
Benchmark.ips do |x|
  s1 = "a"*100
  s2 = "a"*100

  x.report("initialize") { SubstrComparer.new(s1, s2) }

  comp = SubstrComparer.new(s1, s2)
  x.report("max_substr") { comp.max_substr }

  x.compare!
end
