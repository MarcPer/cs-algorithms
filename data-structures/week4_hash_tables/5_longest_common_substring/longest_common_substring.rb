

class SubstrComparer
  def initialize(s1, s2)
    @max_len = [s1.size, s2.size].min
    @size1 = s1.size
    @size2 = s2.size

    # Reusing the primes given in the instructions of the previous assignment
    @mods = [(1e9+7).to_i, (1e9+9).to_i]

    @hash_x = Random.new(42).rand(1e9.to_i)+1

    # hashes for string 1. Each sub-element is the result for a different hash function
    @hashes1 = Array.new(s1.size+1) { Array.new(@mods.size) }
    
    # hashes for string 2. Each sub-element is the result for a different hash function
    @hashes2 = Array.new(s2.size+1) { Array.new(@mods.size) }

    compute_prefix_hashes(@hashes1, s1.bytes)
    compute_prefix_hashes(@hashes2, s2.bytes)

    # puts @hashes1.inspect
    # puts @hashes2.inspect
  end

  # Run a binary search to find the largest matching common substring length
  def max_substr
    bottom = 0
    top = @max_len

    # holds information about the match with longest substring in the form
    # [s1_idx, s2_idx, len] ,
    # where si_idx is the starting index of the substring in string i,
    # and len is the found length.
    # returns [0,0,0] if no match is found
    max_match = [0,0,0]
    len = nil

    while top > bottom
      len = (top+bottom)/2

      if (m=match_len(len))
        max_match = [m[0], m[1], len]
        bottom = len+1
      else
        top = len
      end
    end

    if bottom == top && top != len && (m=match_len(top))
      max_match = [m[0], m[1], top]
    end

    max_match
  end

  def match_len(len)
    return if len == 0

    mods = @mods
    xl = mods.map { |m| mod_power(@hash_x, len, m) }

    # lazily-evaluated hashes for all substrings of string 1 with length len
    h1 = @hashes1
    h1len = (0..@size1-len).lazy.map do |i|
      mods.map.with_index do |mod, mod_idx|
        (h1[i+len][mod_idx]-xl[mod_idx]*h1[i][mod_idx]) % mod
      end
    end

    # hold computed values of elements in enumerator h1len
    h1len_mat = Array.new(@size1-len+1)

    h2 = @hashes2
    (0..@size2-len).each do |s2i|
      v = (0..mods.size-1).map do |mod_idx|
          (h2[s2i+len][mod_idx]-xl[mod_idx]*h2[s2i][mod_idx]) % mods[mod_idx]
      end
      (0..@size1-len).each do |s1i|
        h1v = h1len_mat[s1i] || (h1len_mat[s1i]=h1len.next)

        # there's a match only if the hashes match for all hash functions
        match = (0..mods.size-1).inject(true) do |memo, mod_idx|
          next false unless memo

          v[mod_idx] == h1v[mod_idx]
        end

        return [s1i, s2i] if match
      end
    end

    # no match found
    nil
  end

  def self.max_substr(s1, s2)
    comp = self.new(s1, s2)

    comp.max_substr
  end

  private

  def compute_prefix_hashes(h, bytes)
    # Use local variables to optimize the loop
    mods = @mods
    x = @hash_x

    h[0] = Array.new(mods.size) { 0 }

    bytes.each_with_index do |b, i|
      mods.each_with_index { |m, mi| h[i+1][mi] = (x*h[i][mi]+b) % m }
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
  while line=gets(chomp:true)
    s1, s2 = line.split
    puts SubstrComparer.max_substr(s1.to_s, s2.to_s).join(' ')
  end
end

