# Union find

## Dynamic connectivity

Given a set of `N` objects, and a *Union* command that connects two of them, find whether two objects are connected.

## Quick find

**Data structure:** Array `var arr [N]int`.
**Interpretation:** Two objects are connected iff they have the same id.

- Find: Check if given objects have the same id.
- Union: Merge `p` and `q` by changing all entries whose id is equals `arr[q]`  to `arr[p]`

[**Implementation**](./quick_find.md)

```go
package main
```

**Performance**

algorithm  | initialize | union | find
---------- | ---------- | ----- | ----
quick-find | `N `       | `N`   | 1

*Union is too costly*. It takes `M*N` array accesses to process a sequence of `N` union commands on `M` objects.

## Quick union