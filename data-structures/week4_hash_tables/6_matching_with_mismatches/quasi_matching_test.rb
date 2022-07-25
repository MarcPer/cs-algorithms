require_relative './quasi_matching.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_match_patt?
    specs = [
      {text: "ab", patt: "a", text_base: 0, offset: 0, len: 1, want: true},
      {text: "ab", patt: "a", text_base: 1, offset: 0, len: 1, want: false},
      {text: "aba", patt: "ba", text_base: 0, offset: 0, len: 2, want: false},
      {text: "aba", patt: "ba", text_base: 1, offset: 0, len: 2, want: true},
    ]

    specs.each do |spec|
      comp = SubstrComparer.new(spec[:text], spec[:patt])
      out = comp.match_patt?(spec[:text_base], spec[:offset], spec[:len])
      assert_equal spec[:want], out, "text=#{spec[:text]} patt=#{spec[:patt]} text_base=#{spec[:text_base]} offset=#{spec[:offset]} len=#{spec[:len]}"
    end
  end

  def test_next_mismatch
    specs = [
      {text: "a", patt: "a", offset: 0, text_base: 0, want: nil},
      {text: "abac", patt: "abab", offset: 0, text_base: 0, want: 3},
      {text: "xabac", patt: "abab", offset: 0, text_base: 0, want: 0},
      {text: "xabac", patt: "abab", offset: 0, text_base: 1, want: 3},
      {text: "xabac", patt: "abab", offset: 1, text_base: 1, want: 3},
    ]

    specs.each do |spec|
      comp = SubstrComparer.new(spec[:text], spec[:patt])
      out = comp.next_mismatch(spec[:text_base], spec[:offset])
      assert_equal spec[:want], out, "text=#{spec[:text]} patt=#{spec[:patt]} text_base=#{spec[:text_base]} offset=#{spec[:offset]}"
    end
  end

  def test_solution
    specs = [
      {num_mismatches: 0, text: "ababab", patt: "baaa", want: []},
      {num_mismatches: 1, text: "ababab", patt: "baaa", want: [1]},
      {num_mismatches: 1, text: "xabcabc", patt: "ccc", want: []},
      {num_mismatches: 2, text: "xabcabc", patt: "ccc", want: [1,2,3,4]},
      {num_mismatches: 3, text: "aaa", patt: "xxx", want: [0]},
    ]

    specs.each do |spec|
      out = SubstrComparer.matches(spec[:num_mismatches], spec[:text], spec[:patt])
      assert_equal spec[:want], out, "num_mismatches=#{spec[:num_mismatches]} text=#{spec[:text]} patt=#{spec[:patt]}"
    end
  end
end

