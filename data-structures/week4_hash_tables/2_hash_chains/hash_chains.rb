class Record < Struct.new(:val)
  attr_accessor :next_rec

  def initialize(val)
    super
    @next_rec = nil 
  end
end

class MyHash
  def initialize(cardinality)
    @x = 263
    @p = 1_000_000_007
    @cardinality = cardinality
    @arr = []
  end

  def add(val)
    r = @arr[i=hash(val)]
    if r.nil?
      @arr[i] = Record.new(val)
      return
    elsif r.val == val
      return
    end

    loop do
      break unless r.next_rec

      if r.next_rec.val == val
        return
      end
      r = r.next_rec
    end

    r.next_rec = Record.new(val)
  end

  def del(val)
    return unless (r=@arr[i=hash(val)])

    if r.val == val
      @arr[i] = r.next_rec
      return
    end

    loop do
      break unless r

      if r.next_rec&.val == val
        r.next_rec = r.next_rec.next_rec
        break
      end
      r = r.next_rec
    end
  end

  def find(val)
    return false unless (r = @arr[hash(val)])

    loop do
      return true if r.val == val
      r = r.next_rec
      return false unless r
    end
  end

  def check(i)
    return "" unless (r=@arr[i])

    out = [r.val]
    while r=r.next_rec
      out << r.val
    end
    out.reverse.join(' ')
  end

  def process(queries)
    queries.each do |q|
      cmd, *args = q.split
      str = args.join(' ')
      case cmd
      when 'add' then self.add(str)
      when 'del' then self.del(str)
      when 'find' then yield self.find(str) ? "yes" : "no"
      when 'check' then yield self.check(args[0].to_i)
      end
    end
  end

  private
  
  def hash(key)
    sum = 0
    key.bytes.each_with_index do |s, i|
      sum += (s * @x**i) % @p
      sum %= @p
    end
    sum % @cardinality
  end
end

if $0 == __FILE__
  cardinality = gets(chomp: true).to_i
  nqueries = gets(chomp: true).to_i
  queries = []
  nqueries.times do
    queries << gets(chomp: true)
  end

  MyHash.new(cardinality).process(queries) { |out| puts out }
end

