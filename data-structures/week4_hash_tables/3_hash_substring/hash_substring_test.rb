require_relative './hash_substring.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      {pattern: "aba", text: "abacaba", want: [0,4]},
      {pattern: "Test", text: "testTesttesT", want: [4]},
      {pattern: "aaaaa", text: "baaaaaaa", want: [1,2,3]},
    ]

    specs.each do |spec|
      out = substr_indexes(spec[:text], spec[:pattern], spec[:debug] || false)
      assert_equal spec[:want], out, "patt=#{spec[:pattern]} text=#{spec[:text]}"
    end
  end
end

