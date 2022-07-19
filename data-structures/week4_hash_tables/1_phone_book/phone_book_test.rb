require_relative './phone_book.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      {
        queries: [
          "add 911 police",
          "add 76213 Mom",
          "add 17239 Bob",
          "find 76213",
          "find 910",
          "find 911",
          "del 910",
          "del 911",
          "find 911",
          "find 76213",
          "add 76213 daddy",
          "find 76213",
        ],
        want: [
          "Mom",
          "not found",
          "police",
          "not found",
          "Mom",
          "daddy"
        ]
      },
      {
        queries: [
          "find 3839442",
          "add 123456 me",
          "add 0 granny",
          "find 0",
          "find 123456",
          "del 0",
          "del 0",
          "find 0",
        ],
        want: [
          "not found",
          "granny",
          "me",
          "not found",
        ]
      },
      {
        queries: Array.new(1001) { |i| "add 1 bob_#{i}" } + ["find 1"],
        want: ["bob_1000"]
      },
      {
        queries: Array.new(899) { |i| "add #{i} bob_#{i}" } +
          Array.new(899) { |i| "find #{i}" },
        want: Array.new(899) { |i| "bob_#{i}" }
      },
      {
        queries: ["del 1", "add 1 bob", "find 1", "del 1", "find 1"],
        want: ["bob", "not found"]
      },
    ]

    specs.each do |spec|
      out = []
      PhoneBook.process(spec[:queries]) { |name| out << name }
      assert_equal spec[:want], out, "queries=#{spec[:queries]}"
    end
  end

  def test_collision_handling
    book = PhoneBook.new
    book.instance_variable_set(:@cardinality, 2)
    out = []
    book.stub(:hash, 0) do
      5.times { |i| book.add(i, "bob_#{i}") }
      5.times { |i| assert_equal "bob_#{i}", book.find(i) }

      assert_equal "bob_4", book.find(4)
      book.del(0)
      4.downto(1) { |i| assert_equal "bob_#{i}", book.find(i) }

      book.add(1, "bob_1000")
      4.downto(2) { |i| assert_equal "bob_#{i}", book.find(i) }
      assert_equal "bob_1000", book.find(1)
    end
  end

  def test_random_input
    n_nums = 1000
    n_names = 200
    n_queries = 10
    100.times do
      queries = build_random_query(n_queries, n_nums, n_names)

      naive_out = []
      naive_out = NaivePhoneBook.process(queries) { |name| naive_out << name }

      out = []
      out = PhoneBook.process(queries) { |name| out << name }

      assert_equal naive_out, out, "queries=#{queries}"
    end
  end

  def build_random_query(n_queries, n_nums, n_names)
    cmds = %w[add del find]
    input_nums = (1..n_nums).to_a
    input_names = (1..n_names).map { "name_#{_1}" }
    queries = []
    n_queries.times do
      cmd = cmds.sample
      num = input_nums.sample
      case cmd
      when "add"
        queries << "add #{num} #{input_names.sample}"
      else
        queries << "#{cmd} #{num}"
      end
    end

    queries
  end
end

class NaivePhoneBook < PhoneBook
  def initialize
    @h = {}
  end

  def add(number, name)
    @h[number] = name
  end

  def del(number)
    @h.delete(number)
  end

  def find(number)
    @h[number]
  end
end

