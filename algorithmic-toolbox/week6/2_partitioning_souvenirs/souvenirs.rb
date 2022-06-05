#!/usr/bin/env ruby

class Solver
  attr_reader :debug, :good_sums, :total_value, :sentinel, :souvenirs

  def initialize(souvenirs, debug=false)
    @souvenirs = souvenirs.sort
    @total_value = souvenirs.sum
    @debug = debug

    # Store partial sums that equal total_value/3
    # This array stores the indexes referencing the elements with the desired
    # sum, not the sum values itself.
    #
    # Note that we only need to find two non-overlapping good sums, as that
    # already implies we have a third one with the remaining elements.
    @good_sums = []

    # Sentinel value used below to mark sums that were not yet calculated.
    @sentinel = @total_value*3

    # The following array maps from chosen souvenirs to their summed values.
    # The index is such that it represents the which souvenirs are present and
    # which ones aren't with 1s and 0s. For example, a 1010 indicates elements
    # v1 and v3 are being summed, but not v2 and v4.
    # If we have n souvenirs, the array will contain 2**n elements.
    #
    # The array is also initialized with a large value. Its sole purpose is to
    # act as a sentinel. While summing, we stop considering further elements if
    # the sum has already exceeded the target value of total_value/3. The
    # skipped elements are therefore by default already set with a value
    # indicating they have some large value that shouldn't be considered.
    @sums = Array.new(2**souvenirs.size) { @sentinel }
  end

  def partitionable?
    return false if total_value % 3 != 0 || souvenirs.size < 3
    
    (1..souvenirs.size-1).each do |n|
      stop = compute_sums(n)
      return false if stop == :stop
    end

    print("target_value=#{@total_value/3}")
    print("souvenirs=#{@souvenirs.inspect}")
    print_good_sums
    print("sums=#{@sums.inspect}")

    nonoverlaping_sums?
  end

  # The function returns the calculated sum for the given terms.
  # If a block is given, it yields the @sums array as well as the index being
  # referenced. Note that a conversion is needed between the input indexes,
  # which are more intuitive, to the corresponding one in the @sums array.
  #
  # For instance, if souvenirs=[1,2,3,4], then sum(1,3) is the sum between
  # elements 1 and 3, in this case 2+4=6. sum(1,2,3) would be then 2+3+4=9.
  #
  # To encapsulate the index conversion, assignments to the @sums array are
  # done through this method as well, by passing a block to it. The block is
  # yielded the @sums array, as well as the corresponding index being queried,
  # so it can be modified.
  #
  # As an example, to change sum(1,3) to have the value x, one would do
  # sums(1,3) { |arr, i| arr[i] = x }
  def sum(*idxs)
    return 0 if idxs.empty?
    idx = 0 
    idxs.each do |i|
      idx |= (1 << i)
    end

    idx -= 1

    yield @sums, idx if block_given?
    @sums[idx]
  end

  # Check, among the sums that led to the desired value, whether there is any
  # pair that doesn't have any overlapping elements.
  def nonoverlaping_sums?
    @good_sums.each_with_index do |sum1, idx1|
      @good_sums[idx1+1..-1].each do |sum2|
        return true if sum1 & sum2 == 0
      end
    end
    false
  end

  # Compute the sums while using n elements. For example, if n=3, computes
  # 3-wise sums sum(i,j,k) for all i, j, and k, with j>i and k>j.
  def compute_sums(n)
    return compute1_sum if n == 1
    pivot_index = n/2-1
    target_value = total_value/3
    num_souvenirs = souvenirs.size

    indexes = []
    skip = false
    while indexes = next_indexes(indexes, n, skip)
      skip = false
      val = nil
      sum(*indexes) do |arr, i|
        val = sum(*indexes[0..pivot_index]) + sum(*indexes[pivot_index+1..-1])
        arr[i] = val
        print "indexes: #{indexes}, val=#{val}, sum(#{indexes[0..pivot_index].inspect})=#{sum(*indexes[0..pivot_index])}, sum(#{indexes[pivot_index+1..-1]})=#{sum(*indexes[pivot_index+1..-1])}"
        print "good indexes found=#{indexes}, pivot=#{pivot_index}" if val == target_value
        @good_sums << i+1 if val == target_value
        skip = val > target_value
      end
    end
  end

  # Initializes sum(i) for all i, that is, sums containing a single element.
  # The values should equal those of the corresponding souvenir element.
  # For example, if souvenirs=[1,2,3], then sum(0)=1, sum(1)=2, ...
  def compute1_sum
    target_value = total_value/3
    souvenirs.each_with_index do |val, idx|
      sum(idx) do |arr, i|
        arr[i] = val
        
        # return early if any single element exceeds the target value
        return :stop if val > target_value
        print "good sum found idx=#{idx}, i=#{i}" if val == target_value
        @good_sums << i+1 if val == target_value
      end
    end
  end

  def next_indexes(curr_idxs, n, skip=false)
    return if curr_idxs.nil?
    return Array.new(n) { |i| i } if curr_idxs.empty?

    idxs = curr_idxs.dup
    num_souvenirs = souvenirs.size

    smallest_idx = n-1
    (0..n-1).each do |i|
      ii = n-1-i
      smallest_idx = ii
      idxs[ii] += 1
      break if idxs[ii] < num_souvenirs-i && !skip

      skip = false
      print "skipped curr_idxs=#{curr_idxs}, i=#{i}, ii=#{ii}, idxs[ii]=#{idxs[ii]}, skip=#{skip}, num_souvenirs-i=#{num_souvenirs-i}"
      idxs[ii] = idxs[ii-1]+2
    end

    (1..n-1-smallest_idx).each do |j|
      idxs[smallest_idx+j] = idxs[smallest_idx]+j
      return nil if idxs[smallest_idx+j] >= num_souvenirs - (n-1)+(smallest_idx+j)
    end

    idxs
  end

  def print(msg)
    return unless debug
    puts msg
  end

  def print_good_sums
    return unless debug

    out = []
    @good_sums.each do |gs|
      els = {repr: gs.to_s(2), indexes:[], elements:[]} 
      souvenirs.each_with_index do |val, i| 
        if gs % 2 == 1
          els[:indexes] << i
          els[:elements] << val
        end
        gs = gs/2
      end
      out << els
    end
    puts "good_sums=#{out.inspect}"
  end
end

if $0 == __FILE__
  _num_souvenirs = gets
  souvenirs = gets.split.map(&:to_i)
  solver = Solver.new(souvenirs)
  puts solver.partitionable? ? 1 : 0
end
