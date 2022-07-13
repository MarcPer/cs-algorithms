Worker = Struct.new(:id, :free_at)

class WorkerHeap
  attr_reader :arr
  def initialize
    @arr = []
  end

  def insert(worker)
    arr << worker
    sift_up(arr.size-1)
  end

  def extract_max
    res = arr[0]
    arr[0] = arr.last
    arr.pop

    sift_down(0)
    res
  end

  private

  def swap(i,j)
    arr[i], arr[j] = arr[j], arr[i]
  end

  def children_idxs(i)
    [2*i+1, 2*i+2].select { |el| el < arr.size }
  end

  def parent_idx(i)
    return 0 if i <= 0
    (i-1)/2
  end

  def sift_up(i)
    while (pid=parent_idx(i)) != i 
      worker = arr[i]
      parent_worker = arr[pid]
      break if worker.free_at > parent_worker.free_at
      break if worker.free_at == parent_worker.free_at && worker.id > parent_worker.id

      swap(i, pid)
      i = pid
    end
  end

  def sift_down(i)
    while !(ch_idxs = children_idxs(i)).empty?
      min_time = arr[i].free_at
      min_wid = arr[i].id

      min_idx = i
      ch_idxs.each do |j|
        w = arr[j]
        if (w.free_at < min_time) || (w.free_at == min_time && w.id < min_wid)
          min_time = w.free_at
          min_wid = w.id
          min_idx = j
        end
      end
      break if i == min_idx

      swap(i, min_idx)

      i = min_idx
    end
  end
end


def process_jobs(nthreads, jobs)
  heap = WorkerHeap.new
  nthreads.times { |id| heap.insert(Worker.new(id, 0)) }

  process_times = []
  jobs.each do |job|
    w = heap.extract_max
    
    process_times << [w.id, w.free_at]
    w.free_at += job
    heap.insert(w)
  end

  process_times
end

if $0 == __FILE__
  nthreads, _njobs = gets(chomp: true).split.map(&:to_i)
  jobs = gets(chomp: true).split.map(&:to_i)

  process_times = process_jobs(nthreads, jobs)
  process_times.each { |pt| puts pt.join(' ') }
end
