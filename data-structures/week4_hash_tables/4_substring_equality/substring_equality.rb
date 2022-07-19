

class SubstrComparer
  def initialize(text)
    @text = text

    # Primes given by the assignment instruction
    @mod1 = (1e9+7).to_i
    @mod2 = (1e9+9).to_i

    @hash_x = Random.new(42).rand(1e9.to_i)+1

    @hashes1 = Array.new(text.size+1)
    @hashes2 = Array.new(text.size+1)
    compute_prefix_hashes(text.bytes)

    # holds precomputed powers of @hash_x
    # @x_powers = Array.new(text.size)
  end

  def substr_equal?(ia, ib, len)
    return true if ia == ib

    ha = (@hashes1[ia+len]-mod_power(@hash_x, len, @mod1)*@hashes1[ia]) % @mod1
    ha = (ha+@mod1) % @mod1
    hb = (@hashes1[ib+len]-mod_power(@hash_x, len, @mod1)*@hashes1[ib]) % @mod1
    hb = (hb+@mod1) % @mod1

    return false if ha != hb

    ha = (@hashes2[ia+len]-mod_power(@hash_x, len, @mod2)*@hashes2[ia]) % @mod2
    hb = (@hashes2[ib+len]-mod_power(@hash_x, len, @mod2)*@hashes2[ib]) % @mod2

    ha == hb
  end

  def self.process_queries(text, queries)
    comp = self.new(text)

    queries.each do |q|
      yield comp.substr_equal?(q[0], q[1], q[2])
    end
  end

  private

  def compute_prefix_hashes(bytes)
    # Use local variables to optimize the loop
    h1 = @hashes1
    h2 = @hashes2
    m1 = @mod1
    m2 = @mod2
    x = @hash_x

    h1[0] = h2[0] = 0 
    bytes.each_with_index do |b, i|
      h1[i+1] = (x*h1[i]+b) % m1
      h2[i+1] = (x*h2[i]+b) % m2
    end
  end

  def mod_power(x, exp, mod)
    x %= mod
    return 0 if x == 0

    result = 1
    while exp > 0
      result = (result*x)%mod if exp.odd?

      exp >>= 1
      x = (x*x)%mod
    end

    result
  end
end

if $0 == __FILE__
  text = gets(chomp: true)
  nqueries = gets(chomp: true).to_i
  queries = []
  nqueries.times { queries << gets(chomp: true).split.map(&:to_i) }

  SubstrComparer.process_queries(text, queries) do |eq|
    eq ? puts("Yes") : puts("No")
  end
end

