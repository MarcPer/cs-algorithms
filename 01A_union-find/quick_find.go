package unionfind

import (
  "fmt"
)

func Run() {
  n, ok := ReadSize()
  if ok {
    fmt.Println(n)
  }
}

func initialize() []int {
  return []int{1, 2, 3}
}
