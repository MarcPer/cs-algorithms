package main

import (
  "fmt"
)

func main() {
  n, ok := ReadSize()
  if ok {
    fmt.Println(n)

  }
}

func initialize() []int {
  return []int{1, 2, 3}
}
