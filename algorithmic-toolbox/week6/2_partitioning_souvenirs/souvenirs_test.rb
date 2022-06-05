require 'minitest/autorun'
require_relative './souvenirs.rb'

class SolutionTest < Minitest::Test
  NAIVE_SPECS = [
    {souvenirs:[40], exp_out:false, debug: false},
    {souvenirs:[3,3,3], exp_out:true, debug: false},
    {souvenirs:[3,3,4], exp_out:false, debug: false},
    {souvenirs:[1,4,4,3], exp_out:true, debug: false},
    {souvenirs:[1,1,2,5,6], exp_out:false, debug: false},
    {souvenirs:[1,1,1,1,2,3], exp_out:true, debug: false},
    {souvenirs:[4,2,3,6,3], exp_out:true, debug: false},
    {souvenirs:[4, 3, 4, 3, 6, 1], exp_out:true, debug: false},
    {souvenirs:[1,1,1,3,3,3], exp_out:true, debug: false},
    {souvenirs:[3,3,3,3], exp_out:false},
    {souvenirs:[1,1,2,2,2,4], exp_out:true, debug: false},
    {souvenirs:[17,59,34,57,17,23,67,1,18,2,59], exp_out:true, debug:false},
    {souvenirs:[1,2,3,4,5,5,7,7,8,10,12,19,25], exp_out:true, debug:false},
  ]

  SPECS = NAIVE_SPECS | [
    {souvenirs:Array.new(20){3}, exp_out:false, debug: false},
  ]

  def test_souvenir_partition
    SPECS.each do |spec|
      solver = Solver.new(spec[:souvenirs], spec[:debug])
      out = solver.partitionable?
      assert_equal spec[:exp_out], out, "souvenirs=#{spec[:souvenirs]}"
    end
  end

  def test_naive_solution
    NAIVE_SPECS.each do |spec|
      out = naive_partitionable?(spec[:souvenirs])
      assert_equal spec[:exp_out], out, "souvenirs=#{spec[:souvenirs]}"
    end
  end

  def test_random_inputs
    max_val = 4
    max_itens = 6
    1000.times do
      souvenirs = Array.new(rand(max_itens)+1) { rand(max_val)+1 }

      exp_out = naive_partitionable?(souvenirs)
      out = Solver.new(souvenirs).partitionable?

      assert_equal exp_out, out, "souvenirs=#{souvenirs}"
    end
  end

  def test_next_indexes
    solver = Solver.new([1,2,3,4,5])

    specs = [
      {in: [0,1],   out:[0,2]},
      {in: [0,5],   out:[1,2]},
      {in: [0,1,2], out:[0,1,3]},
      {in: [0,1,3], out:[0,1,4]},
      {in: [0,1,4], out:[0,2,3]},
      {in: [0,2,3], out:[0,2,4]},
      {in: [0,3,4], out:[1,2,3]},
      {in: [1,2,3], out:[1,2,4]},
      {in: [1,2,4], out:[1,3,4]},
      {in: [1,3,4], out:[2,3,4]},
      {in: [2,3,4], out:nil},
    ]

    specs.each do |spec|
      n = spec[:in].size
      assert_equal spec[:out], solver.next_indexes(spec[:in], n), "input: #{spec[:in]}"
    end
  end
end


def naive_partitionable?(souvenirs)
  sum = souvenirs.sum
  return false if sum % 3 != 0 || souvenirs.size < 3

  target_value = sum/3
  souvenirs.permutation.each do |seq|
    part_num = 0
    part_sum = 0

    seq.each do |val|
      part_sum += val
      break if part_sum > target_value

      if part_sum == target_value
        # found one partition that sums to the correct value
        return true if part_num == 1
        part_num += 1
        part_sum = 0
      end
    end
  end

  false
end
