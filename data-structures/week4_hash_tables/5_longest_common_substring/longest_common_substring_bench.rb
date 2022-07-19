require_relative './longest_common_substring.rb'
require 'benchmark/ips'

Benchmark.ips do |x|
  s1 = "a"*1000
  s2 = "a"*1000

  x.report("initialize") { SubstrComparer.new(s1, s2) }

  comp = SubstrComparer.new(s1, s2)
  x.report("max_substr") { comp.max_substr }

  x.compare!
end
