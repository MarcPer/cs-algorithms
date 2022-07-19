class Record < Struct.new(:number, :name)
  attr_accessor :next_rec

  def initialize(number, name)
    super
    @next_rec = nil 
  end
end

class PhoneBook
  PRIME_NUMBER = 10_000_019 # prime bigger than maximum phone number 10^7-1
  LOAD_FACTOR_THRESHOLD = 0.9 # dynamically increase hash table if threshold is reached

  def initialize(seed=42)
    @arr = []
    @size = 0
    r = Random.new(seed)
    @cardinality = 1000
    @hash_a = ((r.rand(PRIME_NUMBER-1)+1)%PRIME_NUMBER) % @cardinality
    @hash_b = r.rand(PRIME_NUMBER)
  end

  def add(number, name)
    r = @arr[i=hash(number)]
    if r.nil?
      @size += 1
      @arr[i] = Record.new(number, name)
      check_rehash!
      return
    elsif r.number == number
      r.name = name
      return
    end

    loop do
      break unless r.next_rec

      if r.next_rec.number == number
        r.next_rec.name = name
        return
      end
      r = r.next_rec
    end

    r.next_rec = Record.new(number, name)
    @size += 1
    check_rehash!
  end

  def del(number)
    return unless (r=@arr[i=hash(number)])

    if r.number == number
      @size -= 1
      @arr[i] = r.next_rec
      return
    end

    loop do
      break unless r

      if r.next_rec&.number == number
        @size -= 1
        r.next_rec = r.next_rec.next_rec
        break
      end
      r = r.next_rec
    end
  end

  def find(number)
    return unless (r = @arr[hash(number)])

    loop do
      return r.name if r.number == number
      r = r.next_rec
      return unless r
    end
  end

  def self.process(queries)
    book = self.new

    queries.each do |q|
      cmd, *args = q.split
      case cmd
      when 'add' then book.add(args[0].to_i, args[1])
      when 'del' then book.del(args[0].to_i)
      when 'find' then yield (name = book.find(args[0].to_i)) ? name : "not found"
      end
    end
  end

  private
  
  def hash(key)
    (@hash_a+((@hash_b*key) % PRIME_NUMBER)) % @cardinality
  end

  # Check if load factor is greater than threshold
  # if so, resize hash table by doubling its cardinality.
  # Elements need to be rehashed in this case.
  def check_rehash!
    return if @size.to_f/@cardinality < LOAD_FACTOR_THRESHOLD

    @cardinality *= 2
    old_arr = @arr.dup
    @arr = []
    old_arr.each do |r|
      next unless r

      self.add(r.number, r.name)
      el = r
      while (el = el.next_rec)
        self.add(el.number, el.name)
      end
    end
  end
end

if $0 == __FILE__
  nqueries = gets(chomp: true).to_i
  queries = []
  nqueries.times do
    queries << gets(chomp: true)
  end

  PhoneBook.process(queries) { |name| puts name }
end

