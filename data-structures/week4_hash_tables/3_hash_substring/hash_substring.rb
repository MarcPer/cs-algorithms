# require 'prime'

class Hasher

  attr_reader :hash_p, :hash_x

  # After trying many primes, 49 was the one that made me pass the assignment.
  # For some still unknown reason, larger primes led to a time limit exceeded
  # failure.
  def initialize(size)
    # @hash_p = Prime.lazy.select { |n| n > size }.first
    @hash_p = 49
    r = Random.new(41)
    @hash_x = r.rand(@hash_p-1)+1
  end

  def hash(key)
    hp = self.hash_p
    hx = self.hash_x

    sum = 0
    x = 1
    key.each_byte do |b|
      sum += (b * x) % hp
      sum %= hp 
      x *= hx
    end
    sum
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

def precompute_hashes(hasher, text, patt_size)
  out = Array.new(text.size-patt_size+1)
  out[-1] = hasher.hash(text[-patt_size..-1])

  hash_x = hasher.hash_x
  hash_p = hasher.hash_p

  xp = mod_power(hash_x, patt_size, hash_p)
  # patt_size.times { xp = (xp * hash_x) % hash_p }

  bytes = text.bytes
  (bytes.size-patt_size-1).downto(0).map do |i|
    val = (hash_x*out[i+1] + bytes[i] - bytes[i+patt_size]*xp)%hash_p
    val = (val + hash_p) % hash_p
    out[i] = val
  end
  out
end

def substr_indexes(text, patt, debug=false)
  patt_size = patt.size
  return [] if patt_size > text.size

  hasher = Hasher.new(text.size)
  hashes = precompute_hashes(hasher, text, patt_size)
  patt_hash = hasher.hash(patt)

  positions = []
  (0..text.size-patt_size).each do |i|
    next if hashes[i] != patt_hash

    positions << i if text[i...i+patt_size] == patt
  end

  positions
end

if $0 == __FILE__
  patt = gets(chomp: true)
  text = gets(chomp: true)

  puts substr_indexes(text, patt).join(' ')
end

