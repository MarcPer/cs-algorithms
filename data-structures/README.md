# Data structures

Based on the [Data structures course](https://www.coursera.org/learn/data-structures/home/week/1) on Coursera.

## Structures

### Trees

To do a breadth-first traversal, one can use a queue:
```ruby
def breadth_traverse(node)
  return unless node

  q = MyQueue.new # not the Ruby Queue, used in multi-threading
  q.enq(node)
  while (n = q.deq)
    puts n.val
    q.enq(n.left) if n.left
    q.enq(n.right) if n.right
  end
end
```


### Heaps

In a max/min heap, the parent's value is always bigger/smaller than its children's values.

Useful as priority queues, and can be implemented as arrays. When each node has at most _c_ children,
one can calculate array indexes related to a certain node:

```ruby
# given node index i
def children(i) = [2*i+1, 2*i+2]
def parent(i) = (i-1)/2
```

Another use of heaps is the [Heapsort algorithm](https://en.wikipedia.org/wiki/Heapsort). It is a fast
sorting algorithm that sorts elements in place.

Binary heaps have `c=2` children. Changing this value has trade-offs (although small ones; see below):
- With a bigger `c`, the tree height would be about `log_d(n)` instead of `log_2(n)`
- The running time of _sift up_ becomes `O(log_d(n))`
- The running time of _sift down_ becomes `O(d log_d(n))`, since on each level,
`d` nodes need to be checked to find the smallest/largest one.

Therefore, operations that rely on _sift up_, such as _insert_, will be faster.
Operations that rely on _sift down_, like _extract max_, will be slower if `c>4`,
faster if `c=3`, and the same speed if `c=4`.

Note though, that the difference is minimal, as the logarithms in different bases
are all related to each other by a multiplicative constant.

### Hashes

For some hash functions, one can compute the hash values of some input faster using known
hash values for other input. For example,



This is used to efficiently implement the [Rabin-Karp algorithm](https://en.wikipedia.org/wiki/Rabin%E2%80%93Karp_algorithm),
for finding occurrences of a certain pattern string within a longer string.

For any hash function, there's always a set of input keys that lead to a bad hash table, in which the
keys are not uniformly distributed; in other words, a table with many collisions.
Normally, one chooses a function among an universal family of hash functions, with parameters
that can be adjusted to make collision less likely (for the given input set).

A malicious user may generate especially chosen input to cause collisions, and this has been
used in DoS attacks known as [Hash flooding](https://en.wikipedia.org/wiki/Collision_attack#Hash_flooding).
Because of that, many programming languages' default hashes were changed to something like
[SipHash](https://en.wikipedia.org/wiki/SipHash), so that even given the input and its hash value,
it's not possible to deduce the hash values other input.

There are many ways of handling collisions:
- each entry in the hash table can be a linked list, and colliding entries are linked.
- [linear search](https://benhoyt.com/writings/hash-table-in-c/): if a slot is already occupied, add a new entry to the next empty slot.

### Search trees

Allows for efficient range searches.

Given any node `n` with value `n.val`, and an input value `v`, the _binary search condition_ is the following:
- if `v` is smaller than `n.val`, it either is part of the `n.left` subtree or isn't present at all.
- if `v` is greater than `n.val`, it either is part of the `n.right` subtree or isn't present at all.

Since finding a node scales with the logarithm of the tree height, it's important to keep the tree
balanced. This can be done with an [AVL tree](https://en.wikipedia.org/wiki/AVL_tree). These trees
are kept balanced by applying [rotations](https://en.wikipedia.org/wiki/AVL_tree#Rebalancing).

