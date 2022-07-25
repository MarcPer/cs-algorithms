

class SubstrComparer
  attr_reader :patt_len, :text_len

  def initialize(text, patt)
    # Smallest prime bigger than the maximum pattern size
    @mod = 100003
    @hash_x = Random.new(42).rand(1e9.to_i)+1

    @text_len = text.size.freeze
    @patt_len = patt.size.freeze

    @hashes_t = compute_prefix_hashes(text.bytes)
    @hashes_p = compute_prefix_hashes(patt.bytes)

    hash_x = @hash_x
    mod = @mod

    # precompute values used in the match check: (x^l)%mod for all l
    @xl = (1..patt.size).map { |len| mod_power(hash_x, len, mod) }
  end

  # Use precomputed hashes to test whether two substrings are equal
  # text_base is the start index of the text
  # offset applies to both the text (in addition to text_base) and the pattern
  # len is the length of both substrings being compared
  def match_patt?(text_base, offset, len)
    return true if len <= 0

    xl = @xl[len-1]
    it = text_base + offset

    ht = (@hashes_t[it+len]-xl*@hashes_t[it]) % @mod
    hp = (@hashes_p[offset+len]-xl*@hashes_p[offset]) % @mod

    ht == hp
  end

  # Use binary search to find the next mismatch for a given
  # text_base and offset.
  # The search varies the value of len, the substring length,
  # to find the minimum length for which the substrings don't match.
  def next_mismatch(text_base, offset)
    l = 0
    r = patt_len-offset

    mismatch_offset = nil

    while l < r
      len = (l+r)/2

      if match_patt?(text_base, offset, len)
        l = len+1
      else
        mismatch_offset = offset+len-1
        r = len
      end
    end
    
    if l==r && r!=len && !match_patt?(text_base, offset, r)
      mismatch_offset = offset+r-1
    end

    mismatch_offset
  end


  # Checks whether text[i..i+len-1] matches the pattern of length len.
  # i is given by the text_base argument.
  # A match is considered to have happened if the text substring equals the
  # pattern up to a maximum number of individual character mismatches,
  # given by max_mismatches.
  def quasi_match?(text_base, max_mismatches)
    return true if max_mismatches >= patt_len

    # offset affects both the text and pattern.
    # Match checks are done by comparing
    # text[text_base+offset..text_base+len-1]
    # against
    # patt[offset..len-1]
    offset = 0

    # up to and including max_mismatches can be found
    (max_mismatches+1).times do
      mismatch_idx = next_mismatch(text_base, offset)
      return true unless mismatch_idx

      # If the mismatch was found at some index, further checks
      # need to happen from that index onward (not including the mismatch index)
      offset = mismatch_idx+1
    end

    false
  end

  # Returns text indexes for which it matches the pattern, up to the maximum
  # number of individual character mismatches given as argument.
  def matches(max_mismatches)
    out = []

    (0..text_len-patt_len).each do |i|
      out << i if quasi_match?(i, max_mismatches)
    end

    out
  end

  def self.matches(num_mismatches, text, patt)
    comp = self.new(text, patt)
    comp.matches(num_mismatches)
  end

  private

  def compute_prefix_hashes(bytes)
    # Use local variables to optimize the loop
    mod = @mod
    x = @hash_x

    h = Array.new(bytes.size+1) {0}

    bytes.each_with_index do |b, i|
      h[i+1] = (x*h[i]+b) % mod
    end
    h
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
  while (line = gets(chomp: true))
    num_mismatches, text, patt = line.split
    matches = SubstrComparer.matches(num_mismatches.to_i, text, patt)
    puts "#{matches.size} #{matches.join(' ')}"
  end
end

