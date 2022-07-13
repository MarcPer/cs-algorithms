require_relative './job_queue.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      {threads: 2, jobs: [1,2,3,4,5], want: [[0,0], [1,0], [0,1], [1,2], [0,4]]},
      {threads: 4, jobs: Array.new(20){1}, want: Array.new(20){|i| [i%4, i/4]}},
      {threads: 1, jobs: Array.new(20){1}, want: Array.new(20){|i| [0, i]}},
    ]

    specs.each do |spec|
      out = process_jobs(spec[:threads], spec[:jobs])
      assert_equal spec[:want], out, "threads=#{spec[:threads]} jobs=#{spec[:jobs]}"
    end
  end
end
