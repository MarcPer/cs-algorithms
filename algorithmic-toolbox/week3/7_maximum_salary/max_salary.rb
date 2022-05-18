def max_salary(nums)
  return 0 if nums.empty?

  output = []
  until nums.empty?
    max_val = 0
    idx = -1
    nums.each_with_index do |num, i|
      if concat(num, max_val) > concat(max_val, num)
        max_val = num
        idx = i
      end
    end

    output << max_val
    nums.delete_at(idx)
  end
  output.join.to_i
end

def concat(lval, rval)
  (lval.to_s + rval.to_s).to_i
end


if __FILE__ == $0
  n = gets.to_i
  nums = gets.strip.split.map(&:to_i)
  puts max_salary(nums)
end

