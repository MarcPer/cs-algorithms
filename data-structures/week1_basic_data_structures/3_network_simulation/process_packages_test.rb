require_relative './process_packages.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      {buff_size: 1, input: [], want: []},
      {buff_size: 1, input: ["0 0"], want: [0]},
      {buff_size: 1, input: ["1 0"], want: [1]},
      {buff_size: 1, input: ["0 1", "0 1"], want: [0, -1]},
      {buff_size: 1, input: ["0 1", "1 1"], want: [0, 1]},
      {buff_size: 2, input: ["0 1", "1 1", "2 1"], want: [0, 1, 2]},
      {buff_size: 2, input: ["0 1", "0 1", "0 1", "1 1"], want: [0, 1, -1, 2]},
    ]

    specs.each do |spec|
      buf = Buffer.new(spec[:buff_size])
      out = Processor.process(spec[:input].to_enum, buf, spec[:debug]).inject([]) { |memo, n| memo << n }
      assert_equal spec[:want], out, "buff_size=#{spec[:buff_size]} input=#{spec[:input]}"
    end
  end
end
