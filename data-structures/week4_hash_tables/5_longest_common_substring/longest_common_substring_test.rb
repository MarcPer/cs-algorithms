require_relative './longest_common_substring.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    # the solution is correct if the output equals any of the items in "want"
    specs = [
      {str1: "bla", str2: "bla", want: [[0,0,3]]},
      {str1: "cool", str2: "toolbox", want: [[1,1,3]]},
      {str1: "aaa", str2: "bb", want: [[0,0,0]]},
      {str1: "aabaa", str2: "babbaab", want: [[0,4,3], [2,3,3]]},
      {str1: "voteforthegreatalbaniaforyou", str2: "choosethegreatalbanianfuture", want: [[7,6,15]]},
      {str1: "a"*1000, str2: "a"*1001, want: [[0,0,1000],[0,1,1000]]},
      {str1: "a"*1000, str2: "b"*1000, want: [[0,0,0]]},
    ]

    specs.each do |spec|
      out = SubstrComparer.max_substr(spec[:str1], spec[:str2])
      assert_includes spec[:want], out, "str1=#{spec[:str1]} str2=#{spec[:str2]}"
    end
  end
end

