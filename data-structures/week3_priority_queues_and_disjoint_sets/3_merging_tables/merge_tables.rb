class Table
  attr_reader :id
  attr_accessor :num_rows, :symlink

  def initialize(id, num_rows)
    @id = id
    @id.freeze
    @num_rows = num_rows
    @symlink = self
  end

  def ==(other)
    other.id == self.id
  end

  def source
    target = @symlink
    return target if target == self

    loop do
      next_tg = target.symlink
      break if next_tg == target

      target = next_tg
    end

    target
  end

  def merge_into(dest)
    return if dest.id == self.id

    dest_table = dest.source
    src_table = self.source
    return if src_table.id == dest_table.id

    link_to(dest_table)
    dest_table.num_rows += src_table.num_rows
  end
  
  def link_to(dst)
    s = self.symlink
    loop do
      next_link = s.symlink
      break if next_link.id == dst.id

      s.symlink = dst
      s = next_link
    end
  end

  def to_s
    "<Table id=#{id} rows=#{num_rows} source=#{symlink.id}>"
  end
end

def merge_tables(rows, queries, debug=false)
  tables = rows.map.with_index { |nrows, idx| Table.new(idx+1, nrows) }

  max_size = rows.max
  queries.each do |q|
    tdst, tsrc = tables[q[0]-1], tables[q[1]-1]
    if debug
      print "q=#{q} src=#{tsrc} (src_id=#{tsrc.source.id} src_rows=#{tsrc.source.num_rows}) => dst=#{tdst} (dst_id=#{tdst.source.id} dst_rows=#{tdst.source.num_rows}) " 
    end
    tsrc.merge_into(tdst)
    final_size = tdst.source.num_rows
    puts "final_size=#{final_size}" if debug

    if block_given?
      max_size = final_size if final_size > max_size
      yield max_size
    end
  end
end

if $0 == __FILE__
  _ntables, nqueries = gets(chomp: true).split.map(&:to_i)
  rows = gets(chomp: true).split.map(&:to_i)
  queries = []
  nqueries.times { queries << gets(chomp: true).split.map(&:to_i) }

  max_rows = rows.max
  merge_tables(rows, queries) { |max_size| puts max_size }
end
