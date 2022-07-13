require_relative './merge_tables.rb'
require 'minitest/autorun'

class SolutionTest < Minitest::Test
  def test_solution
    specs = [
      {rows: [1], queries: [], want: []},
      {rows: [2], queries: [[1,1]], want: [2]},
      {rows: [5,0,1], queries: [[1,2],[2,3]], want: [5,6]},
      {rows: [4,3,1,1,5,4,3,2], queries: [[1,2],[2,3],[3,4],[5,6],[7,8],[8,5],[4,5]], want: [7,8,9,9,9,14,23]},
      {
        rows: [1,2,3,4,5,6,7,8],
        queries: [[1,2], [3,4], [3,2], [5,6], [7,8], [7,5], [8,1]],
        want: [8,8,10,11,15,26,36],
        debug: false
      },
      {rows: [10,1,5,6,1], queries: [[1,2],[3,4],[4,5],[5,2]], want: [11,11,12,23]},
      {rows: [1,1,1,1,1], queries: [[3,5],[2,4],[1,4],[5,4],[5,3]], want: [2,2,3,5,5]},
      {rows: [10,0,5,0,3,3], queries: [[6,6],[6,5],[5,4],[4,3]], want: [10,10,10,11]},
      {rows: [1,4,2,3], queries: [[1,2],[3,4],[1,2],[2,3]], want: [5,5,5,10]},
      {rows: [1,1,1], queries: [[3,2],[2,1],[1,3]], want: [2,3,3]},
      {rows: [0,200,0], queries: [[3,2],[2,1],[1,3]], want: [200,200,200]},
      {rows: [1,1,0], queries: [[3,2],[2,1],[1,3]], want: [1,2,2]},
      {rows: [1,2,4], queries: [[1,2],[2,1],[3,3],[2,3]], want: [4,4,4,7]},
      {rows: Array.new(5){_1}, queries: Array.new(4){[_1+1,_1+2]}, want: [4,4,6,10]},
      {
        rows: Array.new(100_000){10_000},
        queries: Array.new(49_999){[2*_1+1,2*_1+2]}<<[1,3],
        want: Array.new(49_999){20_000} << 40_000
      },
    ]

    specs.each do |spec|
      sizes = []
      merge_tables(spec[:rows], spec[:queries], spec[:debug]) { |sz| sizes << sz }
      err_msg = proc do
        if spec[:queries].size > 30
          "num_rows=#{spec[:rows].size} num_queries=#{spec[:queries].size}"
        else
          "rows=#{spec[:rows]} queries=#{spec[:queries]}"
        end
      end
      assert_equal spec[:want], sizes, err_msg.call
    end
  end
end
