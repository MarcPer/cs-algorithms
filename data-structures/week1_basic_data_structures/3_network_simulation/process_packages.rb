class Buffer
  attr_reader :size

  def initialize(size)
    @size = size
    @arr = []
    @read_idx = @write_idx = 0
    @empty = true
    @full = false
  end

  def <<(x)
    return false if @full
    @empty = false

    @arr << x
    @write_idx = (@write_idx+1) % size
    @full = @write_idx == @read_idx
    true
  end

  def next
    return nil if @empty
    @full = false
    @read_idx = (@read_idx+1) % size
    @empty = @read_idx == @write_idx
    @arr.shift
  end

  def peek
    return nil if @empty
    @arr[0]
  end

  def full?
    @full
  end
end

class Packet < Struct.new(:arrival_t, :duration_t, :idx)
  def initialize(arrival_t, duration_t, idx)
    super
  end

  def processed_before?(other, base_time)
    return true unless other

    case x = (base_time + self.duration_t <=> other.arrival_t)
    when 1 then false
    when -1 then true
    else
      self.idx < other.idx
    end
  end

  def <=>(other)
    return -1 unless other
    case (x = self.arrival_t <=> other.arrival_t)
    when -1, 1
      x
    else
      self.idx <=> other.idx
    end
  end
end

class Processor
  def self.process(input, buff, debug=false)
    Processor.new(debug).process(input, buff)
  end

  def initialize(debug)
    @debug = debug
    @packet_idx = 0
  end

  def log(msg)
    return unless @debug
    puts msg
  end

  def rcv_pack(input)
    pkg = nil
    begin
      pkg = input.next
    rescue StopIteration
      return nil
    end

    arrival_t, duration_t = pkg.strip.split.map(&:to_i)
    pkg = Packet.new(arrival_t, duration_t, @packet_idx)
    @packet_idx += 1
    pkg
  end

  def process(input, buff)
    return enum_for(:process, input, buff) unless block_given?

    process_t = 0
    dropped_pkgs = []
    i = 0
    d_pkg = nil

    loop do
      in_pkg ||= rcv_pack(input)
      buf_pkg ||= buff.peek
      break if in_pkg.nil? && buf_pkg.nil?

      log "BEGIN -- in_pkg=#{in_pkg&.idx}, buf_pkg=#{buf_pkg&.idx}, drop_pkg=#{d_pkg&.idx}, buff_full=#{buff.full?}"
      # nothing in buffer; just insert new package there
      if buf_pkg.nil?
        success = buff << in_pkg
        dropped_pkgs << in_pkg unless success
        in_pkg = nil
        next
      end

      # process everything on the buffer that finished before the new packet arrived
      while in_pkg.nil? || buf_pkg.processed_before?(in_pkg, process_t)
        # make sure to output -1 for dropped packages that arrived before buffered ones
        d_pkg ||= dropped_pkgs.shift
        log "MIDDLE -- in_pkg=#{in_pkg&.idx}, buf_pkg=#{buf_pkg&.idx}, drop_pkg=#{d_pkg&.idx}"
        if (d_pkg <=> buf_pkg) == -1
          d_pkg = nil
          yield -1
        else
          process_t = [process_t, buf_pkg.arrival_t].max
          yield process_t
          process_t += buf_pkg.duration_t
          buff.next
          buf_pkg = buff.peek
          break unless buf_pkg
        end
      end

      log "END -- in_pkg=#{in_pkg&.idx}, buf_pkg=#{buf_pkg&.idx}, drop_pkg=#{d_pkg&.idx}"
      if in_pkg
        success = buff << in_pkg
        dropped_pkgs << in_pkg unless success
        in_pkg = nil
      end
    end

    loop do
      buf_pkg ||= buff.next
      d_pkg ||= dropped_pkgs.shift
      break if buf_pkg.nil? && d_pkg.nil?

      if (d_pkg <=> buf_pkg) == -1
        d_pkg = dropped_pkgs.shift
        yield -1
      else
        yield process_t
        process_t += buf_pkg.duration_t
        buf_pkg = buff.next
      end
    end
  end
end


if $0 == __FILE__
  buf_size, _npackets = gets.strip.split.map(&:to_i)
  input = STDIN.to_enum
  buff = Buffer.new(buf_size)
  Processor.process(input, buff).each { |i| puts i }
end

