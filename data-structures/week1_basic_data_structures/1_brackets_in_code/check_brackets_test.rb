require_relative './check_brackets.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      { input: %q"[]", want: true },
      { input: %q"{}[]", want: true },
      { input: %q"[()]", want: true },
      { input: %q"(())", want: true },
      { input: %q"{[]}()", want: true },
      { input: %q"{", want: 1 },
      { input: %q"}", want: 1 },
      { input: %q"{[}", want: 3 },
      { input: %q"foo(bar)", want: true },
      { input: %q"foo(bar[i)", want: 10 },
    ]

    specs.each do |spec|
      out = parse(spec[:input])
      assert_equal spec[:want], out, "input=#{spec[:input]}"
    end
  end
end
