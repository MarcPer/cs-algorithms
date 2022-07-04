require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def pipe_input(arr, win_size)
    raw_output = nil
    IO.popen('./max_sliding_window', 'r+') do |pipe|
      pipe.puts arr.size
      pipe.puts arr.join(' ')
      pipe.puts win_size

      pipe.close_write

      raw_output = pipe.gets(nil)
    end

    raw_output.strip.split.map(&:to_i)
  end

  def test_solution
    specs = [
      {arr: [2, 7, 3, 1, 5, 2, 6, 2], win_size: 4, want: [7, 7, 5, 6, 6]},
    ]

    specs.each do |spec|
      out = pipe_input(spec[:arr], spec[:win_size])
      assert_equal spec[:want], out, "input arr=#{spec[:arr]}, win_size=#{spec[:win_size]}"
    end
  end
end
